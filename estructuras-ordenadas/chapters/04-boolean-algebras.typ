#import "../../lib/notes.typ": *

= Reticulados distributivos y álgebras de Boole <ch-boolean-algebras>

En este capítulo enriquecemos la estructura de reticulado del @ch-lattices: primero con constantes para el primer y el último elemento, luego con una operación de complemento, y finalmente con la propiedad distributiva. Las tres juntas dan lugar a las álgebras de Boole. Cerramos con los átomos y los elementos irreducibles.

== Reticulados acotados y complementados

#definition(title: "Reticulado acotado")[
  Una estructura $(L, or, and, 0, 1)$ es un *reticulado acotado* si $(L, or, and)$ es un reticulado, $0, 1 in L$ y, para todo $x in L$,
  $ x and 0 = 0 quad "y" quad x or 1 = 1. $
] <def-bounded-lattice>

#remark[
  $(L, or, and, 0, 1)$ es un reticulado acotado sii $(L, <=)$ es un reticulado con máximo $1$ y mínimo $0$, es decir, con primer elemento $0$ y último elemento $1$; cuando haga falta indicar el reticulado, los notamos $0^upright(bold(L))$ y $1^upright(bold(L))$. Por eso a veces nos referiremos indistintamente a una u otra estructura.
] <rem-bounded-lattice-order>

#exercise[
  Probar que si $(L, or, and, 0, 1)$ es un reticulado acotado, entonces, para todo $x in L$,
  $ x or 0 = x quad "y" quad x and 1 = x. $
] <exr-bounded-lattice-identities>

#definition(title: "Complemento")[
  Sea $upright(bold(L)) = (L, or, and, 0, 1)$ un reticulado acotado. Dados $a, b in L$, diremos que $b$ es *complemento* de $a$ si
  $ a or b = 1 quad "y" quad a and b = 0. $
] <def-complement>

Un elemento puede no tener complemento, o tener varios.

#definition(title: "Reticulado complementado")[
  Un *reticulado complementado* es una estructura $(L, or, and, not, 0, 1)$ tal que $(L, or, and, 0, 1)$ es un reticulado acotado y $not$ es una función unaria tal que, para todo $x in L$, $not x$ es un complemento de $x$.
] <def-complemented-lattice>

Esto no significa que en un reticulado complementado todo elemento tenga un único complemento, sino que tiene al menos uno: la función $not$ “elige” algún complemento para cada elemento de $L$. Así, un reticulado acotado puede verse como complementado exactamente cuando todos sus elementos tienen complemento.

== Reticulados distributivos

En todo reticulado valen las desigualdades distributivas (@cor-distributive-inequalities); los reticulados distributivos son aquellos en los que valen como igualdades.

#lemma[
  Sea $upright(bold(L)) = (L, or, and)$ un reticulado. Son equivalentes:
  + para todo $x, y, z in L$, $x and (y or z) = (x and y) or (x and z)$;
  + para todo $x, y, z in L$, $x or (y and z) = (x or y) and (x or z)$.
] <lem-distributive-laws-equivalent>

#definition(title: "Reticulado distributivo")[
  Dado un reticulado $upright(bold(L)) = (L, or, and)$, decimos que es un *reticulado distributivo* si satisface cualquiera de las condiciones equivalentes del @lem-distributive-laws-equivalent.
] <def-distributive-lattice>

#example[
  Todos los $D_n$ y todos los $(cal(P)(A), subset.eq)$ son distributivos. En cambio, los reticulados $M_3$ y $N_5$, dados por los diagramas de Hasse

  #align(center, grid(
    columns: 2, column-gutter: 5em, row-gutter: 0.6em, align: center + horizon,
    $M_3$, $N_5$,
    image("../img/boolean-algebras/m3-hasse.png", width: 90pt),
    image("../img/boolean-algebras/n5-hasse.png", width: 62pt),
  ))

  no son distributivos.
] <ex-distributive-lattices>

La distributividad se preserva por isomorfismos (@def-lattice-isomorphism), subreticulados (@def-sublattice) e incrustaciones (@def-lattice-embedding).

#lemma(title: "Preservación de la distributividad")[
  Sea $upright(bold(L))$ un reticulado distributivo y $upright(bold(L))'$ un reticulado. Entonces:
  + Si $upright(bold(L))'$ es isomorfo a $upright(bold(L))$, $upright(bold(L))'$ es distributivo.
  + Si $upright(bold(L))'$ es subreticulado de $upright(bold(L))$, $upright(bold(L))'$ es distributivo.
  + Si $upright(bold(L))'$ se incrusta en $upright(bold(L))$, $upright(bold(L))'$ es distributivo.
] <lem-distributivity-preservation>

#lemma(title: "Propiedad cancelativa")[
  Sea $upright(bold(L)) = (L, or, and)$ un reticulado distributivo. Para todos $a, b, c in L$,
  $ cases(reverse: #true, a or c = b or c, a and c = b and c) ==> a = b. $
] <lem-distributive-cancellation>

#corollary[
  Si $upright(bold(L)) = (L, or, and, 0, 1)$ es un reticulado acotado distributivo, todo elemento de $L$ tiene *a lo sumo* un complemento.
] <cor-distributive-unique-complement>

