%%retorna a velocidade do efetuador -> velEfetuador = J.velJunta
%%parametros: posJunta vetor 1x6 (Graus e mm)
%%velJunta vetor 6x1 (em graus/s)

%%retorno : matriz de velocidade do efetuador 6x1, onde as três primeiras
%%linhas são as velocidades lineares, e as três últimas angulares (mm/s e
%%graus/s)
function velEfetuador= Kr3fj(posJunta,velJunta)

%%parâmetros de geometria do manipulador
a1=20;
a2=260;
a3=20;
d1=-345;
d4=-260;
d6=75+146.9;

%%variáveis auxiliares
c1=cos(posJunta(1,1));
s1=sin(posJunta(1,1));
c2=cos(posJunta(1,2));
s2=sin(posJunta(1,2));
c3=cos(posJunta(1,3));
s3=sin(posJunta(1,3));
c4=cos(posJunta(1,4));
s4=sin(posJunta(1,4));
c5=cos(posJunta(1,5));
s5=sin(posJunta(1,5));
c6=cos(posJunta(1,6));
s6=sin(posJunta(1,6));

%%Matrizes de transformação homogênea
T01= [c1 0 s1 a1*c1; s1 0 -c1 a1*s1; 0 1 0 -d1; 0 0 0 1];
T12= [-c2 s2 0 -a2*c2; -s2 -c2 0 -a2*s2; 0 0 1 0; 0 0 0 1];
T23= [-s3 0 c3 -a3*s3; c3 0 s3 a3*c3; 0 1 0 0; 0 0 0 1];
T34= [c4 0 -s4 0; s4 0 c4 0; 0 -1 0 -d4; 0 0 0 1];
T45= [c5 0 s5 0; s5 0 -c5 0; 0 1 0 0; 0 0 0 1];
T56= [c6 s6 0 0; s6 -c6 0 0; 0 0 1 d6; 0 0 0 1];

% PARÂMETROS PARA O CALCULO DO JACOBIANO$$

%%Obtenção das matrizes de transformação com relação a origem 0
T01 = T01;
T02 = T01*T12;
T03 = T02*T23;
T04 = T03*T34;
T05 = T04*T45;
T06= T01*T12*T23*T34*T45*T56;

%%Seleciona a origem (4ª coluna) das matrizes de transformação.
O0 = [0; 0; 0];
O1 = T01(1:3,4);
O2 = T02(1:3,4);
O3 = T03(1:3,4);
O4 = T04(1:3,4);
O5 = T05(1:3,4);
O6 = T06(1:3,4);

%%Seleciona a coluna Z (3ª coluna) das matrizes de transformação.
z00 = [0; 0; 1];  %z00 = COLUNA Z DA IDENTIDADE
z01 = T01(1:3,3);
z02 = T02(1:3,3);
z03 = T03(1:3,3);
z04 = T04(1:3,3);
z05 = T05(1:3,3);

%%Velocidades angulares
JW = [z00 z01 z02 z03 z04 z05];%juntas  de revolução: todos parametros pi = 1

r=O6-O0;
s=O6-O1;
t=O6-O2;
u=O6-O3;
v=O6-O4;
x=O6-O5;

%%produto vetorial para obter velocidades lineares
JV1 = cross(z00,r);
JV2 = cross(z01,s);
JV3 = cross(z02,t);
JV4 = cross(z03,u);
JV5 = cross(z04,v);
JV6 = cross(z05,x);

JV = [JV1 JV2 JV3 JV4 JV5 JV6];

J = vertcat(JV,JW); %%concatena as matrizes uma em baixo da outra

velEfetuador = J*velJunta;


