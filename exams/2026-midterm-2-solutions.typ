#import "../lib/notes.typ": *
#import "2026-midterm-2.typ": statement, PROP

// Solutions to the 2026 Parcial 2: page 1 is the statement, unchanged; the solutions start on page 2.

#show: exam.with(
  title: [Segundo parcial: Lógica Proposicional · 2026],
  short: [Parcial 2 · Lógica Proposicional · 2026],
  note: [Enunciado reconstruido después del examen.],
  solutions: true,
)

#statement

#pagebreak()

= Resolución

Recordemos que $not phi$ abrevia $phi -> bot$. Para refutar una derivabilidad usamos el lema de no derivabilidad: si $f$ es modelo de $Gamma$ y $#sem($phi$, $f$) = 0$, entonces $Gamma tack.r.not phi$.

== Ejercicio 1

/ (a) Falso: Sean $Gamma = emptyset$ y $phi = p_0$. El conjunto vacío es consistente, porque $tack.r.not bot$, y $not p_0 in.not emptyset$, pero #box[$p_0 in.not emptyset$]. Que un conjunto contenga $phi$ o $not phi$ para toda $phi$ es propio de los consistentes maximales, no de cualquier consistente.

/ (b) Verdadero: Como $phi in Gamma$ y $tack.r phi -> psi$, aplicando $-> E$ a la hoja $phi$ y a la derivación de $phi -> psi$ (sin hipótesis) obtenemos $Gamma tack.r psi$. Los consistentes maximales son cerrados por derivación, así que #box[$psi in Gamma$], y por lo tanto $not psi in.not Gamma$: si no, $Gamma tack.r psi$ y $Gamma tack.r not psi$, y $Gamma$ sería inconsistente.

/ (c) Falso: Sea $Delta = {phi in PROP : p_0 tack.r phi}$. Si $Delta$ fuera consistente maximal, contendría $p_1$ o $not p_1$. Pero ninguna de las dos se deduce de $p_0$:
  - Sea $f(p_0) = 1$ y $f(p_i) = 0$ para $i >= 1$. Entonces $f$ es modelo de ${p_0}$ y $#sem($p_1$, $f$) = 0$, así que $p_0 tack.r.not p_1$.
  - Sea $g(p_i) = 1$ para todo $i$. Entonces $g$ es modelo de ${p_0}$ y $#sem($not p_1$, $g$) = 0$, así que $p_0 tack.r.not not p_1$.

  Luego $p_1 in.not Delta$ y $not p_1 in.not Delta$, y $Delta$ no es maximal.

/ (d) Falso: La fórmula $p_0 -> p_0$ es un teorema: aplicando $-> I$ a la hoja $[p_0]^1$ obtenemos una derivación sin hipótesis no canceladas. Entonces $p_1 tack.r p_0 -> p_0$ y $not p_1 tack.r p_0 -> p_0$, y la intersección contiene a $p_0 -> p_0$.

/ (e) Verdadero: Si $Delta tack.r phi$, existe $D$ con $"hip"(D) subset.eq Delta$ y $"concl"(D) = phi$. Como $Delta subset.eq Gamma$, la misma $D$ cumple $"hip"(D) subset.eq Gamma$, y entonces $Gamma tack.r phi$.

/ (f) Verdadero: Por el Ejercicio 3 con $phi = p_5$ y $psi = p_3$, ${not (p_5 -> p_3)} tack.r p_5$. Como #box[${not (p_5 -> p_3)} subset.eq Gamma$], por (e) vale $Gamma tack.r p_5$. Las hipótesis $p_7$ y $p_4 or p_6$ no se usan.

/ (g) Verdadero: Sea $f(p_1) = 0$, $f(p_2) = 1$ y $f(p_i) = 0$ para $i in.not {1, 2}$ (en particular, $f(p_3) = 0$). Entonces
  $ #sem($p_2 -> not p_1$, $f$) &= max(1 - 1, #sem($not p_1$, $f$)) = max(0, 1) = 1, \
    #sem($p_2 and not p_3$, $f$) &= min(1, #sem($not p_3$, $f$)) = min(1, 1) = 1, \
    #sem($p_1 -> p_3$, $f$) &= max(1 - 0, 0) = 1. $
  Así, $f$ es modelo del conjunto, que por el criterio de consistencia (corrección) es consistente.

