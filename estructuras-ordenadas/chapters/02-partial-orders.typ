#import "../../lib/notes.typ": *

= Relaciones de orden <ch-partial-orders>

Recordemos que una relación $R$ sobre un conjunto $A$ es una *relación de orden parcial sobre $A$* sii es reflexiva, antisimétrica y transitiva (@def-partial-order-relation). En este capítulo estudiamos los conjuntos dotados de una relación de este tipo: su representación mediante diagramas de Hasse, los órdenes totales, los elementos distinguidos de un orden (máximo, mínimo, maximales y minimales), las nociones de supremo e ínfimo y, finalmente, los posets reticulados.

== Posets

#definition(title: "Poset")[
  Un *conjunto parcialmente ordenado* (*poset*) es un par $(A, R)$ donde $A$ es un conjunto y $R$ es una relación de orden parcial sobre $A$. Usualmente notamos con $<=$ a la relación de orden, y diremos que $(A, <=)$ es un *poset finito* si $A$ es finito.
] <def-poset>

#example[
  Son posets $(NN, <=)$, $(ZZ, <=)$, $(RR, <=)$ y $(NN, divides)$, así como $(cal(P)(A), subset.eq)$ para cada conjunto $A$.
] <ex-posets>

== Diagramas de Hasse

#definition(title: "Cubrimiento")[
  Dados un poset $(A, <=)$ y $a, b in A$, decimos que $b$ *cubre* a $a$ ($a prec b$) sii
  $ underbrace(a != b \, space a <= b, #[“$a < b$”]) "y, para cualquier" c in A, "si" a <= c <= b "entonces" c = a "o" c = b. $
] <def-cover>

#definition(title: "Diagrama de Hasse")[
  Dado un poset *finito* $(A, <=)$, un *diagrama de Hasse* del mismo es un gráfico en el que se representa la relación de “cubre” asociada, de forma que si $b$ cubre a $a$ hay una línea ascendente de $a$ a $b$.
] <def-hasse-diagram>

== Subposets

#definition(title: "Restricción")[
  Dada una relación $R$ sobre $A$ y $B subset.eq A$, definimos la *restricción de $R$ a $B$* como
  $ R|_B = R inter B times B. $
] <def-relation-restriction>

#remark[
  Si $R$ es una relación de orden sobre $A$, entonces $R|_B$ es una relación de orden sobre $B$.
] <rem-restriction-order>

#definition(title: "Subposet")[
  Dados un orden parcial $(A, <=)$ y $B subset.eq A$, decimos que el poset $(B, <=|_B)$ es un *subposet* de $(A, <=)$. Muchas veces escribiremos $(B, <=)$ directamente.
] <def-subposet>

#example(title: [Conjunto de divisores de $n$])[
  Para cualquier $n$, llamamos
  $ D_n = {k in NN : k divides n}. $
  Entonces $upright(bold(D_6)) = (D_6, divides)$, $upright(bold(D_15)) = (D_15, divides)$ y $upright(bold(D_28)) = (D_28, divides)$ son subposets de $(NN, divides)$.
] <ex-divisor-posets>

== Órdenes totales

#exercise(title: "V o F")[
  Sean $(A, <=)$ un poset y $a, b in A$. Si $a lt.eq.not b$, entonces $b <= a$.

  _Respuesta:_ Falso.
] <exr-incomparable-elements>

#definition(title: "Orden total")[
  Dada una relación $R$ sobre $A$, decimos que $R$ es un *orden total* sobre $A$ sii $R$ es un orden parcial sobre $A$ y además satisface que, para todo $a, b in A$,
  $ a class("relation", R) b "o" b class("relation", R) a. $
  Una *cadena* es un poset $(A, <=)$ en el que $<=$ es un orden total sobre $A$.
] <def-total-order>

#example[
  $(RR, <=)$ y $(NN, <=)$ son cadenas. El orden lexicográfico es un orden total.
] <ex-chains>

#exercise(title: "V o F")[
  + $(NN, divides)$ es una cadena.
  + $(D_8, divides)$ es una cadena.
  + Si $<=$ es un orden total, entonces no es un orden parcial.
  + Si $<=$ es un orden parcial, entonces no es un orden total.
] <exr-chains-true-false>

== Máximo, mínimo, maximal y minimal

#definition[
  Sean $upright(bold(P)) = (P, <=)$ un poset y $m in P$. Decimos que:
  - $m$ es *máximo* de $upright(bold(P))$ sii para todo $a in P$, $a <= m$;
  - $m$ es *mínimo* de $upright(bold(P))$ sii para todo $a in P$, $m <= a$;
  - $m$ es *maximal* de $upright(bold(P))$ sii para todo $a in P$, si $m <= a$ entonces $a = m$;
  - $m$ es *minimal* de $upright(bold(P))$ sii para todo $a in P$, si $a <= m$ entonces $a = m$.
] <def-extremal-elements>

