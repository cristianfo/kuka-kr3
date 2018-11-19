%    Calcula a cinemática inversa do robô
%    Parâmetros: M = matriz homogênea 4 x 4
%    Retorno: angulos = ângulos das juntas em graus (Denavit-Hartemberg)
function angulos = kr3IK(M)

global kr3
global A1
global A2
global A3

%Verifica se o parâmetro foi informado
if ~exist('M','var')
    erro('Parâmetro não informado!');
end

fprintf('Calculando cinemática inversa\n');

L = kr3.links;
F = kr3.tool.T;

d6=[0; 0; abs(L(6).d)]; %%d6 é um comprimento no eixo Z, entre o referencial
 %do punho e o referencial da ferramenta
 
 p06 = M(1:3,4); %%Vetor que une o referencial inercial ao referencial da ferramenta
 R = M(1:3,1:3); %%Submatriz de rotação de M
 p0w_aux = p06+R*(d6); %%Vetor que une o referencial inercial ao referencial do
                     %%punho
 
 %%Cálculo de q1                    
 q1 = atan2(p0w_aux(2,1),p0w_aux(1,1)); 
 
 %%Calculados através do método geométrico
 
 %%_Aux = vetores ,
 %%Variáveis = comprimentos destes vetores.
 
 p0w = sqrt(p0w_aux(1,1)^2+p0w_aux(2,1)^2+p0w_aux(3,1)^2);
 p01_aux = L(1).A(q1);
 p01_aux = [p01_aux.t(1,1); p01_aux.t(2,1); p01_aux.t(3,1)];
 p01 = sqrt(p01_aux(1,1)^2+p01_aux(2,1)^2+p01_aux(3,1)^2); 
 p1w_aux = p0w_aux-p01_aux;
 p1w = sqrt(p1w_aux(1,1)^2+p1w_aux(2,1)^2+p1w_aux(3,1)^2);
 p2w = sqrt(260^2+20^2);
 
 %%Os ângulos auxiliares necessários para o cálculo de q2:
 A = atan(345/20);
 B = acos((p0w^2-p01^2-p1w^2)/(-2*p01*p1w));
 C = acos((-p1w^2-260^2+p2w^2)/(-2*260*p1w));
 
 if rad2deg(B)>180+atand(20/345)
    fprintf('Ponto invalido');
 end
 
 q2 = 2*pi-(pi/2+A+B+C);
 
 %%Os ângulos auxiliares necessários para o cálculo de q3:
 D = acos((p1w^2-260^2-p2w^2)/(-2*260*p2w));
 E = atan(260/20);
 
 if rad2deg(D)>180 || rad2deg(D)<0
    fprintf('Ponto invalido');
 end
 
 q3 = pi-D-E;
 
 %%A orientação, pelo desacoplamento cinemático:
 T03 = (A1*A2*A3);
 T36 = inv(T03)*M;
 
 %%q4, q5 e q6:
 q4 = atan2(T36(2,3),T36(1,3));
 q5 = atan2(sqrt(T36(1,3)^2+T36(2,3)^2),T36(3,3));
 q6 = atan2(T36(3,2),-T36(3,1));
 
 %%Conversão dos ângulos radianos -> graus
 Qn = [rad2deg(q1) rad2deg(q2) rad2deg(q3) rad2deg(q4) rad2deg(q5) rad2deg(q6)];
 
 angulos = round(Qn,2);
 
 %%Erros do limites das juntas:
 erro = 0;
if q1 < -170*pi/180 || q1> 170*pi/180
    erro = 1;
    error('Limite da junta 1');
end

if q2 < -170*pi/180 || q2> 50*pi/180
    erro = 1;
    error('Limite da junta 2');
end

if q3 < -110*pi/180 || q3> 155*pi/180
    erro = 1;
    error('Limite da junta 3');
end

if q4 < -175*pi/180 || q4> 175*pi/180
    erro = 1;
    error('Limite da junta 4');
end

if q5 < -120*pi/180 || q5> 120*pi/180
    erro = 1;
    error('Limite da junta 5');
end

if q6 < -350*pi/180 || q6> 350*pi/180
    erro = 1;
    error('Limite da junta 6');
end

if erro ~= 1
   % disp('Sem erros')
end