/ (h) Falso: Sea $Gamma = {p_0}$, consistente porque tiene un modelo. El conjunto ${not p_0}$ también es consistente (la asignación constante $0$ es modelo), y se extiende a un consistente maximal #box[$Delta supset.eq {not p_0}$]. Entonces $Gamma union Delta tack.r p_0$ y $Gamma union Delta tack.r not p_0$, así que $Gamma union Delta$ es inconsistente y, en particular, no es consistente maximal.

== Ejercicio 2

Como $not (phi and psi) = (phi and psi) -> bot$, suponemos $phi and psi$, llegamos a $bot$ en cada caso de la disyunción y cancelamos $phi and psi$ al final:

$ #prooftree(rule(
  name: $-> I_3$,
  rule(
    name: $or E_(1, 2)$,
    $not phi or not psi$,
    rule(name: $-> E$, rule(name: $and E$, $[phi and psi]^3$, $phi$), $[not phi]^1$, $bot$),
    rule(name: $-> E$, rule(name: $and E$, $[phi and psi]^3$, $psi$), $[not psi]^2$, $bot$),
    $bot$,
  ),
  $not (phi and psi)$,
)) $

La única hipótesis no cancelada es $not phi or not psi$, que no lleva corchetes, y la conclusión es $not (phi and psi)$.

== Ejercicio 3

No hay regla de eliminación que dé $phi$ directamente, así que usamos RAA: suponemos $not phi$ y llegamos a $bot$. Para usar la hipótesis $not (phi -> psi)$ necesitamos $phi -> psi$, que sale de $not phi$ por $bot E$:

$ #prooftree(rule(
  name: $"RAA"_1$,
  rule(
    name: $-> E$,
    rule(
      name: $-> I_2$,
      rule(name: $bot E$, rule(name: $-> E$, $[phi]^2$, $[not phi]^1$, $bot$), $psi$),
      $phi -> psi$,
    ),
    $not (phi -> psi)$,
    $bot$,
  ),
  $phi$,
)) $

La única hipótesis no cancelada es $not (phi -> psi)$, y la conclusión es $phi$.

== Ejercicio 4

#proof[
  Por hipótesis, existen derivaciones $D_1$ y $D_2$ tales que
  $ "hip"(D_1) subset.eq Gamma without {psi}, quad "concl"(D_1) = psi -> phi, wide "hip"(D_2) subset.eq Gamma union {chi}, quad "concl"(D_2) = phi. $
  Queremos una derivación $D'$ con $"hip"(D') subset.eq Gamma$ y $"concl"(D') = (chi or psi) -> phi$. Suponemos $chi or psi$ y la eliminamos: en el caso $chi$ usamos $D_2$, cancelando las hojas $chi$; en el caso $psi$ aplicamos $-> E$ con $D_1$. Al final cancelamos $chi or psi$ con $-> I$:
  $ D' = mat(delim: #none, #prooftree(rule(
    name: $-> I_3$,
    rule(
      name: $or E_(1, 2)$,
      $[chi or psi]^3$,
      deriv($phi$, name: $D_2$, hyp: $[chi]^1$),
      rule(name: $-> E$, $[psi]^2$, deriv($psi -> phi$, name: $D_1$), $phi$),
      $phi$,
    ),
    $(chi or psi) -> phi$,
  ))) $

  Calculamos las hipótesis no canceladas de abajo hacia arriba. Sea $E$ la subderivación del caso $psi$, que termina en $-> E$, y $F$ la que termina en $or E$:
  $ "hip"(E) &= {psi} union "hip"(D_1), \
    "hip"(F) &= {chi or psi} union ("hip"(D_2) without {chi}) union ("hip"(E) without {psi}) \
      &= {chi or psi} union ("hip"(D_2) without {chi}) union "hip"(D_1), \
    "hip"(D') &= "hip"(F) without {chi or psi} = (("hip"(D_2) without {chi}) union "hip"(D_1)) without {chi or psi}. $
  En el segundo renglón, $"hip"(E) without {psi} = "hip"(D_1)$ porque $psi in.not "hip"(D_1)$, ya que $"hip"(D_1) subset.eq Gamma without {psi}$.

  Además, $"hip"(D_2) without {chi} subset.eq (Gamma union {chi}) without {chi} subset.eq Gamma$ y $"hip"(D_1) subset.eq Gamma without {psi} subset.eq Gamma$, así que
  $ "hip"(D') subset.eq ("hip"(D_2) without {chi}) union "hip"(D_1) subset.eq Gamma quad "y" quad "concl"(D') = (chi or psi) -> phi. $
  Por lo tanto, $Gamma tack.r (chi or psi) -> phi$.
]
