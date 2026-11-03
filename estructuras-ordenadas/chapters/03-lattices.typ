#import "../../lib/notes.typ": *

// Circled ∨ and ∧ for the operations of an abstract lattice, before they are identified with sup and inf.
#let circled(op) = math.class("binary", box(baseline: 0.1em, circle(radius: 0.36em, stroke: 0.04em, inset: 0pt, align(center + horizon, text(size: 0.8em, op)))))
#let ovee = circled($or$)
#let owedge = circled($and$)

= Reticulados <ch-lattices>

Recordemos que un poset reticulado (@def-lattice-ordered-poset) es un poset $(P, <=)$ en el que todo par de elementos $x, y in P$ tiene supremo e ínfimo, que notamos $x or y = sup{x, y}$ y $x and y = inf{x, y}$ (@not-join-meet). En este capítulo estudiamos las propiedades de estas operaciones, la noción de isomorfismo entre posets, y la presentación algebraica de los reticulados, en la que $or$ y $and$ pasan a ser las operaciones primitivas.

== Posets reticulados

#lemma[
  Sea $(P, <=)$ un poset reticulado y sean $x, y, z in P$. Se satisfacen las siguientes equivalencias:
  - $x or y <= z$ sii $x <= z$ y $y <= z$;
  - $z <= x and y$ sii $z <= x$ y $z <= y$.
] <lem-sup-inf-characterization>

Como aplicaciones del @lem-sup-inf-characterization se obtienen las siguientes desigualdades.

#corollary(title: "Leyes de compatibilidad o monotonía")[
  Sea $(P, <=)$ un poset reticulado y sean $x, y, z, w in P$. Si $x <= y$ y $z <= w$, entonces
  $ x or z <= y or w quad "y" quad x and z <= y and w. $
] <cor-join-meet-monotonicity>

#corollary(title: "Desigualdades distributivas")[
  Sea $(P, <=)$ un poset reticulado y sean $x, y, z in P$. Entonces
  $ x or (y and z) <= (x or y) and (x or z) quad "y" quad x and (y or z) >= (x and y) or (x and z). $
] <cor-distributive-inequalities>

#proposition(title: "Propiedades de supremos e ínfimos")[
  Sea $(P, <=)$ un poset reticulado. Para todos $x, y, z in P$ valen:
  + Leyes de idempotencia: $x or x = x and x = x$.
  + Leyes conmutativas: $x or y = y or x$, $x and y = y and x$.
  + Leyes de absorción: $x or (x and y) = x$, $x and (x or y) = x$.
  + Leyes asociativas: $(x or y) or z = x or (y or z)$, $(x and y) and z = x and (y and z)$.
] <prop-join-meet-laws>

== Isomorfismo de posets

#definition(title: "Isomorfismo de posets")[
  Sean $upright(bold(P)) = (P, <=)$ y $upright(bold(Q)) = (Q, <=')$ dos posets. Dada una función $f : P -> Q$, decimos que $f$ es un *isomorfismo* entre $upright(bold(P))$ y $upright(bold(Q))$ sii
  - $f$ es biyectiva, y
  - para todo $x, y in P$, $ x <= y <==> f(x) <=' f(y). $
  Cuando *existe* uno de tales isomorfismos decimos que $upright(bold(P))$ y $upright(bold(Q))$ son *isomorfos* y escribimos $upright(bold(P)) tilde.equiv upright(bold(Q))$.
] <def-poset-isomorphism>

#example[
  - $D_12$ y $D_18$ son isomorfos.
  - $D_2$ y $(cal(P)({a}), subset.eq)$ son isomorfos.
] <ex-poset-isomorphisms>

Los isomorfismos preservan toda la estructura de orden: cotas, supremos e ínfimos.

#proposition[
  Sea $f$ un isomorfismo de $(P, <=)$ en $(Q, <=')$ y sean $u in P$ y $S subset.eq P$. Entonces $u$ es cota superior de $S$ sii $f(u)$ es cota superior de
  $ f(S) := {f(x) : x in S}. $
] <prop-isomorphism-upper-bounds>

#lemma[
  Sea $f$ un isomorfismo de $(P, <=)$ en $(Q, <=')$ y sea $S subset.eq P$. Entonces:
  - Existe el supremo de $S$ sii existe el supremo de $f(S)$. En tal caso, además, $ f(sup(S)) = sup(f(S)). $
  - Existe el ínfimo de $S$ sii existe el ínfimo de $f(S)$. En tal caso, además, $ f(inf(S)) = inf(f(S)). $
] <lem-isomorphism-sup-inf>

== Reticulados

Las propiedades de la @prop-join-meet-laws sirven para definir los reticulados de manera puramente algebraica, sin hacer referencia a un orden. Para distinguir estas operaciones abstractas del supremo y el ínfimo de un poset, las escribimos por ahora $ovee$ y $owedge$.

