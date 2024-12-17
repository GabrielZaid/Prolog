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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plantillas
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Plantillas para respuestas x
plantilla([hola, eliza], ['--Eliza: ¡Hola! ¿Cómo te puedo ayudar hoy?'], []).
plantilla([hola, amiga, eliza], ['--Eliza: ¡Hola! ¿Cómo te puedo ayudar hoy?'], []).
plantilla([que, tal, amiga, eliza], ['--Eliza: ¡Hola! ¿Cómo te puedo ayudar hoy?'], []).
plantilla([hola, querida, eliza], ['--Eliza: ¡Hola! ¿Cómo te puedo ayudar hoy?'], []).
plantilla([buenos, dias, eliza], ['--Eliza: ¡Buenos días! ¿Cómo te puedo ayudar hoy?'], []).
plantilla([buenas, tardes, eliza], ['--Eliza: ¡Buenas tardes! ¿Cómo te puedo ayudar hoy?'], []).
plantilla([buenas, noches, eliza], ['--Eliza: ¡Buenas noches! ¿Cómo te puedo ayudar hoy?'], []).
plantilla([que, tal, eliza], ['--Eliza: ¡Hola! ¿Cómo te puedo ayudar hoy?'], []).
plantilla([como, estas, eliza], ['--Eliza: ¡Hola! ¿Cómo te puedo ayudar hoy?'], []).
plantilla([como, estas, eliza, '?'], ['--Eliza: ¡Hola! ¿Cómo te puedo ayudar hoy?'], []).
plantilla([hey, eliza], ['--Eliza: ¡Hey! ¿En qué te puedo ayudar?'], []).
plantilla([saludos, eliza], ['--Eliza: ¡Saludos! ¿Cómo te puedo ayudar hoy?'], []).
plantilla([yo, pienso, que, _], ['--Eliza: No son tan inútiles, ¿puedes explicarlo más?'], []).
plantilla([me, gustaria, saber, que, puedes, hacer], ['--Eliza: Puedo hacer poco, pero me puedes preguntar acerca de medicina y un árbol familiar. puedes hacer preguntas como, cuales medicos existen? y lo mismo para la familia'], []).
plantilla([que, puedes, hacer, eliza], ['--Eliza: Puedo hacer poco, pero me puedes preguntar acerca de medicina y un árbol familiar. puedes hacer preguntas como, cuales medicos existen? y lo mismo para la familia'], []).
plantilla([que, sabes, hacer, eliza], ['--Eliza: Puedo hacer poco, pero me puedes preguntar acerca de medicina y un árbol familiar. puedes hacer preguntas como, cuales medicos existen? y lo mismo para la familia'], []).
plantilla([que, puedes, hacer, por, mi], ['--Eliza: Puedo hacer poco, pero me puedes preguntar acerca de medicina y un árbol familiar. puedes hacer preguntas como, cuales medicos existen? y lo mismo para la familia'], []).
plantilla([me, puedes, contar, que, puedes, hacer], ['--Eliza: Puedo hacer poco, pero me puedes preguntar acerca de medicina y un árbol familiar. puedes hacer preguntas como, cuales medicos existen? y lo mismo para la familia'], []).
plantilla([me, gustaria, saber, mas, sobre, ti], ['--Eliza: Puedo hacer poco, pero me puedes preguntar acerca de medicina y un árbol familiar. puedes hacer preguntas como, cuales medicos existen? y lo mismo para la familia'], []).
plantilla([que, te, gustaria, hacer, eliza], ['--Eliza: Puedo hacer poco, pero me puedes preguntar acerca de medicina y un árbol familiar. puedes hacer preguntas como, cuales medicos existen? y lo mismo para la familia'], []).
plantilla([me, gustaria, saber, que, puedes, hacer], ['--Eliza: Puedo hacer poco, pero me puedes preguntar acerca de medicina y un árbol familiar. puedes hacer preguntas como, cuales medicos existen? y lo mismo para la familia'], []).
plantilla([que, puedes, hacer, en, general], ['--Eliza: Puedo hacer poco, pero me puedes preguntar acerca de medicina y un árbol familiar. puedes hacer preguntas como, cuales medicos existen? y lo mismo para la familia'], []).
plantilla([que, puedes, hacer, '?'], ['--Eliza: Puedo hacer poco, pero me puedes preguntar acerca de medicina y un árbol familiar. puedes hacer preguntas como, cuales medicos existen? y lo mismo para la familia'], []).
plantilla([que, sabes, hacer, especificamente], ['--Eliza: Puedo hacer poco, pero me puedes preguntar acerca de medicina y un árbol familiar. puedes hacer preguntas como, cuales medicos existen? y lo mismo para la familia'], []).
plantilla([puedes, ayudarme, con, algo], ['--Eliza: Puedo hacer poco, pero me puedes preguntar acerca de medicina y un árbol familiar. puedes hacer preguntas como, cuales medicos existen? y lo mismo para la familia'], []).
plantilla([me, puedes, decir, lo, que, sabes, hacer], ['--Eliza: Puedo hacer poco, pero me puedes preguntar acerca de medicina y un árbol familiar. puedes hacer preguntas como, cuales medicos existen? y lo mismo para la familia'], []).
plantilla([yo, creo, que, _,__,__,__,__,__,__,__,_], ['--Eliza: No son tan inútiles, ¿puedes explicarlo más?'], []).
plantilla([me, parece, que, _], ['--Eliza: No son tan inútiles, ¿puedes explicarlo más?'], []).
plantilla([porque, _], ['--Eliza: Esa no es una buena razón.'], []).
plantilla([ya que, _], ['--Eliza: Esa no es una buena razón.'], []).
plantilla([debido, a, _], ['--Eliza: Esa no es una buena razón.'], []).
plantilla([yo, tengo, s(_), con, s(_), '.'], ['--Eliza: Tienes que lidiar con tu', 0, 'y tu', 1, 'de una manera madura.'], [2, 4]).
plantilla([yo, sufro, con, s(_), en, s(_), '.'], ['--Eliza: Tienes que lidiar con tu', 0, 'y tu', 1, 'de una manera madura.'], [2, 4]).
plantilla([yo, lidio, con, s(_), en, s(_), '.'], ['--Eliza: Tienes que lidiar con tu', 0, 'y tu', 1, 'de una manera madura.'], [2, 4]).
plantilla([yo, s(_), _], ['--Eliza: Puedo recomendarte un libro sobre ese tema.'], []).
plantilla([yo, me, siento, _], ['--Eliza: Puedo recomendarte un libro sobre ese tema.'], []).
plantilla([yo, estoy, _], ['--Eliza: Puedo recomendarte un libro sobre ese tema.'], []).
plantilla([por, favor, s(_), _], ['--Eliza: No puedo ayudar, soy solo una máquina.'], []).
plantilla([dime, un, s(_), _], ['--Eliza: No puedo, soy malo en eso.'], []).
plantilla([como, ha, sido, tu, dia, hoy, '?'], ['--Eliza: Cuéntame un poco sobre tu día.'], []).
plantilla([que, tal, tu, dia, hoy, '?'], ['--Eliza: Cuéntame un poco sobre tu día.'], []).
plantilla([como, te, va, hoy, '?'], ['--Eliza: Cuéntame un poco sobre tu día.'], []).
plantilla([que, planes, tienes, para, el, fin, de, semana, '?'], ['--Eliza: Me gustaría encontrar los números de la lotería.'], []).
plantilla([que, opinas, sobre, el, clima, de, hoy, '?'], ['--Eliza: El clima es un tema interesante, ¿no crees?'], []).
plantilla([has, escuchado, alguna, cancion, nueva, recientemente, '?'], ['--Eliza: Estoy interesado en conocer tu opinión sobre música.'], []).
plantilla([has, visto, alguna, pelicula, interesante, ultimamente, '?'], ['--Eliza: Me encantaría escuchar tu recomendación de película.'], []).
plantilla([que, has, estado, haciendo, ultimamente, '?'], ['--Eliza: Cuéntame un poco sobre tus actividades recientes.'], []).
plantilla([tienes, algun, pasatiempo, favorito, '?'], ['--Eliza: Me gusta aprender sobre los intereses de las personas.'], []).
plantilla([has, probado, alguna, comida, nueva, ultimamente, '?'], ['--Eliza: La comida siempre es un buen tema de conversación.'], []).
plantilla([cual, es, tu, lugar, favorito, para, relajarte, '?'], ['--Eliza: Me gusta saber dónde encuentras tranquilidad.'], []).
plantilla([te, gusta, viajar, '?'], ['--Eliza: Los viajes son una experiencia maravillosa, ¿no crees?'], []).
plantilla([que, te, motiva, todos, los, dias, '?'], ['--Eliza: Me interesa saber qué te impulsa en la vida.'], []).
plantilla([tienes, alguna, meta, que, te, gustaria, alcanzar, '?'], ['--Eliza: Las metas son importantes para el crecimiento personal.'], []).
plantilla([como, te, sientes, hoy, '?'], ['--Eliza: Tu bienestar es importante para mí.'], []).
plantilla([cual, es, tu, recuerdo, mas, preciado, '?'], ['--Eliza: Los recuerdos son parte de quienes somos.'], []).
plantilla([tienes, algun, consejo, de, vida, que, quieras, compartir, '?'], ['--Eliza: Los consejos sabios siempre son bienvenidos.'], []).
plantilla([que, significa, la, felicidad, para, ti, '?'], ['--Eliza: La felicidad es un tema profundo. ¿Qué significa para ti?'], []).
plantilla([cual, es, tu, libro, favorito, '?'], ['--Eliza: Los libros nos transportan a otros mundos, ¿cuál es el tuyo?'], []).
plantilla([que, opinas, sobre, la, amistad, '?'], ['--Eliza: La amistad es un pilar importante en la vida.'], []).
plantilla([como, manejas, el, estres, '?'], ['--Eliza: Manejar el estrés es esencial para la salud. ¿Cómo lo haces tú?'], []).
plantilla([cual, es, tu, mayor, logro, '?'], ['--Eliza: Los logros reflejan esfuerzo. Cuéntame el tuyo.'], []).
plantilla([tienes, alguna, filosofia, de, vida, '?'], ['--Eliza: Me interesa conocer tus principios de vida.'], []).
plantilla([que, es, lo, que, mas, te, gusta, de, ti, '?'], ['--Eliza: Conocerse a uno mismo es importante.'], []).


% que sabes de mediciona, dime acerca de medicina, que puedes decirme de medicina

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


%------------------------------------------------------------------------------------------------------------------------------------

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plantillas para respuestas sobre el árbol familiar
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

%------------------------------------------------------------------------------------------------------------------------------------

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



%-----------------------------------------------------------------------------------------------------
% Arbol familiar Reglas para consulta en el árbol genealógico-
%---------------------------------------------------------------------------------------------------

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

%----------------------------------------------------------------------------------------------------------------------------------

% Reglas de deducción de medicos y sus atributos ---------------------------------------------------------------
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
%----------------------------------------------------------------------------------------------------------------------------------
% Reglas de deducción de familiares y sus atributos ---------------------------------------------------------------



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
%----------------------------------------------------------------------------------------------------------------------------------

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


%----------------------------------------------------------------------------------------------------------------------------------

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
hermano_de(julio, yolanda).
hermano_de(faviola, julio).

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