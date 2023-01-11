# simple-mref
A simple tool, following the [KISS principle][KISS],
that i use to retrieve BibTeX entries from [MathSciNet][].
As it uses the free access via [MRef][], __no subscription__ is required.

Before writing my own script,
i [found](https://github.com/siudej/Cite)
[multiple](https://github.com/AndrewAtLarge/BibUpdate)
[other](https://github.com/vtex-soft/getmref/blob/master/getmref.py)
projects with similar objectives.
Though i tried to adjust them to run with modern python, none worked out for me.
Basically, they are all (much) too complex and/or do stuff that i don't need or want.

The drawback of `simple-mref` is, that the input string must already be in "bibliography style",
i.e. "Author. Some title. Maybe publisher, year." or similar. From the [MRef help page][MRef_help]:
> MRef can be used whenever a reference can be copied and pasted as text. For example, the reference might be copied as text from a Web page, from a PDF document, or from a file presented in a TeX/AMS-TeX/LaTeX application.

One particular annoyance is, that it does not simply accept an ISBN – but see [`isbn-to-reference`](#isbn-to-reference).

## Prerequisites
* zsh
* curl
* grep
* awk

Confirmed to be working with: `curl 7.87.0`, `GNU Awk 5.2.1`, the MRef site in fall 2022.

## Usage
### simple-mref.sh
The fetching script expects the search string as its first argument, i.e. it can be run like this:
```
./simple-mref.sh "Euclid. Euclid's Elements - All thirteen books complete in one volume, Green Lion Press"
```
to print the BibTeX entry – if one is found – unmodified to standard output.
Alternatively, one may specify `-` (hyphen) to read the search string from standard input:
```
echo "Euclid. Euclid's Elements - All thirteen books complete in one volume, Green Lion Press" | ./simple-mref.sh -
```

### post-processing
As i don't like [MathSciNet][]'s output format, i keep a set of scripts in `post-processing/`
that transform the BibTeX entry to my preferred style. They are mostly independent from each
other, but many assume single-line entry fields. Two "drivers" `post-process-pipe.sh` and
`post-process-tmp.sh` exist to filter their file argument through all
executable post-processing scripts, where again, a hyphen can be used to read from standard
input instead. The scripts `simple-mref-with-*.sh` pass `simple-mref.sh`'s output to the
respective driver:
```
./simple-mref-with-pipe-post.sh "Euclid. Euclid's Elements - All thirteen books complete in one volume, Green Lion Press"
```

Note, that some post-processing scripts use further tools such as `sed` or `vim`.

### vim
For convenience, i use this command
```
:r !zsh -c '/path/to/simple-mref-with-pipe-post.sh "$(cat)"'
```
directly in `vim`: after pasting the copied reference, possibly with line breaks
(which don't seem to disturb [MRef][] even in the middle of words), and
terminating `cat` via `Ctrl+D` twice, the BibTeX entry is pasted into the current
file.


# isbn-to-reference
Another [KISS][] tool that uses [Open Library](https://openlibrary.org/)'s
API to search for an ISBN and outputs a format that [MRef][] can parse. For example:
```
./isbn-to-reference.sh 0201038099 | ./simple-mref.sh -
```

Any non-digit characters from the input argument (or standard input in case of `-`) are stripped,
so it accepts ISBNs with or without hyphens, spaces, leading "ISBN: ", …

## Prerequisites
* zsh
* curl
* jq (<https://stedolan.github.io/jq/>)

Confirmed to be working with: `curl 7.87.0`, `jq-1.6`.



[KISS]: https://en.wikipedia.org/wiki/KISS_principle
[MathSciNet]: https://mathscinet.ams.org/mathscinet
[MRef]: https://mathscinet.ams.org/mref
[MRef_help]: https://mathscinet.ams.org/mathscinet/help/mref_help.html
