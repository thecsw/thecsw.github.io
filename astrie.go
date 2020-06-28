package main

import (
	"fmt"
	"io/ioutil"
	"os"
	"strings"
	"time"

	"github.com/go-git/go-git/v5"
	"github.com/go-git/go-git/v5/plumbing/object"
	"github.com/go-git/go-git/v5/plumbing/transport"
	"github.com/go-git/go-git/v5/plumbing/transport/ssh"
	"github.com/pkg/errors"
	"github.com/sirupsen/logrus"
	tb "gopkg.in/tucnak/telebot.v2"
)

// Gitter is the command line interface for astrie
type Gitter struct {
	Directory   string
	AuthorName  string
	AuthorEmail string
	Repo        *git.Repository
	Auth        transport.AuthMethod
	Prepend     string
}

var (
	// Astrie token for telegram
	AstrieToken = os.Getenv("ASTRIE_TOKEN")
	// The location of the website root directory
	AstrieHome = os.Getenv("ASTRIE_HOME")
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

func main() {
	// Check if env vars are initalized.
	if AstrieHome == "" || AstrieToken == "" {
		logrus.Fatalln("One of the env vars is not initialized")
	}
	// Git interface for astrie
	logrus.Infoln("Initializing gitter at " + AstrieHome)
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
		if err := AddQuote(m.Payload); err != nil {
			logrus.Errorln("Failed adding quote: " + err.Error())
			return
		}
		logrus.Infoln("Committing...")
		if err := gitter.Commit("Added new quote"); err != nil {
			logrus.Errorln("Failed committing: " + err.Error())
			return
		}
		logrus.Infoln("Pushing...")
		if err := gitter.Push(); err != nil {
			logrus.Errorln("Failed pushing: " + err.Error())
			return
		}
		logrus.Infoln("Success!")

	})

	// Start listening and capturing messages
	logrus.Infoln("Listening...")
	b.Start()
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
	// Init the repo
	r, err := git.PlainOpen(AstrieHome)
	if err != nil {
		return err
	}
	g.Repo = r
	// Grab the deploy key
	auth, err := g.publicKey(AstrieHome + "/" + AstrieKey)
	if err != nil {
		return err
	}
	g.Auth = auth
	return nil
}

// Commit just commits everything
func (g *Gitter) Commit(msg string) error {
	w, err := g.Repo.Worktree()
	if err != nil {
		return err
	}
	_, err = w.Commit(msg, &git.CommitOptions{
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
func (g *Gitter) publicKey(filePath string) (*ssh.PublicKeys, error) {
	var publicKey *ssh.PublicKeys
	sshKey, err := ioutil.ReadFile(filePath)
	if err != nil {
		return nil, errors.Wrap(err, "Failed gathering the deploy key")
	}
	publicKey, err = ssh.NewPublicKeys("git", sshKey, "")
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
	quotes = strings.ReplaceAll(quotes, "%QUOTE%", "%QUOTE%\n\n"+formQuote(msg))
	err = ioutil.WriteFile(filename, []byte(quotes), 0644)
	if err != nil {
		return errors.Wrap(err, "Failed writing quotes")
	}
	return nil
}
