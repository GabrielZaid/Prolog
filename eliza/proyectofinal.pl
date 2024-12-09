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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plantillas
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Preguntas sobre investigadores
plantilla([cual, es, el, descubrimiento, de, s(N), '?'], [flagDescubrimiento], [5]).
plantilla([de, que, pais, es, s(N), '?'], [flagPaisInvestigador], [4]).
plantilla([que, instrumento, utiliza, s(N), '?'], [flagInstrumento], [4]).
plantilla([cual, es, la, especialidad, secundaria, de, s(N), '?'], [flagEspecialidadSecundaria], [6]).
plantilla([s(N), es, de, s(N), '?'], [flagEsDePais], [0, 3]).
plantilla([s(N), utiliza, s(N), '?'], [flagUtilizaInstrumento], [0, 2]).
plantilla([s(N), esta, interesado, en, s(N), '?'], [flagInteresInvestigador], [0, 4]).

% Explicación de la especialidad de un medico
plantilla([cual, es, la, especialidad, de, s(N), '?'], [flagEspecialidadMedico], [5]).
plantilla([en, que, hospital, trabaja, s(N), '?'], [flagHospitalMedico], [5]).
plantilla([que, equipo, utiliza, s(N), '?'], [flagEquipoMedico], [5]).
plantilla([cual, es, el, interes, de, investigacion, de, s(N), '?'], [flagInteresMedico], [8]).
plantilla([s(N), esta, interesado, en, s(N), '?'], [flagEsInteresDeMedico], [0, 4]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plantillas para respuestas sobre el árbol familiar
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plantilla([quienes, son, los, hijos, de, s(N), '?'], [flagHijos], [5]).
plantilla([quienes, son, los, hermanos, de, s(N), '?'], [flagHermanos], [5]).
plantilla([quienes, son, los, tios, de, s(N), '?'], [flagTios], [5]).
plantilla([quienes, son, los, abuelos, de, s(N), '?'], [flagAbuelos], [5]).
plantilla([quienes, son, los, sobrinos, de, s(N), '?'], [flagSobrinos], [5]).
plantilla([quienes, son, los, primos, de, s(N), '?'], [flagPrimos], [5]).
plantilla([quienes, son, los, nietos, de, s(N), '?'], [flagNietos], [5]).

% Caso general para entradas desconocidas
plantilla(_, ['Por favor explica un poco más.'], []).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Predicado para coincidencia de patrones
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Deducción de medicos, especialidades, hospitales, equipos e intereses
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

replace0([Indice|_], Entrada, _, [flagEspecialidadMedico], Resultado) :-
    nth0(Indice, Entrada, Medico),
    especialidad_de_medico(Medico, Resultado), !.

replace0([Indice|_], Entrada, _, [flagHospitalMedico], Resultado) :-
    nth0(Indice, Entrada, Medico),
    hospital_de_medico(Medico, Resultado), !.

replace0([Indice|_], Entrada, _, [flagEquipoMedico], Resultado) :-
    nth0(Indice, Entrada, Medico),
    equipo_favorito_de_medico(Medico, Resultado), !.

replace0([Indice|_], Entrada, _, [flagInteresMedico], Resultado) :-
    nth0(Indice, Entrada, Medico),
    interes_de_medico(Medico, Resultado), !.

replace0([Indice, Indice2|_], Entrada, _, [flagEsInteresDeMedico], Resultado) :-
    nth0(Indice, Entrada, Interes),
    nth0(Indice2, Entrada, Medico),
    es_interes_de(Medico, Interes, Resultado), !.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reglas de deducción
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Determina la especialidad de un medico
especialidad_de_medico(Medico, Respuesta) :-
    medico(Medico),
    especialista(Medico, Especialidad),
    format(atom(Respuesta), '-- Eliza: La especialidad de ~w es ~w.', [Medico, Especialidad]).
especialidad_de_medico(_, '-- Eliza: No se pudo determinar la especialidad del medico.').

% Determina el hospital donde trabaja un medico
hospital_de_medico(Medico, Respuesta) :-
    medico(Medico),
    trabaja_en(Medico, Especialidad, Hospital),
    format(atom(Respuesta), '-- Eliza: ~w trabaja en el hospital ~w como especialista en ~w.', [Medico, Hospital, Especialidad]).
hospital_de_medico(_, '-- Eliza: No se pudo determinar el hospital del medico.').

% Determina el equipo favorito de un medico
equipo_favorito_de_medico(Medico, Respuesta) :-
    medico(Medico),
    utiliza(Equipo, Especialidad, _),
    especialista(Medico, Especialidad),
    format(atom(Respuesta), '-- Eliza: El equipo favorito de ~w es ~w.', [Medico, Equipo]).
equipo_favorito_de_medico(_, '-- Eliza: No se pudo determinar el equipo medico favorito.').

% Determina el interes de investigación de un medico
interes_de_medico(Medico, Respuesta) :-
    medico(Medico),
    interes_de(Medico, Interes),
    format(atom(Respuesta), '-- Eliza: El interés de investigación de ~w es ~w.', [Medico, Interes]).
interes_de_medico(_, '-- Eliza: No se pudo determinar el interés de investigación del medico.').

% Comprueba si un interes pertenece a un medico
es_interes_de(Medico, Interes, Respuesta) :-
    interes_de(Medico, Interes),
    format(atom(Respuesta), '-- Eliza: ~w está interesado en ~w.', [Medico, Interes]).
es_interes_de(Medico, Interes, Respuesta) :-
    \+ interes_de(Medico, Interes),
    format(atom(Respuesta), '-- Eliza: ~w no está interesado en ~w.', [Medico, Interes]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Deducción de descubrimientos, países, instrumentos y especialidades secundarias
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Descubrimiento del investigador
replace0([Indice|_], Entrada, _, [flagDescubrimiento], Resultado) :-
    nth0(Indice, Entrada, Investigador),
    descubrimiento_de_investigador(Investigador, Resultado), !.

% País de origen del investigador
replace0([Indice|_], Entrada, _, [flagPaisInvestigador], Resultado) :-
    nth0(Indice, Entrada, Investigador),
    pais_de_investigador(Investigador, Resultado), !.

% Instrumento favorito del investigador
replace0([Indice|_], Entrada, _, [flagInstrumento], Resultado) :-
    nth0(Indice, Entrada, Investigador),
    instrumento_de_investigador(Investigador, Resultado), !.

% Especialidad secundaria del investigador
replace0([Indice|_], Entrada, _, [flagEspecialidadSecundaria], Resultado) :-
    nth0(Indice, Entrada, Investigador),
    especialidad_secundaria_de_investigador(Investigador, Resultado), !.

% Comprueba si un investigador es de un país específico
replace0([Indice1, Indice2|_], Entrada, _, [flagEsDePais], Resultado) :-
    nth0(Indice1, Entrada, Investigador),
    nth0(Indice2, Entrada, Pais),
    es_de_pais(Investigador, Pais, Resultado), !.

% Comprueba si un investigador utiliza un instrumento
replace0([Indice1, Indice2|_], Entrada, _, [flagUtilizaInstrumento], Resultado) :-
    nth0(Indice1, Entrada, Investigador),
    nth0(Indice2, Entrada, Instrumento),
    utiliza_instrumento(Investigador, Instrumento, Resultado), !.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reglas de deducción
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Descubrimiento del investigador
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
descubrimiento_de_investigador(Investigador, Respuesta) :-
    investigador(Investigador),
    trabaja_en(Investigador, Descubrimiento),
    format(atom(Respuesta), '-- Eliza: El descubrimiento de ~w es ~w.', [Investigador, Descubrimiento]).
descubrimiento_de_investigador(_, '-- Eliza: No se pudo determinar el descubrimiento del investigador.').

% País del investigador
pais_de_investigador(Investigador, Respuesta) :-
    investigador(Investigador),
    es_de(Investigador, Pais),
    format(atom(Respuesta), '-- Eliza: ~w es de ~w.', [Investigador, Pais]).
pais_de_investigador(_, '-- Eliza: No se pudo determinar el país del investigador.').

% Instrumento favorito
instrumento_de_investigador(Investigador, Respuesta) :-
    investigador(Investigador),
    utiliza(Investigador, Instrumento),
    format(atom(Respuesta), '-- Eliza: ~w utiliza el instrumento ~w.', [Investigador, Instrumento]).
instrumento_de_investigador(_, '-- Eliza: No se pudo determinar el instrumento del investigador.').

% Especialidad secundaria
especialidad_secundaria_de_investigador(Investigador, Respuesta) :-
    investigador(Investigador),
    especialista_en(Investigador, Especialidad),
    format(atom(Respuesta), '-- Eliza: La especialidad secundaria de ~w es ~w.', [Investigador, Especialidad]).
especialidad_secundaria_de_investigador(_, '-- Eliza: No se pudo determinar la especialidad secundaria del investigador.').

% Verifica si un investigador es de un país
es_de_pais(Investigador, Pais, Respuesta) :-
    es_de(Investigador, Pais),
    format(atom(Respuesta), '-- Eliza: Sí, ~w es de ~w.', [Investigador, Pais]).
es_de_pais(Investigador, Pais, Respuesta) :-
    \+ es_de(Investigador, Pais),
    format(atom(Respuesta), '-- Eliza: No, ~w no es de ~w.', [Investigador, Pais]).

% Verifica si un investigador utiliza un instrumento
utiliza_instrumento(Investigador, Instrumento, Respuesta) :-
    utiliza(Investigador, Instrumento),
    format(atom(Respuesta), '-- Eliza: Sí, ~w utiliza el instrumento ~w.', [Investigador, Instrumento]).
utiliza_instrumento(Investigador, Instrumento, Respuesta) :-
    \+ utiliza(Investigador, Instrumento),
    format(atom(Respuesta), '-- Eliza: No, ~w no utiliza el instrumento ~w.', [Investigador, Instrumento]).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Base de conocimiento (medicos, especialidades, hospitales, equipos e intereses)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Relacion entre medicos y especialidades
especialista(ana, pediatria).
especialista(bruno, neurologia).
especialista(carla, dermatologia).
especialista(diego, microbiologia).
especialista(elena, bioetica).

% Hospitales donde trabajan
trabaja_en(ana, pediatria, regional).
trabaja_en(bruno, neurologia, privado).
trabaja_en(carla, dermatologia, general).
trabaja_en(diego, microbiologia, militar).
trabaja_en(elena, bioetica, universitario).

% Equipos medicos favoritos
utiliza(ecografo, pediatria, regional).
utiliza(resonador, neurologia, privado).
utiliza(dermatoscopio, dermatologia, general).
utiliza(electrocardiografo, microbiologia, militar).
utiliza(tomografo, bioetica, universitario).

% Intereses de investigación
interes_de(ana, genetica).
interes_de(bruno, farmacologia).
interes_de(carla, inmunologia).
interes_de(diego, microbiologia).
interes_de(elena, bioetica).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Arbol familiar Reglas para consulta en el árbol genealógico
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Regla para determinar hijos de un padre/madre
hijos_de(X, R) :- 
    setof(Y, (padre_de(X, Y) ; madre_de(X, Y)), Hijos),
    atomic_list_concat(Hijos, ', ', HijosStr),
    format(atom(R), '-- Eliza: Los hijos de ~w son: ~w.', [X, HijosStr]).
hijos_de(X, '-- Eliza: No se encontraron hijos para esta persona.') :- 
    \+ (padre_de(X, _) ; madre_de(X, _)).

% Reemplazo para hijos
replace0([Indice|_], Entrada, _, Respuesta, Resultado) :- 
    nth0(Indice, Entrada, Atomo),
    nth0(0, Respuesta, X),
    X == flagHijos,
    hijos_de(Atomo, Resultado).

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

% Reemplazo para hermanos
replace0([Indice|_], Entrada, _, Respuesta, Resultado) :- 
    nth0(Indice, Entrada, Atomo),
    nth0(0, Respuesta, X),
    X == flagHermanos,
    hermanos_de(Atomo, Resultado).

% Regla para determinar primos
primo_de(X, Y) :- 
    padre_de(A, X), padre_de(B, Y), hermano_de(A, B).
primo_de(X, Y) :- 
    madre_de(A, X), madre_de(B, Y), hermano_de(A, B).

primos_de(X, R) :- 
    setof(Y, primo_de(X, Y), Primos),
    atomic_list_concat(Primos, ', ', PrimosStr),
    format(atom(R), '-- Eliza: Los primos de ~w son: ~w.', [X, PrimosStr]).
primos_de(X, '-- Eliza: No se encontraron primos para esta persona.') :- 
    \+ primo_de(X, _).

% Reemplazo para primos
replace0([Indice|_], Entrada, _, Respuesta, Resultado) :- 
    nth0(Indice, Entrada, Atomo),
    nth0(0, Respuesta, X),
    X == flagPrimos,
    primos_de(Atomo, Resultado).

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

% Reemplazo para tíos
replace0([Indice|_], Entrada, _, Respuesta, Resultado) :- 
    nth0(Indice, Entrada, Atomo),
    nth0(0, Respuesta, X),
    X == flagTios,
    tios_de(Atomo, Resultado).

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

% Reemplazo para abuelos
replace0([Indice|_], Entrada, _, Respuesta, Resultado) :- 
    nth0(Indice, Entrada, Atomo),
    nth0(0, Respuesta, X),
    X == flagAbuelos,
    abuelos_de(Atomo, Resultado).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Base de conocimiento del árbol familiar
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Padres de Lucero y Gabriel
padre_de(jose_guadalupe, lucero).
padre_de(jose_guadalupe, gabriel).
madre_de(yolanda, lucero).
madre_de(yolanda, gabriel).

% Hermana y hermano de Yolanda
hermana_de(yolanda, faviola).
hermano_de(yolanda, julio).

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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% medicos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
medico(ana).
medico(bruno).
medico(carla).
medico(diego).
medico(elena).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Especialidades medicas
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
especialidad(cardiologia).
especialidad(neurologia).
especialidad(oncologia).
especialidad(pediatria).
especialidad(dermatologia).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hospitales
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hospital(general).
hospital(regional).
hospital(universitario).
hospital(privado).
hospital(militar).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Equipos medicos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
equipo(ecografo).
equipo(resonador).
equipo(tomografo).
equipo(dermatoscopio).
equipo(electrocardiografo).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Intereses de investigación
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
interes(genetica).
interes(farmacologia).
interes(inmunologia).
interes(bioetica).
interes(microbiologia).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Pistas
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Carla no trabaja en el Hospital General ni en el Privado, y no estudia neurología.
no_trabaja(carla, general).
no_trabaja(carla, privado).
no_estudia(carla, neurologia).

% La persona que utiliza el electrocardiógrafo trabaja en cardiología en el Hospital Militar, pero no es Diego.
utiliza(electrocardiografo, cardiologia, militar).
no_utiliza(diego, electrocardiografo).

% Bruno está interesado en farmacología, pero no trabaja en el Hospital Regional ni en el Militar.
interes_de(bruno, farmacologia).
no_trabaja(bruno, regional).
no_trabaja(bruno, militar).

% La persona que utiliza el ecógrafo trabaja en pediatría y no es del Hospital Universitario ni del Militar.
utiliza(ecografo, pediatria, _).
no_trabaja(_, universitario).
no_trabaja(_, militar).

% El especialista en oncología trabaja en el Hospital General y utiliza un tomógrafo.
especialista(oncologia, general).
utiliza(tomografo, oncologia, general).

% El medico interesado en inmunología usa el resonador magnético, pero no es Elena.
interes_de(_, inmunologia).
utiliza(resonador, _, _).
no_utiliza(elena, resonador).

% El medico del Hospital Regional se dedica a dermatología.
trabaja_en(_, dermatologia, regional).

% Elena está interesada en bioética y no utiliza el electrocardiógrafo.
interes_de(elena, bioetica).
no_utiliza(elena, electrocardiografo).

% Diego es el experto en microbiología.
interes_de(diego, microbiologia).

% El medico del Hospital Universitario utiliza un dermatoscopio.
trabaja_en(_, _, universitario).
utiliza(dermatoscopio, _, universitario).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Regla para deducción
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Determina quién trabaja en qué especialidad, hospital, equipo e interés.
asignar(Medico, Especialidad, Hospital, Equipo, Interes) :-
    medico(Medico),
    especialidad(Especialidad),
    hospital(Hospital),
    equipo(Equipo),
    interes(Interes),
    not(no_trabaja(Medico, Hospital)),
    not(no_estudia(Medico, Especialidad)),
    not(no_utiliza(Medico, Equipo)),
    interes_de(Medico, Interes),
    utiliza(Equipo, Especialidad, Hospital).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Base de conocimiento de Investigadores
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
investigador(alonso).
investigador(beatriz).
investigador(carlos).
investigador(diana).
investigador(eduardo).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Áreas de descubrimiento
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
area(astronomia).
area(biologia).
area(quimica).
area(fisica).
area(geologia).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Países de origen
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pais(mexico).
pais(espana).
pais(canada).
pais(japon).
pais(alemania).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Instrumentos favoritos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
instrumento(microscopio).
instrumento(telescopio).
instrumento(acelerador).
instrumento(sismografo).
instrumento(espectrometro).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Especialidades secundarias
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
especialidad(botanica).
especialidad(genetica).
especialidad(oceanografia).
especialidad(paleontologia).
especialidad(vulcanologia).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Pistas
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Carlos no es de México ni de Canadá, y no estudia biología.
no_es_de(carlos, mexico).
no_es_de(carlos, canada).
no_estudia(carlos, biologia).

% 2. La persona que usa el telescopio es de Japón y trabaja en astronomía, pero no es Diana.
usa(telescopio, astronomia).
es_de(_, japon).
no_es(diana, telescopio).

% 3. Beatriz es experta en botánica y no es de España ni de Japón.
especialista_en(beatriz, botanica).
no_es_de(beatriz, espana).
no_es_de(beatriz, japon).

% 4. La persona que usa el microscopio trabaja en biología y no es de Alemania ni de España.
usa(microscopio, biologia).
no_es_de(_, alemania).
no_es_de(_, espana).

% 5. El investigador de física es de México y utiliza el acelerador.
es_de(_, mexico).
usa(acelerador, fisica).

% 6. El especialista en genética usa el espectrómetro y no es Eduardo.
especialista_en(_, genetica).
usa(espectrometro, genetica).
no_es(eduardo, genetica).

% 7. El investigador de Canadá se dedica a la geología.
es_de(_, canada).
trabaja_en(_, geologia).

% 8. Eduardo estudia vulcanología y no utiliza el telescopio.
especialista_en(eduardo, vulcanologia).
no_usa(eduardo, telescopio).

% 9. Alonso es el experto en oceanografía.
especialista_en(alonso, oceanografia).

% 10. El investigador de Alemania utiliza un sismógrafo.
es_de(_, alemania).
usa(sismografo, _).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Regla principal para determinar las combinaciones
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Asigna descubrimientos, países, instrumentos y especialidades
asignar(Investigador, Area, Pais, Instrumento, Especialidad) :-
    investigador(Investigador),
    area(Area),
    pais(Pais),
    instrumento(Instrumento),
    especialidad(Especialidad),
    not(no_es_de(Investigador, Pais)),
    not(no_estudia(Investigador, Area)),
    not(no_usa(Investigador, Instrumento)),
    especialista_en(Investigador, Especialidad),
    usa(Instrumento, Area),
    trabaja_en(Area, Pais).

% Validaciones basadas en las pistas
validar :-
    asignar(Investigador, Area, Pais, Instrumento, Especialidad),
    format('~w trabaja en ~w, es de ~w, usa ~w y su especialidad secundaria es ~w.~n',
           [Investigador, Area, Pais, Instrumento, Especialidad]).
