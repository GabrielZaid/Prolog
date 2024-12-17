/******************************************************************************

                            Online Prolog Compiler.
                Code, Compile, Run and Debug Prolog program online.
Write your code in this editor and press "Run" button to execute it.

*******************************************************************************/


main:-
        eliza,
        halt.
% Predicado principal de Eliza
eliza :-
writeln('Hola, mi nombre es Eliza, tu chatbot.'),
    writeln('Por favor ingresa tu consulta, usar solo minusculas sin . al final:'),
    readln(Entrada),
    eliza(Entrada), !.

% Predicado para manejar la entrada de "Adios"
eliza(Entrada) :- member('adios', Entrada),
    writeln('Adios. Espero haber podido ayudarte.'), !.

% Predicado principal de procesamiento de entrada
eliza(Entrada) :-
    findall(Patron, plantilla(Patron, _, _), Patrones),
    encontrar_plantilla(Entrada, Patrones, Patron),
    plantilla(Patron, Respuesta, IndicesPatron),
    % Si se ha encontrado la plantilla correcta:
    replace0(IndicesPatron, Entrada, 0, Respuesta, RespuestaFinal),
    writeln(RespuestaFinal),
    readln(NuevaEntrada),
    eliza(NuevaEntrada), !.

% Predicado para encontrar la plantilla correcta
encontrar_plantilla(Entrada, [Patron|_], Patron) :- coincide(Patron, Entrada), !.
encontrar_plantilla(Entrada, [_|RestoPatrones], Patron) :- encontrar_plantilla(Entrada, RestoPatrones, Patron).


%---------------------------------------------------
% Plantillas para respuestas sobre el árbol familiar
%---------------------------------------------------

% Plantillas generales para preguntar nombres de familiares
plantilla([dime, nombres, del, arbol, genealogico], [flagArbolGenealogico], [3]).
plantilla([cuales, familiares, existen, '?'], [flagArbolGenealogico], [2]).
plantilla([dame, nombres, del, arbol, genealogico], [flagArbolGenealogico], [3]).
plantilla([sabes, nombres, del, arbol, genealogico, '?'], [flagArbolGenealogico], [3]).
plantilla([conoces, nombres, del, arbol, genealogico], [flagArbolGenealogico], [3]).
plantilla([dime, nombres, de, familiares], [flagArbolGenealogico], [3]).
plantilla([dime, nombres, de, los, familiares], [flagArbolGenealogico], [3]).
plantilla([dame, nombres, de, los, familiares], [flagArbolGenealogico], [3]).
plantilla([sabes, nombres, de, los, familiares, '?'], [flagArbolGenealogico], [3]).
plantilla([sabes, nombres, de, los, familiares, '?'], [flagArbolGenealogico], [3]).
plantilla([conoces, nombres, de, familiares, '?'], [flagArbolGenealogico], [3]).
plantilla([dame, nombres, de, padres], [flagPadresNombres], [3]).
plantilla([dame, nombres, de, los, padres], [flagPadresNombres], [3]).
plantilla([dime, nombres, de, padres], [flagPadresNombres], [3]).
plantilla([dime, nombres, de, los, padres], [flagPadresNombres], [3]).
plantilla([conoces, nombres, de, padres, '?'], [flagPadresNombres], [3]).
plantilla([conoces, nombres, de, los, padres, '?'], [flagPadresNombres], [3]).
plantilla([dame, nombres, de, hijos], [flagHijosNombres], [3]).
plantilla([conoces, nombres, de, hijos, '?'], [flagHijosNombres], [3]).
plantilla([conoces, nombres, de, los, hijos, '?'], [flagHijosNombres], [3]).
plantilla([dime, nombres, de, padres], [flagPadresNombres], [3]).
plantilla([dime, nombres, de, hijos], [flagHijosNombres], [3]).
plantilla([dame, nombres, de, hermanos], [flagHermanosNombres], [3]).
plantilla([dime, nombres, de, hermanos], [flagHermanosNombres], [3]).

