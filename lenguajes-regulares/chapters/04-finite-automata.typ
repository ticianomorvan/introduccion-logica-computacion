#import "../lib/notes.typ": *

= Autómatas finitos <ch-finite-automata>

Un *autómata finito* (AF) es un modelo computacional basado en la noción de máquina secuencial automática, cuyo poder computacional caracteriza a los lenguajes regulares. Primero estudiaremos los autómatas finitos en sí mismos (su funcionamiento, sus tipos y sus propiedades) para luego probar que efectivamente son la máquina secuencial que caracteriza a los lenguajes regulares.

== Qué computa un autómata finito

Un AF computa un lenguaje, en el sentido de que decide la pertenencia de cadenas a un cierto lenguaje: toma como entrada una cadena y, luego de procesar todos sus símbolos, decide si la cadena es *aceptada* o *rechazada*.

#fig("finite-automata/fa-black-box.png", 280pt)

Estudiaremos tres tipos de autómatas finitos, todos computacionalmente equivalentes entre sí:
- determinísticos (AFD),
- no determinísticos (AFN),
- no determinísticos con transiciones espontáneas (AFN$ϵ$).

== Funcionamiento

Un AF cuenta con un conjunto finito de *estados*, y en todo momento la máquina se encuentra en exactamente uno de ellos. Hay un único *estado inicial*, desde donde comienza todo cómputo, y un subconjunto de *estados de aceptación* (o *finales*) que definen si una cadena es aceptada.

Además, cuenta con una *cinta de entrada*, en cuyas celdas se alojan los símbolos de la cadena a procesar, y un cabezal de solo lectura que apunta a dichas celdas. Cada vez que el cabezal lee un símbolo, la máquina ejecuta un cambio de estado, llamado *transición*, y el cabezal se desplaza a la celda contigua; así sucesivamente, hasta leer todos los símbolos de la cadena. La cadena es aceptada si el estado al que arriba la máquina luego de procesarla es de aceptación, y rechazada en caso contrario.

#example[
  Procesamiento de la cadena “$a a b a b$”:

  #fig("finite-automata/trace-aabab.png", 245pt)

  El cómputo arranca en el estado inicial $q_0$. El cabezal lee sucesivamente los símbolos $a, a, b, a, b$, y la máquina transiciona a los estados $q_0, q_0, q_1, q_1, q_2$. Si $q_2$ es de aceptación, la cadena es aceptada; si no, es rechazada.
]

== Autómatas finitos determinísticos

#definition(title: "AFD")[
  Un *autómata finito determinístico* es una 5-upla $M = (Sigma, Q, q_0, F, delta)$ donde:
  - $Sigma$ es un alfabeto, llamado _alfabeto de entrada_;
  - $Q$ es un conjunto finito y no vacío de _estados_;
  - $q_0 in Q$ es el _estado inicial_;
  - $F subset.eq Q$ es el conjunto de _estados de aceptación_ (o _finales_);
  - $delta : Q times Sigma -> Q$ es la _función de transición_.

  Que $delta(q, a) = q'$ significa que si el autómata se encuentra en el estado $q$ y el cabezal lee el símbolo $a$, entonces transiciona al estado $q'$. Una cadena $alpha in Sigma^*$ es *aceptada* por $M$ sii el estado al que arriba $M$ luego de procesar todos los símbolos de $alpha$, partiendo de $q_0$, es un estado de aceptación. Notamos
  $ "AFD"^Sigma = {M : M "es un AFD con alfabeto de entrada" Sigma}. $
] <def-dfa>

