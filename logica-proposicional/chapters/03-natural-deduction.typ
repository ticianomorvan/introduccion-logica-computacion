#import "../../lib/notes.typ": *


= Deducción natural <ch-natural-deduction>

Dijimos al comenzar (@ch-syntax) que la lógica es el estudio de los razonamientos correctos. Sin embargo, hasta ahora no introdujimos ningún mecanismo para deducir conclusiones válidas a partir de premisas válidas. En este capítulo presentamos la *deducción natural*, un sistema de reglas de inferencia que permite construir esas deducciones.

== Conectivos primitivos

Hasta aquí definimos la sintaxis de la lógica proposicional, el conjunto $"Prop"$ (@def-prop), junto con la definición de funciones por recursión y la prueba de propiedades sobre $"Prop"$ por inducción en subfórmulas. Para la deducción natural restringimos, por ahora, el conjunto de conectivos.

#notation(title: [Conectivos de $"Prop"$])[
  Por ahora nos restringimos a los conectivos $and$, $->$ y $bot$. La negación y la doble implicación son abreviaturas:
  $ not phi &eq.dot phi -> bot, \
    phi <-> psi &eq.dot (phi -> psi) and (psi -> phi). $
  Además, la conjunción tiene mayor precedencia que la implicación:
  $ phi and psi -> chi eq.dot (phi and psi) -> chi. $
] <not-restricted-connectives>

== Inferencia

Un razonamiento correcto es aquel que, partiendo de ciertas _hipótesis_, produce nuevos conocimientos. Para asegurarnos de que las conclusiones son válidas debemos restringir las _formas_ en que producimos las conclusiones a partir de las premisas. Con ese fin damos a continuación una serie de _reglas de inferencia_ que nos aseguran que los razonamientos hechos usando esas reglas (y solo esas) son correctos.

#notation(title: [Reglas de inferencia])[
  Representamos gráficamente una regla de inferencia de la siguiente manera:
  $ #prooftree(rule(name: [nombre], $phi_1$, $phi_2$, $dots$, $phi_n$, $psi$)) $
  Tanto las $phi_i$ (las _premisas_) como $psi$ (la _conclusión_) son metavariables, que pueden ser reemplazadas por cualquier proposición.
] <not-inference-rule>

Para cada conectivo tendremos reglas de _introducción_, que dicen cómo concluir una proposición con ese conectivo, y reglas de _eliminación_, que dicen cómo usarla.

== Reglas para la conjunción

Si conocemos $phi$ y $psi$, ya sea porque las asumimos como hipótesis o porque ya tenemos una prueba de ellas, entonces podemos concluir $phi and psi$.

#definition(title: [Introducción de la conjunción])[
  $ #prooftree(rule(name: $and I$, $phi$, $psi$, $phi and psi$)) $
] <def-rule-and-intro>

#exercise[
  + ¿Es $p_1 and p_2$ verdadero, es decir, una tautología?
  + ¿Vale ${p_1, p_2} ⊨ p_1 and p_2$?
] <exr-conjunction-semantics>

Recíprocamente, de saber $phi and psi$ podemos deducir tanto $phi$ como $psi$. Tenemos entonces dos reglas para utilizar el conocimiento de una conjunción, a las que llamamos con el mismo nombre.

#definition(title: [Eliminación de la conjunción])[
  $ #prooftree(rule(name: $and E$, $phi and psi$, $phi$)) wide #prooftree(rule(name: $and E$, $phi and psi$, $psi$)) $
] <def-rule-and-elim>

¿Podemos derivar la validez de $chi$ a partir de la validez de $phi and (psi and chi)$? Si decimos que sí, debemos poder construir una prueba, una *derivación*, en la que podemos usar varias veces las reglas de inferencia. En ese caso decimos que existe una _derivación de $chi$ a partir de $phi and (psi and chi)$_, y lo escribimos
$ {phi and (psi and chi)} tack.r chi. $
La definición precisa de esta notación está en la @def-deducibility.

#example[
  La siguiente derivación muestra que ${phi and (psi and chi)} tack.r chi$:
  $ #prooftree(rule(name: $and E$, rule(name: $and E$, $phi and (psi and chi)$, $psi and chi$), $chi$)) $
] <ex-derivation-and-elim>

#example[
  Una derivación puede tener varias premisas. La siguiente derivación construye $phi and (psi -> psi)$ a partir de $phi$ y $(psi -> psi) and chi$, es decir, muestra que ${phi, (psi -> psi) and chi} tack.r phi and (psi -> psi)$:
  $ #prooftree(rule(name: $and I$, $phi$, rule(name: $and E$, $(psi -> psi) and chi$, $psi -> psi$), $phi and (psi -> psi)$)) $
] <ex-derivation-two-premises>

