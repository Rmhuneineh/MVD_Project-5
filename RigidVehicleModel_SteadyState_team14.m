% Motor Vehicle Design PROJECT 5 - COMPUTATION OF THE STEADY STATE PERFORMANCE
clear all
close all
clc
%Data
DATA_team14;
%DATA

V=0.1/3.6:0.1/3.6:100/3.6;

%Computation  of the Derivatives of Stability

 Y_beta  = -(C_1 + C_2);               
 Y_r     = -(1./V) .* (a*C_1 - b*C_2);
 Y_delta = C_1;
    
N_beta  = - (a*C_1 - b*C_2)+ M_z_alpha1 + M_z_alpha2;
N_r     = (1./V).*(- C_1*(a^2) - C_2*(b^2)+ a*M_z_alpha1 - b*M_z_alpha2);
N_delta =   a*C_1- M_z_alpha1;
          
K_RC = (1./V).*((Y_delta.*N_beta - N_delta.*Y_beta)./ (N_beta.*(m*V-Y_r) + N_r.*Y_beta));

K_AL= V.*(Y_delta.*N_beta - N_delta.*Y_beta)./ (N_beta.*(m*V-Y_r) + N_r.*Y_beta);

K_BETA = ((-1)*N_delta.*(m*V - Y_r) - N_r.*Y_delta) ./ (N_beta.*(m*V-Y_r) + N_r.*Y_beta);
      
figure
plot(V*3.6,K_RC)
xlabel('V, km/h')
ylabel('Curvature gain, m^-1/rad')
grid
figure
plot(V*3.6,K_AL/9.81/180*pi)
xlabel('V, km/h')
ylabel('lateral acceleration gain, g/deg')
grid
figure
plot(V*3.6,K_BETA)
xlabel('V, km/h')
ylabel('sideslip gain')
grid
