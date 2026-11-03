#import "../../lib/notes.typ": *

= Completitud <ch-completeness>

El teorema de corrección (@thm-soundness) nos asegura que todo lo que derivamos es válido. En este capítulo probamos la recíproca: si $Gamma ⊨ phi$, entonces $Gamma tack.r phi$. Seguimos con los conectivos $and$, $->$ y $bot$, y con $not phi eq.dot phi -> bot$ (@not-restricted-connectives).

#remark(title: [Plan de la demostración])[
  Queremos probar que $Gamma ⊨ phi$ implica $Gamma tack.r phi$. Si $Gamma ⊨ phi$, entonces no existe ningún modelo de $Gamma union {not phi}$. Si no existe un modelo de $Gamma union {not phi}$, entonces $Gamma union {not phi} tack.r bot$: ¡esto es lo difícil! Por lo tanto, $Gamma tack.r phi$ por RAA.
] <rem-completeness-plan>

== Consistencia

#definition[
  Un conjunto $Gamma subset.eq "Prop"$ es _inconsistente_ si $Gamma tack.r bot$, y es _consistente_ si $Gamma tack.r.not bot$.
] <def-consistent>

#proposition[
  Sea $Gamma subset.eq "Prop"$. Son equivalentes:
  + $Gamma$ es inconsistente;
  + existe $phi in "Prop"$ tal que $Gamma tack.r phi$ y $Gamma tack.r not phi$;
  + para toda $phi in "Prop"$, $Gamma tack.r phi$.
] <prop-inconsistency-equivalences>

#proof[
  (1 $==>$ 3) Si $Gamma tack.r bot$, para cualquier $phi$ aplicamos RAA a una derivación de $bot$ con hipótesis en $Gamma$ y obtenemos $Gamma tack.r phi$.

  (3 $==>$ 2) Basta tomar cualquier $phi$: por hipótesis, $Gamma tack.r phi$ y $Gamma tack.r not phi$.

  (2 $==>$ 1) Como $not phi = phi -> bot$, de $Gamma tack.r phi$ y $Gamma tack.r phi -> bot$ obtenemos $Gamma tack.r bot$ por $-> E$.
]

#lemma(title: [Consecuencias de la inconsistencia])[
  + Si $Gamma union {not phi} tack.r bot$, entonces $Gamma tack.r phi$.
  + Si $Gamma union {phi} tack.r bot$, entonces $Gamma tack.r not phi$.
] <lem-inconsistency-consequences>

#proof[
  (1) Aplicamos RAA a una derivación de $bot$ con hipótesis en $Gamma union {not phi}$, cancelando $not phi$. (2) Aplicamos $-> I$ a una derivación de $bot$ con hipótesis en $Gamma union {phi}$, cancelando $phi$; obtenemos $phi -> bot = not phi$.
]

=== Criterios de consistencia

¿Cómo podemos saber si un conjunto $Gamma$ es consistente? Para probar que $emptyset$ es consistente, es decir, $tack.r.not bot$, usamos el lema de no derivabilidad (@lem-non-derivability y @cor-bot-not-derivable). En general, vale lo siguiente.

#proposition(title: [Criterio de consistencia])[
  Si existe un modelo de $Gamma$, entonces $Gamma$ es consistente.
] <prop-consistency-criterion>

#proof[
  Sea $f$ un modelo de $Gamma$ y supongamos $Gamma tack.r bot$ para llegar a una contradicción. Entonces, por corrección (@thm-soundness), $#sem($bot$, $f$) = 1$: la contradicción que buscábamos. Por lo tanto, $Gamma tack.r.not bot$.
]

#exercise[
  ¿Es consistente el conjunto ${p_0, not p_1, p_2, not p_3, dots, p_(2k), not p_(2k+1), dots}$?
] <exr-alternating-atoms-consistent>

En cambio, para ver que un conjunto $Gamma$ es inconsistente, ¡debemos mostrar $Gamma tack.r bot$!

== Conjuntos consistentes maximales

¿Será cierta la vuelta del criterio de consistencia? Es decir, si $Gamma$ es consistente, ¿existe un modelo de $Gamma$? Si así fuera, tendríamos lo que necesita el plan de la demostración (@rem-completeness-plan): si $Gamma union {not phi}$ no tiene un modelo, entonces $Gamma union {not phi}$ es inconsistente, $Gamma union {not phi} tack.r bot$, y por lo tanto $Gamma tack.r phi$.

#definition[
  Un conjunto $Gamma subset.eq "Prop"$ es _consistente maximal_ si es consistente y, para todo $Delta$ consistente, $Gamma subset.eq Delta$ implica $Delta = Gamma$.
] <def-maximal-consistent>