plantilla([dame, nombres, de, tios], [flagTiosNombres], [3]).
plantilla([dime, nombres, de, tios], [flagTiosNombres], [3]).
plantilla([dame, nombres, de, primos], [flagPrimosNombres], [3]).
plantilla([dime, nombres, de, primos], [flagPrimosNombres], [3]).
plantilla([dame, nombres, de, sobrinos], [flagSobrinosNombres], [3]).
plantilla([dime, nombres, de, sobrinos], [flagSobrinosNombres], [3]).

plantilla([quienes, son, los, hijos, de, s(N), '?'], [flagHijos], [5]).
plantilla([dime, quienes, son, los, hijos, de, s(N), '?'], [flagHijos], [6]).
plantilla([sabes, quienes, son, los, hijos, de, s(N), '?'], [flagHijos], [6]).
plantilla([s(N), tiene, hijos,'?'], [flagHijos], [0]).

plantilla([quienes, son, los, hermanos, de, s(N), '?'], [flagHermanos], [5]).
plantilla([dime, quienes, son, los, hermanos, de, s(N), '?'], [flagHermanos], [6]).
plantilla([sabes, quienes, son, los, hermanos, de, s(N), '?'], [flagHermanos], [6]).
plantilla([s(N), tiene, hermanos. '?'], [flagHermanos], [0]).

plantilla([quienes, son, los, tios, de, s(N), '?'], [flagTios], [5]).
plantilla([quienes, son, los, tios, de, s(N), '?'], [flagTios], [6]).
plantilla([sabes, quienes, son, los, tios, de, s(N), '?'], [flagTios], [6]).
plantilla([s(N), tiene, tios, '?'], [flagTios], [0]).

plantilla([quienes, son, los, abuelos, de, s(N), '?'], [flagAbuelos], [5]).
plantilla([quienes, son, los, abuelos, de, s(N), '?'], [flagAbuelos], [6]).
plantilla([sabes, quienes, son, los, abuelos, de, s(N), '?'], [flagAbuelos], [6]).
plantilla([s(N), tiene, abuelos, '?'], [flagAbuelos], [0]).

plantilla([quienes, son, los, padres, de, s(N), '?'], [flagPadres], [5]).
plantilla([quienes, son, los, padres, de, s(N), '?'], [flagPadres], [6]).
plantilla([dime, quienes, son, los, padres, de, s(N), '?'], [flagPadres], [6]).
plantilla([sabes, quienes, son, los, padres, de, s(N), '?'], [flagPadres], [6]).
plantilla([s(N), tiene, padres, '?'], [flagPadres], [0]).

plantilla([quienes, son, los, nietos, de, s(N), '?'], [flagNietos], [5]).
plantilla([quienes, son, los, nietos, de, s(N), '?'], [flagNietos], [6]).
plantilla([sabes, quienes, son, los, nietos, de, s(N), '?'], [flagNietos], [6]).
plantilla([s(N), tiene, nietos, '?'], [flagNietos], [0]).

plantilla([quienes, son, los, primos, de, s(N), '?'], [flagPrimos], [5]).
plantilla([quienes, son, los, primos, de, s(N), '?'], [flagPrimos], [6]).
plantilla([sabes, quienes, son, los, primos, de, s(N), '?'], [flagPrimos], [6]).
plantilla([s(N), tiene, primos, '?'], [flagPrimos], [0]).

plantilla([quienes, son, los, sobrinos, de, s(N), '?'], [flagSobrinos], [5]).
plantilla([quienes, son, los, sobrinos, de, s(N), '?'], [flagSobrinos], [6]).
plantilla([sabes, quienes, son, los, sobrinos, de, s(N), '?'], [flagSobrinos], [6]).
plantilla([s(N), tiene, sobrinos, '?'], [flagSobrinos], [0]).

