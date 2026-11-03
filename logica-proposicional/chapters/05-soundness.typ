#import "../../lib/notes.typ": *

= Corrección <ch-soundness>

En los capítulos anteriores construimos pruebas usando reglas de inferencia: el conjunto $cal(D)$ de derivaciones se define inductivamente (@def-derivation-set), y $phi$ se deduce de $Gamma$, $Gamma tack.r phi$, si existe una derivación $D$ tal que $"hip"(D) subset.eq Gamma$ y $"concl"(D) = phi$. Pero, ¿realmente las reglas nos permiten concluir proposiciones verdaderas a partir de hipótesis verdaderas? En este capítulo respondemos esta pregunta afirmativamente: probamos que toda derivación es correcta respecto de la semántica.

Seguimos restringidos a los conectivos $and$, $->$ y $bot$, con la negación y la doble implicación como abreviaturas y la conjunción con mayor precedencia que la implicación (@not-restricted-connectives).

== Derivabilidad y contraejemplos

#exercise[
  + De los siguientes pares de afirmaciones, ¿cuáles son correctas?
    $ {p_0, p_1} tack.r p_2 wide {p_0, p_1} tack.r.not p_2 $
    $ tack.r bot wide tack.r.not bot $
  + Y de los siguientes pares, ¿cuáles son correctas?
    $ {p_0, p_1} ⊨ p_2 wide {p_0, p_1} ⊭ p_2 $
    $ ⊨ bot wide ⊭ bot $
] <exr-derivability-pairs>

¿Cómo podemos probar o refutar las afirmaciones anteriores? Las del segundo par, que hablan de modelos, las podemos comprobar rápidamente construyendo las tablas de verdad. En cambio, para verificar cualquiera de las del primer par debemos o bien construir una derivación, o bien mostrar que no existe ninguna derivación con la conclusión esperada y las hipótesis permitidas. Por ejemplo, ¿no podríamos concluir $bot$ utilizando una regla de eliminación o RAA?

== Corrección

Como la validez de las fórmulas está dada por su semántica, podemos utilizar la noción de consecuencia lógica $⊨$ (@def-logical-consequence) para expresar la corrección.

#definition[
  Una derivación $D in cal(D)$ con $"hip"(D) subset.eq Gamma$ y $"concl"(D) = phi$ es _correcta_ si todo modelo de $Gamma$ satisface $phi$.
] <def-correct-derivation>

Nuestro trabajo será mostrar que toda derivación es correcta, es decir:
$ "si" Gamma tack.r phi, "entonces" Gamma ⊨ phi. $

Suponiendo la corrección, podemos usar $ {p_0, p_1} ⊭ p_2 quad "y" quad ⊭ bot $ para concluir $ {p_0, p_1} tack.r.not p_2 quad "y" quad tack.r.not bot. $

#example[
  Si suponemos que existe una derivación para ${p_0, p_1} tack.r p_2$, entonces para todo modelo $f$ de ${p_0, p_1}$ tendríamos $#sem($p_2$, $f$) = 1$. Sin embargo, la siguiente asignación es un contraejemplo:
  $ f thin p_0 &= f thin p_1 = 1, \
    f thin p_j &= 0 quad "para" j > 1. $
  Como $f$ es modelo de ${p_0, p_1}$, $f$ debería satisfacer $p_2$; pero $#sem($p_2$, $f$) = f thin p_2 = 0$. Por lo tanto, ${p_0, p_1} tack.r.not p_2$.
] <ex-soundness-counterexample>

== El teorema de corrección

Para probar el teorema de corrección usaremos inducción en sub-derivaciones. Para ello establecemos el siguiente predicado $A$ sobre derivaciones.

#definition[
  Sea $D$ una derivación con conclusión $phi$. Entonces $A(D)$ vale si y solo si
  $ "para todo" Gamma "tal que" "hip"(D) subset.eq Gamma, "se da" Gamma ⊨ phi. $
] <def-soundness-predicate>

#example[
  Si $D$ es la derivación
  $ #prooftree(rule(name: $and E$, $phi and psi$, $phi$)) $
  entonces $A(D)$ vale.
] <ex-soundness-predicate-and-elim>

#theorem(title: [Corrección])[
  Si $Gamma tack.r phi$, entonces $Gamma ⊨ phi$.
] <thm-soundness>

Este enunciado lo podemos escribir con nuestro predicado $A$.

#theorem[
  Para toda derivación $D$ y para todo $Gamma$ tal que $"hip"(D) subset.eq Gamma$, vale $Gamma ⊨ "concl"(D)$.
] <thm-soundness-derivations>

#proof[
  Por inducción en $D$.
]

#lemma(title: [No derivabilidad])[
  Si $f$ es modelo de $Gamma$ y $#sem($phi$, $f$) = 0$, entonces $Gamma tack.r.not phi$.
] <lem-non-derivability>

#proof[
  Si fuera $Gamma tack.r phi$, por @thm-soundness tendríamos $Gamma ⊨ phi$ y, como $f$ es modelo de $Gamma$, $#sem($phi$, $f$) = 1$.
]

#corollary[
  $tack.r.not bot$.
] <cor-bot-not-derivable>

#proof[
  Para cualquier asignación $f$ vale $#sem($bot$, $f$) = 0$, y $f$ es modelo de $emptyset$; luego, por @lem-non-derivability, $tack.r.not bot$.
]

El meta-teorema de corrección nos asegura que todo teorema es una tautología. Pero, ¿sucederá lo recíproco? ¿Podremos derivar todas las tautologías? En términos más generales: si $Gamma ⊨ phi$, ¿vale $Gamma tack.r phi$? Es decir, ¿se podrán hacer _todas_ las derivaciones de premisas válidas a conclusiones válidas? Respondemos esta pregunta en el @ch-completeness.
