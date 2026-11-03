#import "../../lib/notes.typ": *


// One case of a function defined by recursion on D: left side, right side, clause name, in fixed columns.
#let case(lhs, rhs, clause) = grid(
  columns: (1fr, 12em, 3.5em), column-gutter: 0.5em, inset: (y: 0.25em), align: (right + horizon, left + horizon, right + horizon),
  math.equation(block: false, math.display(lhs.body)), math.equation(block: false, math.display(rhs.body)), clause,
)

= Derivaciones <ch-derivations>

En el @ch-natural-deduction introdujimos reglas de inferencia que nos aseguran que, si partimos de premisas válidas, las conclusiones serán válidas. A las hojas de una derivación que no están entre corchetes las llamamos hipótesis, y a la raíz, conclusión (@def-hypothesis-conclusion). En este capítulo completamos el sistema con la reducción al absurdo y las reglas de la disyunción, y definimos formalmente el conjunto de todas las derivaciones.

== Reducción al absurdo

El uso habitual de la reducción al absurdo es el siguiente: "para probar $phi$, asumí $not phi$ y llegá a una conclusión $bot$". La regla correspondiente tiene como conclusión $phi$, y en ella podemos cancelar todas las veces que queramos la hipótesis $not phi$.

#definition(title: [Reducción al absurdo])[
  $ #prooftree(rule(name: "RAA", deriv($bot$, hyp: $[not phi]$), $phi$)) $
] <def-rule-raa>

== Reglas para la disyunción

La disyunción es el dual de la conjunción: mientras que para introducir una conjunción necesitamos pruebas de ambos términos (@def-rule-and-intro), para la disyunción nos alcanza con una de ellas. Por eso tenemos dos reglas de introducción.

#definition(title: [Introducción de la disyunción])[
  $ #prooftree(rule(name: $or I$, $phi$, $phi or psi$)) wide #prooftree(rule(name: $or I$, $psi$, $phi or psi$)) $
] <def-rule-or-intro>

Teniendo en cuenta la dualidad entre $and$ y $or$, es esperable tener una única regla de eliminación de la disyunción. Pero ¿cómo podemos usar una disyunción $phi or psi$? Si suponiendo $phi$ podemos concluir $chi$, y suponiendo $psi$ también podemos concluir $chi$, entonces podemos concluir $chi$ a partir de cualquiera de las dos.

#definition(title: [Eliminación de la disyunción])[
  $ #prooftree(rule(name: $or E$, $phi or psi$, deriv($chi$, hyp: $[phi]$), deriv($chi$, hyp: $[psi]$), $chi$)) $
] <def-rule-or-elim>

#remark[
  La regla $or E$ muestra cómo probar $chi$ por casos: por un lado suponemos $phi$ para probar $chi$, y por lo tanto en el segundo subárbol podemos descargar $phi$; por otro lado suponemos $psi$ para probar $chi$, y consecuentemente descargamos $psi$ del tercer subárbol. Pero esta regla *no* nos permite descargar ni $phi$ ni $psi$ en el primer subárbol.
] <rem-or-elim-discharge>

== Deducibilidad

#definition(title: [Deducibilidad])[
  Decimos que $psi$ *se deriva* de $phi_1, dots, phi_n$ si existe una derivación con conclusión $psi$ cuyas hipótesis no canceladas están entre $phi_1, dots, phi_n$.

  Para $Gamma subset.eq "Prop"$ y $psi in "Prop"$, decimos que $psi$ *se deduce* de $Gamma$, y escribimos
  $ Gamma tack.r psi, $
  si existe una derivación $D$ con conclusión $psi$ cuyas hipótesis no canceladas están contenidas en $Gamma$.

  Si $psi$ se deduce del conjunto vacío, $emptyset tack.r psi$, decimos que $psi$ es un *teorema*. En ese caso nos ahorramos escribir el conjunto vacío: $tack.r psi$.
] <def-deducibility>

#exercise[
  + Si tenemos ${phi} tack.r psi$, ¿podemos construir una derivación que muestre $tack.r phi -> psi$?
  + Si tenemos ${phi and psi} tack.r chi$, ¿podemos construir una derivación que muestre $tack.r phi -> (psi -> chi)$?
] <exr-derivation-manipulation>

#remark[
  Este tipo de manipulaciones de derivaciones las podemos expresar como _meta-teoremas_; por ejemplo: si ${phi and psi} tack.r chi$, entonces $tack.r phi -> (psi -> chi)$.
] <rem-meta-theorems>

== El conjunto de derivaciones

Definimos el conjunto de derivaciones, $cal(D)$, como el menor conjunto que satisface ciertas condiciones, una por cada regla de inferencia. Como con $"Prop"$, podríamos también construirlo por etapas, pero es más trabajoso.

