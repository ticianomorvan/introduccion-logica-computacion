#import "../../lib/notes.typ": *

= Lenguajes regulares y expresiones regulares <ch-regular-expressions>

Los *lenguajes regulares* (LR) son los lenguajes más simples dentro de la jerarquía de Chomsky. Son aquellos que se pueden construir recursivamente a partir de ciertos lenguajes muy básicos, o atómicos, aplicando una cantidad finita de operadores de lenguajes. Estos operadores son tres: unión, concatenación (@def-language-concatenation) y clausura de Kleene (@def-kleene-closure), conocidos como *operadores regulares* por ser los constructores de cualquier lenguaje regular.

== Lenguajes regulares

#definition(title: "Lenguaje regular")[
  Sea $Sigma$ un alfabeto. Los *lenguajes regulares* sobre $Sigma$ se definen recursivamente.

  _Casos atómicos:_
  - $emptyset$ es un lenguaje regular;
  - ${ϵ}$ es un lenguaje regular;
  - ${a}$ es un lenguaje regular, para cada $a in Sigma$.

  _Casos recursivos:_ si $L_1$ y $L_2$ son lenguajes regulares, entonces
  - $L_1 union L_2$ es un lenguaje regular;
  - $L_1 L_2$ es un lenguaje regular;
  - $L_1^*$ es un lenguaje regular.
] <def-regular-language>

Más formalmente, podemos estratificar los lenguajes regulares según la cantidad de operadores regulares anidados que se necesitan para obtenerlos a partir de los casos atómicos.

#definition(title: $"LR"^Sigma$)[
  Definimos $"LR"_k^Sigma$ como el conjunto de los lenguajes regulares que se obtienen a partir de los casos atómicos aplicando a lo sumo $k$ niveles de operadores regulares:
  $ "LR"_0^Sigma &= {emptyset} union {{ϵ}} union {{a} : a in Sigma}, \
    "LR"_(k+1)^Sigma &= "LR"_k^Sigma union {L_1 union L_2 : L_1, L_2 in "LR"_k^Sigma} \
      &quad union {L_1 L_2 : L_1, L_2 in "LR"_k^Sigma} \
      &quad union {L^* : L in "LR"_k^Sigma}. $
  El conjunto de todos los lenguajes regulares sobre $Sigma$ es
  $ "LR"^Sigma = union.big_(k=0)^infinity "LR"_k^Sigma. $
] <def-lr>

#example[
  Sea $Sigma = {a, b}$. El lenguaje $L_1 = {b^n a a b^m : n, m in NN}$ es regular, pues
  $ L_1 &= {b^n a a b^m : n, m in NN} \
    &= {b^n : n in NN}{a a}{b^m : m in NN} \
    &= {b}^* {a}{a}{b}^*. $
  El lenguaje $L_2 = {b alpha : alpha in Sigma^*}$ es regular, pues
  $ L_2 &= {b}{alpha : alpha in Sigma^*} \
    &= {b} Sigma^* \
    &= {b}{a, b}^* \
    &= {b}({a} union {b})^*. $
  El lenguaje $L_3 = {a^n b^m : n, m in NN}$ es regular, pues
  $ L_3 &= {a^n : n in NN}{b^m : m in NN} \
    &= {a}^* {b}^*. $
] <ex-regular-languages>

== Finitud y regularidad

Todo lenguaje finito es un lenguaje regular.

#theorem[
  Si $L$ es finito, entonces $L in "LR"^Sigma$.
] <thm-finite-regular>

#proof[
  Si $L$ es finito, entonces $L = {alpha_1, dots, alpha_k}$ con $alpha_i in Sigma^*$ y $k >= 0$. Si $k = 0$, entonces $L = emptyset$, que es regular por ser un caso atómico. Si $k >= 1$, entonces
  $ L = {alpha_1} union dots.c union {alpha_k}, $
  de modo que $L$ es regular si cada ${alpha_i}$ lo es. Veamos que ${alpha_i} in "LR"^Sigma$. Si $alpha_i = ϵ$, entonces ${ϵ} in "LR"^Sigma$ por ser un caso atómico. Si $alpha_i = a_1 dots a_r$ con $r >= 1$, entonces
  $ {alpha_i} = {a_1} dots {a_r}, $
  donde cada $\{a_j\} in "LR"^Sigma$ por ser un caso atómico; luego ${alpha_i} in "LR"^Sigma$.
]