#exercise[
  ¿Cuáles de los siguientes posets tienen máximo, mínimo, maximales y/o minimales?
  + $(NN, <=)$
  + $([0, 1), <=)$
  + $({2, 4, 6, 12, 16}, divides)$
] <exr-extremal-elements>

#theorem[
  Todo poset finito no vacío tiene al menos un elemento maximal (minimal).
] <thm-finite-poset-maximal>

#proof[
  Lo probaremos para maximales, por inducción sobre la cantidad de elementos del poset; la prueba para minimales es análoga.

  Si el poset tiene un único elemento, es fácil ver que este es maximal.

  _HI:_ Para todo poset finito $upright(bold(P)) = (P, <=)$, si $abs(P) = n$ entonces $upright(bold(P))$ tiene un maximal.

  Sea $upright(bold(P)) = (P, <=)$ un poset tal que $abs(P) = n + 1$ y sea $a in P$. Si $a$ es maximal, queda probado. Consideremos entonces el caso en que $a$ no es maximal. Sean $Q = P without {a}$ y $upright(bold(Q)) = (Q, <=)$. Como $abs(Q) = n$, por HI $upright(bold(Q))$ tiene un elemento maximal $m$. Queremos probar que $m$ es maximal en $upright(bold(P))$, es decir, queremos ver que para todo $x in P$
  $ m <= x -> m = x. quad (*) $

  Sea $x in P$. Si $x != a$, entonces $x in Q$, por lo que $(*)$ se sigue trivialmente. Nos queda ver el caso $x = a$. Para mayor claridad, vamos a utilizar la notación “$x < y$” para expresar la relación “$x <= y$ y $x != y$”.

  Supongamos que $m <= a$. Recordemos que supusimos que $a$ no es maximal; por ende, existe $y in P$ tal que $a < y$ (convencerse de que esto se sigue de la definición de maximal). De lo anterior se deduce, por transitividad y antisimetría, que $m < y$. Pero $y in Q$ (pues $y != a$) y $m$ es maximal de $upright(bold(Q))$, lo que nos conduce a un absurdo. El absurdo provino de suponer $m <= a$, por lo que esto es falso y concluimos que la implicación $(*)$ es verdadera para el caso $x = a$.
]

== Supremo e ínfimo

#definition(title: "Cotas")[
  Sean $upright(bold(P)) = (P, <=)$ un poset, $c in P$ y $S subset.eq P$. Decimos que:
  - $c$ es *cota superior* de $S$ sii para todo $a in S$, $a <= c$;
  - $c$ es *cota inferior* de $S$ sii para todo $a in S$, $c <= a$.
] <def-bounds>

#definition(title: "Supremo e ínfimo")[
  Sean $upright(bold(P)) = (P, <=)$ un poset, $s, i in P$ y $S subset.eq P$. Decimos que:
  - $s$ es el *supremo* de $S$ sii $s$ es la menor de las cotas superiores de $S$; escribimos $s = sup(S)$.
  - $i$ es el *ínfimo* de $S$ sii $i$ es la mayor de las cotas inferiores de $S$; escribimos $i = inf(S)$.
] <def-sup-inf>

== Posets reticulados

#definition(title: "Poset reticulado")[
  Dado un poset $upright(bold(P)) = (P, <=)$, decimos que $upright(bold(P))$ es un *poset reticulado* sii para todos $a$ y $b$ en $P$ existen el supremo y el ínfimo del conjunto ${a, b}$.
] <def-lattice-ordered-poset>

#notation[
  En los posets reticulados escribimos
  $ a or b eq.dot sup{a, b} quad "y" quad a and b eq.dot inf{a, b}. $
] <not-join-meet>

#example[
  $(NN, <=)$, $(RR, <=)$ y $(NN, divides)$ son posets reticulados. En cambio, $({2, 4, 6, 12, 16}, divides)$ no es un poset reticulado.
] <ex-lattice-ordered-posets>

#exercise(title: [Conjunto de divisores de $n$, $(D_n, divides)$])[
  ¿Quién es el supremo y quién el ínfimo entre $a$ y $b$? ¿Cuál es el mínimo elemento? ¿Y el máximo?
] <exr-divisors-sup-inf>

#exercise(title: [Conjunto de partes, $(cal(P)(A), subset.eq)$])[
  ¿Quién es el supremo y quién el ínfimo entre $a$ y $b$? ¿Cuál es el mínimo elemento? ¿Y el máximo?
] <exr-power-set-sup-inf>
