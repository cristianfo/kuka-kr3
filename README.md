# Kuka KR3

Protótipo do robo Kuka KR3 R540 no MATLAB.

## Requisitos

- Software MATLAB
- Robotics Toolbox 10.2.1 de Peter Cork para MATLAB , disponível em http://petercorke.com/wordpress/toolboxes/robotics-toolbox

## Como usar

O arquivo Exemple.m demonstra a utilização das funções.

### kr3Init - Inicialização do robô

Esta função inicializa o robô Kuka KR3 com os parâmetros de ferramenta passados como argumento da função.


``` matlab
kr3Init(f)

% Inicialização do robo kuka kr3
% Argumentos: f = vetor de posicionamento da ferramenta em mm

```

Ao inicializar o robo com kr3Init, esta função cria um objeto global kr3 do tipo SerialLink que pode ser manipulável com as funções da biblioteca de Peter Cork, para isto, no MatLab você deve declará-la:

``` matlab
global kr3
```

### kr3FK - Cinemática direta do robô

Calculo da cinemática direta do robô, que apartir da posição das juntas, retorna uma matriz de transformação homogênea da cinemática direta.

``` matlab
kr3FK(angulos)

%    Parâmetros: angulos = angulos das juntas em graus
%%   Retorno: T0f = matriz de transformação homogênea da cinemática direta
```

### kr3IK - Cinemática inversa do robô

Recebe a matriz de transformação da postura desejada e calcula a cinemática inversa do manipulador. São retornados os angulos das juntas são retornados.

``` matlab
kr3IK(mat)

%    Parâmetros: M = matriz homogênea 4 x 4
%    Retorno: angulos = ângulos das juntas em graus (Denavit-Hartemberg)
```

### kr3fj - Jacobiano de velocidade do efetuador

Recebe a posição e velocidade das juntas e calcula a velocidade do efetuador através do Jacobiano.

``` matlab
kr3fj(posJunta,velJunta)

%%Parametros: posJunta vetor 1x6 (Graus e mm), velJunta vetor 6x1 (em graus/s)

%%Retorno : matriz de velocidade do efetuador 6x1, onde as três primeiras
%%linhas são as velocidades lineares, e as três últimas angulares (mm/s e
%%graus/s)

```

### kr3ij - Jacobiano de velocidade das juntas


Recebe a posição das juntas e velocidade do efetuador, e calcula a velocidade das juntas através do Jacobiano inverso.

``` matlab
kr3ij(posJunta,velEfetuador)

%%Parametros: posJunta vetor 1x6 (Graus e mm), velEfetuador vetor 6x1 (mm/s e em graus/s)
%%Retorno : matriz de velocidade das juntas 6x1 (graus/s)
```

### kr3Teach - Teach pendant gráfico

Esta função recebe a posição das juntas e gera uma visualização gráfica do robô assim como um teach pendant virtual para poder iteragir com o mesmo.

``` matlab
kr3Teach(q)

%   Representação gráfica do robo
%   Parâmetros:  q = ângulos das juntas em graus (Denavit-Hartemberg)

```

## Licença

GNU General Public License v3.0

## Autores

Cristian Fernando Oecksler

Jorge Lucas de Santana
