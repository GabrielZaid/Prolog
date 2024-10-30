hijo(zaid)
hijo(isai)

hija(lucero)
hija(monse)

padre(antonio)
padre(jose)

madre(yolanda)
madre(rosa)

cunado(isai)
cunado(zaid)

madrede(yolanda, zaid)
madrede(rosa, isai)

padrede(jose, zaid)
padrede(antonio, isai)

hermanode(lucero,zaid)




abuelo(X, Y):-padrede(X,Z), padrede(Z,Y); madrede(X,Z), madrede(Z,Y); 
#hacer regla de los hermanos
hermano(X, Y):- (padrede(Z, X); madrede(Z, X)), (padrede(Z, Y); madrede(Z, Y)).

#hacer regla del tio
tio(X, Y):- (padrede(Z, Y); madrede(Z, Y)), hermano(X, Z).


#hacer regla del nieto
nieto(X, Y):-(padrede(Y, Z); madrede(Y, Z)), (padrede(Z, X); madrede(Z, X)).

#hacer regla del cuñado
cunado(X, Y):- (padrede(Z, Y); madrede(Z, Y)), hermano(X, Z).
