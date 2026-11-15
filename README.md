# Introducción a la Lógica y la Computación

Study notes for the course, written in [Typst](https://typst.app): one book per unit, transcribed from the course slides into a math text, and the course's exams with their solutions.

| Unit | Book |
|---|---|
| 1. Estructuras Ordenadas | [`estructuras-ordenadas/`](estructuras-ordenadas/) |
| 2. Lógica Proposicional | [`logica-proposicional/`](logica-proposicional/) |
| 3. Lenguajes Regulares | [`lenguajes-regulares/`](lenguajes-regulares/) |

Exams live in [`exams/`](exams/), one statement and one solutions file per exam.

## Build

```sh
make                          # every unit and every exam
make lenguajes-regulares      # one unit → <unit>/main.pdf
make watch-lenguajes-regulares  # rebuild one unit on save
make exams                    # every exam → exams/<name>.pdf
```

`make` runs `typst compile --root . <unit>/main.typ` for each unit and `typst compile --root . exams/<name>.typ` for each exam; to rebuild one exam on save, run `typst watch --root . exams/<name>.typ`. The root must be the repository, because every unit and exam imports the shared template from `lib/`. On typst.app, import the repository as one project and pick a unit's `main.typ` as the entry file. A unit always builds as a whole, so cross-chapter references always resolve; it takes about a second.

## Layout

```
lib/notes.typ             the only file with styling: book and exam templates, environments, helpers
<unit>/main.typ           applies the template, #includes the chapters in reading order
<unit>/chapters/NN-*.typ  one file per chapter, NN-english-slug.typ
<unit>/img/<slug>/        figures for the chapter with that slug
exams/<name>.typ          an exam's statement, e.g. 2026-midterm-2.typ (Parcial 2 of 2026)
exams/<name>-solutions.typ  the same statement on page 1, solutions from page 2
```

To add a chapter: create `<unit>/chapters/NN-slug.typ`, add its `#include` line to `<unit>/main.typ`, put its images in `<unit>/img/slug/`. To add a unit: copy an existing `main.typ`, add the folder to `UNITS` in the `Makefile`, to the table above, and to the allowlist in `.gitignore`. To add an exam: create its two files in `exams/`; `make exams` picks them up.

## Conventions

**Language.** Code is English: file names, labels, helper names, comments. Document text is Spanish, including the words the environments print ("Definición", "Demostración").

**Chapter file shape.**

```typst
#import "../../lib/notes.typ": *

= Gramáticas regulares <ch-regular-grammars>

Intro paragraph.

== Section
```

One level-1 heading per file (the chapter), sections with `==`, subsections with `===` (not shown in the table of contents). `@ch-…` prints "Capítulo N", `@` on a section prints "Sección N.M". No `#set`/`#show` rules and no styling in chapters: if something needs a new look, it belongs in `lib/notes.typ`.

**Environments.** Use the helpers from `lib/notes.typ`, never hand-made boxes or bold labels:

| Helper | Prints | Body |
|---|---|---|
| `definition`, `notation`, `remark`, `example`, `exercise`, `algorithm` | Definición, Notación, Observación, Ejemplo, Ejercicio, Algoritmo | upright |
| `theorem`, `lemma`, `proposition`, `corollary` | Teorema, Lema, Proposición, Corolario | italic |
| `proof` | *Demostración.* … ∎ | not numbered |

All numbered kinds share one counter per chapter (Definición 4.1, Teorema 4.2, …). An optional `title:` goes in parentheses: `#theorem(title: [Kleene])[...]`.

**Labels and references.** Label every environment that is, or may be, referenced, and every chapter heading, right after the closing bracket: `#definition(...)[...] <def-dfa>`. Reference with `@def-dfa`, which prints "Definición 4.1". Prefixes: `ch-`, `def-`, `thm-`, `lem-`, `prop-`, `cor-`, `ex-`, `exr-`, `alg-`, `rem-`, `not-`; slug in English kebab-case. Labels are unique within a unit (each unit is its own document), so keep them specific (`def-dfa-language`, not `def-language`).

**Math.** Write notation the way the course does, and the same way across a unit. Lenguajes Regulares: `"AFD"^Sigma`, `"AFN"ϵ^Sigma`, `arrow(delta)` for the extended transition function, `hat(Delta)` for its extension to sets, `cal(P)(Q)` for the power set, `ϵ` (U+03F5) for the empty string and spontaneous transitions, `#xarrow($a$)` for a labeled arrow. Multi-line definitions and derivations use aligned display math (`&=`, `&<==>`), not lines joined with `\`.

**Proof trees.** Natural-deduction derivations use `prooftree` and `rule` (from the `curryst` package, re-exported by `lib/notes.typ`): `#prooftree(rule(name: $and I$, $phi$, $psi$, $phi and psi$))`: premises first, conclusion last; a premise can itself be a `rule`, which nests deeper trees. Never paste a derivation as an image.

**Figures.** Plain `#image("../img/slug/name.png", width: 160pt)` from a chapter; the template centers it. Images are the original rasters extracted from the slides (`pdfimages -png`) or, for vector diagrams, crops of a 300 dpi render, named for what they show (`nfa-m1-trace-accept.png`), never `img-003.png`. Tables and plain equations are typeset, not pasted as images.

**Exams.** Exams are standalone documents, not chapters: the statement file defines the whole statement as `#let statement = [...]`, applies `#show: exam.with(...)` and prints `#statement`. The solutions file imports `statement` from it, applies `exam` with the same arguments plus `solutions: true`, prints `#statement`, a `#pagebreak()`, and the solutions. The statement is therefore written once and page 1 of both PDFs is identical. Exam names are `YYYY-midterm-N` for a parcial and `YYYY-final-MM-DD` for a final. True/false items use `tf-items`; solutions use a term list per item (`/ (a) Falso: …`), derivations use `prooftree`, and meta-proofs go in `proof`. A statement reconstructed from memory says so in the template's `note:`.

**Prose.** Each chapter reads as a math text, not as slides: paragraphs instead of bullet fragments, one environment per definition/result, examples inside `example`. Content follows the course slides; obvious typos are fixed silently, while anything that changes meaning is checked against the slides. Course logistics (dates, "contenidos de hoy", recap slides that only repeat earlier chapters) are left out.