Tanto en esta derivación como en la del @ex-derivation-and-elim, utilizamos la conclusión de una prueba como premisa para el uso de otra regla.

== Hipótesis y conclusión

#definition(title: [Hipótesis y conclusión])[
  En una derivación, llamamos *hipótesis* a todas las proposiciones que no fueron obtenidas como conclusión de una prueba, y *conclusión* a la proposición que está en la raíz del árbol.
] <def-hypothesis-conclusion>

En el @ex-derivation-two-premises, las hipótesis son $phi$ y $(psi -> psi) and chi$, y la conclusión es $phi and (psi -> psi)$.

#notation(title: [Derivaciones esquemáticas])[
  A veces queremos referirnos a una derivación de $psi$ a partir de la hipótesis $phi$, entre otras. La escribimos
  $ #deriv($psi$, name: $D$, hyp: $phi$) $
  donde $D$ es el nombre de la derivación. Que $phi$ esté entre las hipótesis de $D$ significa que esa proposición se ha utilizado 0, 1 o muchas veces.
] <not-schematic-derivation>

== Implicación

Si $D$ es una derivación de $psi$ a partir de $phi$, entonces $D$ debería contar como una derivación de $phi -> psi$. Pero cuando utilizamos la implicación (pensemos en el uso de "si …, entonces …") queremos decir "si tuviéramos una prueba de $phi$": no queremos obligarnos a tener una prueba de $phi$, al menos hasta que queramos usar la implicación. Vemos entonces que, al introducir la implicación, quitamos la carga de la prueba sobre el antecedente.

#definition(title: [Introducción de la implicación])[
  $ #prooftree(rule(name: $-> I$, deriv($psi$, hyp: $[phi]$), $phi -> psi$)) $
  A diferencia de las reglas anteriores, aquí encorchetamos, si queremos, las hojas donde esté $phi$. Esa es la manera en que indicamos que *descargamos* (o *cancelamos*) la hipótesis $phi$.
] <def-rule-imp-intro>

Como podemos utilizar varias veces la regla $-> I$ en una misma derivación, marcamos con un índice las hipótesis que cancelamos con cada uso de la regla, y ponemos el mismo índice en el nombre de la regla.

#example[
  $ #prooftree(rule(name: $-> I_1$, rule(name: $and I$, rule(name: $and E$, $[phi and psi]^1$, $psi$), rule(name: $and E$, $[phi and psi]^1$, $phi$), $psi and phi$), $(phi and psi) -> (psi and phi)$)) $
] <ex-and-commutative>

La regla de eliminación de la implicación responde a la pregunta de cómo podemos usar una implicación: es la conocida regla _modus ponens_.

#definition(title: [Eliminación de la implicación])[
  $ #prooftree(rule(name: $-> E$, $phi$, $phi -> psi$, $psi$)) $
] <def-rule-imp-elim>

#example[
  Recordemos que $not phi$ abrevia $phi -> bot$ (@not-restricted-connectives). Entonces:
  $ #prooftree(rule(name: $-> I_3$, rule(name: $-> E$, rule(name: $-> E$, $[phi]^3$, $phi -> psi$, $psi$), $not psi$, $bot$), $not phi$)) $
  En esta derivación, las hipótesis no canceladas son $phi -> psi$ y $not psi$. Pero podemos continuar la derivación y cancelar todas las hipótesis:
  $ #prooftree(rule(name: $-> I_1$, rule(name: $-> I_2$, rule(name: $-> I_3$, rule(name: $-> E$, rule(name: $-> E$, $[phi]^3$, $[phi -> psi]^1$, $psi$), $[not psi]^2$, $bot$), $not phi$), $not psi -> not phi$), $(phi -> psi) -> (not psi -> not phi)$)) $
] <ex-contrapositive>

== El absurdo

Para $bot$ no tenemos regla de introducción. Sin embargo, siempre que tengamos una prueba de $bot$ podemos concluir lo que se nos antoje: _ex falso quodlibet_.

#exercise[
  ¿Por qué no hay una regla de introducción para $bot$?
] <exr-no-bot-intro>

#definition(title: [Eliminación del absurdo])[
  $ #prooftree(rule(name: $bot E$, $bot$, $phi$)) $
] <def-rule-bot-elim>

#example[
  Recordando que $not phi$ es $phi -> bot$, podemos construir una derivación de $psi$ a partir de $phi$ y $not phi$:
  $ #prooftree(rule(name: $bot E$, rule(name: $-> E$, $phi$, $not phi$, $bot$), $psi$)) $
] <ex-ex-falso>
