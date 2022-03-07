![preview](./preview.png)
Write an Emulator in 24 hours 🥃
===============================

![ You can (not) interpret](preview.png:VMAGI)

Welcome! **VMAGI** is a small emulator/interpreter my friend
[Matthew](https://github.com/matthewsanetra) and I challenged each other
to build in 24 hours. This includes both the implementation of the
interpreter and creating your own ISA/3ac/IR for it that it will run on
top of. If you want to see Matthew\'s implementation, go to [his
repository](https://github.com/matthewsanetra/sandy_isa).

My friend [Ethan](https://github.com/Username-ejg-not-available) also
joined us on this competition and completed [his
implementation](https://github.com/Username-ejg-not-available/not-fake-assembly-language).
Funnily enough, I did it in Go, Matthew in Rust, Ethan in C++.

The goal within 24 hours was to write an interpreter that can reliably
run a recursive version of fibonacci sequence, such that for any natural
`n`, `fib(n)` returns the n\'th element of the sequence.

This was an interesting challenge, as writing the machine itself, with
all the instructions and logic around it was pretty simple. This
includes required stuff like labels, jumps, conditionals, etc. The idea
was to make it a workable interpreter for whatever you write.

Want to read more? See the whole story with the architecture, pitfalls,
dragons(?), and needy-greedy technical details in the project\'s
repository!

-\> [Go to VMAGI](https://github.com/thecsw/VMAGI)
