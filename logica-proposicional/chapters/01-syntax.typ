#import "../../lib/notes.typ": *


= Sintaxis <ch-syntax>

La lógica se entiende, en términos generales, como el _análisis de los razonamientos correctos_. A fines del siglo XIX y principios del XX se despierta un interés por dar bases sólidas a la matemática. Para ello se introducen sistemas lógicos en los que las fórmulas y los razonamientos válidos están establecidos sin ninguna referencia a lenguajes naturales. De esta manera se puede comprobar la validez de razonamientos por medios matemáticos.

== Razonamientos correctos e incorrectos

#example(title: "Razonamiento correcto")[
  - Premisa 1: si $P$ es un poset finito, entonces $P$ tiene al menos un maximal.
  - Premisa 2: $(D_32, |)$ es un poset finito.
  - Conclusión: $D_32$ tiene al menos un maximal.
] <ex-correct-reasoning-poset>

#example(title: "Otro razonamiento correcto")[
  - Premisa 1: si un reticulado tiene un sub-reticulado isomorfo a $N_5$, entonces no es distributivo.
  - Premisa 2: el reticulado
    #image("../img/syntax/lattice-with-n5-sublattice.png", width: 60pt)
    tiene un sub-reticulado isomorfo a $N_5$.
  - Conclusión: ese reticulado no es distributivo.
] <ex-correct-reasoning-lattice>

Ambos ejemplos siguen el mismo patrón:
- Premisa 1: si $P$, entonces $Q$.
- Premisa 2: $P$.
- Conclusión: $Q$.

#example(title: "Razonamiento incorrecto")[
  - Premisa 1: si $L$ tiene un sub-reticulado isomorfo a $N_5$, entonces $L$ no es distributivo.
  - Premisa 2: $M_3$ no es distributivo.
  - Conclusión: $M_3$ tiene un sub-reticulado isomorfo a $N_5$.

  Aquí la premisa 2 afirma la conclusión de la premisa 1, y no su hipótesis, de modo que el razonamiento no sigue el patrón anterior: la conclusión no se deduce de las premisas.
] <ex-incorrect-reasoning>

== Sintaxis y semántica

Para estudiar matemáticamente los razonamientos válidos debemos saber representarlos de manera matemática; esto es, definir un conjunto de proposiciones: la *sintaxis*. Cada proposición la podremos interpretar como cierta o falsa; a esta interpretación la llamamos la *semántica*.

Lo primero que descubrimos es que los razonamientos demuestran la validez de una afirmación a partir de la validez de otras siguiendo ciertas reglas. Esta noción se formaliza como *pruebas*. Estudiaremos la relación que hay entre las proposiciones ciertas y aquellas para las que podemos construir pruebas.

== Proposiciones

=== El alfabeto

#definition(title: "Alfabeto")[
  Asumimos un conjunto numerable $cal(V)$ de *variables proposicionales*, que representan las afirmaciones más básicas. A los elementos de $cal(V)$ los escribiremos simplemente como $p_0, p_1, dots$; definimos
  $ "At" = cal(V) union {bot}, $
  donde el símbolo $bot$ representa la afirmación “es falso”. Al conjunto $"At"$ lo llamamos el conjunto de *átomos*. Las proposiciones serán ciertas palabras construidas sobre el *alfabeto*
  $ Sigma = "At" union {not, or, and, ->} union {"(", ")"}. $
] <def-prop-alphabet>

=== Palabras

Al conjunto de palabras que se construyen con el alfabeto $Sigma$ lo denotamos con $Sigma^*$.

#example[
  Son palabras sobre $Sigma$:
  $ p_0 #h(3em) class("normal", and) p_0 \(p_1 #h(3em) (p_23 and p_9) #h(3em) (not bot) $
  En cambio, las siguientes cadenas _no_ son palabras sobre $Sigma$:
  $ 4 + 0 #h(3em) x <= y and z #h(3em) A or B $
] <ex-words-over-alphabet>

Pero no todas las palabras serán proposiciones.

