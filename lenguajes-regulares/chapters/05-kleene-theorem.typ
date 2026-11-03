#import "../lib/notes.typ": *

= Teorema de Kleene <ch-kleene-theorem>

En este capítulo probamos que un lenguaje es regular si y solo si es aceptado por un autómata finito. Una interpretación posible de este resultado es que los AF son las máquinas secuenciales que caracterizan a los lenguajes regulares. Debemos ver dos cosas:
- (ida) todo lenguaje regular es aceptado por un AF;
- (vuelta) todo lenguaje aceptado por un AF es un lenguaje regular.

Ya probamos que $"LR"^Sigma equiv "ER"^Sigma$ (@thm-lr-er) y que $"AFD"^Sigma equiv "AFN"^Sigma equiv "AFN"ϵ^Sigma$ (@thm-dfa-nfa y @thm-nfa-enfa). Por lo tanto, podemos unir estas dos cadenas de equivalencias probando en particular que $"ER"^Sigma equiv "AF"^Sigma$.

#theorem(title: [Kleene, $"ER"^Sigma equiv "AF"^Sigma$])[
  + (Ida) Si $e in "ER"^Sigma$, entonces existe $M in "AFN"ϵ^Sigma$ tal que $L(M) = L(e)$.
  + (Vuelta) Si $M in "AFN"^Sigma$, entonces existe $e in "ER"^Sigma$ tal que $L(M) = L(e)$.
] <thm-kleene>

== De expresiones regulares a autómatas

Para probar el inciso (1), notemos que un AF puede verse como una estructura recursiva: es un estado (el inicial) conectado con $k$ sub-autómatas. Por lo tanto, podemos construir un AF recursivamente, siguiendo la recursividad de las expresiones regulares.

#proof[
  (1) Hacemos inducción en la forma de la expresión regular $e$. En los casos recursivos suponemos, renombrando estados si es necesario, que los conjuntos de estados de los sub-autómatas son disjuntos, y vemos cada función de transición como el conjunto de pares $((q, x), Delta(q, x))$.

  _Casos base._ Si $e = emptyset$, tomamos el autómata $M$

  #fig("kleene-theorem/enfa-empty-set.png", 38pt)

  y luego $L(M) = emptyset = L(emptyset)$. Si $e = ϵ$, tomamos

  #fig("kleene-theorem/enfa-epsilon.png", 46pt)

  y luego $L(M) = {ϵ} = L(ϵ)$. Si $e = a$, tomamos

  #fig("kleene-theorem/enfa-symbol.png", 108pt)

  y luego $L(M) = {a} = L(a)$.

  _Casos recursivos._ Si $e = e_1 + e_2$, por hipótesis inductiva existen AFN$ϵ$ $M_1 = (Sigma, Q_1, q_1, F_1, Delta_1)$ y $M_2 = (Sigma, Q_2, q_2, F_2, Delta_2)$ tales que $L(M_1) = L(e_1)$ y $L(M_2) = L(e_2)$. Tomamos el AFN$ϵ$ $M = (Sigma, Q, q_0, F, Delta)$ donde
  $ Q &= Q_1 union Q_2 union {q_0}, quad "con" q_0 in.not Q_1, Q_2, \
    F &= F_1 union F_2, \
    Delta &= Delta_1 union Delta_2 union {((q_0, ϵ), {q_1, q_2})}, $
  es decir, un nuevo estado inicial $q_0$ con transiciones espontáneas hacia los estados iniciales de $M_1$ y $M_2$:

  #fig("kleene-theorem/enfa-union.png", 185pt)

  Luego, $L(M) = L(M_1) union L(M_2) = L(e_1) union L(e_2) = L(e_1 + e_2) = L(e)$.

  Si $e = e_1 e_2$, por hipótesis inductiva existen AFN$ϵ$ $M_1 = (Sigma, Q_1, q_1, F_1, Delta_1)$ y $M_2 = (Sigma, Q_2, q_2, F_2, Delta_2)$ tales que $L(M_1) = L(e_1)$ y $L(M_2) = L(e_2)$. Tomamos el AFN$ϵ$ $M = (Sigma, Q, q_0, F, Delta)$ donde
  $ Q &= Q_1 union Q_2, \
    q_0 &= q_1, \
    F &= F_2, \
    Delta &= (Delta_1 union Delta_2) without {((q, ϵ), Delta_1(q, ϵ)) : q in F_1} \
      &quad union {((q, ϵ), Delta_1(q, ϵ) union {q_2}) : q in F_1}, $
  es decir, agregamos una transición espontánea desde cada estado de aceptación de $M_1$ hacia el estado inicial de $M_2$:

  #fig("kleene-theorem/enfa-concatenation.png", 305pt)

  Luego, $L(M) = L(M_1) L(M_2) = L(e_1) L(e_2) = L(e_1 e_2) = L(e)$.

  Si $e = e_1^*$, por hipótesis inductiva existe un AFN$ϵ$ $M_1 = (Sigma, Q_1, q_1, F_1, Delta_1)$ tal que $L(M_1) = L(e_1)$. Tomamos el AFN$ϵ$ $M = (Sigma, Q, q_0, F, Delta)$ donde
  $ Q &= Q_1 union {q_0}, quad "con" q_0 in.not Q_1, \
    F &= F_1 union {q_0}, \
    Delta &= Delta_1 without {((q, ϵ), Delta_1(q, ϵ)) : q in F_1} \
      &quad union {((q, ϵ), Delta_1(q, ϵ) union {q_0}) : q in F_1} \
      &quad union {((q_0, ϵ), {q_1})}, $
  es decir, un nuevo estado inicial $q_0$, que también es de aceptación, con una transición espontánea hacia $q_1$, y transiciones espontáneas desde cada estado de aceptación de $M_1$ de vuelta hacia $q_0$:

  #fig("kleene-theorem/enfa-star.png", 130pt)

  Luego, $L(M) = (L(M_1))^* = (L(e_1))^* = L(e_1^*) = L(e)$.
]

