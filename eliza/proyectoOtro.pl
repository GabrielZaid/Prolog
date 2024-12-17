/******************************************************************************

                            Online Prolog Compiler.
                Code, Compile, Run and Debug Prolog program online.
Write your code in this editor and press "Run" button to execute it.

*******************************************************************************/

% Predicado principal
main :-
    eliza,
    halt.

eliza :-
    writeln('Hola, mi nombre es Eliza, tu chatbot.'),
    writeln('Por favor ingresa tu consulta (usar solo minusculas sin . al final):'),
    readln(Entrada),
    eliza(Entrada).

eliza(Entrada) :-
    member('adios', Entrada),
    writeln('Adios. Espero haber podido ayudarte.'), !.

eliza(Entrada) :-
    findall(Patron, plantilla(Patron, _, _), Patrones),
    encontrar_plantilla(Entrada, Patrones, Patron),
    plantilla(Patron, Respuesta, IndicesPatron),
    replace0(IndicesPatron, Entrada, 0, Respuesta, RespuestaFinal),
    writeln(RespuestaFinal),
    readln(NuevaEntrada),
    eliza(NuevaEntrada), !.

% Encuentra la plantilla que coincide con la entrada
encontrar_plantilla(Entrada, [Patron|_], Patron) :-
    coincide(Patron, Entrada), !.
encontrar_plantilla(Entrada, [_|RestoPatrones], Patron) :-
    encontrar_plantilla(Entrada, RestoPatrones, Patron).

% Coincidencia entre entrada y patrón
coincide([], []).
coincide([s(_)|RestoPatron], [_|RestoEntrada]) :-
    coincide(RestoPatron, RestoEntrada), !.
coincide([Palabra|RestoPatron], [Palabra|RestoEntrada]) :-
    coincide(RestoPatron, RestoEntrada).

% Sustitución en la respuesta de los flags por los valores correspondientes de medicos
replace0([], _, _, Respuesta, Respuesta).
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

replace0([Indice|_], Entrada, _, [flagMedicosExisten], Resultado) :-
    existen_medicos(Resultado), !.

replace0([Indice|_], Entrada, _, [flagEspecialidadesExisten], Resultado) :-
    existen_especialidades(Resultado), !.

replace0([Indice|_], Entrada, _, [flagHospitalesExisten], Resultado) :-
    existen_hospitales(Resultado), !.

replace0([Indice|_], Entrada, _, [flagEquiposExistentes], Resultado) :-
    existen_equipos(Resultado), !.

replace0([Indice|_], Entrada, _, [flagInteresesExistentes], Resultado) :-
    existen_intereses(Resultado), !.

% Plantillas
plantilla([cuales, medicos, existen, '?'], [flagMedicosExisten], [3]).
plantilla([dime, cuales, medicos, existen, '?'], [flagMedicosExisten], [3]).
plantilla([cuales, medicos, conoces, '?'], [flagMedicosExisten], [3]).
plantilla([dime, cuales, medicos, conoces, '?'], [flagMedicosExisten], [3]).

plantilla([cuales, especialidades, existen, '?'], [flagEspecialidadesExisten], [3]).
plantilla([cuales, especialidades, conoces, '?'], [flagEspecialidadesExisten], [3]).
plantilla([dime, cuales, especialidades, existen, '?'], [flagEspecialidadesExisten], [3]).
plantilla([dime, cuales, especialidades, conoces, '?'], [flagEspecialidadesExisten], [3]).

plantilla([cuales, hospitales, existen, '?'], [flagHospitalesExisten], [3]).
plantilla([cuales, hospitales, conoces, '?'], [flagHospitalesExisten], [3]).
plantilla([dime, cuales, hospitales, existen, '?'], [flagHospitalesExisten], [3]).
plantilla([dime, cuales, hospitales, conoces, '?'], [flagHospitalesExisten], [3]).

plantilla([cuales, equipos, existen, '?'], [flagEquiposExistentes], [3]).
plantilla([cuales, equipos, conoces, '?'], [flagEquiposExistentes], [3]).
plantilla([dime, cuales, equipos, existen, '?'], [flagEquiposExistentes], [3]).
plantilla([dime, cuales, equipos, conoces, '?'], [flagEquiposExistentes], [3]).

