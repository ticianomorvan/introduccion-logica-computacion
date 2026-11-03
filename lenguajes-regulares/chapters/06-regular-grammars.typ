#import "../../lib/notes.typ": *

= Gramáticas regulares <ch-regular-grammars>

En los capítulos anteriores probamos que los lenguajes regulares, las expresiones regulares y los autómatas finitos son equivalentes (@thm-lr-er y @thm-kleene):
$ "LR"^Sigma equiv "ER"^Sigma equiv "AF"^Sigma. $
En este capítulo presentamos el último modelo computacional que caracteriza a los lenguajes regulares: las llamadas *gramáticas regulares*.

Las gramáticas fueron el modelo matemático propuesto originalmente por Chomsky para caracterizar cada una de las clases de lenguajes de su jerarquía:

#align(center, grid(
  columns: 3, column-gutter: 1.5em, row-gutter: 0.7em,
  [Lenguaje regular], $<->$, [Gramática regular],
  [Lenguaje independiente del contexto], $<->$, [Gramática independiente del contexto],
  [Lenguaje sensible al contexto], $<->$, [Gramática sensible al contexto],
  [Lenguaje recursivamente enumerable], $<->$, [Gramática sin restricciones],
))

== Gramáticas de Chomsky

Definimos primero la versión más general del modelo, denominada *gramática sin restricciones*; luego le impondremos una fuerte restricción, que da lugar a la llamada gramática regular.

#definition(title: "Gramática sin restricciones")[
  Una *gramática* es una 4-upla $G = (V, Sigma, S, P)$, con $V inter Sigma = emptyset$, donde:
  - $V$ es un conjunto finito de *símbolos no terminales*, llamado conjunto de _variables_;
  - $Sigma$ es un conjunto finito de *símbolos terminales*;
  - $S in V$ es la *variable inicial*;
  - $P$ es un conjunto finito de *producciones* de la forma $alpha -> beta$, con $alpha, beta in (V union Sigma)^*$ y $alpha != ϵ$.
] <def-chomsky-grammar>

Una gramática permite generar o _derivar_ cadenas de símbolos terminales mediante una sucesión de reemplazos sintácticos definidos en su conjunto de producciones: la producción $alpha -> beta$ significa que podemos *sustituir* una ocurrencia de la cadena $alpha$ por la cadena $beta$. Todas las cadenas que se pueden derivar en una gramática definen el _lenguaje_ de la gramática.

#example[
  Sea $G_1 = ({S}, {a, b}, S, {S -> a S, S -> ϵ})$. Podemos derivar la cadena $a a a$ en $G_1$ de la siguiente manera:
  $ S limits(=>)_(G_1) a S limits(=>)_(G_1) a a S limits(=>)_(G_1) a a a S limits(=>)_(G_1) a a a. $
] <ex-grammar-g1-derivation>

#notation[
  Denotamos con mayúsculas a las variables de una gramática y con minúsculas a sus símbolos terminales. Por simplicidad, describimos una gramática listando sus producciones, separando con “$|$” las que tienen el mismo lado izquierdo, y con $S$ como variable inicial. Por ejemplo, la gramática $G_1$ del @ex-grammar-g1-derivation se escribe
  $ G_1 : S -> a S | ϵ. $
] <not-grammar-productions>

== Derivación de cadenas

#definition(title: "Derivación")[
  Sea $G = (V, Sigma, S, P)$ una gramática y sean $alpha, beta in (V union Sigma)^*$. Decimos que $beta$ se deriva de $alpha$ en *un paso*, y escribimos $alpha limits(=>)_G beta$, sii existen $alpha_1, alpha_2, alpha'_2, alpha_3 in (V union Sigma)^*$ tales que
  $ alpha = alpha_1 alpha_2 alpha_3, quad beta = alpha_1 alpha'_2 alpha_3 quad "y" quad alpha_2 -> alpha'_2 in P. $
  Decimos que $beta$ se deriva de $alpha$ en *$n$ pasos*, y escribimos $alpha limits(=>)_G^n beta$, sii existen $alpha_1, dots, alpha_(n+1) in (V union Sigma)^*$ tales que
  $ alpha = alpha_1 limits(=>)_G alpha_2 limits(=>)_G dots.c limits(=>)_G alpha_(n+1) = beta. $
  Finalmente, escribimos $alpha limits(=>)_G^* beta$ sii $alpha limits(=>)_G^n beta$ para algún $n in NN$.
] <def-derivation>

