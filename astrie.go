package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"os"
	"os/signal"
	"strings"
	"time"

	"github.com/go-git/go-git/v5"
	"github.com/go-git/go-git/v5/plumbing/object"
	"github.com/go-git/go-git/v5/plumbing/transport"
	"github.com/go-git/go-git/v5/plumbing/transport/ssh"
	"github.com/gorilla/mux"
	"github.com/pkg/errors"
	"github.com/rs/cors"
	"github.com/sirupsen/logrus"
	tb "gopkg.in/tucnak/telebot.v2"
)

// Gitter is the command line interface for astrie
type Gitter struct {
	Directory    string
	AuthorName   string
	AuthorEmail  string
	Repo         *git.Repository
	SourceBranch *git.Worktree
	Auth         transport.AuthMethod
	Prepend      string
}

var (
	// Astrie token for telegram
	AstrieToken = os.Getenv("ASTRIE_TOKEN")
	// Astrie keys
	AstrieKey = os.Getenv("ASTRIE_KEY")
	// The initial token settings for astrie
	settings = tb.Settings{
		URL:    "https://api.telegram.org",
		Token:  AstrieToken,
		Poller: &tb.LongPoller{Timeout: 10 * time.Second},
	}
	// allowed users
	allowedUsers = []string{"thecsw"}
	// Git interface for astrie
	gitter = &Gitter{
		Directory:   AstrieHome,
		AuthorName:  "Astrie",
		AuthorEmail: "ctu@ku.edu",
		Prepend:     "Astrie: ",
	}
)

const (
	// repo link
	repoUrl = "git@github.com:thecsw/thecsw.github.io"
	// reference to source branch
	sourceBranch = "refs/heads/source"
	// Astrie home git the source branch
	AstrieHome = "./astrie_repo"
	// quote anchor
	quoteAnchor = "Some quotes are regular and some are not"
)

func main() {
	// Check if env vars are initalized.
	if AstrieToken == "" {
		logrus.Fatalln("Missing token.")
	}
	if AstrieKey == "" {
		logrus.Fatalln("Missing key.")
	}
	// Git interface for astrie
	logrus.Infoln("Initializing gitter")
	gitter.Init()
	// Telegram bot
	logrus.Infoln("Initializing telegram bot")
	b, err := tb.NewBot(settings)
	if err != nil {
		logrus.Fatal(err)
		return
	}
	// On start
	b.Handle("/start", func(m *tb.Message) {
		logrus.Infoln("Got /start from " + m.Sender.Username)
		b.Send(m.Sender, "about time...")
	})

	// Simple checking if it works
	b.Handle("/hello", func(m *tb.Message) {
		logrus.Infoln("Got /hello from " + m.Sender.Username)
		b.Send(m.Sender, "hello, world")
	})

	// Handle new quotes
	b.Handle("/quote", func(m *tb.Message) {
		if !checkUser(m.Sender.Username) {
			b.Send(m.Sender, "Can't do that. Sorry")
			return
		}
		logrus.Infoln("Got /quote from " + m.Sender.Username + ": " + m.Payload)
		logrus.Infoln("Adding quote...")
		b.Send(m.Sender, "Adding quote...")
		if err := AddQuote(m.Payload); err != nil {
			logrus.Errorln("Failed adding quote: " + err.Error())
			return
		}
		logrus.Infoln("Committing...")
		b.Send(m.Sender, "Committing...")
		if err := gitter.Commit("Added new quote"); err != nil {
			logrus.Errorln("Failed committing: " + err.Error())
			return
		}
		logrus.Infoln("Pushing...")
		b.Send(m.Sender, "Pushing...")
		if err := gitter.Push(); err != nil {
			logrus.Errorln("Failed pushing: " + err.Error())
			return
		}
		logrus.Infoln("Success!")
		b.Send(m.Sender, "Success! Check out https://sandyuraz.com/quotes/")
	})

	// Start listening and capturing messages
	logrus.Infoln("Listening...")
	go b.Start()

	r := mux.NewRouter()
	r.HandleFunc("/", greet).Methods(http.MethodGet)
	handler := cors.Default().Handler(r)
	srv := &http.Server{
		Handler: handler,
		Addr:    ":" + os.Getenv("PORT"),
		// Good practice: enforce timeouts for servers you create!
		WriteTimeout: 15 * time.Second,
		ReadTimeout:  15 * time.Second,
		IdleTimeout:  60 * time.Second,
	}
	// Let it run
	go func() {
		if err := srv.ListenAndServe(); err != nil {
			log.Println(err)
		}
	}()
	c := make(chan os.Signal, 1)
	// We'll accept graceful shutdowns when quit via SIGINT (Ctrl+C)
	// SIGKILL, SIGQUIT or SIGTERM (Ctrl+/) will not be caught.
	signal.Notify(c, os.Interrupt)
	// Block until we receive our signal.
	<-c
	log.Println("shutting down")
	os.Exit(0)

}