plantilla([quienes, son, los, primos, de, los, sobrinos, de, s(N), '?'], [flagPrimosSobrinos], [8]).
plantilla([dime, quienes, son, los, primos, de, los, sobrinos, de, s(N), '?'], [flagPrimosSobrinos], [9]).
plantilla([quienes, son, los, primos, de, los, sobrinos, de, s(N), '?'], [flagPrimosSobrinos], [8]).
plantilla([sabes, quienes, son, los, primos, de, los, sobrinos, de, s(N), '?'], [flagPrimosSobrinos], [9]).
plantilla([s(N), tiene, primos, de, sobrinos, '?'], [flagPrimosSobrinos], [0]).



% Caso general para entradas desconocidas
plantilla(_, ['Por favor explica un poco más.'], []).

%----------------------------------------
% Predicado para coincidencia de patrones
%----------------------------------------

% Verifica si un patrón coincide con la entrada
coincide([], []).
coincide([S|RestoPatron], [I|RestoEntrada]) :-
    atom(S), % Si S es un átomo
    S == I,
    coincide(RestoPatron, RestoEntrada), !.
coincide([s(_)|RestoPatron], [_|RestoEntrada]) :-
    coincide(RestoPatron, RestoEntrada), !.

% Reemplazo final
replace0([], _, _, Respuesta, Respuesta) :- !.


%------------------------------------------------------------
% Arbol familiar Reglas para consulta en el árbol genealógico
%------------------------------------------------------------

%replace0:

% Reemplazo para hijos
replace0([Indice|_], Entrada, _, Respuesta, Resultado) :- 
    nth0(Indice, Entrada, Atomo),
    nth0(0, Respuesta, X),
    X == flagHijos,
    hijos_de(Atomo, Resultado).

% Reemplazo para hermanos
replace0([Indice|_], Entrada, _, Respuesta, Resultado) :- 
    nth0(Indice, Entrada, Atomo),
    nth0(0, Respuesta, X),
    X == flagHermanos,
    hermanos_de(Atomo, Resultado).

% Reemplazo para primos
replace0([Indice|_], Entrada, _, Respuesta, Resultado) :- 
    nth0(Indice, Entrada, Atomo),
    nth0(0, Respuesta, X),
    X == flagPrimos,
    primos_de(Atomo, Resultado).

% Reemplazo para tíos
replace0([Indice|_], Entrada, _, Respuesta, Resultado) :- 
    nth0(Indice, Entrada, Atomo),
    nth0(0, Respuesta, X),
    X == flagTios,
    tios_de(Atomo, Resultado).

% Reemplazo para sobrinos
replace0([Indice|_], Entrada, _, Respuesta, Resultado) :- 
    nth0(Indice, Entrada, Atomo),
    nth0(0, Respuesta, X),
    X == flagSobrinos,
    sobrinos_de(Atomo, Resultado).

% Reemplazo para abuelos
replace0([Indice|_], Entrada, _, Respuesta, Resultado) :- 
    nth0(Indice, Entrada, Atomo),
    nth0(0, Respuesta, X),
    X == flagAbuelos,
    abuelos_de(Atomo, Resultado).

% Reemplazo para nietos
replace0([Indice|_], Entrada, _, Respuesta, Resultado) :- 
    nth0(Indice, Entrada, Atomo),
    nth0(0, Respuesta, X),
    X == flagNietos,
    nietos_de(Atomo, Resultado).

% Reemplazo para padres
replace0([Indice|_], Entrada, _, Respuesta, Resultado) :- 
    nth0(Indice, Entrada, Atomo),
    nth0(0, Respuesta, X),
    X == flagPadres,
    padres_de(Atomo, Resultado).

% Reemplazo para primos de sobrinos
replace0([Indice|_], Entrada, _, Respuesta, Resultado) :- 
    nth0(Indice, Entrada, Atomo),
    nth0(0, Respuesta, X),
    X == flagPrimosSobrinos,
    primos_sobrinos_de(Atomo, Resultado).

