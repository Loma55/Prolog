% Autor:
% Fecha: 29/07/2022

:-use_module(library(pce)).
:-use_module(library(pce_style_item)).
:-pce_image_directory('./imagenes').
resource(preg,imagen,image('preg.jpg')).
esrespuesta('no').
esrespuesta('si').
%% AREA II: RIESGO MEDIO.
espregunta('Negatividad',X):-esrespuesta(X).
espregunta('Trata de vivir',X):-esrespuesta(X).
espregunta('Intenta socializar',X):-esrespuesta(X).


%% AREA III: RIESGO BAJO.
espregunta('Gusto por la vida',X):- esrespuesta(X).
espregunta('Buena relaci?n con la familia',X):- esrespuesta(X).
espregunta('Empatia con los dem?s ',X):- esrespuesta(X).
espregunta('Sociable',X):- esrespuesta(X).
espregunta('Valora lo que lo rodea',X):- esrespuesta(X).


%% AREA IV: RIESGO ALTO.
espregunta('Pensamientos de querer morir',X):-esrespuesta(X).
espregunta('Depresi?n y desesperanza',X):-esrespuesta(X).



%PRINCIPAL
espregunta('es hombre ?',X):-esrespuesta(X).
espregunta('es mujer ?',X):-esrespuesta(X).