#example[
  Sea $M_1 = (Sigma, Q, q_0, F, delta)$ con $Sigma = {a, b}$, $Q = {q_0, q_1, q_2}$, $F = {q_0, q_2}$ y $delta$ dada por:

  #align(center, grid(
    columns: 2, column-gutter: 3em, align: horizon,
    table(
      columns: 3, align: center, inset: 5pt,
      $delta$, $a$, $b$,
      $q_0$, $q_0$, $q_1$,
      $q_1$, $q_1$, $q_2$,
      $q_2$, $q_1$, $q_1$,
    ),
    grid(
      columns: 2, column-gutter: 2em, row-gutter: 0.8em,
      $delta(q_0, a) = q_0$, $delta(q_0, b) = q_1$,
      $delta(q_1, a) = q_1$, $delta(q_1, b) = q_2$,
      $delta(q_2, a) = q_1$, $delta(q_2, b) = q_1$,
    ),
  ))

  La cadena $alpha_1 = a a b a b$ es aceptada por $M_1$, pues el autómata arriba al estado $q_2 in F$ luego de procesar todos sus símbolos:

  #fig("finite-automata/dfa-m1-trace-aabab.png", 260pt)

  En cambio, la cadena $alpha_2 = a a b a b a$ es rechazada, pues el autómata arriba al estado $q_1 in.not F$:

  #fig("finite-automata/dfa-m1-trace-aababa.png", 285pt)
] <ex-dfa-m1>

#notation(title: "Diagrama de transición")[
  Representamos un AF mediante un sistema de transición etiquetado, es decir, un grafo cuyos nodos son los estados del AF; el estado inicial se marca con una flecha pequeña a su lado, los estados de aceptación con un doble círculo, y hay una arista de $q$ a $q'$ etiquetada con $a$ siempre que $delta(q, a) = q'$. El diagrama de transición del autómata $M_1$ del @ex-dfa-m1 es:

  #fig("finite-automata/dfa-m1-diagram.png", 160pt)
]

#definition(title: "Lenguaje aceptado")[
  Sea $M = (Sigma, Q, q_0, F, delta)$ un AFD. Definimos $arrow(delta) : Q times Sigma^* -> Q$ por
  $ arrow(delta)(q, ϵ) &= q, \
    arrow(delta)(q, a) &= delta(q, a), \
    arrow(delta)(q, alpha' a) &= delta(arrow(delta)(q, alpha'), a), $
  de modo que $arrow(delta)(q, alpha)$ es el estado al que arriba $M$ luego de procesar la cadena $alpha$ partiendo del estado $q$. El *lenguaje aceptado* por $M$ es el conjunto de todas las cadenas aceptadas por $M$:
  $ L(M) = {alpha in Sigma^* : arrow(delta)(q_0, alpha) in F}. $
] <def-dfa-language>

#example[
  Para el AFD $M_1$
  #fig("finite-automata/dfa-example-m1.png", 200pt)
  tenemos $L(M_1) = b^* a b^* a b^*$, el lenguaje de las cadenas que tienen exactamente dos símbolos $a$. Para el AFD $M_2$
  #fig("finite-automata/dfa-example-m2.png", 150pt)
  tenemos $L(M_2) = (a + b)^* b$, el lenguaje de las cadenas que terminan con el símbolo $b$.
]

== Autómatas finitos no determinísticos

En un autómata determinístico, dado un estado y un símbolo existe un único estado al cual transicionar; por lo tanto, la traza de procesamiento de una cadena es única:
$ delta(q, a) = q' ==> arrow(delta)(q, alpha) "es un único estado". $
En un autómata no determinístico, dado un estado y un símbolo pueden existir varios estados a los cuales transicionar, de modo que hay varias trazas de procesamiento para una misma cadena:
$ delta(q, a) = {q_1, dots, q_k} ==> arrow(delta)(q, alpha) "es un conjunto de estados". $
Para evitar confusiones, denotaremos con $Delta$ las funciones de transición no deterministas y con $delta$ las deterministas.