% Regla general para obtener los nombres de los familiares
replace0([Indice|_], Entrada, _, Respuesta, Resultado) :-
    nth0(Indice, Entrada, Atomo),
    nth0(0, Respuesta, X),
    X == flagArbolGenealogico,
    nombres_de_familia(Resultado).

replace0([Indice|_], Entrada, _, Respuesta, Resultado) :-
    nth0(Indice, Entrada, Atomo),
    nth0(0, Respuesta, X),
    X == flagPadresNombres,
    nombres_padres(Resultado).

replace0([Indice|_], Entrada, _, Respuesta, Resultado) :-
    nth0(Indice, Entrada, Atomo),
    nth0(0, Respuesta, X),
    X == flagHijosNombres,
    nombres_hijos(Resultado).

replace0([Indice|_], Entrada, _, Respuesta, Resultado) :-
    nth0(Indice, Entrada, Atomo),
    nth0(0, Respuesta, X),
    X == flagHermanosNombres,
    nombres_hermanos(Resultado).

replace0([Indice|_], Entrada, _, Respuesta, Resultado) :-
    nth0(Indice, Entrada, Atomo),
    nth0(0, Respuesta, X),
    X == flagTiosNombres,
    nombres_tios(Resultado).

replace0([Indice|_], Entrada, _, Respuesta, Resultado) :-
    nth0(Indice, Entrada, Atomo),
    nth0(0, Respuesta, X),
    X == flagPrimosNombres,
    nombres_primos(Resultado).

replace0([Indice|_], Entrada, _, Respuesta, Resultado) :-
    nth0(Indice, Entrada, Atomo),
    nth0(0, Respuesta, X),
    X == flagSobrinosNombres,
    nombres_sobrinos(Resultado).



% Regla general para obtener los nombres de los familiares
nombres_de_familia(Resultado) :-
    findall(Nombre, (
        padre_de(Nombre, _) ;
        madre_de(Nombre, _) ;
        hermano_de(Nombre, _) ;
        hermana_de(Nombre, _) ;
        tio_de(Nombre, _) ;
        tia_de(Nombre, _) ;
        primo_de(Nombre, _) ;
        prima_de(Nombre, _) ;
        sobrino_de(Nombre, _) ;
        nieto_de(Nombre, _) ;
        esposo_de(Nombre, _) ;
        esposa_de(Nombre, _) ;
        sin_esposa(Nombre)
    ), Familia),
    list_to_set(Familia, FamiliaUnica),
    atomic_list_concat(FamiliaUnica, ', ', FamiliaStr),
    format(atom(Resultado), '-- Eliza: Los nombres de los familiares son: ~w.', [FamiliaStr]).

nombres_de_familia('-- Eliza: No se encontraron nombres de familiares.') :-
    \+ (padre_de(_, _) ;
        madre_de(_, _) ;
        hermano_de(_, _) ;
        hermana_de(_, _) ;
        tio_de(_, _) ;
        tia_de(_, _) ;
        primo_de(_, _) ;
        prima_de(_, _) ;
        sobrino_de(_, _) ;
        nieto_de(_, _) ;
        esposo_de(_, _) ;
        esposa_de(_, _) ;
        sin_esposa(_)).

% Regla para obtener los nombres de los padres
nombres_padres(Resultado) :-
    findall(Nombre, (
        padre_de(Nombre, _) ;
        madre_de(Nombre, _)
    ), Padres),
    list_to_set(Padres, PadresUnicos),
    atomic_list_concat(PadresUnicos, ', ', PadresStr),
    format(atom(Resultado), '-- Eliza: Los nombres de los padres son: ~w.', [PadresStr]).
nombres_padres('-- Eliza: No se encontraron nombres de padres.') :- 
    \+ (padre_de(_, _) ; madre_de(_, _)).


% Regla para obtener los nombres de los hijos
nombres_hijos(Resultado) :-
    findall(Nombre, (
        padre_de(_, Nombre) ;
        madre_de(_, Nombre)
    ), Hijos),
    list_to_set(Hijos, HijosUnicos),
    atomic_list_concat(HijosUnicos, ', ', HijosStr),
    format(atom(Resultado), '-- Eliza: Los nombres de los hijos son: ~w.', [HijosStr]).
