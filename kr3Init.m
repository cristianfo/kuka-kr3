% Inicialização do robo kuka kr3
% Argumentos: f = vetor de posicionamento da ferramenta em mm, padrão [0 0 0]
function kr3Init(f)

clear global;
global kr3 Qd

%Verificação se o parâmetro existe
if ~exist('f','var')
    F=[0 0 0];
    fprintf('KR3 inicializado com ferramenta [0.00 0.00 0.00]\n');
else
    F = f;
    fprintf('KR3 inicializado com ferramenta [%3.2f %3.2f %3.2f]\n', F(1), F(2), F(3));
end

%%Parâmetros de Denavit-Hatemberg
L1 = Link('d', -345, 'a', 20, 'alpha', pi/2, 'qlim', [-170*pi/180 170*pi/180]);
L2 = Link('offset', -pi/2, 'd', 0, 'a', 260, 'alpha', 0, 'qlim', [-170*pi/180 50*pi/180]);
L3 = Link('d', 0, 'a', 20, 'alpha', pi/2, 'qlim', [-155*pi/180 110*pi/180]);
L4 = Link('d', -260, 'a', 0, 'alpha', -pi/2, 'qlim', [-175*pi/180 175*pi/180]);
L5 = Link('d', 0, 'a', 0, 'alpha', pi/2, 'qlim', [-120*pi/180 120*pi/180]);
L6 = Link('d', -(75+F(3)), 'a', 0, 'alpha', 0, 'qlim', [-350*pi/180 350*pi/180]);
L = [L1;L2;L3;L4;L5;L6];

%Robô com os parâmetros DH
kr3 = SerialLink(L, 'manufacturer', 'Kuka', 'name', 'KR 3 R540', 'tool', F);

%Ângulo padrão master position
Qd=[0 -90 90 80 0 0];