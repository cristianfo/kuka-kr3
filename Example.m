clear all
close all
clc

%Posi��o da ferramenta
T = [0 0 146.9];
 
%Inicializa��o do rob� com ferramenta
kr3Init(T)

%Acesso � variavel global criada em kr3Init
global kr3

%Defini��o dos �ngulos desejados, em graus ( -170<o1<170; 0<o2<50, 0<o3<94,
% 0<o4<175; 0<o5<120; 0<o6<180;)
Q = [-90 20 30 110 90 90]

%C�lculo da cinem�tica direta
matFK = kr3FK(Q)

%C�lculo da cinem�tica inversa
Qn = kr3IK(matFK)

%%C�lculo da velocidade do efetuador dado a velocidade das juntas
velocidadeEfetuador = Kr3fj(Q, [0.1; 0.2; 0.1; 0.3; 0.1; 0.1])

%%C�lculo da velocidade das juntas dado a velocidade do efetuador

velocidadeJuntas = Kr3ij(Q, [0.1; 2; 0.1; 4; 0.1; 0.1])

kr3Teach(Qn)           %Visualiza��o gr�fica dos �ngulos retornados da inversa