nombres_hijos('-- Eliza: No se encontraron nombres de hijos.') :-
    \+ (padre_de(_, _) ; madre_de(_, _)).

% Regla para obtener los nombres de los hermanos
nombres_hermanos(Resultado) :-
    findall(Nombre, hermano_de(Nombre, _), Hermanos),
    list_to_set(Hermanos, HermanosUnicos),
    atomic_list_concat(HermanosUnicos, ', ', HermanosStr),
    format(atom(Resultado), '-- Eliza: Los nombres de los hermanos son: ~w.', [HermanosStr]).
nombres_hermanos('-- Eliza: No se encontraron nombres de hermanos.') :-
    \+ hermano_de(_, _).


% Regla para obtener los nombres de los tios
nombres_tios(Resultado) :-
    findall(Nombre, tio_de(Nombre, _), Tios),
    list_to_set(Tios, TiosUnicos),
    atomic_list_concat(TiosUnicos, ', ', TiosStr),
    format(atom(Resultado), '-- Eliza: Los nombres de los tios son: ~w.', [TiosStr]).
nombres_tios('-- Eliza: No se encontraron nombres de tios.') :-
    \+ tio_de(_, _).

% Regla para determinar nombres de primos
nombres_primos(Resultado) :-
    findall(Nombre, primo_de(Nombre, _), Primos),
    list_to_set(Primos, PrimosUnicos),
    atomic_list_concat(PrimosUnicos, ', ', PrimosStr),
    format(atom(Resultado), '-- Eliza: Los nombres de los primos son: ~w.', [PrimosStr]).
nombres_primos('-- Eliza: No se encontraron nombres de primos.') :-
    \+ primo_de(_, _).

% Regla para determinar nombres de sobrinos
nombres_sobrinos(Resultado) :-
    findall(Nombre, sobrino_de(Nombre, _), Sobrinos),
    list_to_set(Sobrinos, SobrinosUnicos),
    atomic_list_concat(SobrinosUnicos, ', ', SobrinosStr),
    format(atom(Resultado), '-- Eliza: Los nombres de los sobrinos son: ~w.', [SobrinosStr]).



% Regla para determinar hijos de un padre/madre
hijos_de(X, R) :- 
    setof(Y, (padre_de(X, Y) ; madre_de(X, Y)), Hijos),
    atomic_list_concat(Hijos, ', ', HijosStr),
    format(atom(R), '-- Eliza: Los hijos de ~w son: ~w.', [X, HijosStr]).
hijos_de(X, '-- Eliza: No se encontraron hijos para esta persona.') :- 
    \+ (padre_de(X, _) ; madre_de(X, _)).

% Regla para determinar hermanos
hermano_de(X, Y) :- 
    padre_de(Z, X), padre_de(Z, Y), X \= Y.
hermano_de(X, Y) :- 
    madre_de(Z, X), madre_de(Z, Y), X \= Y.

hermanos_de(X, R) :- 
    setof(Y, hermano_de(X, Y), Hermanos),
    atomic_list_concat(Hermanos, ', ', HermanosStr),
    format(atom(R), '-- Eliza: Los hermanos de ~w son: ~w.', [X, HermanosStr]).
hermanos_de(X, '-- Eliza: No se encontraron hermanos para esta persona.') :- 
    \+ hermano_de(X, _).


% Regla para determinar primos
primo_de(X, Y) :- 
    padre_de(A, X), padre_de(B, Y), hermano_de(A, B).
primo_de(X, Y) :- 
    madre_de(A, X), madre_de(B, Y), hermano_de(A, B).
primo_de(X, Y) :-
    padre_de(A, X), madre_de(B, Y), hermana_de(A, B).
primo_de(X, Y) :-
    madre_de(A, X), padre_de(B, Y), hermana_de(A, B).



