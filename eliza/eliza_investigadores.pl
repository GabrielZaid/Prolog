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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plantillas
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plantilla([de, investigadores,'?'], ['--Eliza: ¡Si!, puedes hacer preguntas como "cuales investigadores existen?", "que hace un investigador?", "de que pais es s(N) ?"'], []).
plantilla([dime, que, sabes, de, investigadores,'?'], ['--Eliza: ¡Si!, puedes hacer preguntas como "cuales investigadores existen?", "que hace un investigador?", "de que pais es s(N) ?"'], []).
plantilla([sobre, investigadores,'?'], ['--Eliza: ¡Claro!, puedes preguntar cosas como "¿quienes son los investigadores mas conocidos?", "¿que hace un investigador?", "¿de que país es s(N)?"'], []).
plantilla([acerca, de, investigadores, '?'], ['--Eliza: ¡Sí!, puedes preguntar por ejemplo "que hacen los investigadores?", "¿quienes son los investigadores ", "¿de que país es s(N)?"'], []).
plantilla([en, cuanto, a, investigadores, '?'], ['--Eliza: ¡Sí!, puedes hacer preguntas como "¿qué es un investigador?", "¿quiénes son los investigadores más influyentes?", "¿de qué país es s(N)?"'], []).
plantilla([de, que, trata, la, investigacion, '?'], ['--Eliza: ¡Sí!, puedes preguntar sobre "¿cómo funciona la investigación?", "¿qué hace un investigador?", "¿quiénes son los investigadores destacados?", "¿de qué país es s(N)?"'], []).
plantilla([sobre, los, investigadores, '?'], ['--Eliza: ¡Sí!, puedes preguntar "¿qué hacen los investigadores?", "¿quiénes son los principales investigadores?", "¿de qué país es s(N)?"'], []).
plantilla([preguntar, sobre, investigadores, '?'], ['--Eliza: ¡Por supuesto! Puedes preguntar "¿quiénes son los investigadores más conocidos?", "¿qué hace un investigador?", "¿de qué país es s(N)?"'], []).
plantilla([puedo, preguntar, sobre, investigadores, '?'], ['--Eliza: ¡Sí!, puedes hacer preguntas como "¿qué hace un investigador?", "¿quiénes son los más importantes en la investigación?", "¿de qué país es s(N)?"'], []).
plantilla([tienes, informacion, sobre, investigadores, '?'], ['--Eliza: ¡Sí!, puedes preguntar sobre "¿qué hacen los investigadores?", "¿quiénes son los principales?", "¿de qué país es s(N)?"'], []).

% que sabes de mediciona, dime acerca de medicina, que puedes decirme de medicina


% Preguntas sobre investigadores
plantilla([cuales, investigadores, existen,'?'], [flagInvestigadores], [3]).
plantilla([dime, que, investigadores, hay,'?'], [flagInvestigadores], [3]).
plantilla([quienes, son, los, investigadores,'?'], [flagInvestigadores], [4]).
plantilla([que, hace, un, investigador, '?'], '--Eliza: se dedica a la investigacion científica', []).
plantilla([que, hacen, los, investigadores, '?'], '--Eliza: se dedica a la investigacion científica', []).
plantilla([cual, es, el, descubrimiento, de, s(N), '?'], [flagDescubrimiento], [5]).
plantilla([de, que, pais, es, s(N), '?'], [flagPaisInvestigador], [4]).
plantilla([que, instrumento, utiliza, s(N), '?'], [flagInstrumento], [4]).
plantilla([cual, es, la, especialidad, secundaria, de, s(N), '?'], [flagEspecialidadSecundaria], [6]).
plantilla([s(N), es, de, s(N), '?'], [flagEsDePais], [0, 3]).
plantilla([s(N), utiliza, s(N), '?'], [flagUtilizaInstrumento], [0, 2]).
plantilla([s(N), esta, interesado, en, s(N), '?'], [flagInteresInvestigador], [0, 4]).


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

%------------- Aquí se implementan las reglas de deducción para los investigadores -------------%
replace0([Indice|_], Entrada, _, [flagInvestigadores], Resultado) :-
    existen_investigadores(Resultado), !.

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
% Regla para listar todos los investigadores
existen_investigadores(Respuesta) :-
    findall(Investigador, investigador(Investigador), ListaInvestigadores),
    (   ListaInvestigadores \= [] ->
        atomic_list_concat(ListaInvestigadores, ', ', InvestigadoresStr),
        format(atom(Respuesta), '-- Eliza: Los investigadores existentes son: ~w.', [InvestigadoresStr])
    ;   Respuesta = '-- Eliza: No se encontraron investigadores registrados.'
    ).

descubrimiento_de_investigador(Investigador, Respuesta) :-
    investigador(Investigador),
    trabaja_en(Investigador, Descubrimiento),
    format(atom(Respuesta), '-- Eliza: El descubrimiento de ~w es ~w.', [Investigador, Descubrimiento]).
descubrimiento_de_investigador(_, '-- Eliza: No se pudo determinar el descubrimiento del investigador.').

% País del investigador
pais_de_investigador(Investigador, Respuesta) :-
    investigador(Investigador),
    findall(Pais, es_de(Investigador, Pais), Paises), % Obtén todos los países posibles
    (   % Si el investigador tiene un único país asignado
        length(Paises, 1) -> 
        format(atom(Respuesta), '-- Eliza: ~w es de ~w.', [Investigador, Paises]),
        !
    ;   % Si tiene múltiples países posibles, aplicar restricciones adicionales
        validacion_paises(Investigador, Paises, Respuesta)
    ).

validacion_paises(Investigador, [Pais|_], Respuesta) :- 
    not(no_es_de(Investigador, Pais)), % Si no está excluido de ese país
    format(atom(Respuesta), '-- Eliza: ~w es de ~w.', [Investigador, Pais]), 
    !.
validacion_paises(_, _, '-- Eliza: No se pudo determinar el país del investigador.').


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

:- main.