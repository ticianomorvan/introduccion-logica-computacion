#import "../lib/notes.typ": *

= Lenguajes no regulares <ch-non-regular-languages>

Hasta aquí, todos los lenguajes vistos resultaron ser lenguajes regulares (@def-lr), por lo que surge la pregunta de si verdaderamente existen lenguajes que no lo sean. La respuesta es que sí: claro que existen, y hay infinidad de ellos. En este capítulo presentamos algunos y desarrollamos una técnica para probar formalmente que un lenguaje no es regular.

== Ejemplos de lenguajes no regulares

El lenguaje de todas las cadenas formadas por una secuencia de $a$'s seguida de una secuencia de $b$'s de igual longitud no es regular:
$ L_1 = {a^m b^m : m >= 0} in.not "LR"^Sigma. $
Una intuición posible detrás de este resultado es que no puede existir un AF que compute $L_1$, pues los AF son máquinas puramente locales, es decir, sin memoria: no guardan ningún registro de lo que ya computaron de la cadena en el pasado. Y claramente, para computar $L_1$ necesitamos algún mecanismo de memoria que permita saber cuántas $a$'s se procesaron previamente, para poder compararlas más tarde con la cantidad de $b$'s que se procesarán.

Tampoco es regular el lenguaje de las cadenas capicúas del alfabeto,
$ L_2 = {alpha in Sigma^* : alpha = alpha^R} in.not "LR"^Sigma, $
ni el lenguaje de todas las reflexiones del alfabeto,
$ L_3 = {alpha alpha : alpha in Sigma^*} in.not "LR"^Sigma. $
Ninguno de estos tres lenguajes puede tener un AF que lo acepte, pues los AF carecen de memoria. $L_1$ y $L_2$ son lenguajes independientes de contexto, mientras que $L_3$ es sensible al contexto.

Más allá de la intuición, necesitamos una herramienta para probar con rigurosidad matemática que dicho autómata no existe, es decir, una técnica que pruebe formalmente que un lenguaje no es regular. Para ello utilizaremos el _lema de bombeo_ (_pumping lemma_), que es una propiedad que todo lenguaje regular cumple. Por lo tanto, si probamos que un lenguaje no satisface dicha propiedad, entonces ese lenguaje no puede ser regular.

== Lema de bombeo

La propiedad dice que toda cadena suficientemente larga de un lenguaje regular tiene una subcadena que puede repetirse una cantidad arbitraria de veces (_bombeo_), y que la nueva cadena “bombeada” pertenece al lenguaje.

#lemma(title: "Lema de bombeo")[
  Para todo $L in "LR"^Sigma$ existe $n in NN$, llamada _constante de bombeo_ de $L$, tal que, si $alpha in L$ con $|alpha| >= n$, entonces $alpha$ se puede descomponer como $alpha = alpha_1 alpha_2 alpha_3$ donde:
  + $|alpha_1 alpha_2| <= n$;
  + $alpha_2 != ϵ$;
  + $alpha_1 alpha_2^i alpha_3 in L$ para todo $i >= 0$.
] <lem-pumping>

#proof[
  Si $L in "LR"^Sigma$, entonces, por el teorema de Kleene (@thm-kleene) y la equivalencia entre los tipos de autómatas (@thm-dfa-nfa y @thm-nfa-enfa), existe un AFD $M = (Sigma, Q, q_0, F, delta)$ tal que $L(M) = L$; sea $n = |Q|$. Sea $alpha in L$ con $|alpha| >= n$. Al procesar la cadena $alpha$ existe al menos un estado $q in Q$ que es visitado dos veces (es decir, se repite), pues al procesar sus $|alpha| >= n$ símbolos $M$ recorre al menos $n + 1$ estados (contando $q_0$), y $Q$ tiene solo $n$. Por lo tanto, $alpha$ se puede descomponer de la siguiente manera:

  #fig("non-regular-languages/pumping-decomposition-tape.png", 340pt)

  donde $alpha_1$ lleva a $M$ de $q_0$ a $q$, $alpha_2$ lo lleva de $q$ nuevamente a $q$, y $alpha_3$ lo lleva de $q$ a un estado $p in F$. Luego, la subcadena $alpha_2$ puede ser repetida (bombeada) una cantidad cualquiera de veces y, aun así, el procesamiento de la cadena bombeada arribará al estado $p in F$:

  #fig("non-regular-languages/pumping-loop-diagram.png", 185pt)

  Por lo tanto, la cadena bombeada pertenece al lenguaje $L$:
  $ alpha_1 alpha_2^i alpha_3 in L quad "para todo" i >= 0. $
]

