#import "../lib/notes.typ": *

// Statement of the 2026 Parcial 2 (Lógica Proposicional), reconstructed from memory after the exam.
// The solutions file imports `statement` and `PROP` so its first page stays identical to this one.

#let PROP = $"PROP"$

#let statement = [
  + *Verdadero y falso.* Marque si cada afirmación es verdadera o falsa, sin justificar. Las respuestas correctas suman, las incorrectas restan y las vacías no suman ni restan.

    #tf-items(
      [Supongamos que $Gamma$ es consistente y que $not phi in.not Gamma$. Entonces $phi in Gamma$.],
      [Sea $Gamma$ consistente maximal, y supongamos que $phi in Gamma$ y que $tack.r phi -> psi$. Entonces #box[$not psi in.not Gamma$].],
      [El conjunto ${phi in PROP : p_0 tack.r phi}$ es consistente maximal.],
      [${phi in PROP : p_1 tack.r phi} inter {phi in PROP : not p_1 tack.r phi} = emptyset$.],
      [Si $Delta subset.eq Gamma$ y $Delta tack.r phi$, entonces $Gamma tack.r phi$.],
      [Si ${p_7, not (p_5 -> p_3), p_4 or p_6} subset.eq Gamma$, entonces $Gamma tack.r p_5$.],
      [${p_2 -> not p_1, p_2 and not p_3, p_1 -> p_3}$ es consistente.],
      [Si $Gamma$ es consistente y $Delta$ es consistente maximal, entonces $Gamma union Delta$ es consistente maximal.],
    )

  + Dar una derivación que pruebe ${not phi or not psi} tack.r not (phi and psi)$.

  + Dar una derivación que pruebe ${not (phi -> psi)} tack.r phi$.

  + Sea $Gamma subset.eq PROP$. Mediante transformación de derivaciones, pruebe que si
    $ Gamma without {psi} tack.r psi -> phi quad "y" quad Gamma union {chi} tack.r phi, $
    entonces $Gamma tack.r (chi or psi) -> phi$. Además de construir la derivación, calcule el conjunto de hipótesis no canceladas.
]

#show: exam.with(
  title: [Segundo parcial: Lógica Proposicional · 2026],
  short: [Parcial 2 · Lógica Proposicional · 2026],
  note: [Enunciado reconstruido después del examen.],
)

#statement