#definition(title: "AFN")[
  Un *autómata finito no determinístico* es una 5-upla $M = (Sigma, Q, q_0, F, Delta)$ donde $Sigma$, $Q$, $q_0$ y $F$ son como en un AFD y
  $ Delta : Q times Sigma -> cal(P)(Q) $
  es la _función de transición_. Que $Delta(q, a) = {q_1, dots, q_k}$ significa que si el autómata se encuentra en el estado $q$ y el cabezal lee el símbolo $a$, entonces puede transicionar a cualquier estado $q_i$. Una cadena $alpha in Sigma^*$ es *aceptada* por $M$ si existe *al menos una forma* de procesar $alpha$, partiendo de $q_0$, en la que el estado al que arriba $M$ es de aceptación. Notamos
  $ "AFN"^Sigma = {M : M "es un AFN con alfabeto de entrada" Sigma}. $
] <def-nfa>

#example[
  Sea $M_1$ el siguiente AFN:

  #fig("finite-automata/nfa-m1.png", 170pt)

  La cadena $a b b$ tiene una traza de procesamiento de aceptación:

  #fig("finite-automata/nfa-m1-trace-accept.png", 170pt)

  y también una traza de procesamiento de rechazo:

  #fig("finite-automata/nfa-m1-trace-reject.png", 170pt)
]

#definition(title: "Lenguaje aceptado")[
  Sea $M = (Sigma, Q, q_0, F, Delta)$ un AFN. Extendemos $Delta$ a conjuntos de estados $S subset.eq Q$:
  $ hat(Delta)(S, a) = union.big_(q in S) Delta(q, a). $
  Definimos $arrow(Delta) : Q times Sigma^* -> cal(P)(Q)$ por
  $ arrow(Delta)(q, ϵ) &= {q}, \
    arrow(Delta)(q, a) &= Delta(q, a), \
    arrow(Delta)(q, alpha' a) &= hat(Delta)(arrow(Delta)(q, alpha'), a), $
  de modo que $arrow(Delta)(q, alpha)$ es el conjunto de todos los estados a los que puede arribar $M$ luego de procesar $alpha$ partiendo de $q$. El *lenguaje aceptado* por $M$ es
  $ L(M) = {alpha in Sigma^* : arrow(Delta)(q_0, alpha) inter F != emptyset}. $
] <def-nfa-language>

#theorem(title: $"AFD"^Sigma equiv "AFN"^Sigma$)[
  Los AFD y los AFN son computacionalmente equivalentes:
  + Si $M in "AFD"^Sigma$, entonces existe $M' in "AFN"^Sigma$ tal que $L(M') = L(M)$.
  + Si $M in "AFN"^Sigma$, entonces existe $M' in "AFD"^Sigma$ tal que $L(M') = L(M)$.
] <thm-dfa-nfa>

#proof[
  (1) Un AFD puede verse como un AFN que no usa su no determinismo: basta definir $Delta'(q, a) = {delta(q, a)}$.

  (2) Debemos ver que siempre se puede determinizar un AFN preservando su lenguaje. La idea es que los estados del AFD sean conjuntos de estados del AFN, de modo que si el AFD se encuentra en el estado ${q_1, dots, q_k}$ luego de procesar un prefijo de la cadena, entonces el AFN se encuentra en algún $q_i$. Sea $M = (Sigma, Q, q_0, F, Delta)$; tomamos $M' = (Sigma, Q', q'_0, F', delta')$ con
  $ Q' &= cal(P)(Q), \
    q'_0 &= {q_0}, \
    F' &= {S subset.eq Q : S inter F != emptyset}, \
    delta'(S, a) &= hat(Delta)(S, a) = union.big_(q in S) Delta(q, a). $
  Por definición de $M'$, vale $arrow(delta')({q_0}, alpha) = arrow(Delta)(q_0, alpha)$ para toda $alpha$. Luego
  $ alpha in L(M) &<==> exists q in F "tal que" q in arrow(Delta)(q_0, alpha) \
    &<==> exists q in F "tal que" q in arrow(delta')({q_0}, alpha) \
    &<==> arrow(delta')({q_0}, alpha) in F' \
    &<==> alpha in L(M'), $
  y por lo tanto $L(M) = L(M')$.
]