== Propiedades de los lenguajes regulares

Los lenguajes regulares son cerrados para los operadores de conjuntos y la reversa.

#theorem[
  Si $L_1, L_2 in "LR"^Sigma$, entonces:
  + $L_1 union L_2 in "LR"^Sigma$ (trivial por definición de lenguaje regular);
  + $L_1 inter L_2 in "LR"^Sigma$;
  + $L_1 without L_2 in "LR"^Sigma$;
  + $overline(L_1) in "LR"^Sigma$;
  + $L_1^R in "LR"^Sigma$.
] <thm-lr-closure>

Postergamos la demostración, ya que para probarlo de forma relativamente sencilla necesitamos un par de resultados teóricos aún no vistos.

== Expresiones regulares

Las *expresiones regulares* son expresiones o fórmulas que sirven para describir lenguajes regulares (de allí su nombre) en forma muy legible y compacta. Con ellas podemos realizar aritmética de lenguajes regulares más fácilmente: en lugar de describir un conjunto (regular) de cadenas, escribimos directamente la expresión regular que lo denota. Al igual que los lenguajes regulares, las expresiones regulares se construyen recursivamente a partir de expresiones básicas, o atómicas, aplicando una cantidad finita de operadores.

#definition(title: "Expresión regular")[
  Sea $Sigma$ un alfabeto. Las *expresiones regulares* sobre $Sigma$ se definen recursivamente.

  _Casos atómicos:_
  - $emptyset$ es una expresión regular;
  - $ϵ$ es una expresión regular;
  - $a$ es una expresión regular, para cada $a in Sigma$.

  _Casos recursivos:_ si $e_1$ y $e_2$ son expresiones regulares, entonces
  - $e_1 + e_2$ es una expresión regular;
  - $e_1 e_2$ es una expresión regular;
  - $e_1^*$ es una expresión regular.
] <def-regular-expression>

#definition(title: $"ER"^Sigma$)[
  Definimos $"ER"_k^Sigma$ como el conjunto de las expresiones regulares que se obtienen a partir de los casos atómicos aplicando a lo sumo $k$ niveles de operadores:
  $ "ER"_0^Sigma &= Sigma union {emptyset, ϵ}, \
    "ER"_(k+1)^Sigma &= "ER"_k^Sigma union {e_1 + e_2 : e_1, e_2 in "ER"_k^Sigma} \
      &quad union {e_1 e_2 : e_1, e_2 in "ER"_k^Sigma} \
      &quad union {e^* : e in "ER"_k^Sigma}. $
  El conjunto de todas las expresiones regulares sobre $Sigma$ es
  $ "ER"^Sigma = union.big_(k=0)^infinity "ER"_k^Sigma. $
] <def-er>

#definition(title: "Lenguaje denotado")[
  Sea $e$ una expresión regular. El *lenguaje denotado* por $e$, notado $L(e)$, se define recursivamente.

  _Casos atómicos:_
  - $L(emptyset) = emptyset$;
  - $L(ϵ) = {ϵ}$;
  - $L(a) = {a}$, para cada $a in Sigma$.

  _Casos recursivos:_ si $e_1$ y $e_2$ son expresiones regulares, entonces
  - $L(e_1 + e_2) = L(e_1) union L(e_2)$;
  - $L(e_1 e_2) = L(e_1) L(e_2)$;
  - $L(e^*) = (L(e))^*$.
] <def-regex-language>

