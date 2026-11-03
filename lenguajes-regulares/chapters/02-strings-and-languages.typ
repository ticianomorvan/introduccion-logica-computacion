#import "../lib/notes.typ": *

= Alfabetos, cadenas y lenguajes <ch-strings-and-languages>

En este capítulo definimos formalmente la noción de lenguaje a partir de los conceptos de alfabeto y de cadena de un alfabeto. Definimos operadores sobre las cadenas y luego los extendemos a los lenguajes, enunciamos las principales propiedades que satisfacen dichas operaciones y fijamos su orden de precedencia.

== Alfabetos y cadenas

#definition(title: "Alfabeto")[
  Un *alfabeto* es cualquier conjunto finito y no vacío de símbolos arbitrarios. Los alfabetos se suelen denotar con la letra griega $Sigma$.
] <def-alphabet>

#definition(title: "Cadena")[
  Una *cadena* o *palabra* del alfabeto $Sigma$ es cualquier secuencia finita de símbolos de $Sigma$. Las denotamos con letras griegas $alpha$, $beta$, $gamma$.

  Denotamos con $Sigma^*$ al conjunto de todas las cadenas posibles del alfabeto $Sigma$ (es decir, el universo de cadenas del alfabeto), y con $ϵ$ a la única cadena que no contiene símbolos, llamada *cadena vacía*.
] <def-string>

#example[
  $Sigma_1 = {a, b, c}$ es un alfabeto con tres símbolos, mientras que $Sigma_2 = {\&, \#}$ es un alfabeto con dos símbolos. La secuencia $alpha = a b b$ es una cadena del alfabeto $Sigma_1$, mientras que $beta = \&\#\#\&$ es una cadena del alfabeto $Sigma_2$.
] <ex-alphabets-and-strings>

== Operaciones sobre cadenas

Definimos cuatro operadores de cadenas: concatenación, potencia, longitud y reversa.

#definition(title: "Concatenación de cadenas")[
  Sean $alpha, beta in Sigma^*$. La *concatenación* de $alpha$ y $beta$ es
  $ alpha . beta = cases(
    alpha & "si" beta = ϵ,
    beta & "si" alpha = ϵ,
    a_1 dots a_n b_1 dots b_m & "si" alpha = a_1 dots a_n "y" beta = b_1 dots b_m.
  ) $
] <def-string-concatenation>

#example[
  Si $alpha = a a$ y $beta = b b$, entonces $alpha . beta = a a b b$.
]

#proposition[
  La concatenación de cadenas satisface:
  + es asociativa: $alpha . (beta . gamma) = (alpha . beta) . gamma$;
  + no es conmutativa, pues en general $alpha . beta != beta . alpha$;
  + su elemento neutro es la cadena vacía: $alpha . ϵ = ϵ . alpha = alpha$.
] <prop-string-concatenation-properties>

De aquí en adelante denotamos la concatenación de $alpha$ y $beta$ escribiendo simplemente $alpha beta$ (omitimos el “$.$”).

#definition(title: "Potencia de una cadena")[
  Sean $alpha in Sigma^*$ y $n in NN$. La *potencia $n$-ésima* de $alpha$ es
  $ alpha^n = cases(
    ϵ & "si" n = 0,
    underbrace(alpha dots alpha, n "veces") & "si" n >= 1.
  ) $
] <def-string-power>

#example[
  Si $alpha = a b$, entonces $alpha^3 = alpha alpha alpha = a b a b a b$.
]

#proposition[
  Para toda $alpha in Sigma^*$ y $n, m in NN$:
  + $alpha^n alpha^m = alpha^(n + m)$;
  + $(alpha^n)^m = alpha^(n dot m)$.
] <prop-string-power-properties>

#definition(title: "Longitud de una cadena")[
  Sea $alpha in Sigma^*$. La *longitud* de $alpha$ es
  $ |alpha| = cases(
    0 & "si" alpha = ϵ,
    n & "si" alpha = a_1 dots a_n.
  ) $
] <def-string-length>

#example[
  $|a b b a b| = 5$ y $|ϵ| = 0$.
]

#proposition[
  Para toda $alpha, beta in Sigma^*$ y $n, m in NN$:
  + $|alpha beta| = |alpha| + |beta|$;
  + $|alpha^n| = n dot |alpha|$;
  + $|alpha^(n + m)| = |alpha^n| + |alpha^m|$;
  + $|(alpha^n)^m| = n dot m dot |alpha|$.
] <prop-string-length-properties>