#definition(title: "Lenguaje generado")[
  El *lenguaje generado* por una gramática $G = (V, Sigma, S, P)$ es el conjunto de todas las cadenas de símbolos terminales que pueden ser derivadas en $G$ a partir de su variable inicial:
  $ L(G) = {alpha in Sigma^* : S limits(=>)_G^* alpha}. $
] <def-grammar-language>

#example[
  Para la gramática $G_1 : S -> a S | ϵ$ del @ex-grammar-g1-derivation tenemos $L(G_1) = {a^n : n in NN} = a^*$.

  Sea $G_2$ la gramática
  $ G_2 : S &-> ϵ | b S | a A \
          A &-> a S | b A. $
  Tenemos $L(G_2) = {alpha in Sigma^* : |alpha|_a "es par"}$.

  Sea $G_3$ la gramática
  $ G_3 : S -> a S b | ϵ. $
  Tenemos $L(G_3) = {a^m b^m : m in NN}$.

  Sea $G_4$ la gramática
  $ G_4 : S -> a S a | b S b | a | b | ϵ. $
  Tenemos $L(G_4) = {alpha in Sigma^* : alpha = alpha^R}$, el lenguaje de las cadenas capicúas.
] <ex-grammar-languages>

== Gramáticas regulares

Las gramáticas regulares surgen de imponer una fuerte restricción en la forma de las producciones $alpha -> beta$ de la gramática: $alpha$ es una única variable, y $beta$ es una cadena de símbolos terminales seguida de a lo sumo una variable, o al revés.

#definition(title: "Gramática regular")[
  Una gramática $G = (V, Sigma, S, P)$ es *lineal por derecha* sii todas sus producciones son de la forma $A -> alpha B$ o $A -> alpha$, con $alpha in Sigma^*$ y $A, B in V$. Análogamente, $G$ es *lineal por izquierda* sii todas sus producciones son de la forma $A -> B alpha$ o $A -> alpha$, con $alpha in Sigma^*$ y $A, B in V$.

  Una gramática es una *gramática regular* (GR) sii es lineal por derecha o lineal por izquierda. Notamos
  $ "GR"^Sigma = {G : G "es GR con símbolos terminales" Sigma}. $
] <def-regular-grammar>

#example[
  De los ejemplos anteriores (@ex-grammar-languages), $G_1$ y $G_2$ son gramáticas regulares, mientras que $G_3$ y $G_4$ no lo son, pues las producciones $S -> a S b$ y $S -> a S a | b S b$, respectivamente, no son lineales.

  Sea $G_5$ la gramática regular
  $ G_5 : S &-> a S | B \
          B &-> b B | ϵ. $
  Tenemos $L(G_5) = {a^n b^m : n, m in NN} = a^* b^*$.

  Sea $G_6$ la gramática regular
  $ G_6 : S &-> a S | b S | A \
          A &-> a A | a. $
  Tenemos $L(G_6) = (a + b)^* a^+$.
] <ex-regular-grammars>

=== Probar por inducción que $L(G) = L$

Sea $L = {alpha in Sigma^* : |alpha| "es par"}$ y sea $G$ la gramática regular
$ G : S -> a a S | a b S | b a S | b b S | ϵ. $
Tenemos que $L(G) = L$. Pero ¿cómo podemos asegurar con certeza matemática que efectivamente $L(G) = L$? Debemos ver que vale la inclusión mutua, $L(G) subset.eq L$ y $L subset.eq L(G)$, y lo probaremos por inducción.

#proposition[
  Sea $L = {alpha in Sigma^* : |alpha| "es par"}$ y sea $G : S -> a a S | a b S | b a S | b b S | ϵ$. Entonces $L(G) = L$.
] <prop-even-length-grammar>

