% 1. La Biblioteca Nacional tiene el libro "Don Quijote de la Mancha".
libro('Don Quijote de la Mancha').
biblioteca('Biblioteca Nacional').
libro_en_biblioteca('Don Quijote de la Mancha', 'Biblioteca Nacional').
libro_en_biblioteca(biblioteca,libro).

% 2. Todos los libros en la Biblioteca Nacional están catalogados.
libro('Don Quijote de la Mancha').
biblioteca('Biblioteca Nacional').
catalogado(Libro) :- libro(Libro), libro_en_biblioteca(Libro, 'Biblioteca Nacional').

% 3. Existen libros que están en más de una biblioteca.
libro('Don Quijote de la Mancha').
biblioteca('Biblioteca Nacional').
biblioteca('Otra Biblioteca').
libro_en_biblioteca('Don Quijote de la Mancha', 'Biblioteca Nacional').
libro_en_biblioteca('Don Quijote de la Mancha', 'Otra Biblioteca').
libro_en_multiples_bibliotecas(Libro) :- libro(Libro), libro_en_biblioteca(Libro, Biblioteca1), libro_en_biblioteca(Libro, Biblioteca2), Biblioteca1 \= Biblioteca2.

% 4. Si un libro es raro, entonces no se puede prestar.
raro(Libro).
no_prestable(Libro) :- raro(Libro).

% 5. La Biblioteca Central tiene más de 10,000 libros.
biblioteca('Biblioteca Central').
muchos_libros('Biblioteca Central').

% 6. Todos los autores tienen al menos un libro en una biblioteca.
autor('Miguel de Cervantes').
libro_de_autor_en_biblioteca(Autor, Libro, Biblioteca) :- autor(Autor), libro(Libro), libro_en_biblioteca(Libro, Biblioteca).

% 7. Existe un autor que tiene más de 5 libros publicados.
autor('Miguel de Cervantes').
libros_publicados('Miguel de Cervantes', 6).
autor_con_mas_de_5_libros(Autor) :- libros_publicados(Autor, Cantidad), Cantidad > 5.

% 8. No todos los libros de la biblioteca están en buen estado.
libro('Don Quijote de la Mancha').
biblioteca('Biblioteca Nacional').
buen_estado('Don Quijote de la Mancha').
no_todos_en_buen_estado :- libro(Libro), biblioteca(Biblioteca), libro_en_biblioteca(Libro, Biblioteca), \+ buen_estado(Libro).

% 9. Si un libro está en buen estado, puede ser prestado.
prestado(Libro) :- buen_estado(Libro).

% 10. Todos los usuarios registrados pueden tomar prestado un libro.
usuario_registrado('Juan Perez').
puede_tomar_prestado(Usuario, Libro) :- usuario_registrado(Usuario), libro(Libro).

% 11. Existen libros que solo se pueden consultar en la biblioteca.
solo_consulta(Libro).

% 12. Todo libro prestado debe ser devuelto en 15 días.
devolucion_plazo(Libro, 15).


% 13. Hay un libro que nadie ha pedido en préstamo.
no_pedido_prestamo(Libro) :- libro(Libro), \+ prestamo(_, Libro).

% 14. Si un usuario tiene una multa, no puede pedir un libro prestado.
multa(Usuario).
no_puede_prestamo(Usuario, Libro) :- multa(Usuario).

% 15. Todos los libros escritos por un mismo autor están en la misma sección.
seccion_comun(Autor, Seccion) :-
    autor(Autor),
    findall(Seccion, (escrito_por(Libro, Autor), seccion(Libro, Seccion)), Secciones),
    list_to_set(Secciones, [Seccion]).

% 16. Existe un libro que tiene más de un ejemplar en la biblioteca.
varios_ejemplares(Libro) :- ejemplares(Libro, N), N > 1.

% 17. Todo usuario con más de tres préstamos debe devolver uno para pedir otro.
prestamos_usuario(Usuario, Prestamos) :-
    findall(Libro, prestamo(Usuario, Libro), Prestamos).
limite_prestamos(Usuario) :-
    prestamos_usuario(Usuario, Prestamos),
    length(Prestamos, N),
    N > 3.

% 18. Hay una sección de la biblioteca donde todos los libros son de ciencias.
seccion('Ciencias').
seccion_ciencias(Seccion) :- seccion(Seccion), forall(libro_en_seccion(Libro, Seccion), ciencia(Libro)).

% 19. No todos los libros en la biblioteca tienen más de 100 páginas.
paginas(Libro, Paginas).
tiene_mas_de_100_paginas(Libro) :- paginas(Libro, P), P > 100.

% 20. Existe un usuario que ha tomado prestados todos los libros de la sección infantil.
prestamo_usuario_seccion(Usuario, Seccion) :-
    usuario(Usuario),
    seccion_libros(Seccion, LibrosSeccion),
    forall(member(Libro, LibrosSeccion), prestamo(Usuario, Libro)).