== Cómo probar que un lenguaje no es regular

#algorithm(title: "Prueba de no regularidad")[
  Para demostrar formalmente que un lenguaje $L$ no es regular utilizando el lema de bombeo (@lem-pumping), procedemos siempre de la siguiente manera:
  + Suponer que $L in "LR"^Sigma$ y denotar con $n$ a la constante de bombeo de $L$.
  + Tomar una $alpha in L$ con $|alpha| >= n$, arbitraria pero “conveniente”, que esté definida en términos de $n$.
  + Descomponer $alpha$ en subcadenas $alpha_1, alpha_2, alpha_3$ como indica el lema de bombeo.
  + Hallar un $i >= 0$ tal que $alpha_1 alpha_2^i alpha_3 in.not L$, lo cual es absurdo.

  El absurdo proviene de suponer en (1) que $L in "LR"^Sigma$; por lo tanto, $L in.not "LR"^Sigma$.
] <alg-non-regularity-proof>

== Aplicaciones del lema de bombeo

En lo que sigue, sea $Sigma = {a, b}$.

#proposition[
  El lenguaje $L_1 = {a^m b^m : m >= 0}$ no es regular.
] <prop-anbn-non-regular>

#proof[
  Supongamos que $L_1 in "LR"^Sigma$ y sea $n$ la constante de bombeo de $L_1$. Tomamos $alpha = a^n b^n in L_1$, luego $|alpha| = 2n >= n$. Por el lema de bombeo, $alpha = alpha_1 alpha_2 alpha_3$ donde, como $|alpha_1 alpha_2| <= n$ y $alpha_2 != ϵ$,
  $ alpha_1 &= a^r "con" r >= 0, \
    alpha_2 &= a^s "con" s >= 1, \
    alpha_3 &= a^(n-(s+r)) b^n. $
  Para $i = 0$ tenemos que
  $ alpha_1 alpha_2^0 alpha_3 &= a^r (a^s)^0 a^(n-(s+r)) b^n \
    &= a^r ϵ a^(n-s-r) b^n \
    &= a^(n-s) b^n in.not L_1, $
  pues $s >= 1$, lo cual es absurdo. Por lo tanto, $L_1 in.not "LR"^Sigma$.
]

#proposition[
  El lenguaje $L_2 = {alpha in Sigma^* : alpha = alpha^R}$ de todas las cadenas capicúas del alfabeto no es regular.
] <prop-palindromes-non-regular>

#proof[
  Supongamos que $L_2 in "LR"^Sigma$ y sea $n$ la constante de bombeo de $L_2$. Tomamos $alpha = a^n b a^n in L_2$, luego $|alpha| = 2n + 1 >= n$. Por el lema de bombeo, $alpha = alpha_1 alpha_2 alpha_3$ donde, como $|alpha_1 alpha_2| <= n$ y $alpha_2 != ϵ$,
  $ alpha_1 &= a^r "con" r >= 0, \
    alpha_2 &= a^s "con" s >= 1, \
    alpha_3 &= a^(n-(s+r)) b a^n. $
  Para $i = 2$ tenemos que
  $ alpha_1 alpha_2^2 alpha_3 &= a^r (a^s)^2 a^(n-(s+r)) b a^n \
    &= a^r a^(2s) a^(n-s-r) b a^n \
    &= a^(n+s) b a^n in.not L_2, $
  pues $s >= 1$, lo cual es absurdo. Por lo tanto, $L_2 in.not "LR"^Sigma$.
]

== Resumen

Hay lenguajes que no son regulares, tales como $L_1 = {a^m b^m : m >= 0}$ (@prop-anbn-non-regular) y $L_2 = {alpha in Sigma^* : alpha = alpha^R}$ (@prop-palindromes-non-regular). El lema de bombeo (@lem-pumping) y el razonamiento por el absurdo conforman una técnica para probar formalmente que un lenguaje no es regular (@alg-non-regularity-proof). $L_1$ y $L_2$ son lenguajes independientes de contexto, y esto se prueba mediante autómatas a pila o gramáticas independientes de contexto, modelos que exceden el alcance de estas notas.