#notation(title: "Ocurrencias de un símbolo")[
  Sean $alpha in Sigma^*$ y $x in Sigma$. Denotamos con $|alpha|_x$ la cantidad de ocurrencias del símbolo $x$ en la cadena $alpha$. Por ejemplo, $|a b b a b|_a = 2$ y $|a b b a b|_b = 3$.
] <not-symbol-occurrences>

#definition(title: "Reversa de una cadena")[
  Sea $alpha in Sigma^*$. La *reversa* de $alpha$ es
  $ alpha^R = cases(
    ϵ & "si" alpha = ϵ,
    a_n dots a_1 & "si" alpha = a_1 dots a_n.
  ) $
] <def-string-reverse>

#example[
  Si $alpha = a b b$, entonces $alpha^R = b b a$.
]

#proposition[
  Para toda $alpha, beta in Sigma^*$:
  + $(alpha beta)^R = beta^R alpha^R$;
  + $(alpha^R)^R = alpha$;
  + $|alpha^R| = |alpha|$.
] <prop-string-reverse-properties>

#definition(title: "Subcadena, prefijo y sufijo")[
  Sean $alpha, alpha' in Sigma^*$. Decimos que:
  - $alpha'$ es *subcadena* de $alpha$ sii existen $beta_1, beta_2 in Sigma^*$ tales que $alpha = beta_1 alpha' beta_2$;
  - $alpha'$ es *prefijo* de $alpha$ sii existe $beta in Sigma^*$ tal que $alpha = alpha' beta$;
  - $alpha'$ es *sufijo* de $alpha$ sii existe $beta in Sigma^*$ tal que $alpha = beta alpha'$.
] <def-substring-prefix-suffix>

#example[
  Si $alpha = a b b$, entonces $b$ es subcadena, $a b$ es prefijo y $b b$ es sufijo de $alpha$.
]

== Lenguajes

#definition(title: "Lenguaje")[
  Un *lenguaje* en el alfabeto $Sigma$ es cualquier conjunto de cadenas de $Sigma$; más formalmente, un lenguaje es cualquier conjunto $L subset.eq Sigma^*$.
] <def-language>

#example[
  Sea $Sigma = {a, b}$.
  - $L_1 = emptyset$ es el lenguaje que no contiene cadenas (*lenguaje vacío*).
  - $L_2 = Sigma^*$ es el lenguaje de todas las cadenas en el alfabeto.
  - $L_3 = {a a, a b, b a, b b}$ es el lenguaje de todas las cadenas de longitud 2.
  - $L_4 = {ϵ, a, a^2, a^3, a^4, dots}$ es el lenguaje de todas las cadenas que no tienen un símbolo $b$.
  - $L_5 = {alpha in Sigma^* : |alpha|_a "es par"}$ es el lenguaje de todas las cadenas que tienen una cantidad par de símbolos $a$.
  - $L_6 = {alpha in Sigma^* : alpha = alpha^R}$ es el lenguaje de todas las cadenas capicúas.

  Un lenguaje puede ser finito (como $L_1$ y $L_3$) o infinito (como $L_2$, $L_4$, $L_5$ y $L_6$).
] <ex-languages>

== Operaciones sobre lenguajes

#remark(title: "Operaciones de conjuntos")[
  Como los lenguajes son conjuntos (de cadenas), todo operador de conjuntos es también un operador de lenguajes. Si $L_1$ y $L_2$ son lenguajes, entonces también lo son su *unión* $L_1 union L_2$, su *intersección* $L_1 inter L_2$, su *resta* $L_1 without L_2$ y el *complemento* $overline(L_1)$.
] <rem-language-set-operations>

Además, podemos extender los operadores de concatenación, potencia y reversa de las cadenas a los lenguajes.

#definition(title: "Concatenación de lenguajes")[
  Sean $L_1, L_2 subset.eq Sigma^*$. La *concatenación* de $L_1$ y $L_2$ es
  $ L_1 . L_2 = {alpha beta : alpha in L_1 "y" beta in L_2}. $
  Como con las cadenas, omitimos el “$.$” y escribimos $L_1 L_2$.
] <def-language-concatenation>