plantilla([cuales, intereses, existen, '?'], [flagInteresesExistentes], [3]).
plantilla([cuales, intereses, conoces, '?'], [flagInteresesExistentes], [3]).
plantilla([dime, cuales, intereses, existen, '?'], [flagInteresesExistentes], [3]).
plantilla([dime, cuales, intereses, conoces, '?'], [flagInteresesExistentes], [3]).
plantilla([cuales, intereses, de, investigacion, existen, '?'], [flagInteresesExistentes], [5]).
plantilla([cuales, intereses, de, investigacion, conoces, '?'], [flagInteresesExistentes], [5]).
plantilla([dime, cuales, intereses, de, investigacion, existen, '?'], [flagInteresesExistentes], [5]).
plantilla([dime, cuales, intereses, de, investigacion, conoces, '?'], [flagInteresesExistentes], [5]).
plantilla([cuales, son, los, intereses, de, investigacion, existentes, '?'], [flagInteresesExistentes], [6]).


plantilla([cual, es, la, especialidad, de, s(N), '?'], [flagEspecialidadMedico], [5]).
plantilla([dime, cual, es, la, especialidad, de, s(N), '?'], [flagEspecialidadMedico], [6]).
plantilla([en, que, se, especializo, s(N), '?'], [flagEspecialidadMedico], [4]).
plantilla([que, especialidad, tiene, s(N), '?'], [flagEspecialidadMedico], [3]).
plantilla([sabes, cual, es, la, especialidad, de, s(N), '?'], [flagEspecialidadMedico], [6]).

plantilla([donde, trabaja, s(N), '?'], [flagHospitalMedico], [2]).
plantilla([en, que, lugar, trabaja, s(N), '?'], [flagHospitalMedico], [4]).
plantilla([dime, donde, trabaja, s(N), '?'], [flagHospitalMedico], [3]).
plantilla([sabes, donde, trabaja, s(N), '?'], [flagHospitalMedico], [3]).
plantilla([cual, es, el, lugar, de, trabajo, de, s(N), '?'], [flagHospitalMedico], [7]).

plantilla([que, equipo, utiliza, s(N), '?'], [flagEquipoMedico], [3]).
plantilla([dime, que, equipo, utiliza, s(N), '?'], [flagEquipoMedico], [4]).
plantilla([sabes, que, equipo, utiliza, s(N), '?'], [flagEquipoMedico], [4]).
plantilla([cual, es, el, equipo, que, utiliza, s(N), '?'], [flagEquipoMedico], [6]).
plantilla([que, instrumento, usa, s(N), '?'], [flagEquipoMedico], [3]).

plantilla([cual, es, el, interes, de, investigacion, de, s(N), '?'], [flagInteresMedico], [7]).
plantilla([dime, cual, es, el, interes, de, investigacion, de, s(N), '?'], [flagInteresMedico], [8]).
plantilla([en, que, esta, interesado, s(N), '?'], [flagInteresMedico], [5]).
plantilla([sabes, cual, es, el, interes, de, investigacion, de, s(N), '?'], [flagInteresMedico], [8]).
plantilla([que, area, de, investigacion, le, interesa, a, s(N), '?'], [flagInteresMedico], [9]).

plantilla([s(N), esta, interesado, en, s(N), '?'], [flagEsInteresDeMedico], [0, 4]).
plantilla([dime, si, s(N), esta, interesado, en, s(N), '?'], [flagEsInteresDeMedico], [2, 6]).
plantilla([sabes, si, s(N), esta, interesado, en, s(N), '?'], [flagEsInteresDeMedico], [2, 6]).
plantilla([es, s(N), interesado, en, s(N), '?'], [flagEsInteresDeMedico], [1, 5]).
plantilla([puedes, decirme, si, s(N), esta, interesado, en, s(N), '?'], [flagEsInteresDeMedico], [3, 7]).


% Reglas de deducción de medicos y sus atributos
especialidad_de_medico(Medico, Respuesta) :-
    especialista(Medico, Especialidad),
    format(atom(Respuesta), '-- Eliza: La especialidad de ~w es ~w.', [Medico, Especialidad]), !.
especialidad_de_medico(_, '-- Eliza: No se pudo determinar la especialidad del médico.').

hospital_de_medico(Medico, Respuesta) :-
    trabaja_en(Medico, _, Hospital),
    format(atom(Respuesta), '-- Eliza: ~w trabaja en el hospital ~w.', [Medico, Hospital]), !.
hospital_de_medico(_, '-- Eliza: No se pudo determinar el hospital del médico.').

equipo_favorito_de_medico(Medico, Respuesta) :-
    especialista(Medico, Especialidad),
    utiliza(Equipo, Especialidad, _),
    format(atom(Respuesta), '-- Eliza: El equipo favorito de ~w es ~w.', [Medico, Equipo]), !.
equipo_favorito_de_medico(_, '-- Eliza: No se pudo determinar el equipo favorito del médico.').