primos_de(X, R) :- 
    setof(Y, primo_de(X, Y), Primos),
    atomic_list_concat(Primos, ', ', PrimosStr),
    format(atom(R), '-- Eliza: Los primos de ~w son: ~w.', [X, PrimosStr]).
primos_de(X, '-- Eliza: No se encontraron primos para esta persona.') :- 
    \+ primo_de(X, _).


% Regla para determinar tíos
tio_de(Tio, Sobrino) :- 
    padre_de(Padre, Sobrino), hermano_de(Tio, Padre).
tio_de(Tio, Sobrino) :- 
    madre_de(Madre, Sobrino), hermano_de(Tio, Madre).

tios_de(X, R) :- 
    setof(Y, tio_de(Y, X), Tios),
    atomic_list_concat(Tios, ', ', TiosStr),
    format(atom(R), '-- Eliza: Los tíos de ~w son: ~w.', [X, TiosStr]).
tios_de(X, '-- Eliza: No se encontraron tíos para esta persona.') :- 
    \+ tio_de(_, X).



% Regla para determinar abuelos
abuelo_de(Abuelo, Nieto) :- 
    padre_de(Abuelo, Padre), padre_de(Padre, Nieto).
abuelo_de(Abuelo, Nieto) :- 
    padre_de(Abuelo, Madre), madre_de(Madre, Nieto).

abuelos_de(X, R) :- 
    setof(Y, abuelo_de(Y, X), Abuelos),
    atomic_list_concat(Abuelos, ', ', AbuelosStr),
    format(atom(R), '-- Eliza: Los abuelos de ~w son: ~w.', [X, AbuelosStr]).
abuelos_de(X, '-- Eliza: No se encontraron abuelos para esta persona.') :- 
    \+ abuelo_de(_, X).

% Regla para determinar primos de los sobrinos
primos_sobrinos_de(Tio, R) :-
    setof(Primo, 
          (sobrino_de(Sobrino, Tio), primo_de(Sobrino, Primo)), 
          Primos),
    atomic_list_concat(Primos, ', ', PrimosStr),
    format(atom(R), '-- Eliza: Los primos de los sobrinos de ~w son: ~w.', [Tio, PrimosStr]).

primos_sobrinos_de(_, '-- Eliza: No se encontraron primos para los sobrinos de esta persona.') :-
    \+ (sobrino_de(_, _), primo_de(_, _)).


% Regla para determinar si alguien es sobrino
sobrino_de(Sobrino, Tio) :- 
    padre_de(Padre, Sobrino), hermano_de(Padre, Tio).
sobrino_de(Sobrino, Tio) :- 
    madre_de(Madre, Sobrino), hermana_de(Madre, Tio).
sobrino_de(Sobrino, Tio) :- 
    madre_de(Madre, Sobrino), hermano_de(Madre, Tio).
sobrino_de(Sobrino, Tio):-
    tio_de(Tio, Sobrino).

% Regla para obtener lista de sobrinos
sobrinos_de(X, R) :- 
    setof(Y, sobrino_de(Y, X), Sobrinos),
    atomic_list_concat(Sobrinos, ', ', SobrinosStr),
    format(atom(R), '-- Eliza: Los sobrinos de ~w son: ~w.', [X, SobrinosStr]).
sobrinos_de(X, '-- Eliza: No se encontraron sobrinos para esta persona.') :- 
    \+ sobrino_de(_, X).


% Regla para determinar si alguien es nieto
nieto_de(Nieto, Abuelo) :- 
    padre_de(Padre, Nieto), padre_de(Abuelo, Padre).
nieto_de(Nieto, Abuelo) :- 
    madre_de(Madre, Nieto), padre_de(Abuelo, Madre).
nieto_de(Nieto, Abuelo) :- 
    padre_de(Padre, Nieto), madre_de(Abuelo, Padre).
nieto_de(Nieto, Abuelo) :- 
    madre_de(Madre, Nieto), madre_de(Abuelo, Madre).

