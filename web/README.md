![preview](./preview.png)
This Website 🌐
==============

I love typesetting tools. In my experience, I have used and written
articles and papers using the following list of tools: `LaTeX`, `groff`,
`markdown`, `Org-Mode`, `asciidoctor`, `HTML`, `plain text`. I had to
decompress Word files and wrestle with raw XML files there, what a trip
that was.

You might be interested in how this website is built. Basically, the
whole of this website is a collection of [Org Mode](https://orgmode.org)
files, couple of [sed](https://en.wikipedia.org/wiki/Sed) scripts, some
shell, and a master
[makefile](https://github.com/thecsw/thecsw.github.io/blob/source/Makefile).
Makefile converts my raw org mode files into
[asciidoctor](https://asciidoctor.org) with
[pandoc](https://pandoc.org), sed scripts modify the asciidoctor files,
then asciidoctor binary is called to generate HTML, and another sed
script to modify the generated files, like adding CSS and some custom
meta tags.

The [repository](https://github.com/thecsw/thecsw.github.io) is hosted
on Github. `source` branch is the one that contains all the source org
files, on every commit push, a github workflow is triggered that runs
everything above and deploys the generated website to `master` branch,
where it triggers Github Pages to build the branch and deploy it
[here](https://sandyuraz.com).

Below is a good flow graph of files and operations. Just to solidify the
structure of the website, here is the [source org
file](https://github.com/thecsw/thecsw.github.io/blob/source/web/index.org)
for **this** webpage.

            ───────────────
        ───/               \───
       /                       \
      (   Commit push triggers  )
       \     github workflow   /
        ───\               /───
            ────────/──────
                   /
         Makefile /
                  │
                 /
    ┌───────────o────┐     pandoc
    │   org files    ├────────────────┐
    └───────┬────────┘                │
            │                         │
            │                         │
            │ pandoc                  │
            │                         │
    ┌───────┴───────────┐   ┌─────────┴───────────┐
    │ asciidoctor files │   │   README.md files   │
    └─────────┬─────────┘   └─────────────────────┘
              │
              │
               \ sed script
               │
     ┌─────────o─────────┐
     │ modified asciid.  │
     └────────┬──────────┘
              │
              │
               \ asciidoctor
               │
     ┌─────────o─────────┐
     │  generated HTML   │
     └────────┬──────────┘
              │
              │
             /  sed scripts
             │
     ┌───────o───────────┐
     │ pretty HTML files │
     └───────────────────┘
           ─/
         ─/
       ──      ───────────────
         o────/               \────
         /      Push files to      \
        ( master and deploy to Pages)
         \                         /
          ────\               /────
               ───────────────

That\'s the kind of workflow I have for my website. Whenever I do want
to add a new page or update existing ones, all I have to do is edit org
mode files, which are native to Emacs and push committed updates.
That\'s all the magic!

On a quick note, you were probably curious about the [fortunes
page](https://sandyuraz.com/fortunes). The simplicity of website updates
allows some room for automation. Please meet
[astrie](https://git.sr.ht/_thecsw/astrie)! My personal assistant for my
website.

Astrie talks to me through Telegram, where I send her various commands,
such as adding quotes and she [patiently
abides](https://github.com/thecsw/thecsw.github.io/commit/4f39fb7479112e1d116475dad8ed7415c5ba10e6).
I\'m quite proud of her, as all we need for all that complexity is a
\_100 loc Go package with a very small shell script that runs continuous
git submodule updates and pushes.

In a bigger picture, I must say that I would love to be able to typeset
beautiful documents and books like the ones below

-   [The GO Programming Language](https://www.gopl.io/)
-   [C Programming Language, 2nd
    Edition](https://en.wikipedia.org/wiki/The_C_Programming_Language)
-   [The Unix Programming
    Environment](https://en.wikipedia.org/wiki/The_Unix_Programming_Environment)