#definition(title: "Reticulado")[
  Un *reticulado* es una terna $(L, ovee, owedge)$, donde $L$ es un conjunto y $ovee$ y $owedge$ son dos operaciones binarias sobre $L$ que cumplen, para todos $x, y, z in L$:
  + Idempotencia: $x ovee x = x owedge x = x$.
  + Conmutatividad: $x ovee y = y ovee x$, $x owedge y = y owedge x$.
  + Absorción: $x ovee (x owedge y) = x$, $x owedge (x ovee y) = x$.
  + Asociatividad: $(x ovee y) ovee z = x ovee (y ovee z)$, $(x owedge y) owedge z = x owedge (y owedge z)$.
] <def-lattice>

#remark[
  Por la @prop-join-meet-laws, dado un poset reticulado $(L, <=)$, las operaciones de supremo e ínfimo asociadas satisfacen todas estas propiedades, por lo que $(L, or, and)$ es un reticulado.
] <rem-lattice-poset-to-algebra>

Recíprocamente, todo reticulado proviene de un poset reticulado.

#theorem[
  Sea $(L, ovee, owedge)$ un reticulado y sea $<<$ la relación sobre $L$ definida por
  $ x << y <==> x ovee y = y. $
  Entonces $(L, <<)$ es un poset reticulado y, además, $sup{x, y} = x ovee y$ e $inf{x, y} = x owedge y$.
] <thm-lattice-algebra-to-poset>

De ahora en más, la palabra _reticulado_ (a secas) se referirá tanto a un poset reticulado como al reticulado asociado, y escribiremos sus operaciones $or$ y $and$. Usaremos los términos específicos si queremos dar énfasis a alguno de los dos aspectos (relacional o algebraico, respectivamente).

== Subreticulados

#definition(title: "Subreticulado")[
  Sea $(L, or, and)$ un reticulado y sea $S subset.eq L$. Diremos que $S$ es un *subuniverso* de $(L, or, and)$ si es cerrado por las operaciones $or$ y $and$. En tal caso decimos que $(S, class("normal", or)|_S, class("normal", and)|_S)$ es un *subreticulado* de $(L, or, and)$; de aquí en más obviaremos la notación de restricción y escribiremos $(S, or, and)$.
] <def-sublattice>

También escribimos usualmente “$(S, <=)$ es subreticulado de $(L, <=)$”, pero nos estaremos refiriendo siempre a la noción algebraica de la @def-sublattice.

No debemos confundir _subreticulado_ con _subposet_: todo subconjunto de $L$ da lugar a un subposet, pero no todo subconjunto de $L$ es un subuniverso.

#example[
  $({1, 2, 3, 12}, divides)$ es un subposet de $D_12$ y es un reticulado, pero no es un subreticulado de $D_12$, pues en $D_12$ vale $2 or 3 = 6 in.not {1, 2, 3, 12}$.
] <ex-sublattice-vs-subposet>

#example[
  $(D_n, divides)$ es subreticulado de $(NN, divides)$.
] <ex-divisors-sublattice>

#exercise[
  ¿Es $([0, 1) union [2, 3), <=)$ subreticulado de $(RR, <=)$?
] <exr-real-intervals-sublattice>

== Isomorfismos de reticulados

#definition(title: "Isomorfismo de reticulados")[
  Sean $upright(bold(L)) = (L, or, and)$ y $upright(bold(L))' = (L', or', and')$ dos reticulados y $f : L -> L'$ una función. Decimos que $f$ es un *isomorfismo* de $upright(bold(L))$ en $upright(bold(L))'$ sii $f$ es biyectiva y, para todo $x, y in L$,
  $ f(x or y) = f(x) or' f(y) quad "y" quad f(x and y) = f(x) and' f(y). $
] <def-lattice-isomorphism>

Las dos presentaciones de un reticulado dan lugar a la misma noción de isomorfismo.

#theorem[
  Dados dos reticulados $upright(bold(L)) = (L, or, and)$ y $upright(bold(L))' = (L', or', and')$, sean $(L, <=)$ y $(L', <=')$ los posets reticulados asociados, respectivamente. Para toda función $f : L -> L'$ se tiene que
  $ f : (L, or, and) -> (L', or', and') "es un isomorfismo" <==> f : (L, <=) -> (L', <=') "es un isomorfismo". $
] <thm-lattice-iso-iff-poset-iso>

== Incrustaciones

#definition(title: "Incrustación")[
  Dados dos reticulados $upright(bold(L)) = (L, or, and)$ y $upright(bold(L))' = (L', or', and')$, decimos que $upright(bold(L))$ *se incrusta* en $upright(bold(L))'$ sii existe un subreticulado $upright(bold(S))$ de $upright(bold(L))'$ isomorfo a $upright(bold(L))$.
] <def-lattice-embedding>

#example[
  $D_4$ se incrusta en $(cal(P)({a, b, c}), subset.eq)$.
] <ex-d4-embeds-powerset>

Un reticulado es _acotado_ si tiene primer y último elemento, y un reticulado acotado es _complementado_ si todos sus elementos tienen complemento. Estas nociones se definen con precisión al comienzo del @ch-boolean-algebras: ver la @def-bounded-lattice, la @def-complement y la @def-complemented-lattice.
