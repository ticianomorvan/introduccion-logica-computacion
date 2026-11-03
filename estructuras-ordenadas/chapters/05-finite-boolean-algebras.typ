#import "../../lib/notes.typ": *

= Álgebras de Boole finitas <ch-finite-boolean-algebras>

En este capítulo probamos que toda álgebra de Boole finita es isomorfa al álgebra de partes de su conjunto de átomos, y obtenemos de ahí un criterio para decidir si un reticulado finito es un álgebra de Boole. Luego extendemos la idea a los reticulados distributivos finitos, que se representan mediante los conjuntos decrecientes de sus elementos irreducibles.

== Representación de álgebras de Boole finitas

Recordemos que, dado un poset $upright(bold(P))$ con elemento mínimo $0$, un elemento $a$ es un _átomo_ (@def-atom) si cubre a $0$, y que
$ "At"(upright(bold(P))) = {a in P : a "es átomo de" upright(bold(P))}. $

Nos interesa ver que, en las álgebras de Boole finitas, los átomos "separan" elementos distintos.

#lemma[
  Sea $upright(bold(L))$ un reticulado *finito*. Para todo $x in L$, $x != 0$, existe un átomo $a$ tal que $a <= x$.
] <lem-finite-lattice-atom-below>

#lemma(title: [separación])[
  Sea $upright(bold(B))$ un álgebra de Boole finita y sean $x, y in B$ tales que $x lt.eq.not y$. Entonces existe un átomo $a$ tal que
  $ a <= x quad "y" quad a lt.eq.not y. $
] <lem-atom-separation>

#lemma[
  Sea $upright(bold(L))$ un reticulado distributivo con elemento mínimo $0$. Sean $b_1, dots, b_n in L$ y $a$ un átomo de $upright(bold(L))$. Si $a <= b_1 or dots.c or b_n$, entonces $a <= b_i$ para algún $i$, $1 <= i <= n$.
] <lem-atom-below-join>

#theorem(title: [Representación de álgebras de Boole finitas])[
  Sea $upright(bold(B)) = (B, <=)$ un álgebra de Boole finita. La función
  $ F : B &-> cal(P)("At"(upright(bold(B)))) \
      x &|-> {a in "At"(upright(bold(B))) : a <= x} $
  es un isomorfismo entre $upright(bold(B))$ y $(cal(P)("At"(upright(bold(B)))), union, inter, ""^c, emptyset, "At"(upright(bold(B))))$, y la inversa de $F$ es el $sup$.
] <thm-finite-boolean-algebra-representation>

#proof[
  Por el @thm-boolean-iso-iff-poset-iso, basta probar que $F$ es un isomorfismo de posets.

  (1) $F$ es *biyectiva*.

  _Inyectiva:_ por el lema de separación (@lem-atom-separation). En efecto, si $x != y$, entonces $x lt.eq.not y$ o $y lt.eq.not x$; en el primer caso existe un átomo $a$ con $a <= x$ y $a lt.eq.not y$, es decir, $a in F(x)$ y $a in.not F(y)$, y el segundo caso es simétrico. Luego $F(x) != F(y)$.

  _Suryectiva:_ consideremos $A = {a_1, dots, a_n}$ un conjunto de átomos. Veremos que $F(sup(A)) = A$. La inclusión $A subset.eq F(sup(A))$ es trivial. Para ver la otra inclusión, sea $a in F(sup(A))$; entonces $a <= a_1 or dots.c or a_n$. Por el @lem-atom-below-join, $a <= a_i$ para algún $i$. Como $a$ y $a_i$ son átomos, $a = a_i$ y en consecuencia $a in A$. Por lo tanto $F(sup(A)) subset.eq A$.

  (2) Para todo $x, y in B$, $x <= y <==> F(x) subset.eq F(y)$.

  Sean $x, y in B$ tales que $x <= y$. Si $a in F(x)$, es decir, $a <= x$, entonces por transitividad $a <= y$, por lo que $F(x) subset.eq F(y)$.

  Para ver la otra implicación probaremos la contrarrecíproca. Si $x lt.eq.not y$, por el lema de separación existe un átomo $a$ tal que $a <= x$ y $a lt.eq.not y$, lo que implica $F(x) subset.eq.not F(y)$.
]

#corollary[
  Si $upright(bold(B))$ es un álgebra de Boole finita, entonces $|B| = 2^n$ para algún $n in NN$.
] <cor-finite-boolean-algebra-cardinality>

#corollary[
  Si $upright(bold(B))$ y $upright(bold(B))'$ son álgebras de Boole finitas y $g : "At"(upright(bold(B))) -> "At"(upright(bold(B))')$ es una función biyectiva, existe un y solo un isomorfismo $G : upright(bold(B)) -> upright(bold(B))'$ que extiende a $g$. Es decir, todo isomorfismo de álgebras de Boole está determinado por su valor en los átomos.
] <cor-boolean-isomorphism-from-atoms>