#proof[
  ($L(G) subset.eq L$) Sea $alpha in L(G)$. Entonces $S limits(=>)_G^* alpha$ con $alpha in Sigma^*$, y por lo tanto $S limits(=>)_G^n alpha$ para algún $n >= 1$. Hacemos inducción en $n$, es decir, en la cantidad de pasos de la derivación, con hipótesis inductiva

  HI: si $S limits(=>)_G^n alpha$, entonces $alpha in L$ (o sea, $|alpha|$ es par).

  _Caso base_ $n = 1$: si $S limits(=>)_G^1 alpha$, entonces $alpha = ϵ$, y $|ϵ| = 0$ es par, luego $ϵ in L$.

  _Caso inductivo_ $n + 1$: si $S limits(=>)_G^(n+1) alpha$, entonces
  $ S limits(=>)_G^1 x_1 x_2 S limits(=>)_G^n alpha, quad "con" x_1, x_2 in {a, b}, $
  por lo que $alpha = x_1 x_2 alpha'$ con $alpha' in Sigma^*$ y $S limits(=>)_G^n alpha'$. Luego, por HI, $alpha' in L$, es decir, $|alpha'|$ es par. Por lo tanto $|alpha| = |x_1 x_2 alpha'| = 2 + |alpha'|$ es par, y $alpha in L$.

  ($L subset.eq L(G)$) Sea $alpha in L$ y sea $n = |alpha|$, con $n >= 0$ par. Hacemos inducción en $n$, es decir, en la longitud de la cadena, con hipótesis inductiva

  HI: si $alpha in L$ y $|alpha| = n$, entonces $S limits(=>)_G^* alpha$ (o sea, $alpha in L(G)$).

  _Caso base_ $n = 0$: si $|alpha| = 0$, entonces $alpha = ϵ$, y tomamos $S limits(=>)_G^1 ϵ$, luego $ϵ in L(G)$.

  _Caso inductivo_ $n + 2$: si $|alpha| = n + 2$, entonces $alpha = x_1 x_2 alpha'$, con $alpha' in Sigma^*$, $|alpha'| = n$ par y $x_1, x_2 in {a, b}$. Luego $alpha' in L$, y por HI, $alpha' in L(G)$, es decir, $S limits(=>)_G^* alpha'$. Entonces tomamos
  $ S limits(=>)_G^1 x_1 x_2 S limits(=>)_G^* x_1 x_2 alpha' = alpha, $
  y por lo tanto $alpha in L(G)$.
]

#remark[
  No fue el caso en la @prop-even-length-grammar, pero en general, en las gramáticas que utilizan otras variables además de la variable inicial $S$, debemos fortalecer la hipótesis inductiva.
]

== Equivalencia entre lenguajes regulares y gramáticas regulares

Un lenguaje es regular si y solo si es generado por una gramática regular. Es decir, queremos probar que los lenguajes regulares y las gramáticas regulares son equivalentes:
$ "LR"^Sigma equiv "GR"^Sigma. $
Para probarlo de manera sencilla necesitamos introducir primero el concepto de *gramática regular de paso único* (GRPU). Probaremos que las GR y las GRPU son equivalentes,
$ "GRPU"^Sigma equiv "GR"^Sigma, $
y por último, que los AF y las GRPU son equivalentes,
$ "GRPU"^Sigma equiv "AF"^Sigma. $
Así, por transitividad, habremos probado que $"LR"^Sigma equiv "GR"^Sigma$, pues
$ "LR"^Sigma equiv "ER"^Sigma equiv "AFD"^Sigma equiv "AFN"^Sigma equiv "AFN"ϵ^Sigma equiv "GRPU"^Sigma equiv "GR"^Sigma. $

=== Gramáticas regulares de paso único

Las GRPU surgen de imponer una restricción aún más fuerte a la forma de las producciones de una gramática regular; por lo tanto, son un caso particular de gramáticas regulares.

#definition(title: "Gramática regular de paso único")[
  Una gramática $G = (V, Sigma, S, P)$ es una *gramática regular de paso único* (GRPU) sii todas sus producciones son de la forma $A -> a B$, $A -> B$ o $A -> ϵ$, con $a in Sigma$ y $A, B in V$. Notamos
  $ "GRPU"^Sigma = {G : G "es GRPU con símbolos terminales" Sigma}. $
] <def-single-step-grammar>

