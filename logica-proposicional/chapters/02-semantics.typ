#import "../../lib/notes.typ": *

= Semántica <ch-semantics>

Hasta aquí las proposiciones son ciertas palabras sobre un alfabeto. En este capítulo les damos significado: definimos el valor de verdad de una proposición a partir de los valores de verdad de sus variables, y con él las nociones de validez y de consecuencia lógica.

#remark(title: [El conectivo $<->$])[
  A partir de aquí incluimos también el bicondicional entre los conectivos. Las proposiciones son ciertas palabras sobre el alfabeto
  $ Sigma = "At" union {not, or, and, ->, <->} union {"(", ")"}, $
  donde $"At" = cal(V) union {bot}$, y la definición inductiva de $"Prop"$ tiene, además de las cláusulas para $"At"$, $not$, $or$, $and$ y $->$, la cláusula

  - $(phi <-> psi)$: si $phi in "Prop"$ y $psi in "Prop"$, entonces $(phi <-> psi) in "Prop"$.

  En consecuencia, la metavariable $square$ recorre ahora $or$, $and$, $->$ y $<->$, y los esquemas de recursión y de inducción en sub-fórmulas cubren el bicondicional en el caso $(phi boxop psi)$.
] <rem-prop-biconditional>

== Valores de verdad

Las proposiciones representan afirmaciones, de modo que para darles significado alcanza con utilizar el conjunto $bb(2) = {0, 1}$ de valores de verdad, donde $0$ representa lo falso y $1$ lo verdadero. Por ejemplo, establecimos que $bot$ representaba la afirmación falsa. Para otras, como _hoy llueve_ (representada por alguna $p_i$), no podemos fijar su valor de verdad de una vez y para siempre.

¿Cuál es el valor de $(not p_1)$? Depende del valor de $p_1$:

#align(center, table(
  columns: 2, align: center, inset: 5pt,
  $p_1$, $(not p_1)$,
  [0], [1],
  [1], [0],
))

En general, el valor de $(phi boxop psi)$ dependerá del valor de $phi$ y del de $psi$.

== Tablas de verdad

En una *tabla de verdad* esa dependencia se hace patente. Cada línea de la tabla muestra una asignación de valores a las variables proposicionales, y cada columna el valor de una proposición bajo esas asignaciones.

#example[
  La tabla de verdad de $(((not p_0) and p_1) -> p_2)$ es:

  #align(center, table(
    columns: 6, align: center, inset: 5pt,
    $p_0$, $p_1$, $p_2$, $(not p_0)$, $((not p_0) and p_1)$, $(((not p_0) and p_1) -> p_2)$,
    [0], [0], [0], [1], [0], [1],
    [0], [0], [1], [1], [0], [1],
    [0], [1], [0], [1], [1], [0],
    [0], [1], [1], [1], [1], [1],
    [1], [0], [0], [0], [0], [1],
    [1], [0], [1], [0], [0], [1],
    [1], [1], [0], [0], [0], [1],
    [1], [1], [1], [0], [0], [1],
  ))
] <ex-truth-table>

Los valores de las columnas que no son variables quedan determinados unívocamente por los de las columnas anteriores.

== Completitud funcional

Una función $bb(2)^n -> bb(2)$ puede describirse con una tabla de verdad. Recíprocamente, dada una función $F : bb(2)^n -> bb(2)$, ¿existe una proposición $phi$ tal que la tabla de verdad de $phi$ sea justamente la función $F$?

#example[
  Consideremos la función $F : bb(2)^3 -> bb(2)$ dada por la tabla

  #align(center, table(
    columns: 4, align: center, inset: 5pt,
    $p_0$, $p_1$, $p_2$, $F(p_0, p_1, p_2)$,
    [0], [0], [0], [0],
    [0], [0], [1], [1],
    [0], [1], [0], [0],
    [0], [1], [1], [1],
    [1], [0], [0], [0],
    [1], [0], [1], [0],
    [1], [1], [0], [1],
    [1], [1], [1], [0],
  ))

  La idea para obtener $phi$ es tomar la disyunción de los _minterms_ de las líneas con $1$ en $F(p_0, p_1, p_2)$.
] <ex-function-minterms>

Esta construcción solo utiliza los conectivos $not$, $and$ y $or$, de modo que el conjunto ${not, and, or}$ es funcionalmente completo en el sentido de la siguiente definición.

#definition(title: "Completitud funcional")[
  Un conjunto de conectivos es *funcionalmente completo* si toda función $bb(2)^n -> bb(2)$ se puede describir con una proposición que solo utilice esos conectivos.
] <def-functional-completeness>

Si sabemos que un conjunto es funcionalmente completo, entonces podemos probar que otro conjunto lo es utilizando equivalencias lógicas.

