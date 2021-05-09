![preview](./preview.png)
This Website 🌐
==============

I love typesetting tools. In my experience, I have used and written
articles and papers using the following list of tools: `LaTeX`, `groff`,
`markdown`, `Org-Mode`, `asciidoctor`, `HTML`, `plain text`. I had to
decompress Word files and wrestle with raw XML files there, what a trip
that was.

You might be interested in how this website is built. Basically, the
whole of this website is a collection of Org Mode files, couple of sed
scripts, some shell, and a master makefile. Makefile converts my raw org
mode files into asciidoctor with pandoc, sed scripts modify the
asciidoctor files, then asciidoctor binary is called to generate HTML,
and another sed script to modify the generated files, like adding CSS
and some custom meta tags.

The [repository](https://github.com/thecsw/thecsw.github.io) is hosted
on Github. Branch `source` is the one that contains all the source org
files, on every commit push, a github workflow is triggered that runs
everything above and deploys the generated website to `master` branch,
where it triggers Github Pages to build the branch and deploy it
[here](https://sandyuraz.com).

Here is a good flow graph of files and operations:


            ---------------
        ---/               \---
       /                       \
      (   Commit push triggers  )
       \     github workflow   /
        ---\               /---
            --------/------
                   /
         Makefile /
                  |
                 /
    +-----------o----+     pandoc
    |   org files    +----------------+
    +-------+--------+                |
            |                         |
            |                         |
            | pandoc                  |
            |                         |
    +-------+-----------+   +---------+-----------+
    | asciidoctor files |   |   README.md files   |
    +---------+---------+   +---------------------+
              |
              |
               \ sed script
               |
     +---------o---------+
     | modified asciid.  |
     +--------+----------+
              |
              |
               \ asciidoctor
               |
     +---------o---------+
     |  generated HTML   |
     +--------+----------+
              |
              |
             /  sed scripts
             |
     +-------o-----------+
     | pretty HTML files |
     +--------+----------+
           -/
         -/
       --      ---------------
         o----/               \----
         /      Push files to      \
        ( master and deploy to Pages)
         \                         /
          ----\               /----
               ---------------

I would love to be able to typeset beautiful documents and books like
the ones below

-   [The GO Programming Language](https://www.gopl.io/)
-   [C Programming Language, 2nd
    Edition](https://en.wikipedia.org/wiki/The_C_Programming_Language)
-   [The Unix Programming
    Environment](https://en.wikipedia.org/wiki/The_Unix_Programming_Environment)