interes_de_medico(Medico, Respuesta) :-
    interes_de(Medico, Interes),
    format(atom(Respuesta), '-- Eliza: El interés de investigación de ~w es ~w.', [Medico, Interes]), !.
interes_de_medico(_, '-- Eliza: No se pudo determinar el interés de investigación del médico.').

es_interes_de(Medico, Interes, Respuesta) :-
    interes_de(Interes, Medico),
    format(atom(Respuesta), '-- Eliza: Si, ~w está interesado en investigar ~w.', [Interes, Medico]), !.
es_interes_de(Medico, Interes, Respuesta) :-
    format(atom(Respuesta), '-- Eliza: ~w no está interesado en ~w.', [Interes, Medico]).

existen_medicos(Respuesta) :-
    findall(Medicos, medico(Medicos), ListaMedicos),
    (   ListaMedicos \= [] ->
        atomic_list_concat(ListaMedicos, ', ', MedicosStr),
        format(atom(Respuesta), '-- Eliza: Los medicos existentes son: ~w.', [MedicosStr])
    ;   Respuesta = '-- Eliza: No se encontraron medicos registrados.'
    ).

existen_especialidades(Respuesta) :-
    findall(Especialidades, especialidad(Especialidades), ListaEspecialidades),
    (   ListaEspecialidades \= [] ->
        atomic_list_concat(ListaEspecialidades, ', ', EspecialidadesStr),
        format(atom(Respuesta), '-- Eliza: Las Especialidades existentes son: ~w.', [EspecialidadesStr])
    ;   Respuesta = '-- Eliza: No se encontraron Especialidades registradas.'
    ).

existen_hospitales(Respuesta) :-
    findall(Hospitales, hospital(Hospitales), ListaHospitales),
    (   ListaHospitales \= [] ->
        atomic_list_concat(ListaHospitales, ', ', HospitalesStr),
        format(atom(Respuesta), '-- Eliza: Los Hospitales existentes son: ~w.', [HospitalesStr])
    ;   Respuesta = '-- Eliza: No se encontraron Hospitales registrados.'
    ).

existen_equipos(Respuesta) :-
    findall(Equipos, equipo(Equipos), ListaEquipos),
    (   ListaEquipos \= [] ->
        atomic_list_concat(ListaEquipos, ', ', EquiposStr),
        format(atom(Respuesta), '-- Eliza: Los Equipos existentes son: ~w.', [EquiposStr])
    ;   Respuesta = '-- Eliza: No se encontraron Equipos registrados.'
    ).

existen_intereses(Respuesta) :-
    findall(Intereses, interes(Intereses), ListaIntereses),
    (   ListaIntereses \= [] ->
        atomic_list_concat(ListaIntereses, ', ', InteresesStr),
        format(atom(Respuesta), '-- Eliza: Los Intereses existentes son: ~w.', [InteresesStr])
    ;   Respuesta = '-- Eliza: No se encontraron Intereses registrados.'
    ).


% Base de conocimiento de los medicos --------------------------------------------------------------------------
especialista(ana, pediatria).
especialista(bruno, neurologia).
especialista(carla, dermatologia).
especialista(diego, microbiologia).
especialista(elena, bioetica).

trabaja_en(ana, pediatria, regional).
trabaja_en(bruno, neurologia, privado).
trabaja_en(carla, dermatologia, general).
trabaja_en(diego, microbiologia, militar).
trabaja_en(elena, bioetica, universitario).

utiliza(ecografo, pediatria, regional).
utiliza(resonador, neurologia, privado).
utiliza(dermatoscopio, dermatologia, general).
utiliza(electrocardiografo, microbiologia, militar).
utiliza(tomografo, bioetica, universitario).

interes_de(ana, genetica).
interes_de(bruno, farmacologia).
interes_de(carla, inmunologia).
interes_de(diego, microbiologia).
interes_de(elena, bioetica).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
% Médicos  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
medico(ana).  
medico(bruno).  
medico(carla).  
medico(diego).  
medico(elena).  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
% Especialidades médicas  
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
% Equipos médicos  
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

% El médico interesado en inmunología usa el resonador magnético, pero no es Elena.  
interes_de(_, inmunologia).  
utiliza(resonador, _, _).  
no_utiliza(elena, resonador).  

% El médico del Hospital Regional se dedica a dermatología.  
trabaja_en(_, dermatologia, regional).  

% Elena está interesada en bioética y no utiliza el electrocardiógrafo.  
interes_de(elena, bioetica).  
no_utiliza(elena, electrocardiografo).  

% Diego es el experto en microbiología.  
interes_de(diego, microbiologia).  

% El médico del Hospital Universitario utiliza un dermatoscopio.  
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