#example[
  Algunos elementos de $Sigma^*$ representan proposiciones:
  $ p_2 #h(3em) p_35 #h(3em) (not p_35) #h(3em) ((not p_35) and p_2) $
  pero otros no:
  $ class("normal", and) p_0 \(p_1 #h(3em) p_23 and not p_9 or p_2 $
  En la última podemos descubrir la necesidad de utilizar paréntesis.
] <ex-words-propositions>

¿Cómo definir un subconjunto $"Prop" subset.eq Sigma^*$ que sólo contenga proposiciones? Daremos una definición _inductiva_.

#definition(title: "Proposiciones")[
  El conjunto $"Prop"$ de *proposiciones* es el menor subconjunto de $Sigma^*$ que satisface las siguientes cláusulas:
  / $phi in "At"$: si $phi in "At"$, entonces $phi in "Prop"$;
  / $(not phi)$: si $phi in "Prop"$, entonces $(not phi) in "Prop"$;
  / $(phi or psi)$: si $phi in "Prop"$ y $psi in "Prop"$, entonces $(phi or psi) in "Prop"$;
  / $(phi and psi)$: si $phi in "Prop"$ y $psi in "Prop"$, entonces $(phi and psi) in "Prop"$;
  / $(phi -> psi)$: si $phi in "Prop"$ y $psi in "Prop"$, entonces $(phi -> psi) in "Prop"$.
] <def-prop>

#remark[
  Podemos unificar las tres últimas cláusulas usando una meta-variable $square$ que puede ser $or$, $and$ o $->$:
  / $(phi boxop psi)$: si $phi in "Prop"$ y $psi in "Prop"$, entonces $(phi boxop psi) in "Prop"$.
] <rem-binary-connective-metavariable>

¿Cómo sabemos que esas cláusulas definen un conjunto? Podemos definir conjuntos cada vez más grandes:
$ "Prop"_0 &= "At", \
  "Prop"_1 &= "Prop"_0 union {(not phi) | phi in "Prop"_0} union {(phi boxop psi) | phi, psi in "Prop"_0}, \
  &thin dots.v \
  "Prop"_(k+1) &= "Prop"_k union {(not phi) | phi in "Prop"_k} union {(phi boxop psi) | phi, psi in "Prop"_k}. $
El conjunto de proposiciones es la unión de todos esos conjuntos:
$ "Prop" = union.big_(n in NN) "Prop"_n. $

=== Proposiciones como TAD

El tipo abstracto de datos apropiado para las proposiciones está parametrizado por $cal(V)$, y tiene los siguientes constructores:
$ bot &: "Prop" \
  "Symbol" &: cal(V) -> "Prop" \
  not &: "Prop" -> "Prop" \
  or &: "Prop" times "Prop" -> "Prop" \
  and &: "Prop" times "Prop" -> "Prop" \
  class("normal", ->) &: "Prop" times "Prop" -> "Prop" $

== Recursión

=== Recursión en los naturales

Si queremos definir una función $f : NN -> X$ de los naturales en algún conjunto $X$, alcanza con:
/ $n = 0$: elegir $a in X$ y definir $f(0) = a$;
/ $n = k + 1$: definir $f(k + 1)$ en términos de $f(k)$: $f(k + 1) = dots f(k) dots$

Es fácil ver que de esa manera tenemos bien definida la función $f$. Puesto que $"Prop"$ también es un conjunto definido inductivamente, podemos utilizar un esquema semejante.

=== Recursión en Prop

Supongamos ahora que queremos definir una función $f : "Prop" -> X$. Ahora tenemos muchos casos base, $bot, p_0, p_1, dots, p_2356, dots$; por lo tanto debemos definir
$ f(phi) = cases(x_i & "si" phi = p_i, y & "si" phi = bot) $
Y tenemos varios casos recursivos, uno para cada conectivo. En el caso de la negación,
$ f((not phi)) = dots f(phi) dots $
y para las fórmulas de la forma $(phi_1 boxop phi_2)$ podemos utilizar la llamada recursiva tanto en $phi_1$ como en $phi_2$:
$ f((phi_1 boxop phi_2)) = dots f(phi_1) dots f(phi_2) dots $