La demostración anterior nos brinda un algoritmo recursivo que, dada una expresión regular, devuelve un AF equivalente.

#algorithm(title: "Kleene, ida")[
  Dada $e in "ER"^Sigma$, construimos un AFN$ϵ$ $M$ con $L(M) = L(e)$ siguiendo la estructura de $e$:
  - si $e$ es $emptyset$, $ϵ$ o un símbolo $a in Sigma$, $M$ es el autómata del caso base correspondiente;
  - si $e$ es $e_1 + e_2$, $e_1 e_2$ o $e_1^*$, construimos recursivamente los autómatas de $e_1$ (y de $e_2$) y los combinamos mediante la construcción de la unión, la concatenación o la clausura, respectivamente.
] <alg-kleene-regex-to-enfa>

#example[
  Construimos un AF que acepta la expresión regular $a b + b a$. Primero, un AF que acepta $a b$, concatenando los autómatas de $a$ y de $b$:

  #fig("kleene-theorem/enfa-ab.png", 185pt)

  Luego, un AF que acepta $b a$:

  #fig("kleene-theorem/enfa-ba.png", 188pt)

  Finalmente, un AF que acepta $a b + b a$, uniendo los dos anteriores:

  #fig("kleene-theorem/enfa-ab-or-ba.png", 238pt)
] <ex-kleene-ab-or-ba>

== De autómatas a expresiones regulares

Para probar el inciso (2) necesitamos antes el siguiente lema.

#lemma(title: "Arden")[
  Si $A$ y $B$ son lenguajes y $ϵ in.not A$, entonces la ecuación
  $ X = A X union B $
  tiene solución única, y es $X = A^* B$.
] <lem-arden>

Notemos que si $A$ y $B$ son regulares, entonces $X$ es regular, y $A$, $B$ y $X$ pueden ser denotados por expresiones regulares. Por eso escribimos estas ecuaciones directamente con la notación de las expresiones regulares.

#example[
  $ X = a X + b^* a b quad therefore quad X = a^* b^* a b. $
  $ X &= a^2 X + b^+ X + a b \
      &= (a^2 + b^+) X + a b quad therefore quad X = (a^2 + b^+)^* a b. $
  $ X &= a b^2 X + a X + a^* b + b^* a \
      &= (a b^2 + a) X + (a^* b + b^* a) quad therefore quad X = (a b^2 + a)^* (a^* b + b^* a). $
] <ex-arden>

