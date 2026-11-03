# Lenguajes Regulares

Study notes for the third part of *Introducción a la Lógica y la Computación*, written in [Typst](https://typst.app) as one book with one chapter per topic.

## Build

```sh
typst compile main.typ    # whole book → main.pdf
typst watch main.typ      # rebuild on save
```

Run from this folder. Imports and images use relative paths, so the book also builds from a parent directory (`typst compile lenguajes-regulares/main.typ --root .`) or as a subfolder of a typst.app project. The whole book always builds together, so cross-chapter references always resolve; it takes about a second.

## Layout

```
main.typ        entry point: applies the template, lists chapters in order
lib/notes.typ   the only place with styling; environments and helpers
chapters/       one file per chapter, NN-english-slug.typ
img/<slug>/     raster figures for the chapter with that slug
```

To add a chapter: create `chapters/NN-slug.typ`, add its `#include` line to `main.typ`, put its images in `img/slug/`.

## Conventions

**Language.** Code is English: file names, labels, helper names, comments. Document text is Spanish, including the words the environments print ("Definición", "Demostración").

**Chapter file shape.**

```typst
#import "../lib/notes.typ": *

= Gramáticas regulares <ch-regular-grammars>

Intro paragraph.

== Section
```

One level-1 heading per file (the chapter), sections with `==`, subsections with `===` (not shown in the table of contents). `@ch-…` prints "Capítulo N", `@` on a section prints "Sección N.M". No `#set`/`#show` rules and no styling in chapters: if something needs a new look, it belongs in `lib/notes.typ`.

**Environments.** Use the helpers from `lib/notes.typ`, never hand-made boxes or bold labels:

| Helper | Prints | Body |
|---|---|---|
| `definition`, `notation`, `remark`, `example`, `algorithm` | Definición, Notación, Observación, Ejemplo, Algoritmo | upright |
| `theorem`, `lemma`, `proposition`, `corollary` | Teorema, Lema, Proposición, Corolario | italic |
| `proof` | *Demostración.* … ∎ | not numbered |

All numbered kinds share one counter per chapter (Definición 4.1, Teorema 4.2, …). An optional `title:` goes in parentheses: `#theorem(title: [Kleene])[...]`.

**Labels and references.** Label every environment that is, or may be, referenced, and every chapter heading, right after the closing bracket: `#definition(...)[...] <def-dfa>`. Reference with `@def-dfa`, which prints "Definición 4.1". Prefixes: `ch-`, `def-`, `thm-`, `lem-`, `prop-`, `cor-`, `ex-`, `alg-`, `rem-`, `not-`; slug in English kebab-case. Labels are global across the book, so keep them specific (`def-dfa-language`, not `def-language`).

**Math.** Write notation the way the course does: `"AFD"^Sigma`, `"AFN"ϵ^Sigma`, `arrow(delta)` for the extended transition function, `hat(Delta)` for its extension to sets, `cal(P)(Q)` for the power set, `ϵ` (U+03F5) for the empty string and spontaneous transitions, `#xarrow($a$)` for a labeled arrow. Multi-line definitions and derivations use aligned display math (`&=`, `&<==>`), not lines joined with `\`.

**Figures.** `#fig("slug/name.png", 160pt)` centers an image from `img/`. Images are the original rasters extracted from the slides (`pdfimages -png`) and named for what they show (`nfa-m1-trace-accept.png`), never `img-003.png`. Tables and plain equations are typeset, not pasted as images.

**Prose.** Each chapter reads as a math text, not as slides: paragraphs instead of bullet fragments, one environment per definition/result, examples inside `example`. Content follows the course slides; obvious typos are fixed silently, while anything that changes meaning is checked against the slides.