main:-
        new(D,dialog('Mini Encuesta Neuropsiqui?trica')),

        send(D, append, new(Menu, menu_bar)),
        send(Menu, append, new(Iniciar, popup(iniciar))),
        send(Menu, append, new(Acerca, popup(acerca_de))),
        send(Menu, append, new(Ayuda, popup(ayuda))),
        new(Boton2,button('SALIR',and(message(D, destroy)))),


        send_list(Iniciar, append,
                         [ menu_item(iniciar, message(@prolog,pe))
                         ]),
        send_list(Acerca, append,
                        [menu_item(informaci?n, message(@display, inform, 'Encontraras una serie de situaciones con dos alternativas de respuesta [Si] [NO]
Elije la alternativa que coincida contigo.'))
                          ]),
        send_list(Ayuda, append,
                         [ menu_item(autores, message(@display, inform, 'Alfredo L?pez Mac?as, Stefany Orea Herrera - Programaci?n L?gica y Funcional - 8B'))
                         ]),
        mostrar('D:/Escritorio/ProgLog/Programa/imagenes/principal.jpg',D,Menu),
        send(D,append,Boton2),
        send(D,open_centered).


%% FUNCION PARA MOSTRAR LA IMAGEN
%below = debajo
mostrar(V,D,M):- new(I, image(V)),
        new(B, bitmap(I)),
        new(F2, figure),
        send(F2, display, B),
        new(D1, device),
        send(D1, display, F2),
        send(D, display, D1),
        send(D1,below(M)).

%%Ventana para poner Datos de Persona.
pe:-new(D,dialog('Datos Personales')),
    new(T1,text_item('Nombre')),
    new(T2,text_item('Apellidos')),
    new(T3,text_item('Edad')),
    new(A1,button(atras,message(D,destroy))),
    new(S1,button(siguiente,and(message(@prolog,pp),message(D,destroy)))),

    send_list(D,append,[T1,T2,T3,A1,S1]),
    send(D,open_centered).


%% VENTANA DE INICIO, PREGUNTA SI ES HOMBRE O MUJER.
pp:-new(D,dialog('PREGUNTAS')),
       new(Pre1,menu('es hombre ?')),
       send_list(Pre1,append,[si , no]),
       new(Pre2,menu('es mujer ?')),
       send_list(Pre2,append,[si,no]),

       %Imprimimos las preguntas de Hombre o Mujer?
       send(D,append(Pre1)),
       send(D,append,Pre2),
       %vamos a la siguiente ventana para contestar el test con el boton siguiente, Dirigimos al prinicipal:-.
       new(A,button(atras,and(message(@prolog,pe),message(D,destroy)))),
       new(B,button(siguiente,and(message(@prolog,principal,Pre1?selection,Pre2?selection),message(D,destroy)))),
       send(D,append,A),
       send(D,append,B),
       send(D,default_button,siguiente),
       send(D,open_centered).

%% Eleccion de sexo.
principal(P1,P2):-
                  espregunta('es hombre ?',P1),P1='si',
                  espregunta('es mujer ?',P2),P2='no',
                  %Nos dirigimos a pho:-
                  pho.

principal(P1,P2):-
                   espregunta('es hombre ?',P1),P1='no',
                   espregunta('es mujer ?',P2),P2='si',
                   %Nos dirigimos a pho:-
                   pho.

%%En caso de elegir mal el sexo
principal(_,_):-new(D,dialog('ERROR')),
                new(L,label(l,'DEBES ELEGIR SOLO UNA OPCION',font('times','roman',16))),
                new(Atras,button(atras,and(message(@prolog,pp),message(D,destroy)))),
                send(D,append,L),
                send(D,append,Atras),
                send(D,open_centered).



pho:-   %Preguntas del test:
        new(D, dialog('PREGUNTAS')),

        new(Pre1,menu('1. En el ultimo mes, ?has deseado estar muerto(a)? o poder dormir y no despetar')),
        send_list(Pre1,append,[si , no]),
        new(Pre2,menu('2. Soy una persona con autocontrol')),
        send_list(Pre2,append,[si , no]),
        new(Pre3,menu('3.Piense en situaciones reales en las cuales usted ha tenido la oportunidad de explorar algo nuevo o
	   de hacer algo diferente. ?Muestra CURIOSIDAD o INTERE?S en estas situaciones?')),
        send_list(Pre3,append,[si , no]),
        new(Pre4,menu('4. En el ultimo mes, ?has tenido realmente la idea de suicidarte?')),
        send_list(Pre4,append,[si , no]),
        new(Pre5,menu('5. Piense en situaciones reales en las cuales usted ha tenido la oportunidad de aprender ma?s sobre un tema, dentro o fuera de la escuela/universidad. ?Muestra PASIO?N POR APRENDER en estas
	   situaciones?')),
        send_list(Pre5,append,[si , no]),
        new(Pre6,menu('6. En su entorno de amigos, ?ha habido algu?n suicidio consumado?')),
        send_list(Pre6,append,[si , no]),
        new(Pre7,menu('7.  Piense en su vida cotidiana. ?Muestra usted VITALIDAD o ENTUSIASMO cuando es posiblehacerlo?')),
        send_list(Pre7,append,[si , no]),
        new(Pre8,menu('8. ?Ha comenzado a elaborar o ha elaborado los detalles sobre co?mo suicidarse? ?Tiene intenciones de llevarlo a cabo?')),
        send_list(Pre8,append,[si , no]),
        new(Pre9,menu('9.  A lo largo de su vida, ?ha sufrido abuso fi?sico? ')),
        send_list(Pre9,append,[si , no]),
        new(Pre10,menu('10. Piense en situaciones reales en las cuales usted ha experimentado un fracaso o un contratiempo.
       ?Muestra usted ESPERANZA u OPTIMISMO en estas situaciones?')),
        send_list(Pre10,append,[si , no]),


        %Imprimiendo test
        send_list(D,append,[Pre1,Pre2,Pre3,Pre4,Pre5,Pre6,Pre7,Pre8,Pre9,Pre10]),

        send(D, scrollbars, vertical),


        %Boton de retroceso
        new(B1,button(atras,and(message(@prolog,pp),message(D,destroy)))),

        %Al momento de seleccionar siguiente pasamos al areaI:- para comprobar las respuestas que dimos.
        new(B,button(siguiente,and(message(@prolog,areaI,Pre1?selection,Pre2?selection,Pre3?selection,
        Pre4?selection,Pre5?selection,Pre6?selection,Pre7?selection,Pre8?selection,Pre9?selection,Pre10?selection),message(D,destroy)))),

        %Colocamos los botones.
        send(D,append,B1),
        send(D,append,B),

        send(D,open_centered).


%% AREA II: RIESGO ALTO
areaI(P1,_,_,P4,_,_,_,_,_,_):-
                                                  espregunta('Pensamientos de querer morir',P1),P1='si',
                                                  espregunta('Depresi?n y desesperanza',P4),P4='si',
                                                  pf3('D:/Escritorio/ProgLog/Programa/imagenes/imagen2.jpg','Nivel alto:
                                                  El primer momento corresponde al pensamiento suicida, el cual se caracteriza  por tener pensamientos acerca del suicidio.').

%% AREA III: RIEGO BAJO
areaI(_,P2,P3,_,P5,_,P7,_,_,P10):-
                                                      espregunta('Gusto por la vida', P2),P2='si',
                                                      espregunta('Empatia con los dem?s ',P3),P3='si',
                                                      espregunta('Sociable',P5),P5='si',
                                                      espregunta('Buena relaci?n con la familia',P7),P7='si',
                                                      espregunta('Valora lo que lo rodea',P10),P10='si',
                                                      pf3('D:/Escritorio/ProgLog/Programa/imagenes/bajo.jpg','Nivel bajo:
                                                      Por ?ltimo, se puede hablar del suicidio consumado como el momento en el
                                                      cual la persona logr? quitarse la vida.').

%% AREA IV: RIESGO MEDIO
areaI(_,_,_,_,_,P6,_,P8,P9,_):-
                                                      espregunta('Negatividad',P6),P6='si',
                                                      espregunta('Trata de vivir',P8),P8='si',
                                                      espregunta('Intenta socializar',P9), P9='si',
                                                      pf3('D:/Escritorio/ProgLog/Programa/imagenes/medio.jpg','Nivel medio:
                                                      Al hablar de prevenci?n del suicidio es importante conceptualizar la conducta
                                                      suicida como un proceso que consta de diferentes momentos por los cuales puede
                                                      pasar una persona, ya que estos pueden tomarse como una ventana de tiempo en la
                                                      cual si se act?a de forma oportuna se puede prevenir').


areaI(_,_,_,_,_,_,_,_,_,_):-new(D,dialog('ERROR')),
                                                new(L,label(l,'NO SE PUEDE DEFINIR EL RESULTADO DEL TEST ',font('times','roman',16))),
                                                send(D,append,L),
                                                send(D,open,point(350,350)).


mostrar1(V,D):- new(I, image(V)),
        new(B, bitmap(I)),
        new(F2, figure),
        send(F2, display, B),
        new(D1, device),
        send(D1, display, F2),
        send(D, display, D1).


pf3(X,Y):-new(D,dialog('RESULTADOS DE LA Mini Encuesta Neuropsiqui?trica ')),
          mostrar2(X,D,20,30),
           new(L,label(n,'')),
          new(A22,button(salir,and(message(D,destroy)))),
          send(D, append(label(n,''))),
    send(D, append(label(n,'Nivel de riesgo: '))),
         send(D, append(label(n,Y))),
          send(D,append,L),
          send(D,append,A22),
         send(D,open_centered).


mostrar(V,D):- new(I, image(V)),
        new(B, bitmap(I)),
        new(F2, figure),
        send(F2, display, B),
        new(D1, device),
        send(D1, display, F2),
        send(D, display, D1).

mostrar2(V,D,X,Y):- new(I, image(V)),
        new(B, bitmap(I)),
        new(F2, figure),
        send(F2, display, B),
        new(D1, device),
        send(D1, display, F2),
        send(D, display, D1),
        send(D,display,D1,point(X,Y)).