#example[
  De las gramáticas anteriores, $G_1$, $G_2$ y $G_5$ son gramáticas regulares de paso único; $G_6$ no lo es, pues la producción $A -> a$ no es de paso único. La gramática $G$ de la @prop-even-length-grammar, con $L(G) = {alpha in Sigma^* : |alpha| "es par"}$, es regular pero no es de paso único:
  $ G : S -> a a S | a b S | b a S | b b S | ϵ. $
] <ex-single-step-grammars>

#remark(title: "GRPU vs. GR")[
  En una gramática regular podemos derivar una cadena $alpha$ de $k$ símbolos con la aplicación de una sola producción:
  $ S limits(=>)^1 alpha A, quad "con" alpha = a_1 dots a_k. $
  En una gramática regular de paso único, en cambio, derivamos $alpha$ aplicando $k$ producciones:
  $ S limits(=>)^1 a_1 A_1 limits(=>)^1 a_1 a_2 A_2 limits(=>)^1 dots.c limits(=>)^1 a_1 a_2 dots a_(k-1) A_(k-1) limits(=>)^1 a_1 a_2 dots a_k A = alpha A, $
  es decir, $S limits(=>)^k alpha A$. Por lo tanto, las GRPU pueden generar las mismas cadenas que una GR, pero símbolo a símbolo: pueden verse como la versión “bit a bit” de las GR.
] <rem-grpu-vs-gr>

=== Equivalencia entre GRPU y GR

Las gramáticas regulares y las gramáticas regulares de paso único generan exactamente los mismos lenguajes.

#theorem(title: $"GRPU"^Sigma equiv "GR"^Sigma$)[
  + Si $G in "GRPU"^Sigma$, entonces existe $G' in "GR"^Sigma$ tal que $L(G') = L(G)$.
  + Si $G in "GR"^Sigma$, entonces existe $G' in "GRPU"^Sigma$ tal que $L(G') = L(G)$.
] <thm-grpu-gr>

#proof[
  (1) Trivial, pues una GRPU es en particular una GR.

  (2) Debemos reemplazar por producciones de paso único aquellas producciones de $G$ que no lo son, y preservar las que sí lo son. Sean $P$ y $P'$ las producciones de $G$ y $G'$, respectivamente. Para cada producción que reemplazamos introducimos variables nuevas $C_1, dots, C_(k+1)$, que no están en $V$ ni se usan para ninguna otra producción.

  Si $(A -> a_1 dots a_k B) in P$, con $k >= 2$, entonces en $P'$ ponemos
  $ A &-> C_1 \
    C_1 &-> a_1 C_2 \
    C_2 &-> a_2 C_3 \
    & #h(0.6em) dots.v \
    C_k &-> a_k C_(k+1) \
    C_(k+1) &-> B. $

  Si $(A -> a_1 dots a_k) in P$, con $k >= 1$, entonces en $P'$ ponemos
  $ A &-> C_1 \
    C_1 &-> a_1 C_2 \
    C_2 &-> a_2 C_3 \
    & #h(0.6em) dots.v \
    C_k &-> a_k C_(k+1) \
    C_(k+1) &-> ϵ. $

  Es claro que $G'$ es GRPU y que $alpha in L(G)$ sii $alpha in L(G')$; por lo tanto, $L(G) = L(G')$.
]

#example[
  Sea $G$ la gramática regular
  $ G : S -> a a S | b b, $
  con $L(G) = (a a)^* b b$. Su GRPU equivalente $G'$ es
  $ G' : S &-> A_1 | B_1 \
         A_1 &-> a A_2 \
         A_2 &-> a A_3 \
         A_3 &-> S \
         B_1 &-> b B_2 \
         B_2 &-> b B_3 \
         B_3 &-> ϵ, $
  y claramente $L(G') = (a a)^* b b$.
] <ex-gr-to-grpu>

== Equivalencia entre gramáticas regulares y autómatas finitos

Los autómatas finitos y las gramáticas regulares son computacionalmente equivalentes, pues computan los mismos lenguajes: los regulares. Ya sabemos que $"LR"^Sigma equiv "AF"^Sigma$ (@thm-kleene) y, por el @thm-grpu-gr, que $"GRPU"^Sigma equiv "GR"^Sigma$. Probaremos ahora que $"GRPU"^Sigma equiv "AF"^Sigma$; por transitividad tendremos que $"AF"^Sigma equiv "GR"^Sigma$, y por lo tanto, $"LR"^Sigma equiv "GR"^Sigma$.