% Regla para obtener lista de nietos
nietos_de(X, R) :- 
    setof(Y, nieto_de(Y, X), Nietos),
    atomic_list_concat(Nietos, ', ', NietosStr),
    format(atom(R), '-- Eliza: Los nietos de ~w son: ~w.', [X, NietosStr]).
nietos_de(X, '-- Eliza: No se encontraron nietos para esta persona.') :- 
    \+ nieto_de(_, X).



% Regla para obtener los padres
padres_de(X, R) :- 
    setof(Y, (padre_de(Y, X) ; madre_de(Y, X)), Padres),
    atomic_list_concat(Padres, ', ', PadresStr),
    format(atom(R), '-- Eliza: Los padres de ~w son: ~w.', [X, PadresStr]).
padres_de(X, '-- Eliza: No se encontraron padres para esta persona.') :- 
    \+ (padre_de(_, X) ; madre_de(_, X)).



%----------------------------------------
% Base de conocimiento del árbol familiar
%-----------------------------------------

% Padres de Lucero y Gabriel
padre_de(jose_guadalupe, lucero).
padre_de(jose_guadalupe, gabriel).
madre_de(yolanda, lucero).
madre_de(yolanda, gabriel).

% Hermana y hermano de Yolanda
hermana_de(faviola, yolanda).
hermana_de(yolanda, faviola).
hermano_de(yolanda, julio).

% Tios de Lucero y Gabriel
tio_de(julio, lucero).
tio_de(julio, gabriel).
tio_de(esteban, lucero).
tio_de(esteban, gabriel).
tio_de(gabriel_cornelio, lucero).
tio_de(gabriel_cornelio, gabriel).
tio_de(juan, lucero).
tio_de(juan, gabriel).


% Tias de Lucero y Gabriel
tia_de(faviola, lucero).
tia_de(faviola, gabriel).
tia_de(antonia, lucero).
tia_de(antonia, gabriel).

% Tios de jose_luis y eli
tio_de(julio, jose_luis).
tio_de(julio, eli).
tio_de(esteban, jose_luis).
tio_de(esteban, eli).
tio_de(gabriel_cornelio, jose_luis).
tio_de(gabriel_cornelio, eli).
tio_de(jose_guadalupe, jose_luis).
tio_de(jose_guadalupe, eli).
tio_de(juan, jose_luis).
tio_de(juan, eli).


% Tias de jose_luis y eli
tia_de(faviola, jose_luis).
tia_de(faviola, eli).
tia_de(antonia, jose_luis).
tia_de(antonia, eli).
tia_de(yolanda, jose_luis).
tia_de(yolanda, eli).

sobrino_de(lucero,mateo).
sobrino_de(gabriel,mateo).

% Primos de Yolanda
primo_de(yolanda, esteban).
primo_de(yolanda, juan).
primo_de(yolanda, gabriel_cornelio).
prima_de(yolanda, antonia).

% Hijos de Faviola
madre_de(faviola, jose_luis).
madre_de(faviola, eli).

% Hijo de José Luis y su esposa
padre_de(jose_luis, tadeo).
esposa_de(lupita, jose_luis).
esposo_de(jose_luis, lupita).

% Primos de Lucero y Gabriel
primo_de(lucero, jose_luis).
primo_de(lucero, eli).
primo_de(gabriel, jose_luis).
primo_de(gabriel, eli).
primo_de(jose_luis, lucero).
primo_de(jose_luis, gabriel).
primo_de(eli, lucero).
primo_de(eli, gabriel).

% Esposo de Lucero
esposo_de(isair, lucero).
esposa_de(lucero, isair).

% Esposas de Juan y Esteban
esposa_de(guadalupe, juan).
esposo_de(juan, guadalupe).
esposa_de(toña, esteban).
esposo_de(esteban, toña).



% Gabriel Cornelio no tiene esposa
sin_esposa(gabriel_cornelio).

:- main.