#example(title: [¿Alcanza con ${and, not}$?])[
  La tabla de verdad de la disyunción es

  #align(center, table(
    columns: 3, align: center, inset: 5pt,
    $p_0$, $p_1$, $p_0 or p_1$,
    [0], [0], [0],
    [0], [1], [1],
    [1], [0], [1],
    [1], [1], [1],
  ))

  y coincide con la de $not(not p_0 and not p_1)$:

  #align(center, table(
    columns: 6, align: center, inset: 5pt,
    $p_0$, $p_1$, $not p_0$, $not p_1$, $not p_0 and not p_1$, $not(not p_0 and not p_1)$,
    [0], [0], [1], [1], [1], [0],
    [0], [1], [1], [0], [0], [1],
    [1], [0], [0], [1], [0], [1],
    [1], [1], [0], [0], [0], [1],
  ))

  Luego la disyunción se expresa con $and$ y $not$:
  $ class("normal", or)(phi, psi) = (not((not phi) and (not psi))), $
  y como ${not, and, or}$ es funcionalmente completo, también lo es ${and, not}$.
] <ex-and-not-complete>

== Asignaciones y valor de verdad

#definition(title: "Asignación")[
  Una *asignación* es una función $f : cal(V) -> bb(2)$.
] <def-assignment>

En una tabla de verdad no listamos todas las asignaciones, sino solo los valores de las variables que aparecen en la proposición; el @thm-coincidence muestra por qué alcanza con algunas asignaciones.

#definition(title: "Valor de verdad")[
  Dada una asignación $f$, el *valor de verdad* de una proposición se define recursivamente:
  $ #sem($-$, $f$) &: "Prop" -> bb(2) \
    #sem($p_i$, $f$) &= f(p_i) \
    #sem($bot$, $f$) &= 0 \
    #sem($(not phi)$, $f$) &= 1 - #sem($phi$, $f$) \
    #sem($(phi and psi)$, $f$) &= op("mín")(#sem($phi$, $f$), #sem($psi$, $f$)) \
    #sem($(phi -> psi)$, $f$) &= op("máx")(1 - #sem($phi$, $f$), #sem($psi$, $f$)) \
    #sem($(phi or psi)$, $f$) &= op("máx")(#sem($phi$, $f$), #sem($psi$, $f$)) \
    #sem($(phi <-> psi)$, $f$) &= cases(
      1 & "si" #sem($phi$, $f$) = #sem($psi$, $f$),
      0 & "si" #sem($phi$, $f$) != #sem($psi$, $f$),
    ) $
] <def-truth-value>

== Coincidencia y sustitución

#theorem(title: "de coincidencia")[
  Si $f, f' : cal(V) -> bb(2)$ coinciden en las variables que ocurren en $phi$, entonces $#sem($phi$, $f$) = #sem($phi$, $f'$)$.
] <thm-coincidence>

#proof[
  Por inducción en $phi$.
]

#definition(title: "Sustitución")[
  La *sustitución* del símbolo $p_i$ por la proposición $psi$ es la función $-[psi slash p_i] : "Prop" -> "Prop"$ definida recursivamente por
  $ p_j [psi slash p_i] &= cases(
      psi & "si" i = j,
      p_j & "si" i != j,
    ) \
    bot [psi slash p_i] &= bot \
    (not phi) [psi slash p_i] &= (not phi [psi slash p_i]) \
    (phi boxop psi') [psi slash p_i] &= (phi [psi slash p_i] boxop psi' [psi slash p_i]) $
] <def-substitution>

#lemma(title: "de sustitución")[
  Sea $f$ una asignación tal que $#sem($psi_1$, $f$) = #sem($psi_2$, $f$)$. Entonces $#sem($phi [psi_1 slash p_i]$, $f$) = #sem($phi [psi_2 slash p_i]$, $f$)$.
] <lem-substitution>

#proof[
  Por inducción en sub-fórmulas.
]

== Validez

#definition(title: "Satisfacción")[
  La asignación $f$ *satisface* $phi$ si $#sem($phi$, $f$) = 1$.
] <def-satisfies>

#definition(title: "Tautología")[
  Una proposición $phi$ es una *tautología* (o es *válida*) si es satisfecha por toda asignación.
] <def-tautology>

#definition(title: "Modelo")[
  Sea $Gamma subset.eq "Prop"$. Decimos que $f$ es un *modelo* de $Gamma$ si para toda $phi in Gamma$, $f$ satisface $phi$.
] <def-model>

#exercise[
  ¿Existe algún modelo de $"Prop"$?
] <exr-model-of-prop>

== Consecuencia lógica

#notation[
  Si $phi$ es una tautología, escribimos $⊨ phi$.
] <not-tautology>

#definition(title: "Consecuencia lógica")[
  Decimos que $phi$ es *consecuencia lógica* de $Gamma$ si todo modelo de $Gamma$ satisface $phi$. Lo escribimos $Gamma ⊨ phi$.
] <def-logical-consequence>

#remark[
  Como toda asignación es un modelo de $emptyset$, entonces $⊨ phi$ es lo mismo que $emptyset ⊨ phi$.
] <rem-consequence-empty>

¿Cómo verificamos si $Gamma ⊨ phi$, es decir, si todo modelo $f$ de $Gamma$ satisface $phi$? Tomamos un modelo (arbitrario) $f$ de $Gamma$ y verificamos que $#sem($phi$, $f$) = 1$.

¿Cómo contradecimos $Gamma ⊨ phi$? Damos un modelo (concreto) $f$ de $Gamma$ y verificamos que $#sem($phi$, $f$) = 0$.
