#import "../../lib/notes.typ": *

= Relaciones <ch-relations>

Hay nociones que no definiremos, sino que supondremos intuitivamente conocidas, como las nociones de *conjunto*, *elemento*, *número* o *pertenencia*. También consideraremos primitiva la noción de *par ordenado* (aunque podríamos definirla) y la de *producto cartesiano* de conjuntos.

#example[
  Si $A = {a, b, c}$ y $B = {4, 7, 3, 11}$, está claro qué conjunto es $A times B$.
]

== Relaciones binarias

Una relación será para nosotros un objeto matemático muy concreto.

#definition(title: "Relación binaria")[
  Dados dos conjuntos $A$ y $B$, decimos que $R$ es una *relación binaria de $A$ en $B$* si y sólo si $R subset.eq A times B$.
] <def-binary-relation>

#notation[
  Escribimos $a R b$ para denotar $(a, b) in R$, y $a cancel(R) b$ para denotar $(a, b) in.not R$.
] <not-relation-infix>

#example[
  ¿Cómo formalizamos las “relaciones” _divide a_, _es menor a_, _pertenece a_, _es igual a_ y _está incluido en_?
] <ex-everyday-relations>

Hay relaciones que poseen propiedades que son estudiadas especialmente.

#example(title: "Funciones")[
  Dada $R subset.eq A times B$, si $R$ satisface que
  - para todo $a in A$ y $b_1, b_2 in B$, si $(a, b_1) in R$ y $(a, b_2) in R$ entonces $b_1 = b_2$, y
  - para todo $a in A$ existe $b in B$ tal que $(a, b) in R$,

  decimos que $R$ es una *función de $A$ en $B$*.
] <ex-function-as-relation>

== Relaciones sobre un conjunto

En este curso nos enfocaremos en relaciones en las que $A = B$.

#definition(title: "Relación sobre un conjunto")[
  Dado un conjunto $A$, decimos que $R$ es una *relación sobre $A$* si y sólo si $R subset.eq A times A$.
] <def-relation-on-set>

Hay un tipo de relaciones sobre $A$ con las que ya tenemos cierta familiaridad.

#example[
  Sea $R$ la relación sobre $ZZ$ de _congruencia módulo 12_, es decir,
  $ (n, m) in R quad "sii" quad 12 divides (n - m). $
] <ex-congruence-mod-12>

== Propiedades

#definition[
  Sea $R$ una relación sobre $A$. Decimos que:
  - $R$ es *reflexiva* sii para todo $a in A$, $(a, a) in R$;
  - $R$ es *simétrica* sii para todo $a, b in A$, si $(a, b) in R$ entonces $(b, a) in R$;
  - $R$ es *transitiva* sii para todo $a, b, c in A$, si $(a, b) in R$ y $(b, c) in R$ entonces $(a, c) in R$;
  - $R$ es *antisimétrica* sii para todo $a, b in A$, si $(a, b) in R$ y $(b, a) in R$ entonces $a = b$.
] <def-relation-properties>

== Relaciones de equivalencia

#definition(title: "Relación de equivalencia")[
  $R subset.eq A times A$ es una *relación de equivalencia* sii es reflexiva, simétrica y transitiva.
] <def-equivalence-relation>

#definition(title: "Clase de equivalencia")[
  Dada una relación de equivalencia $R$ sobre un conjunto $A$, para cada elemento $a in A$ definimos la *clase de equivalencia de $a$* como
  $ [a] = {b in A : (a, b) in R}. $
] <def-equivalence-class>

#example[
  Construyamos una relación de equivalencia sobre el conjunto $A = {1, 2, 3, 4, 5, 6}$.
] <ex-build-equivalence-relation>

=== Particiones de un conjunto

#definition(title: "Partición")[
  Una *partición* $cal(P)$ de $A$ es una familia de subconjuntos no vacíos de $A$ que son disjuntos entre sí y cuya unión da todo $A$.
] <def-partition>

#example[
  Las siguientes son todas particiones del conjunto $A = {1, 2, 3, 4, 5, 6}$:
  $ cal(P)_1 &= {{1, 4, 6}, {2, 3, 5}}, \
    cal(P)_2 &= {{2}, {1, 5, 6}, {3, 4}}, \
    cal(P)_3 &= {{1, 2, 3, 4, 5, 6}}, \
    cal(P)_4 &= {{1}, {2}, {3}, {4}, {5}, {6}}. $
] <ex-partitions-of-six>

Las clases de equivalencia de una relación de equivalencia forman una partición y, recíprocamente, toda partición determina una relación de equivalencia.

#lemma[
  Sea $R$ una relación de equivalencia sobre $A$ y sean $a, b in A$. Entonces:
  + $[a] = [b]$ sii $(a, b) in R$;
  + si $(a, b) in.not R$ entonces $[a] inter [b] = emptyset$.
] <lem-equivalence-classes>

#corollary[
  El conjunto $A slash R = {[a] : a in A}$ de las clases de equivalencia es una partición de $A$.
] <cor-quotient-is-partition>

#lemma[
  Sea $cal(P)$ una partición de $A$. Entonces la relación $S$ sobre $A$ definida como
  $ (a, b) in S quad "sii" quad &a "y" b "pertenecen a la misma parte" \
    &("i.e., existe" P in cal(P) "tal que" a in P "y" b in P) $
  es una relación de equivalencia, y la clase de equivalencia de un elemento es la parte a la que pertenece.
] <lem-partition-equivalence>

== Relaciones de orden

#definition(title: "Relación de orden parcial")[
  $R subset.eq A times A$ es una *relación de orden parcial* sii es reflexiva, antisimétrica y transitiva.
] <def-partial-order-relation>

#example[
  Son relaciones de orden parcial:
  - las relaciones de orden usuales $<=$ sobre $RR$, $ZZ$ y $NN$;
  - la relación _divide_ sobre $NN$;
  - la relación de inclusión $subset.eq$ sobre las partes $cal(P)(A)$ de un conjunto $A$;
  - la relación de inclusión $subset.eq$ sobre el conjunto ${emptyset, {a}, {a, b}, {a, c}, {a, c, d}}$.
] <ex-partial-order-relations>

#exercise[
  ¿Cómo representaríamos gráficamente la última relación del @ex-partial-order-relations?
] <exr-draw-inclusion-order>

#exercise(title: "Verdadero o falso")[
  #enum(numbering: "a.")[
    Si $R$ es una relación de equivalencia sobre $A$, entonces $R$ *no* es una relación de orden sobre $A$.
  ][
    Si $R$ *no* es una relación de equivalencia sobre $A$, entonces es una relación de orden sobre $A$.
  ]
] <exr-equivalence-vs-order>
