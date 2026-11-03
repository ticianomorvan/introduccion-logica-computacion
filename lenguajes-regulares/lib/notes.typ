// Shared template and helpers. The only file that defines styling.
// main.typ applies `notes`; every chapter imports the helpers with
// `#import "../lib/notes.typ": *` (included files don't inherit main.typ's scope).
// Paths are relative so the book builds from any project root (local, typst.app, a parent repo).

// ---------------------------------------------------------------------------
// Environments: Definición, Teorema, Ejemplo, ...
// All kinds share one counter, numbered per chapter ("Teorema 4.6"), and are
// figures so `<label>` + `@label` cross-references work across chapters.
// ---------------------------------------------------------------------------

#let env-kind = "env"

// `label` is the word printed in the document; `italic` sets the body in
// italics (statements of results, as in amsthm's "plain" style).
#let env(label, italic: false) = (title: none, body) => figure(
  kind: env-kind,
  supplement: label,
  numbering: n => numbering("1.1", counter(heading).get().first(), n),
  caption: title,
  outlined: false,
  if italic { emph(body) } else { body },
)

#let definition = env("Definición")
#let notation = env("Notación")
#let remark = env("Observación")
#let example = env("Ejemplo")
#let algorithm = env("Algoritmo")
#let theorem = env("Teorema", italic: true)
#let lemma = env("Lema", italic: true)
#let proposition = env("Proposición", italic: true)
#let corollary = env("Corolario", italic: true)

#let proof(body) = block(width: 100%, breakable: true)[_Demostración._ #body #h(1fr) $square$]

// ---------------------------------------------------------------------------
// Figures and notation
// ---------------------------------------------------------------------------

// Centered raster image; `path` is relative to img/ (e.g. "finite-automata/nfa-m1.png").
#let fig(path, width) = align(center, block(above: 1em, below: 1em, image("../img/" + path, width: width)))

// Labeled arrow, e.g. $q #xarrow($a$) q'$.
#let xarrow(label) = $limits(arrow.r)^#label$

// ---------------------------------------------------------------------------
// Document template
// ---------------------------------------------------------------------------

#let notes(title: none, body) = {
  set document(title: title)
  set page(paper: "a4", margin: 2.5cm, numbering: "1")
  set text(font: "New Computer Modern", size: 11pt, lang: "es")
  set par(justify: true)
  set list(indent: 0.8em)
  set enum(indent: 0.8em)

  set heading(numbering: "1.1")
  show heading: set block(above: 1.6em, below: 0.9em)
  // `@ch-…` prints "Capítulo 4"; deeper headings keep the default "Sección 4.2".
  show heading.where(level: 1): set heading(supplement: [Capítulo])
  // Tables here are small; splitting one across pages only hurts.
  show table: set block(breakable: false)
  // Each chapter starts on a new page and restarts environment numbering.
  // `outlined: true` excludes the outline's own "Índice" heading.
  show heading.where(level: 1, outlined: true): it => {
    pagebreak(weak: true)
    counter(figure.where(kind: env-kind)).update(0)
    set text(size: 17pt)
    block(below: 1.2em, it)
  }

  // Statements (italic bodies) are short and never split from their header;
  // definitions, examples and the like may flow across pages.
  show figure.where(kind: env-kind): it => block(
    width: 100%, above: 1.3em, below: 1.3em, breakable: it.body.func() != emph,
    align(start)[
      #strong[#it.supplement #context it.counter.display(it.numbering)#if it.caption != none [ (#it.caption.body)].]
      #it.body
    ],
  )

  align(center, text(size: 22pt, title))
  v(1.5em)
  outline(depth: 2)
  body
}