#example(title: "Determinización")[
  Consideremos el siguiente AFN, cuyo lenguaje aceptado es $a(a^* + b^*)$:

  #fig("finite-automata/nfa-determinization.png", 140pt)

  Definimos la función de transición del AFD mediante una tabla, partiendo del estado inicial ${q_0}$; de esta manera solo generamos los estados alcanzables desde ${q_0}$:

  #align(center, table(
    columns: 3, align: left, inset: 5pt,
    [], align(center, $a$), align(center, $b$),
    ${q_0}$, ${q_1, q_2}$, $emptyset$,
    ${q_1, q_2}$, ${q_2}$, ${q_1}$,
    ${q_2}$, ${q_2}$, $emptyset$,
    ${q_1}$, $emptyset$, ${q_1}$,
  ))

  Obtenemos así el AFD

  #fig("finite-automata/dfa-determinization-result.png", 245pt)

  cuyo lenguaje aceptado es $a(a^* + b^*)$, por lo que es equivalente al primero.
] <ex-determinization>

== Transiciones espontáneas

Una *transición espontánea* permite al autómata cambiar de estado sin leer un símbolo ni desplazar el cabezal de la cinta de entrada. Si está definida, puede tener lugar o no (de ahí su nombre), por lo que es en sí misma una transición no determinista; puede pensarse como una transición “gratis”, en la que el autómata cambia de estado sin consumir un símbolo. Las denotamos con $ϵ$: que
$ Delta(q, ϵ) = {q_1, dots, q_k} $
significa que el autómata puede transicionar libremente de $q$ a cualquier $q_i$ sin leer símbolo alguno.

#definition(title: [AFN$ϵ$])[
  Un *autómata finito no determinístico con transiciones espontáneas* es una 5-upla $M = (Sigma, Q, q_0, F, Delta)$ donde $Sigma$, $Q$, $q_0$ y $F$ son como en un AFD y
  $ Delta : Q times (Sigma union {ϵ}) -> cal(P)(Q) $
  es la _función de transición_. La aceptación se define como en un AFN: $alpha in Sigma^*$ es aceptada si existe al menos una forma de procesarla, partiendo de $q_0$, en la que el estado al que arriba $M$ es de aceptación. Notamos
  $ "AFN"ϵ^Sigma = {M : M "es un AFN"ϵ "con alfabeto de entrada" Sigma}. $
] <def-enfa>

#example[
  El siguiente AFN$ϵ$ acepta el lenguaje $a^* b^* c^*$:

  #fig("finite-automata/enfa-abc.png", 175pt)
] <ex-enfa-abc>

Las transiciones espontáneas permiten combinar o empalmar autómatas con mucha facilidad; es decir, diseñar autómatas por composición de sub-autómatas.

#example(title: "Composición")[
  Los siguientes AFD aceptan, respectivamente, las cadenas con un número par de $a$'s y las cadenas con un número par de $b$'s:

  #align(center, grid(
    columns: 2, column-gutter: 4em,
    image("../img/finite-automata/dfa-even-a.png", width: 95pt),
    image("../img/finite-automata/dfa-even-b.png", width: 100pt),
  ))

  Uniéndolos mediante transiciones espontáneas obtenemos un AFN$ϵ$ que acepta las cadenas con un número par de $a$'s o de $b$'s:

  #fig("finite-automata/enfa-even-a-or-b.png", 150pt)
]

#definition(title: "Clausura")[
  La *clausura* de un estado $q$, denotada $[q]$, es el conjunto de estados a los que se puede arribar desde $q$ utilizando solamente transiciones espontáneas:
  $ [q] = {q' in Q : q' in arrow(Delta)(q, ϵ)}. $
  Es decir,
  $ q #xarrow($ϵ$) q_1 #xarrow($ϵ$) q_2 #xarrow($ϵ$) dots.c #xarrow($ϵ$) q_k ==> [q] = {q, q_1, dots, q_k}. $
  Para un conjunto de estados $S subset.eq Q$ definimos
  $ [S] = union.big_(q in S) [q]. $
  Para todo $q in Q$ se cumple que $q in [q]$ y $[[q]] = [q]$.
] <def-closure>