#definition(title: "Cantidad de conectivos")[
  La cantidad de conectivos de una proposición es la función $"con" : "Prop" -> NN$ definida por
  $ "con"(phi) &= 0 quad "si" phi in "At", \
    "con"((not phi)) &= "con"(phi) + 1, \
    "con"((phi_1 boxop phi_2)) &= "con"(phi_1) + "con"(phi_2) + 1. $
] <def-connective-count>

#definition(title: "Cantidad de paréntesis")[
  La cantidad de símbolos “$($” y “$)$” de una proposición es la función $"paren" : "Prop" -> NN$ definida por
  $ "paren"(phi) &= 0 quad "si" phi in "At", \
    "paren"((not phi)) &= "paren"(phi) + 2, \
    "paren"((phi_1 boxop phi_2)) &= "paren"(phi_1) + "paren"(phi_2) + 2. $
] <def-paren-count>

#definition(title: "Sub-fórmulas")[
  El conjunto de sub-fórmulas de una proposición está dado por la función $"sub" : "Prop" -> cal(P)("Prop")$ definida por
  $ "sub"(phi) &= {phi} quad "si" phi in "At", \
    "sub"((not phi)) &= "sub"(phi) union {(not phi)}, \
    "sub"((phi_1 boxop phi_2)) &= "sub"(phi_1) union "sub"(phi_2) union {(phi_1 boxop phi_2)}. $
] <def-subformulas>

== Inducción

Así como podemos definir funciones recursivamente, también podemos probar propiedades sobre $"Prop"$ utilizando _inducción_.

#theorem(title: "Inducción en sub-fórmulas")[
  Para probar que todo $phi in "Prop"$ satisface un predicado $A$, alcanza con probar:
  / $phi in "At"$: $A(phi)$, para todo $phi in "At"$;
  / $(not phi)$: si $A(phi)$, entonces $A((not phi))$;
  / $(phi boxop psi)$: si $A(phi)$ y $A(psi)$, entonces $A((phi boxop psi))$.
] <thm-subformula-induction>

Notemos que este principio de inducción es análogo al principio de inducción para los naturales.

#theorem[
  Para toda $phi in "Prop"$, $"paren"(phi) = 2 * "con"(phi)$.
] <thm-paren-twice-con>

Antes de intentar probarlo, enunciemos las hipótesis inductivas que tendremos a nuestra disposición. Si $phi = (not phi')$, entonces la hipótesis inductiva vale para $phi'$, es decir,
$ "paren"(phi') = 2 * "con"(phi'). $
Si $phi = (phi_1 boxop phi_2)$, disponemos de la hipótesis inductiva tanto sobre $phi_1$ como sobre $phi_2$:
$ "paren"(phi_1) = 2 * "con"(phi_1) #h(3em) "paren"(phi_2) = 2 * "con"(phi_2) $

#proof[
  Por inducción en sub-fórmulas (@thm-subformula-induction).

  Si $phi in "At"$, es fácil:
  $ "paren"(phi) = 0 = 2 * 0 = 2 * "con"(phi). $

  Si $phi = (not phi')$, utilizando la hipótesis inductiva para $phi'$ calculamos:
  $ & "paren"((not phi')) \
    =& {"definición"} \
    & "paren"(phi') + 2 \
    =& {"por h.i. en" phi'} \
    & (2 * "con"(phi')) + 2 \
    =& {"distributividad"} \
    & 2 * ("con"(phi') + 1) \
    =& {"definición"} \
    & 2 * "con"((not phi')) $

  Si $phi = (phi_1 boxop phi_2)$, disponemos de la hipótesis inductiva sobre $phi_1$ y sobre $phi_2$:
  $ & "paren"((phi_1 boxop phi_2)) \
    =& {"definición"} \
    & "paren"(phi_1) + "paren"(phi_2) + 2 \
    =& {"por h.i. en ambas sub-fórmulas"} \
    & 2 * "con"(phi_1) + 2 * "con"(phi_2) + 2 \
    =& {"distributividad"} \
    & 2 * ("con"(phi_1) + "con"(phi_2) + 1) \
    =& {"definición"} \
    & 2 * "con"((phi_1 boxop phi_2)) $
]