#definition(title: [Conjunto de derivaciones])[
  El conjunto de derivaciones $cal(D)$ es el menor conjunto que satisface las siguientes cláusulas.

  $("Prop")$ Si $phi in "Prop"$, entonces $phi in cal(D)$.

  $(and I)$ Si $#deriv($phi$, name: $D_1$) in cal(D)$ y $#deriv($psi$, name: $D_2$) in cal(D)$, entonces
    $ mat(delim: #none, #prooftree(rule(name: $and I$, deriv($phi$, name: $D_1$), deriv($psi$, name: $D_2$), $phi and psi$))) in cal(D). $

  $(and E)$ Si $#deriv($phi and psi$, name: $D$) in cal(D)$, entonces
    $ mat(delim: #none, #prooftree(rule(name: $and E$, deriv($phi and psi$, name: $D$), $phi$))) in cal(D)
      quad "y" quad
      mat(delim: #none, #prooftree(rule(name: $and E$, deriv($phi and psi$, name: $D$), $psi$))) in cal(D). $

  $(-> I)$ Si $#deriv($psi$, name: $D$, hyp: $phi$) in cal(D)$, entonces
    $ mat(delim: #none, #prooftree(rule(name: $-> I$, deriv($psi$, name: $D$, hyp: $[phi]$), $phi -> psi$))) in cal(D). $

  $(-> E)$ Si $#deriv($phi$, name: $D_1$) in cal(D)$ y $#deriv($phi -> psi$, name: $D_2$) in cal(D)$, entonces
    $ mat(delim: #none, #prooftree(rule(name: $-> E$, deriv($phi$, name: $D_1$), deriv($phi -> psi$, name: $D_2$), $psi$))) in cal(D). $

  $(bot E)$ Si $#deriv($bot$, name: $D$) in cal(D)$, entonces
    $ mat(delim: #none, #prooftree(rule(name: $bot E$, deriv($bot$, name: $D$), $phi$))) in cal(D). $

  $("RAA")$ Si $#deriv($bot$, name: $D$, hyp: $not phi$) in cal(D)$, entonces
    $ mat(delim: #none, #prooftree(rule(name: "RAA", deriv($bot$, name: $D$, hyp: $[not phi]$), $phi$))) in cal(D). $

  $(or I)$ Si $#deriv($phi$, name: $D$) in cal(D)$ y $psi in "Prop"$, entonces
    $ mat(delim: #none, #prooftree(rule(name: $or I$, deriv($phi$, name: $D$), $phi or psi$))) in cal(D)
      quad "y" quad
      mat(delim: #none, #prooftree(rule(name: $or I$, deriv($phi$, name: $D$), $psi or phi$))) in cal(D). $

  $(or E)$ Si $#deriv($phi or psi$, name: $D$) in cal(D)$, $#deriv($chi$, name: $D_1$, hyp: $phi$) in cal(D)$ y $#deriv($chi$, name: $D_2$, hyp: $psi$) in cal(D)$, entonces
    $ mat(delim: #none, #prooftree(rule(name: $or E$, deriv($phi or psi$, name: $D$), deriv($chi$, name: $D_1$, hyp: $[phi]$), deriv($chi$, name: $D_2$, hyp: $[psi]$), $chi$))) in cal(D). $
] <def-derivation-set>

Cada cláusula corresponde a una de las reglas de inferencia: las de la conjunción (@def-rule-and-intro y @def-rule-and-elim), la implicación (@def-rule-imp-intro y @def-rule-imp-elim), el absurdo (@def-rule-bot-elim), la reducción al absurdo (@def-rule-raa) y la disyunción (@def-rule-or-intro y @def-rule-or-elim).

== El conjunto $cal(D)$ y sus consecuencias

Si quisiéramos justificar que un árbol está en $cal(D)$, deberíamos mostrar cómo lo vamos construyendo a partir de la cláusula ($"Prop"$), utilizando las cláusulas de la @def-derivation-set. Eso es demasiado engorroso y no lo haremos explícitamente, pero tengamos en cuenta que podríamos hacerlo.

¿Para qué introducir $cal(D)$, entonces? ¿Qué herramientas tenemos ahora a nuestra disposición? Las mismas que con $"Prop"$: por un lado, un principio de definición de funciones por recursión; por otro, la posibilidad de usar inducción en subderivaciones para probar que cierta propiedad vale para toda derivación. El principio de inducción en subderivaciones nos servirá para probar la _corrección_ del sistema, es decir, para fundamentar nuestro eslogan de que las reglas de inferencia preservan la validez, que denotábamos con $⊨$.

== Funciones recursivas sobre derivaciones

Como primer ejemplo, definimos una función (no tan) recursiva que, dada una derivación, devuelve su conclusión.

#definition(title: [Conclusión de una derivación])[
  La función $"concl" : cal(D) -> "Prop"$ se define por
  #case($"concl"(phi)$, $= phi$, $("Prop")$)
  #case($"concl" lr((mat(delim: #none, #prooftree(rule(name: $and I$, deriv($phi$, name: $D_1$), deriv($psi$, name: $D_2$), $phi and psi$)))))$, $= phi and psi$, $(and I)$)
  #case($"concl" lr((mat(delim: #none, #prooftree(rule(name: $and E$, deriv($phi and psi$, name: $D$), $phi$)))))$, $= phi$, $(and E)$)
  #case($"concl" lr((mat(delim: #none, #prooftree(rule(name: $and E$, deriv($phi and psi$, name: $D$), $psi$)))))$, $= psi$, $(and E)$)
  #case($"concl" lr((mat(delim: #none, #prooftree(rule(name: $-> I$, deriv($psi$, name: $D$, hyp: $[phi]$), $phi -> psi$)))))$, $= phi -> psi$, $(-> I)$)
  #case($"concl" lr((mat(delim: #none, #prooftree(rule(name: $-> E$, deriv($phi$, name: $D_1$), deriv($phi -> psi$, name: $D_2$), $psi$)))))$, $= psi$, $(-> E)$)
  #case($"concl" lr((mat(delim: #none, #prooftree(rule(name: $bot E$, deriv($bot$, name: $D$), $phi$)))))$, $= phi$, $(bot E)$)
  #case($"concl" lr((mat(delim: #none, #prooftree(rule(name: "RAA", deriv($bot$, name: $D$, hyp: $[not phi]$), $phi$)))))$, $= phi$, $("RAA")$)
  #case($"concl" lr((mat(delim: #none, #prooftree(rule(name: $or I$, deriv($phi$, name: $D$), $phi or psi$)))))$, $= phi or psi$, $(or I)$)
  #case($"concl" lr((mat(delim: #none, #prooftree(rule(name: $or I$, deriv($phi$, name: $D$), $psi or phi$)))))$, $= psi or phi$, $(or I)$)
  #case($"concl" lr((mat(delim: #none, #prooftree(rule(name: $or E$, deriv($phi or psi$, name: $D$), deriv($chi$, name: $D_1$, hyp: $[phi]$), deriv($chi$, name: $D_2$, hyp: $[psi]$), $chi$)))))$, $= chi$, $(or E)$)
] <def-concl>

La función $"concl"$ no hace llamadas recursivas: le basta mirar la raíz del árbol. Un ejemplo genuinamente recursivo es la función que, dada una derivación, devuelve sus hipótesis no canceladas.

#definition(title: [Hipótesis no canceladas])[
  La función $"hip" : cal(D) -> cal(P)("Prop")$ se define por
  #case($"hip"(phi)$, $= {phi}$, $("Prop")$)
  #case($"hip" lr((mat(delim: #none, #prooftree(rule(name: $and I$, deriv($phi$, name: $D_1$), deriv($psi$, name: $D_2$), $phi and psi$)))))$, $= "hip"(D_1) union "hip"(D_2)$, $(and I)$)
  #case($"hip" lr((mat(delim: #none, #prooftree(rule(name: $and E$, deriv($phi and psi$, name: $D$), $phi$)))))$, $= "hip"(D)$, $(and E)$)
  #case($"hip" lr((mat(delim: #none, #prooftree(rule(name: $and E$, deriv($phi and psi$, name: $D$), $psi$)))))$, $= "hip"(D)$, $(and E)$)
  #case($"hip" lr((mat(delim: #none, #prooftree(rule(name: $-> I$, deriv($psi$, name: $D$, hyp: $[phi]$), $phi -> psi$)))))$, $= "hip"(D) without {phi}$, $(-> I)$)
  #case($"hip" lr((mat(delim: #none, #prooftree(rule(name: $-> E$, deriv($phi$, name: $D_1$), deriv($phi -> psi$, name: $D_2$), $psi$)))))$, $= "hip"(D_1) union "hip"(D_2)$, $(-> E)$)
  #case($"hip" lr((mat(delim: #none, #prooftree(rule(name: $bot E$, deriv($bot$, name: $D$), $phi$)))))$, $= "hip"(D)$, $(bot E)$)
  #case($"hip" lr((mat(delim: #none, #prooftree(rule(name: "RAA", deriv($bot$, name: $D$, hyp: $[not phi]$), $phi$)))))$, $= "hip"(D) without {not phi}$, $("RAA")$)
  #case($"hip" lr((mat(delim: #none, #prooftree(rule(name: $or I$, deriv($phi$, name: $D$), $phi or psi$)))))$, $= "hip"(D)$, $(or I)$)
  #case($"hip" lr((mat(delim: #none, #prooftree(rule(name: $or I$, deriv($phi$, name: $D$), $psi or phi$)))))$, $= "hip"(D)$, $(or I)$)
  #case($"hip" lr((mat(delim: #none, #prooftree(rule(name: $or E$, deriv($phi or psi$, name: $D$), deriv($chi$, name: $D_1$, hyp: $[phi]$), deriv($chi$, name: $D_2$, hyp: $[psi]$), $chi$)))))$, $= "hip"(D) union ("hip"(D_1) without {phi}) \ quad union ("hip"(D_2) without {psi})$, $(or E)$)
] <def-hip>
