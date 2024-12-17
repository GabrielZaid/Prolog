
hermana(Ana)
hermano(Bruno)
hermana(Carla)
hermano(Daniel)

hermanos(X,Y) :- hermana(X), hermano(Y).

mascota(X) :- (X = perro; X = pez; X = gato; X = loro).

% 1.- ¿Qué mascota tiene cada hermano?
mascotade(Ana, X) :- mascota(X), X \= perro, X \= pez.

mascotade(Bruno, X) :- mascota(X), X \= gato.

mascotade(Carla, X) :- mascota(X), X \= pez.
mascotade(daniel, loro).
mascotade(daniel, pez).

mascotadiferente(ana, bruno) :- mascota(X), mascota(Y), X \= Y.
mascotadiferente(ana, carla) :- mascota(X), mascota(Y), X \= Y.
mascotadiferente(ana, daniel) :- mascota(X), mascota(Y), X \= Y.
mascotadiferente(bruno, carla) :- mascota(X), mascota(Y), X \= Y.
mascotadiferente(bruno, daniel) :- mascota(X), mascota(Y), X \= Y.
mascotadiferente(carla, daniel) :- mascota(X), mascota(Y), X \= Y.