#theorem(title: $"GRPU"^Sigma equiv "AF"^Sigma$)[
  + Si $G in "GRPU"^Sigma$, entonces existe $M in "AFN"ϵ^Sigma$ tal que $L(G) = L(M)$.
  + Si $M in "AFN"ϵ^Sigma$, entonces existe $G in "GRPU"^Sigma$ tal que $L(G) = L(M)$.
] <thm-grpu-af>

#proof[
  (1) Sea $G = (V, Sigma, S, P)$. Tomamos el AFN$ϵ$ (@def-enfa) $M = (Sigma, Q, q_0, F, Delta)$ cuyos estados son las variables de $G$ y cuyas transiciones simulan las producciones de $G$:
  $ Q &= V, \
    q_0 &= S, \
    F &= {A in V : A -> ϵ in P}, \
    Delta(A, a) &= {B in V : A -> a B in P}, \
    Delta(A, ϵ) &= {B in V : A -> B in P}. $
  Claramente $M$ es un AFN$ϵ$, y $alpha in L(G)$ sii $alpha in L(M)$; por lo tanto, $L(G) = L(M)$.

  (2) Sea $M = (Sigma, Q, q_0, F, Delta)$ un AFN$ϵ$. Tomamos $G = (V, Sigma, S, P)$ donde
  $ V &= Q, \
    S &= q_0, \
    P &= {q -> a q' : q' in Delta(q, a)} union {q -> q' : q' in Delta(q, ϵ)} union {q -> ϵ : q in F}. $
  Claramente $G$ es una GRPU, y $alpha in L(M)$ sii $alpha in L(G)$; por lo tanto, $L(G) = L(M)$.
]

#example[
  Sea $G$ la GRPU
  $ G : S &-> a S | B | ϵ \
        B &-> b B | C | ϵ \
        C &-> c C | ϵ, $
  con $L(G) = a^* b^* c^*$. Su AFN$ϵ$ equivalente $M$ es
  #image("../img/regular-grammars/enfa-grpu-abc.png", width: 170pt)
  y claramente $L(M) = a^* b^* c^*$.
] <ex-grpu-to-enfa>

#example[
  Sea $M$ el siguiente AF, con $L(M) = (a + b)^* b$:
  #image("../img/regular-grammars/dfa-ends-in-b.png", width: 155pt)
  Su GRPU equivalente $G$, con variable inicial $q_0$, es
  $ G : q_0 &-> a q_0 | b q_1 \
        q_1 &-> b q_1 | a q_0 | ϵ, $
  y claramente $L(G) = (a + b)^* b$.
] <ex-fa-to-grpu>

#corollary(title: $"LR"^Sigma equiv "GR"^Sigma$)[
  Un lenguaje es regular si y solo si es generado por una gramática regular.
] <cor-lr-gr>

#proof[
  Por el @thm-grpu-af y la equivalencia entre los distintos tipos de autómatas finitos (@thm-dfa-nfa y @thm-nfa-enfa), $"GRPU"^Sigma equiv "AF"^Sigma$; junto con el @thm-grpu-gr, por transitividad, $"AF"^Sigma equiv "GR"^Sigma$. Como además $"LR"^Sigma equiv "AF"^Sigma$ por el teorema de Kleene (@thm-kleene), concluimos que $"LR"^Sigma equiv "GR"^Sigma$.
]

== Resumen

Presentamos el modelo gramatical propuesto por Chomsky para caracterizar cada una de las clases de lenguajes de su jerarquía, y definimos el modelo de gramática regular a partir de una fuerte restricción en la forma de las producciones de una gramática sin restricciones. Probamos que un lenguaje es regular si y solo si es generado por una gramática regular (@cor-lr-gr), probando que las gramáticas regulares y los autómatas finitos son modelos equivalentes. Por lo tanto, las gramáticas regulares son también, al igual que los AF, un modelo computacional que caracteriza a los lenguajes regulares. Tenemos así una cuarta herramienta para probar la regularidad de un lenguaje: simplemente dar una GR que lo genere.
