1.- Existe una persona en la feria tal que si dicha persona paga, entonces todas las personas pagan.

    E(X)


2.- Sócrates es un hombre. Los hombres son mortales. luego Sócrates es mortal.
3.-Hay estudiantes inteligentes y hay estudiantes trabajadores. Por tanto, hay estudiantes inteligentes y trabajadores. 
4.- En cierto país oriental se ha celebrado la fase final del campeonato mundial de futbol. Cierto diario deportivo ha publicado las siguientes estadisticas de tan magno acontecimiento: 
- A todos los porteros que no vistieron camisa negra les marcó un gol algun delantero europep. 
- Algun portero jugó con botas blancas y sólo le marcaron goles jugadores con botas blancas. 
- Ningún portero se marcó un gol a si mismo. 
- Ningun jugador con botas blancas vistió camiseta negra. 
- Por tanto, algun delantero europeo jugó con botas blancas. 
5.- Sócrates era el maestro de Platón. Sócrates tuvo. a lo sumo, un discípulo. Aristóteles fue discípulo de alguien cuyo maestro fue Sócrates. Por consiguiente, platon fue el maestro de Aristoteles. 


Predicados y formalización lógica
Existe una persona en la feria tal que si dicha persona paga, entonces todas las personas pagan.

Predicados:
( P(x) ): ( x ) paga.
( \forall x ): Para todo ( x ).
( \exists x ): Existe ( x ).
Formalización:
( \exists x (P(x) \rightarrow \forall y P(y)) )
Sócrates es un hombre. Los hombres son mortales. Luego Sócrates es mortal.

Predicados:
( H(x) ): ( x ) es hombre.
( M(x) ): ( x ) es mortal.
( s ): Sócrates.
Formalización:
( H(s) )
( \forall x (H(x) \rightarrow M(x)) )
( M(s) )
Hay estudiantes inteligentes y hay estudiantes trabajadores. Por tanto, hay estudiantes inteligentes y trabajadores.

Predicados:
( I(x) ): ( x ) es inteligente.
( T(x) ): ( x ) es trabajador.
( \exists x ): Existe ( x ).
Formalización:
( \exists x I(x) )
( \exists x T(x) )
( \exists x (I(x) \land T(x)) )
En cierto país oriental se ha celebrado la fase final del campeonato mundial de futbol. Cierto diario deportivo ha publicado las siguientes estadísticas de tan magno acontecimiento:

A todos los porteros que no vistieron camisa negra les marcó un gol algún delantero europeo.
Predicados:
( P(x) ): ( x ) es portero.
( C(x) ): ( x ) viste camisa negra.
( G(x, y) ): ( x ) marcó un gol a ( y ).
( D(y) ): ( y ) es delantero europeo.
Formalización:
( \forall x (P(x) \land \neg C(x) \rightarrow \exists y (D(y) \land G(y, x))) )
Algún portero jugó con botas blancas y sólo le marcaron goles jugadores con botas blancas.
Predicados:
( B(x) ): ( x ) jugó con botas blancas.
Formalización:
( \exists x (P(x) \land B(x) \land \forall y (G(y, x) \rightarrow B(y))) )
Ningún portero se marcó un gol a sí mismo.
Formalización:
( \forall x (P(x) \rightarrow \neg G(x, x)) )
Ningún jugador con botas blancas vistió camiseta negra.
Formalización:
( \forall x (B(x) \rightarrow \neg C(x)) )
Por tanto, algún delantero europeo jugó con botas blancas.
Formalización:
( \exists x (D(x) \land B(x)) )
Sócrates era el maestro de Platón. Sócrates tuvo, a lo sumo, un discípulo. Aristóteles fue discípulo de alguien cuyo maestro fue Sócrates. Por consiguiente, Platón fue el maestro de Aristóteles.

Predicados:
( M(x, y) ): ( x ) es maestro de ( y ).
( D(x, y) ): ( x ) es discípulo de ( y ).
( s ): Sócrates.
( p ): Platón.
( a ): Aristóteles.
Formalización:
( M(s, p) )
( \forall x \forall y \forall z ((M(s, x) \land M(s, y)) \rightarrow x = y) )
( \exists x (D(a, x) \land M(s, x)) )
( M(p, a) )