#theorem(title: $"AFN"^Sigma equiv "AFN"ϵ^Sigma$)[
  Los AFN y los AFN$ϵ$ son computacionalmente equivalentes:
  + Si $M in "AFN"^Sigma$, entonces existe $M' in "AFN"ϵ^Sigma$ tal que $L(M') = L(M)$.
  + Si $M in "AFN"ϵ^Sigma$, entonces existe $M' in "AFN"^Sigma$ tal que $L(M') = L(M)$.
] <thm-nfa-enfa>

#proof[
  (1) Un AFN puede verse como un AFN$ϵ$ que no utiliza transiciones espontáneas.

  (2) Debemos ver que siempre se pueden eliminar las transiciones espontáneas sin afectar el lenguaje, introduciendo transiciones que simulen sus efectos. Sea $M = (Sigma, Q, q_0, F, Delta)$ un AFN$ϵ$; tomamos el AFN $M' = (Sigma, Q', q'_0, F', Delta')$ que preserva todos los estados y el estado inicial,
  $ Q' = Q, quad q'_0 = q_0, $
  cuyos estados finales son aquellos cuya clausura contiene al menos un estado de aceptación,
  $ F' = {q in Q : [q] inter F != emptyset}, $
  y cuyas transiciones son las siguientes: si en el AFN$ϵ$ hay un camino $q #xarrow($ϵ$) dots.c #xarrow($ϵ$) q_1 #xarrow($a$) q_2 #xarrow($ϵ$) dots.c #xarrow($ϵ$) q'$, entonces en el AFN definimos la transición $q #xarrow($a$) q'$, es decir,
  $ Delta'(q, a) = [hat(Delta)([q], a)]. $
  Luego, $L(M) = L(M')$.
]

#example(title: "Eliminación de transiciones espontáneas")[
  Sea $M$ el AFN$ϵ$ del @ex-enfa-abc, con $L(M) = a^* b^* c^*$:

  #fig("finite-automata/enfa-abc.png", 175pt)

  Calculamos las clausuras de los estados,
  $ [q_0] = {q_0, q_1, q_2}, quad [q_1] = {q_1, q_2}, quad [q_2] = {q_2}, $
  los estados de aceptación,
  $ F' = {q_0, q_1, q_2}, $
  y la función de transición:

  #align(center, table(
    columns: 4, align: left, inset: 5pt,
    [], align(center, $a$), align(center, $b$), align(center, $c$),
    $q_0$, ${q_0, q_1, q_2}$, ${q_1, q_2}$, ${q_2}$,
    $q_1$, $emptyset$, ${q_1, q_2}$, ${q_2}$,
    $q_2$, $emptyset$, $emptyset$, ${q_2}$,
  ))

  Obtenemos así el AFN equivalente $M'$, con $L(M') = a^* b^* c^*$:

  #fig("finite-automata/nfa-abc-no-eps.png", 245pt)
] <ex-epsilon-elimination>

== Resumen

Presentamos tres tipos de autómatas finitos (AFD, AFN y AFN$ϵ$) y probamos que son computacionalmente equivalentes (@thm-dfa-nfa y @thm-nfa-enfa):
$ "AFD"^Sigma equiv "AFN"^Sigma quad "y" quad "AFN"^Sigma equiv "AFN"ϵ^Sigma, quad "luego" quad "AFD"^Sigma equiv "AFN"ϵ^Sigma. $
En la práctica, para convertir un AFN$ϵ$ en un AFD equivalente se eliminan primero las transiciones espontáneas (@ex-epsilon-elimination) y luego se determiniza (@ex-determinization). Por ser equivalentes, hablaremos directamente de autómata finito (AF) sin especificar su tipo:
$ "AF"^Sigma = "AFD"^Sigma union "AFN"^Sigma union "AFN"ϵ^Sigma. $
Con esto estamos en condiciones de probar que los AF caracterizan a los lenguajes regulares (@thm-kleene):
$ "LR"^Sigma equiv "AF"^Sigma. $