#example[
  La expresión $e_1 = (a + b)^* a (a + b)^*$ es una expresión regular sobre el alfabeto $Sigma = {a, b}$, y denota al lenguaje de todas las cadenas que contienen al menos un símbolo $a$. Verifiquémoslo aplicando la definición recursiva del lenguaje denotado:
  $ L((a + b)^* a (a + b)^*) &= L((a + b)^*) L(a) L((a + b)^*) \
    &= (L(a + b))^* L(a) (L(a + b))^* \
    &= (L(a) union L(b))^* L(a) (L(a) union L(b))^* \
    &= ({a} union {b})^* {a} ({a} union {b})^* \
    &= {a, b}^* {a} {a, b}^* \
    &= {alpha_1 a alpha_2 : alpha_1, alpha_2 in Sigma^*} \
    &= {alpha in Sigma^* : |alpha|_a >= 1}. $
] <ex-regex-at-least-one-a>

== Equivalencia entre lenguajes regulares y expresiones regulares

Un lenguaje es regular si y solo si es denotado por una expresión regular. Este resultado tiene una ida y una vuelta:
+ Ida: todo lenguaje regular tiene una expresión regular que lo denota.
+ Vuelta: toda expresión regular denota un lenguaje regular.

Formalmente:

#theorem(title: $"LR"^Sigma equiv "ER"^Sigma$)[
  + (Ida) Si $L in "LR"^Sigma$, entonces existe $e in "ER"^Sigma$ tal que $L(e) = L$.
  + (Vuelta) Si $e in "ER"^Sigma$, entonces existe $L in "LR"^Sigma$ tal que $L(e) = L$.
] <thm-lr-er>

#proof[
  Probamos solo el inciso 1; el 2 es análogo y queda como ejercicio. Procedemos por inducción en la forma del lenguaje regular $L$.

  _Casos atómicos:_
  - Si $L = emptyset$, tomamos $e = emptyset$, y $L(emptyset) = emptyset$.
  - Si $L = {ϵ}$, tomamos $e = ϵ$, y $L(ϵ) = {ϵ}$.
  - Si $L = {a}$, tomamos $e = a$, y $L(a) = {a}$.

  _Casos recursivos:_
  - Si $L = L_1 union L_2$ con $L_1, L_2 in "LR"^Sigma$, por hipótesis inductiva existen $e_1, e_2 in "ER"^Sigma$ tales que $L(e_1) = L_1$ y $L(e_2) = L_2$. Tomamos $e = e_1 + e_2$, y luego
    $ L(e_1 + e_2) = L(e_1) union L(e_2) = L_1 union L_2. $
  - Si $L = L_1 L_2$ con $L_1, L_2 in "LR"^Sigma$, por hipótesis inductiva existen $e_1, e_2 in "ER"^Sigma$ tales que $L(e_1) = L_1$ y $L(e_2) = L_2$. Tomamos $e = e_1 e_2$, y luego
    $ L(e_1 e_2) = L(e_1) L(e_2) = L_1 L_2. $
  - Si $L = L_1^*$ con $L_1 in "LR"^Sigma$, por hipótesis inductiva existe $e_1 in "ER"^Sigma$ tal que $L(e_1) = L_1$. Tomamos $e = e_1^*$, y luego
    $ L(e_1^*) = (L(e_1))^* = L_1^*. $
]

== Resumen

Dimos una definición recursiva de los lenguajes regulares ($"LR"^Sigma$, @def-lr) y probamos que finitud implica regularidad (@thm-finite-regular). Luego dimos una definición recursiva de las expresiones regulares ($"ER"^Sigma$, @def-er) y de su lenguaje denotado $L(e)$ (@def-regex-language), y probamos que los lenguajes regulares y las expresiones regulares son equivalentes (@thm-lr-er):
$ "LR"^Sigma equiv "ER"^Sigma. $
Esto nos brinda una segunda herramienta para probar la regularidad de un lenguaje: dar una expresión regular que lo denote. Asimismo, si simplemente queremos describir un lenguaje regular, en lugar de utilizar comprensión de conjuntos podemos escribir directamente una expresión regular equivalente. Notemos que esta no es única: existen varias expresiones regulares distintas que denotan un mismo lenguaje.