#example[
  Si $L_1 = {a, a a}$ y $L_2 = {b, b b}$, entonces $L_1 L_2 = {a b, a b b, a a b, a a b b}$.
]

#proposition[
  Sean $L, L_1, L_2, L_3 subset.eq Sigma^*$. La concatenación de lenguajes satisface:
  + elemento absorbente: $L emptyset = emptyset L = emptyset$;
  + elemento neutro: $L{ϵ} = {ϵ}L = L$;
  + asociatividad: $L_1 (L_2 L_3) = (L_1 L_2) L_3$;
  + distributividad con $union$ por izquierda y por derecha, respectivamente:
    $ L_1 (L_2 union L_3) &= (L_1 L_2) union (L_1 L_3), \
      (L_2 union L_3) L_1 &= (L_2 L_1) union (L_3 L_1). $

  En cambio, no es conmutativa, y tampoco es distributiva con $inter$ ni por izquierda ni por derecha.
] <prop-language-concatenation-properties>

#definition(title: "Potencia de un lenguaje")[
  Sean $L subset.eq Sigma^*$ y $n in NN$. La *potencia $n$-ésima* de $L$ es
  $ L^n = cases(
    {ϵ} & "si" n = 0,
    underbrace(L dots L, n "veces") & "si" n >= 1.
  ) $
  Por lo tanto, $L^n$ es el conjunto de todas las posibles concatenaciones de $n$ cadenas de $L$.
] <def-language-power>

#example[
  Si $L = {a, b b}$, entonces $L^2 = {a a, a b b, b b a, b b b b}$.
]

#definition(title: "Reversa de un lenguaje")[
  Sea $L subset.eq Sigma^*$. La *reversa* de $L$ es
  $ L^R = {alpha^R : alpha in L}, $
  es decir, el conjunto de todas las reversas de cadenas de $L$.
] <def-language-reverse>

#example[
  Si $L = {a, a b, b a b b}$, entonces $L^R = {a, b a, b b a b}$.
]

#proposition[
  Para todo $L, L_1, L_2 subset.eq Sigma^*$:
  + $(L_1 union L_2)^R = L_1^R union L_2^R$;
  + $(L_1 inter L_2)^R = L_1^R inter L_2^R$;
  + $(L_1 L_2)^R = L_2^R L_1^R$;
  + $(L^R)^R = L$.
] <prop-language-reverse-properties>

== Clausuras

#definition(title: "Clausura de Kleene")[
  Sea $L subset.eq Sigma^*$. La *clausura de Kleene* de $L$ es
  $ L^* = {alpha_1 dots alpha_n : alpha_i in L "y" n >= 0}, $
  es decir, el conjunto de todas las posibles concatenaciones de cadenas de $L$. El lenguaje $L^*$ siempre contiene a la cadena $ϵ$, y es infinito salvo que $L = emptyset$ o $L = {ϵ}$.
] <def-kleene-closure>

#definition(title: "Clausura positiva")[
  Sea $L subset.eq Sigma^*$. La *clausura positiva* de $L$ es
  $ L^+ = {alpha_1 dots alpha_n : alpha_i in L "y" n >= 1}. $
] <def-positive-closure>

#example[
  Si $L = {a}$, entonces $L^* = {ϵ, a, a a, a a a, a a a a, dots}$ y $L^+ = {a, a a, a a a, a a a a, dots}$.
] <ex-closures>

#proposition[
  Para todo $L subset.eq Sigma^*$ se cumplen:
  #grid(
    columns: 2, column-gutter: 4em,
    [
      + $L^* = union.big_(i = 0)^infinity L^i$
      + $L^+ = union.big_(i = 1)^infinity L^i$
      + $L^* L^* = L^*$
      + $L^+ L^+ = L^+$
      + $(L^*)^* = L^*$
      + $(L^+)^+ = L^+$
    ],
    [
      7. $L^+ = L L^*$
      + $(L^+)^* = L^*$
      + $(L^*)^R = (L^R)^*$
      + $(L^+)^R = (L^R)^+$
    ],
  )
] <prop-closure-properties>

== Precedencia de los operadores

#remark(title: "Precedencia de los operadores")[
  En ausencia de paréntesis, los operadores siguen el siguiente orden de precedencia, de mayor a menor:
  + potencia, reversa, complemento y clausuras;
  + concatenación;
  + unión, intersección y resta.
] <rem-operator-precedence>
