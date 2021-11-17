clc
clear all

mu0 = 4*pi*1e-7; % Permeabilidade magnética do vácuo
g = 0.1*1e-3; % Tamaho do gap       
N = 500; % Número de espiras
D = 5*1e-2; % Profundidade
I0 = 5; % Corrente
w = 5*1e-2; %Largura
epslon = 0.5; 

theta = 0:0.001:2*pi;

x = w.*(1+(epslon.*sin(teta)))./2;

L = ((N^2)*(mu0.*(w-x)))/(2*g);

Wprime = ((I0.^2)/2)*L;

F = -1*(((N.*I0).^2)*mu0*D)./(4*g);


% Plot da indutância
figure
plot(theta,L)
grid on
xlabel('Ângulo (rad)')
ylabel('Indutância (H)')


% Plot da Coenergia
figure
plot(theta,Wprime)
grid on
xlabel('Ângulo (rad)')
ylabel('Coenergia (J)')


% Plot da Força
figure
plot(theta,F,'--gs')
grid on
xlabel('Ângulo (rad)')
ylabel('Força (N)')