// Response returns a message from the API
type Response struct {
	Msg string `json:"msg"`
	Err string `json:"err"`
}

// greet is just / handler
func greet(w http.ResponseWriter, r *http.Request) {
	writeGoodStuff(w, Response{Msg: "hello, world"})
}

func writeGoodStuff(w http.ResponseWriter, data interface{}) {
	w.WriteHeader(http.StatusOK)
	json.NewEncoder(w).Encode(data)
}

func writeBadStuff(w http.ResponseWriter, err error) {
	w.WriteHeader(http.StatusInternalServerError)
	json.NewEncoder(w).Encode(Response{Err: err.Error()})
}

// formQuote adds the day in italics for org mode
func formQuote(quote string) string {
	now := time.Now()
	return fmt.Sprintf("  - /%s, %s %d, %d/\n\n%s",
		now.Weekday().String(),
		now.Month().String(),
		now.Day(),
		now.Year(),
		quote,
	)

}

// checkUser checks if user is authorized (me)
func checkUser(user string) bool {
	for _, auser := range allowedUsers {
		if user == auser {
			return true
		}
	}
	return false
}

// Init initializes the repo struct
func (g *Gitter) Init() error {
	// Grab the deploy key
	auth, err := g.publicKey(AstrieKey)
	if err != nil {
		return err
	}
	g.Auth = auth
	// Get the repo
	_, err = git.PlainClone(AstrieHome, false, &git.CloneOptions{
		URL:               repoUrl,
		Auth:              auth,
		RecurseSubmodules: git.DefaultSubmoduleRecursionDepth,
	})
	r, err := git.PlainOpen(AstrieHome)
	g.Repo = r
	return err
}

// Commit just commits everything
func (g *Gitter) Commit(msg string) error {
	w, err := g.Repo.Worktree()
	if err != nil {
		return errors.Wrap(err, "Failed to open worktree")
	}
	err = w.Checkout(&git.CheckoutOptions{
		Branch: sourceBranch,
		Keep:   true,
	})
	if err != nil {
		return errors.Wrap(err, "Failed to check out source")
	}
	_, err = w.Commit(g.Prepend+msg, &git.CommitOptions{
		All: true,
		Author: &object.Signature{
			Name:  g.AuthorName,
			Email: g.AuthorEmail,
			When:  time.Now(),
		},
		Committer: &object.Signature{
			Name:  g.AuthorName,
			Email: g.AuthorEmail,
			When:  time.Now(),
		},
	})
	return err
}

// Push pushes, duh
func (g *Gitter) Push() error {
	return g.Repo.Push(&git.PushOptions{
		Auth: g.Auth,
	})
}

// Reads private rsa key and generates a public one, this is deploy key
func (g *Gitter) publicKey(sshKey string) (*ssh.PublicKeys, error) {
	publicKey, err := ssh.NewPublicKeys("git", []byte(sshKey), "")
	if err != nil {
		return nil, errors.Wrap(err, "Failed generating public key")
	}

	return publicKey, err
}

// AddQuote calls sed to insert a line, it's easier than writing a go function to do that
func AddQuote(msg string) error {
	filename := AstrieHome + "/quotes/index.org"
	dat, err := ioutil.ReadFile(filename)
	if err != nil {
		return errors.Wrap(err, "Failed reading the quote file")
	}
	quotes := string(dat)
	quotes = strings.ReplaceAll(quotes, quoteAnchor, quoteAnchor+"\n\n"+formQuote(msg))
	err = ioutil.WriteFile(filename, []byte(quotes), 0644)
	if err != nil {
		return errors.Wrap(err, "Failed writing quotes")
	}
	return nil
}