#proof[
  (2) Sea $M = (Sigma, Q, q_0, F, Delta)$ un AFN con $Q = {q_0, q_1, dots, q_n}$. Para cada $i$ definimos $M_i = (Sigma, Q, q_i, F, Delta)$, el AFN que se obtiene a partir de $M$ cambiando únicamente el estado inicial por $q_i$, y definimos $X_i = L(M_i)$; en particular, $X_0 = L(M_0) = L(M)$. Cada $X_i$ se puede expresar con la ecuación
  $ X_i = cases(gap: #1em,
    display(sum_(q_j in Delta(q_i, a))) a X_j & "si" q_i in.not F,
    display(sum_(q_j in Delta(q_i, a))) a X_j + ϵ quad & "si" q_i in F,
  ) $
  donde la suma recorre todos los símbolos $a in Sigma$ y todos los estados $q_j in Delta(q_i, a)$: una cadena es aceptada partiendo de $q_i$ si comienza con un símbolo $a$ y el resto es aceptado partiendo de algún $q_j in Delta(q_i, a)$, o bien si es $ϵ$ y $q_i in F$.

  Tenemos así un sistema de $n + 1$ ecuaciones con $n + 1$ incógnitas, al cual le aplicamos sucesivamente el lema de Arden (@alg-kleene-nfa-to-regex). La solución obtenida para $X_0$ es una expresión regular $e$ con $L(e) = X_0 = L(M)$.
]

#algorithm(title: "Kleene, vuelta")[
  Dado el sistema de ecuaciones de un AFN $M$ con estados $q_0, dots, q_n$:
  + Aplicamos el lema de Arden a la ecuación de $X_n$ para obtener su valor, y lo reemplazamos en el resto de las ecuaciones, reduciendo el sistema a uno de $n times n$.
  + Repetimos lo anterior para la ecuación de $X_(n-1)$, y así sucesivamente, hasta obtener un sistema de $1 times 1$ con la ecuación correspondiente a $X_0$.
  + Aplicamos por última vez el lema de Arden, obteniendo la solución buscada, pues $X_0 = L(M)$.
] <alg-kleene-nfa-to-regex>

#example[
  Consideremos el siguiente AFN $M$:

  #fig("kleene-theorem/nfa-arden-example.png", 155pt)

  El sistema de ecuaciones que determina el autómata $M$ es:
  $ cases(
    X_0 &= a X_0 + b X_0 + a X_1 & quad (1),
    X_1 &= a X_2 & quad (2),
    X_2 &= a X_2 + b X_2 + ϵ & quad (3),
  ) $
  Aplicamos el lema de Arden en la ecuación (3):
  $ X_2 &= a X_2 + b X_2 + ϵ \
        &= (a + b) X_2 + ϵ quad therefore quad X_2 = (a + b)^*. $
  Reemplazamos el valor obtenido de $X_2$ en todo el sistema:
  $ cases(
    X_0 &= a X_0 + b X_0 + a X_1 & quad (1),
    X_1 &= a (a + b)^* & quad (2),
  ) $
  No es necesario aplicar el lema de Arden en la ecuación (2), pues no hay incógnita: $X_1 = a(a + b)^*$. Reemplazamos el valor obtenido de $X_1$ en el resto del sistema:
  $ X_0 = a X_0 + b X_0 + a^2 (a + b)^* quad (1) $
  Aplicamos el lema de Arden por última vez, en la ecuación (1):
  $ X_0 &= a X_0 + b X_0 + a^2 (a + b)^* \
        &= (a + b) X_0 + a^2 (a + b)^* quad therefore quad X_0 = (a + b)^* a^2 (a + b)^*. $
  Esta última solución de $X_0$ es la expresión regular que denota al lenguaje aceptado por el autómata $M$; por lo tanto,
  $ L(M) = (a + b)^* a^2 (a + b)^*. $
] <ex-kleene-nfa-to-regex>

== Resumen

Probamos que $"ER"^Sigma equiv "AF"^Sigma$ (@thm-kleene). Por transitividad, tenemos probada toda la cadena de equivalencias
$ "LR"^Sigma equiv "ER"^Sigma equiv "AFD"^Sigma equiv "AFN"^Sigma equiv "AFN"ϵ^Sigma. $
De esta manera, podemos asegurar que *un lenguaje es regular si y solo si es aceptado por un AF*, lo que podemos interpretar como que los AF son las máquinas secuenciales que caracterizan a los lenguajes regulares. Tenemos además una tercera herramienta para probar la regularidad de un lenguaje: simplemente dar un autómata finito que lo acepte.

En el @ch-regular-grammars presentamos un nuevo modelo computacional que también caracteriza a los lenguajes regulares: las gramáticas regulares.
