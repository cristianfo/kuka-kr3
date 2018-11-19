clear all
close all
clc

%Posição da ferramenta
T = [0 0 146.9];
 
%Inicialização do robô com ferramenta
kr3Init(T)

%Acesso à variavel global criada em kr3Init
global kr3

%Definição dos ângulos desejados, em graus ( -170<o1<170; 0<o2<50, 0<o3<94,
% 0<o4<175; 0<o5<120; 0<o6<180;)
Q = [-90 20 30 110 90 90]

%Cálculo da cinemática direta
matFK = kr3FK(Q)

%Cálculo da cinemática inversa
Qn = kr3IK(matFK)

%%Cálculo da velocidade do efetuador dado a velocidade das juntas
velocidadeEfetuador = Kr3fj(Q, [0.1; 0.2; 0.1; 0.3; 0.1; 0.1])

%%Cálculo da velocidade das juntas dado a velocidade do efetuador

velocidadeJuntas = Kr3ij(Q, [0.1; 2; 0.1; 4; 0.1; 0.1])

kr3Teach(Qn)           %Visualização gráfica dos ângulos retornados da inversa