#remark[
  La recíproca no vale: que un reticulado no tenga elementos con dos complementos no implica que sea distributivo.
] <rem-unique-complement-not-distributive>

#exercise(title: "Verdadero o falso")[
  + En un reticulado distributivo acotado, el único complemento del $0$ es el $1$.
  + En un reticulado acotado, el único complemento del $0$ es el $1$.
  + En un reticulado distributivo acotado, todo elemento tiene un complemento.
  + En un reticulado acotado, todo elemento tiene a lo sumo un complemento.
  + En un reticulado distributivo acotado, todo elemento tiene a lo sumo un complemento.
  + En un reticulado acotado *no* distributivo, hay algún elemento con dos complementos.
] <exr-complements-true-false>

Los reticulados $M_3$ y $N_5$ caracterizan a los reticulados distributivos.

#theorem[
  Un reticulado $upright(bold(L))$ es distributivo sii no se incrustan en él ni $M_3$ ni $N_5$.
] <thm-m3-n5-distributivity>

#remark(title: "Estrategia")[
  Con lo visto hasta el momento, para decidir si un reticulado es distributivo:

  #align(center, table(
    columns: 2, align: left, inset: 6pt,
    [*Es distributivo*], [*No es distributivo*],
    [Probar que se incrusta en algo que sabemos que es distributivo, como un $D_n$ o un $(cal(P)(A), subset.eq)$.],
    [Probar que en él se incrustan $M_3$ o $N_5$.],
  ))
] <rem-distributivity-strategy>

== Álgebras de Boole

#definition(title: "Álgebra de Boole")[
  Un *álgebra de Boole* es un reticulado acotado complementado $(B, or, and, not, 0, 1)$ distributivo.
] <def-boolean-algebra>

#example[
  - Toda álgebra de conjuntos $(cal(P)(A), union, inter, ""^c, emptyset, A)$ es un álgebra de Boole.
  - $D_n$ es un álgebra de Boole sii existen $p_1, dots, p_k in NN$, todos primos distintos dos a dos, tales que $n = p_1 dots.c p_k$.
] <ex-boolean-algebras>

#proposition(title: "Leyes de De Morgan")[
  En toda álgebra de Boole $(B, or, and, not, 0, 1)$ valen
  $ not (x or y) = not x and not y quad "y" quad not (x and y) = not x or not y. $
] <prop-de-morgan>

== Isomorfismo de álgebras de Boole

#definition(title: "Isomorfismo de álgebras de Boole")[
  Un *isomorfismo de álgebras de Boole* $f : (B, or, and, not, 0, 1) -> (B', or', and', not', 0', 1')$ es un isomorfismo de reticulados que además satisface, para todo $x in B$,
  $ f(not x) = not' f(x), quad f(0) = 0' quad "y" quad f(1) = 1'. $
] <def-boolean-algebra-isomorphism>

Como ocurre con los reticulados (@thm-lattice-iso-iff-poset-iso), basta con que $f$ sea un isomorfismo entre los posets subyacentes.

#theorem[
  $f : (B, or, and, not, 0, 1) -> (B', or', and', not', 0', 1')$ es un isomorfismo de álgebras de Boole sii $f : (B, <=) -> (B', <=')$ es un isomorfismo de posets.
] <thm-boolean-iso-iff-poset-iso>

== Átomos e irreducibles

#definition(title: "Átomo")[
  Sea $upright(bold(P)) = (P, <=)$ un poset con elemento mínimo $0$ y sea $a in P$. Decimos que $a$ es *átomo* en $upright(bold(P))$ sii $a != 0$ y, para todo $b in P$,
  $ b <= a "implica" b = a "o" b = 0, $
  es decir, $a$ *cubre a* $0$ (@def-cover).
] <def-atom>

#definition(title: "Irreducible")[
  Sea $upright(bold(P)) = (P, <=)$ un poset reticulado. Decimos que $a in P$ es *(supremo) irreducible* en $upright(bold(P))$ sii $a != 0$ (si existiere elemento mínimo $0$) y, para todo $b, c in P$,
  $ a = b or c "implica" a = b "o" a = c. $
  Si $upright(bold(P))$ es finito, esto equivale a que $a$ *cubra exactamente a un elemento*.
] <def-join-irreducible>

#proposition(title: [Irreducibles y átomos en $D_n$])[
  En $D_n$:
  + Los átomos se corresponden con los primos, y los irreducibles con las potencias de primos.
  + Todo irreducible solo puede cubrir a un elemento que es irreducible o $1$.
  + De todos los elementos que cubren a un irreducible, a lo sumo uno puede ser irreducible.
] <prop-dn-atoms-irreducibles>

#exercise[
  ¿Cuáles de los siguientes reticulados son isomorfos a algún $D_n$?

  #align(center, grid(
    columns: 3, column-gutter: 4em, align: bottom,
    image("../img/boolean-algebras/diamond-with-top-chain.png", width: 63pt),
    image("../img/boolean-algebras/diamond-with-bottom-chain.png", width: 63pt),
    image("../img/boolean-algebras/n5-hasse.png", width: 62pt),
  ))
] <exr-dn-isomorphic-lattices>