#remark[
  En la práctica, un conjunto consistente $Delta$ es consistente maximal si no existe $psi in.not Delta$ tal que $Delta union {psi}$ siga siendo consistente.
] <rem-maximal-consistent-practical>

#lemma[
  Los consistentes maximales son cerrados por derivación: si $Delta$ es consistente maximal, entonces $Delta tack.r phi$ implica $phi in Delta$.
] <lem-maximal-closed-derivation>

#proof[
  Supongamos $Delta tack.r phi$. El conjunto $Delta union {phi}$ es consistente: si fuera $Delta union {phi} tack.r bot$, por @lem-inconsistency-consequences tendríamos $Delta tack.r not phi$, y junto con $Delta tack.r phi$, $Delta$ sería inconsistente (@prop-inconsistency-equivalences). Como $Delta subset.eq Delta union {phi}$, por maximalidad $Delta union {phi} = Delta$, es decir, $phi in Delta$.
]

#lemma[
  Sea $Delta$ un conjunto consistente maximal. Entonces $Delta$ _realiza_ los conectivos:
  + Para toda $phi in "Prop"$, $phi in.not Delta$ si y solo si $not phi in Delta$.
  + $phi in Delta$ y $psi in Delta$ si y solo si $phi and psi in Delta$.
  + (a) Si $phi in Delta$ implica $psi in Delta$, entonces $phi -> psi in Delta$. \
    (b) Si $phi -> psi in Delta$, entonces $phi in Delta$ implica $psi in Delta$.
] <lem-maximal-connectives>

#proof[
  En los tres casos concluimos que la proposición está en $Delta$ porque $Delta$ es cerrado por derivaciones (@lem-maximal-closed-derivation).

  (1) Si $phi in.not Delta$, por maximalidad $Delta union {phi}$ es inconsistente; por @lem-inconsistency-consequences, $Delta tack.r not phi$, y luego $not phi in Delta$. Recíprocamente, si $not phi in Delta$ y $phi in Delta$, entonces $Delta tack.r phi$ y $Delta tack.r not phi$, y $Delta$ sería inconsistente (@prop-inconsistency-equivalences); luego $phi in.not Delta$.

  (2) Si $phi, psi in Delta$, por $and I$ tenemos $Delta tack.r phi and psi$, y luego $phi and psi in Delta$. Recíprocamente, si $phi and psi in Delta$, por $and E$ tenemos $Delta tack.r phi$ y $Delta tack.r psi$, y luego $phi, psi in Delta$.

  (3.a) Si $phi in Delta$, entonces $psi in Delta$ y, aplicando $-> I$ a la derivación que consiste solo en la hipótesis $psi$, $Delta tack.r phi -> psi$. Si $phi in.not Delta$, por (1) $not phi in Delta$; de la hipótesis $phi$ y de $not phi = phi -> bot$ obtenemos $bot$ por $-> E$, luego $psi$ por RAA, y finalmente $phi -> psi$ por $-> I$ cancelando $phi$. En ambos casos $Delta tack.r phi -> psi$, y luego $phi -> psi in Delta$.

  (3.b) Si $phi -> psi in Delta$ y $phi in Delta$, por $-> E$ tenemos $Delta tack.r psi$, y luego $psi in Delta$.
]

Si $Delta$ es consistente maximal y sabemos que ciertas proposiciones están en $Delta$, entonces podemos saber que otras también están.

#example[
  Si $phi in Delta$, entonces $psi -> phi in Delta$, para todo $psi$.
] <ex-maximal-implication>

#remark[
  Si $Gamma$ es consistente, entonces pueden existir varios $Delta_i$ consistentes maximales tales que $Gamma subset.eq Delta_i$. Por ejemplo, $emptyset$ es consistente (¿por qué?) y hay muchos maximales que lo contienen.
] <rem-many-maximal-extensions>

== Existencia de un modelo

#corollary[
  Sea $Delta$ consistente maximal. Entonces, para toda $phi in "Prop"$, o bien $phi in Delta$, o bien $not phi in Delta$.
] <cor-maximal-either-or>

#proof[
  Es el ítem (1) de @lem-maximal-connectives.
]

#lemma[
  Si $Delta$ es consistente maximal, entonces existe un modelo de $Delta$.
] <lem-maximal-has-model>