#corollary[
  Si $upright(bold(B))$ y $upright(bold(B))'$ son dos álgebras de Boole finitas, son isomorfas si y solo si tienen la misma cantidad de átomos.
] <cor-finite-boolean-algebras-isomorphic-iff-atoms>

== Un criterio

El @thm-finite-boolean-algebra-representation nos sirve como criterio para determinar si un reticulado finito es o no un álgebra de Boole. Para cualquier reticulado finito $upright(bold(L))$ podemos realizar la construcción $(cal(P)("At"(upright(bold(L)))), subset.eq)$ y fijarnos si es isomorfa a $upright(bold(L))$.

#corollary(title: [Criterio])[
  Un reticulado finito $upright(bold(L))$ es un álgebra de Boole si y solo si resulta isomorfo a $(cal(P)("At"(upright(bold(L)))), subset.eq)$.
] <cor-boolean-algebra-criterion>

== Conjuntos decrecientes de un poset

#definition[
  Sea $upright(bold(P)) = (P, <=)$ un poset. Decimos que un subconjunto $D subset.eq P$ es _decreciente_ si y solo si para todo $x, z in P$,
  $ "si" x in D "y" z <= x", entonces" z in D. $
  Llamaremos $cal(D)(upright(bold(P)))$ a la familia de todos los subconjuntos decrecientes de $upright(bold(P))$.
] <def-decreasing-set>

#lemma[
  Dado un poset $upright(bold(P))$, se tiene que $(cal(D)(upright(bold(P))), subset.eq)$ es un subreticulado de $(cal(P)(P), subset.eq)$.
] <lem-decreasing-sets-sublattice>

#corollary[
  $(cal(D)(upright(bold(P))), subset.eq)$ es distributivo.
] <cor-decreasing-sets-distributive>

== Representación de reticulados distributivos finitos

Recordemos que, dado un reticulado $upright(bold(L))$, un elemento $u in L$ es _(supremo) irreducible_ (@def-join-irreducible) si y solo si cubre exactamente a un elemento, y que denotamos con $"Irr"(upright(bold(L)))$ al conjunto de los elementos irreducibles de $upright(bold(L))$.

#lemma(title: [separación por irreducibles])[
  Sea $upright(bold(L))$ un reticulado finito y sean $x, y in L$ tales que $x lt.eq.not y$. Entonces existe un elemento irreducible $u$ tal que $u <= x$ y $u lt.eq.not y$.
] <lem-irreducible-separation>

#lemma[
  Sea $upright(bold(L))$ un reticulado distributivo, $x_1, dots, x_n in L$ y $u$ un irreducible de $upright(bold(L))$. Si $u <= x_1 or dots.c or x_n$, entonces existe $i$, $1 <= i <= n$, tal que $u <= x_i$.
] <lem-irreducible-below-join>

#theorem(title: [Birkhoff])[
  Sea $upright(bold(L))$ un reticulado distributivo finito. Entonces la función
  $ F : L &-> cal(D)("Irr"(upright(bold(L)))) \
      x &|-> {u in "Irr"(upright(bold(L))) : u <= x} $
  es un isomorfismo entre $(L, <=)$ y $(cal(D)("Irr"(upright(bold(L)))), subset.eq)$.
] <thm-birkhoff>

#proof[
  Notemos primero que $F(x)$ es decreciente en $"Irr"(upright(bold(L)))$, con el orden heredado de $upright(bold(L))$: si $u in F(x)$ y $v <= u$ es irreducible, entonces $v <= x$ por transitividad, es decir, $v in F(x)$. Tenemos que probar que:

  + $F$ es biyectiva.

    Es inyectiva por el lema de separación por irreducibles (@lem-irreducible-separation): si $x != y$, entonces $x lt.eq.not y$ o $y lt.eq.not x$, y en cada caso hay un irreducible que pertenece a uno de los conjuntos $F(x)$, $F(y)$ y no al otro.

    Para ver que es suryectiva tomemos $D = {x_1, dots, x_n} subset.eq "Irr"(upright(bold(L)))$ un conjunto decreciente. Probaremos que $D = F(sup(D))$. La inclusión $D subset.eq F(sup(D))$ es trivial. Para ver la otra inclusión tomemos $u in F(sup(D))$. Tenemos entonces que $u <= x_1 or dots.c or x_n$. Dado que $u$ es irreducible, por el @lem-irreducible-below-join, $u <= x_i$ para algún $i$. Como $D$ es decreciente, $u in D$, con lo que hemos probado la otra inclusión.

  + Para todo $x, y in L$, $x <= y <==> F(x) subset.eq F(y)$.

    Tomemos $x, y in L$ con $x <= y$. Si $u$ es un irreducible y $u <= x$, por transitividad, $u <= y$. Esto implica $F(x) subset.eq F(y)$.

    Para ver la otra implicación probamos la contrarrecíproca y usamos el lema de separación por irreducibles: si $x lt.eq.not y$, existe un irreducible $u$ con $u <= x$ y $u lt.eq.not y$, es decir, $u in F(x)$ y $u in.not F(y)$, lo que implica $F(x) subset.eq.not F(y)$.
]
