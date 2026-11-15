// Shared templates and helpers for every unit book and every exam. The only file that defines styling.
// A unit's main.typ applies `notes`; each chapter imports the helpers with
// `#import "../../lib/notes.typ": *` (included files don't inherit main.typ's scope).

// Natural-deduction trees, re-exported so every unit writes them the same way:
// #prooftree(rule(name: $and I$, $phi$, $psi$, $phi and psi$))  (premises first, conclusion last)
#import "@preview/curryst:0.6.0": rule, prooftree

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
#let exercise = env("Ejercicio")
#let algorithm = env("Algoritmo")
#let theorem = env("Teorema", italic: true)
#let lemma = env("Lema", italic: true)
#let proposition = env("Proposición", italic: true)
#let corollary = env("Corolario", italic: true)

#let proof(body) = block(width: 100%, breakable: true)[_Demostración._ #body #h(1fr) $square$]

// Labeled arrow, e.g. $q #xarrow($a$) q'$.
#let xarrow(label) = $limits(arrow.r)^#label$

// Semantics of a formula under an assignment: $#sem($phi$, $f$)$ → ⟦φ⟧_f (omit the assignment for ⟦φ⟧).
#let sem(formula, assignment) = $lr(⟦ #formula ⟧)_#assignment$

// Metavariable □ for a binary connective, spaced as a binary operator: $(phi boxop psi)$.
#let boxop = $class("binary", square)$

// Schematic derivation: an optional hypothesis, a vertical ellipsis (named on its left) and the
// conclusion. Usable as a premise: rule(name: $-> I$, deriv($psi$, hyp: $[phi]$), $phi -> psi$).
#let deriv(concl, name: none, hyp: none) = {
  let d = math.display
  let rows = if name == none {
    (if hyp != none { (d(hyp),) }, (d($dots.v$),), (d(concl),))
  } else {
    (if hyp != none { ([], d(hyp), []) }, (d(name), d($dots.v$), hide(d(name))), ([], d(concl), []))
  }
  math.equation(block: false, math.mat(delim: none, column-gap: 0.15em, row-gap: 0.3em, ..rows.filter(r => r != none)))
}

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
  // Figures are plain `image(...)` calls in chapters; this centers and spaces them.
  show image: it => align(center, block(above: 1em, below: 1em, it))
  // Each chapter starts on a new page and restarts environment numbering.
  // `outlined: true` excludes the outline's own "Índice" heading.
  show heading.where(level: 1, outlined: true): it => {
    pagebreak(weak: true)
    counter(figure.where(kind: env-kind)).update(0)
    set text(size: 17pt)
    block(below: 1.2em, it)
  }

  // An environment shorter than a third of the page never splits (so a header is
  // never stranded from its body); longer ones, like long proofs or examples, flow.
  show figure.where(kind: env-kind): it => context {
    let content = align(start)[
      #strong[#it.supplement #it.counter.display(it.numbering)#if it.caption != none [ (#it.caption.body)].]
      #it.body
    ]
    let text-width = page.width - 2 * 2.5cm
    let short = measure(content, width: text-width).height < (page.height - 2 * 2.5cm) / 3
    block(width: 100%, above: 1.3em, below: 1.3em, breakable: not short, content)
  }

  align(center, text(size: 22pt, title))
  v(1.5em)
  outline(depth: 2)
  body
}

// ---------------------------------------------------------------------------
// Exam template: one standalone document per exam, under exams/
// ---------------------------------------------------------------------------

// V and F boxes to mark a true/false item.
#let tf-boxes = box(baseline: 15%, grid(
  columns: 2,
  column-gutter: 4pt,
  ..("V", "F").map(l => box(width: 1.3em, height: 1.3em, stroke: 0.5pt, align(center + horizon, text(size: 8pt, l)))),
))

// True/false items labeled (a), (b), … with a hanging indent, each with its V/F boxes on the right.
#let tf-items(..items) = {
  set par(justify: false)
  grid(
    columns: (auto, 1fr, auto),
    column-gutter: (6pt, 12pt),
    row-gutter: 13pt,
    align: (left + top, left + top, right + horizon),
    ..items.pos().enumerate().map(((i, item)) => (numbering("(a)", i + 1), item, tf-boxes)).flatten(),
  )
}

// The first page is the handout: course, `title`, an optional `note` (e.g. that the statement was
// reconstructed), and name/DNI lines. `short` goes in the footer. A solutions file passes
// `solutions: true`, which only changes the PDF's metadata title, so its first page stays identical.
#let exam(title: none, short: none, note: none, solutions: false, body) = {
  let course = [Introducción a la Lógica y la Computación]
  set document(title: if solutions [#short · Resolución] else { short })
  set page(
    paper: "a4",
    margin: (x: 20mm, top: 18mm, bottom: 20mm),
    footer: context {
      set text(size: 8pt, fill: luma(45%))
      line(length: 100%, stroke: 0.4pt + luma(78%))
      v(4pt)
      grid(columns: (1fr, auto), [ILyC · #short], counter(page).display())
    },
  )
  set text(font: "New Computer Modern", size: 11pt, lang: "es")
  set par(justify: true, leading: 0.6em)
  set enum(spacing: 1.8em)
  set terms(separator: [. ], hanging-indent: 1.5em, spacing: 1.2em)
  set heading(numbering: none)
  show heading.where(level: 1): set text(size: 16pt)
  show heading.where(level: 2): set text(size: 12pt)
  show heading: set block(above: 1.4em, below: 0.8em)

  align(center)[
    #text(size: 16pt, weight: "bold", course)
    #v(2pt)
    #text(size: 13pt, title)
    #if note != none {
      v(2pt)
      text(size: 9pt, fill: luma(40%), note)
    }
  ]
  v(8pt)
  grid(columns: (1fr, 1fr), [Nombre: #box(width: 1fr, repeat[.])], [#h(1em)DNI: #box(width: 1fr, repeat[.])])
  v(8pt)
  body
}