#proof[
  Definamos $f : cal(V) -> bb(2)$ de la siguiente manera:
  $ f thin p_i = cases(
    1 quad & "si" p_i in Delta,
    0 & "si" p_i in.not Delta.
  ) $
  Probamos que $#sem($psi$, $f$) = 1$ si y solo si $psi in Delta$, usando inducción en $psi$.

  Si $psi = p_i$, vale por la definición de $f$. Si $psi = bot$, tenemos $#sem($bot$, $f$) = 0$ y $bot in.not Delta$, pues $Delta$ es consistente.

  Si $psi = phi and chi$, entonces $#sem($psi$, $f$) = 1$ si y solo si $#sem($phi$, $f$) = 1$ y $#sem($chi$, $f$) = 1$, si y solo si (por hipótesis inductiva) $phi in Delta$ y $chi in Delta$, si y solo si (por el ítem (2) de @lem-maximal-connectives) $psi in Delta$.

  Si $psi = phi -> chi$, entonces $#sem($psi$, $f$) = 1$ si y solo si $#sem($phi$, $f$) = 0$ o $#sem($chi$, $f$) = 1$, si y solo si (por hipótesis inductiva) $phi in Delta$ implica $chi in Delta$, si y solo si (por los ítems (3.a) y (3.b) de @lem-maximal-connectives) $psi in Delta$.

  En particular, $#sem($psi$, $f$) = 1$ para toda $psi in Delta$, es decir, $f$ es modelo de $Delta$.
]

== Extensión a maximales

Para ver que todo conjunto consistente $Gamma$ tiene un modelo, lo extendemos a uno maximal $Gamma^*$. Como las proposiciones son numerables, podemos pensarlas dadas por una lista infinita $phi_0, phi_1, phi_2, dots$

#definition[
  Sea $Gamma$ un conjunto consistente y $phi_0, phi_1, phi_2, dots$ una enumeración de $"Prop"$. Definimos
  $ Gamma_0 &= Gamma, \
    Gamma_(n+1) &= cases(
      Gamma_n & "si" Gamma_n union {phi_n} tack.r bot,
      Gamma_n union {phi_n} quad & "si" Gamma_n union {phi_n} tack.r.not bot,
    ) \
    Gamma^* &= union.big_(n in NN) Gamma_n. $
] <def-maximal-extension>

#lemma[
  $Gamma^*$ es consistente maximal, y $Gamma subset.eq Gamma^*$.
] <lem-extension-maximal>

#proof[
  Por construcción, $Gamma = Gamma_0 subset.eq Gamma_1 subset.eq dots.c subset.eq Gamma^*$, y cada $Gamma_n$ es consistente, por inducción en $n$: $Gamma_0 = Gamma$ lo es, y $Gamma_(n+1)$ es $Gamma_n$ o bien $Gamma_n union {phi_n}$ cuando este es consistente.

  $Gamma^*$ es consistente: si $Gamma^* tack.r bot$, una derivación de $bot$ con hipótesis en $Gamma^*$ usa finitas hipótesis, que están todas en algún $Gamma_n$ porque la cadena es creciente; luego $Gamma_n tack.r bot$, una contradicción.

  $Gamma^*$ es maximal: sea $Delta$ consistente con $Gamma^* subset.eq Delta$, y sea $psi in Delta$. Entonces $psi = phi_m$ para algún $m$, y $Gamma_m union {phi_m} subset.eq Delta$ es consistente, pues toda derivación con hipótesis en él tiene hipótesis en $Delta$. Luego $Gamma_(m+1) = Gamma_m union {phi_m}$ y $psi in Gamma^*$. Así, $Delta subset.eq Gamma^*$ y $Delta = Gamma^*$.
]

== El teorema de completitud

#lemma[
  Si $f$ es modelo de $Delta$ y $Gamma subset.eq Delta$, entonces $f$ es modelo de $Gamma$.
] <lem-model-subset>

#proof[
  Toda $psi in Gamma$ está en $Delta$, luego $#sem($psi$, $f$) = 1$.
]

#proposition(title: [Vuelta del criterio de consistencia])[
  Todo conjunto consistente tiene un modelo. Equivalentemente, por la contrarrecíproca, si $Gamma$ no tiene un modelo, entonces $Gamma$ es inconsistente.
] <prop-consistent-has-model>

#proof[
  Sea $Gamma$ consistente. Por @lem-extension-maximal, $Gamma$ se extiende a un consistente maximal $Gamma^* supset.eq Gamma$; por @lem-maximal-has-model, $Gamma^*$ tiene un modelo $f$; y por @lem-model-subset, $f$ es modelo de $Gamma$.
]

#theorem(title: [Completitud])[
  Si $Gamma ⊨ phi$, entonces $Gamma tack.r phi$.
] <thm-completeness>

#proof[
  Supongamos $Gamma ⊨ phi$. Entonces no existe un modelo $f$ de $Gamma union {not phi}$: como $f$ sería modelo de $Gamma$, tendríamos $#sem($phi$, $f$) = 1$, y entonces $#sem($not phi$, $f$) = #sem($phi -> bot$, $f$) = 0$. Luego, por el criterio de consistencia (@prop-consistent-has-model), $Gamma union {not phi}$ es inconsistente. Por lo tanto, $Gamma tack.r phi$ (@lem-inconsistency-consequences).
]
