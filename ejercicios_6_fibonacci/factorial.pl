%caso base: factorial(0,1) es 1 y factorial(1,1) es 1

factorial(0,1).
factorial(1,1). 




%caso division: 
division(4,2)

divison(Dividendo, Divisior):-
    Dividendo > Divisior,
    Dividendo1 is Dividendo - Divisior,
    division(Dividendo1,Divisior).
    cociente is cociente + 1.






