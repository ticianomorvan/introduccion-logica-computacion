#import "../lib/notes.typ": *

= Introducción <ch-introduction>

Vamos a definir formalmente la noción de _lenguaje_, estudiar la dificultad estructural de los lenguajes y el modelo computacional necesario para computarlos. Esta rama de la computación se conoce como *teoría de los lenguajes formales*.

Hay lenguajes estructuralmente más complejos (y, en consecuencia, más difíciles de computar) que otros. Los que tienen la misma dificultad se agrupan en una misma clase de lenguajes, lo que da origen a la llamada *jerarquía de Chomsky*. Aquí estudiaremos solamente la primera clase de esa jerarquía: los *lenguajes regulares*.

== Jerarquía de Chomsky

La jerarquía de Chomsky postula cuatro clases de lenguajes:
- lenguajes regulares (tipo 3),
- lenguajes independientes de contexto (tipo 2),
- lenguajes sensibles al contexto (tipo 1),
- lenguajes recursivamente enumerables (tipo 0),

y cada clase está contenida en la siguiente:

#fig("introduction/chomsky-hierarchy.png", 195pt)

== Modelos computacionales

Hay dos tipos de modelos computacionales de lenguajes: los modelos _generativos_, que son las *gramáticas*, y los modelos _reconocedores_, que son los *autómatas*. Cada clase de la jerarquía de Chomsky está caracterizada por el modelo computacional más simple necesario para computarla:

#align(center, table(
  columns: 3, align: left, inset: 6pt,
  [*Clase*], [*Reconocedor*], [*Generador*],
  [Regulares], [autómatas finitos], [gramáticas regulares],
  [Independientes de contexto], [autómatas finitos con una pila], [gramáticas independientes de contexto],
  [Sensibles al contexto], [autómatas finitos con $k$ pilas], [gramáticas sensibles al contexto],
  [Recursivamente enumerables], [máquinas de Turing], [gramáticas sin restricciones],
))

La importancia de estas clases radica en que marcan fronteras: la clase de los lenguajes independientes de contexto delimita los lenguajes _tratables_, es decir, aquellos que se pueden computar eficientemente, mientras que la clase de los lenguajes recursivamente enumerables delimita lo _computable_.

Estudiaremos solamente la clase de los lenguajes regulares y sus dos modelos computacionales: los autómatas finitos (@ch-finite-automata) y las gramáticas regulares (@ch-regular-grammars). La clase siguiente, la de los lenguajes independientes de contexto, con los autómatas con una pila y las gramáticas independientes de contexto, corresponde a un curso posterior de lenguajes formales.
