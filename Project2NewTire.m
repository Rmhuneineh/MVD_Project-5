clear all
clc

% SLOPE IN THE ORIGIN OF Fx-? CURVE
% Vertical Force
Fz = [2 4 6 8 10]; %[kN]

% All Coefficients
Tire2;

% Calculate Maximum Longitudinal Force Coefficients
uxp = b1.*Fz + b2;

% Calculate Slip Stiffness BCDlong
BCDlong = (b3.*Fz.^2 + b4.*Fz).*exp(-b5.*Fz);

% figure; hold on;
% plot(Fz, uxp);
% title('uxp vs Fz');
% xlabel('Fz [kN]');
% ylabel('uxp [-]');
% 
% figure; hold on;
% plot(Fz, BCDlong);
% title('BCD vs Fz');
% xlabel('Fz [kN]');
% ylabel('BCD [-]');

% SIDE SLIP STIFFNESS

% Calculate Side Slip Stiffness BCDside
BCDside = a3.*sind(2*atand(Fz./a4));

% Calculate Maximum Lateral Force Coefficients
uyp = a1.*Fz + a2;

% Calculate Side Slip Stiffness with Camber Angle Effect BCDcamber
gamma = -20:20;
BCDcamber = a3*sind(2*atand(5/a4)).*(1-a5.*abs(gamma));

% figure; hold on;
% plot(Fz, BCDside);
% title('BCDside vs Fz');
% xlabel('Fz [kN]');
% ylabel('BCDside [-]');
% 
% figure; hold on;
% plot(Fz, uyp);
% title('uyp vs Fz');
% xlabel('Fz [kN]');
% ylabel('uyp [-]');
% 
% figure; hold on;
% plot(gamma, BCDcamber);
% title('BCDcamber vs gamma at Fz=5kN');
% xlabel('gamma [deg]');
% ylabel('BCDcamber [-]');

% SELF-ALIGNMENT TORQUE STIFFNESS

% Calculate self-alignment stiffness BCDalign
BCDalign = (c3.*Fz.^3 + c4.*Fz).*exp(-c5.*Fz);

% Calculate Self-Aligning Stiffness with Camber Angle Effect BCDalignCamber
BCDalignCamber = (c3*5^3 + c4*5)*exp(-c5*5).*(1-c6.*abs(gamma));

% figure; hold on;
% plot(Fz, BCDalign);
% title('BCDalign vs Fz');
% xlabel('Fz [kN]');
% ylabel('BCDalign [-]');
% 
% figure; hold on;
% plot(gamma, BCDalignCamber);
% title('BCDalignCamber vs gamma at Fz=5kN');
% xlabel('gamma [deg]');
% ylabel('BCDalignCamber [-]');

% TIRE NON-LINEAR MODEL
% Read Excel File
[NUM, TXT, RAW] = xlsread('Project2_TireCharacteristics.xls');
index = 1:201;

% Extract Data Into Suitable Variables
Slip = NUM(index, 1);
SideSlip = NUM(index, 7);
Fx = zeros(201, 5);
Fy = zeros(201, 5);
Mz = zeros(201, 5);
for i = 1:5
   Fx(index, i) = NUM(index, i+1); 
   Fy(index, i) = NUM(index, i+7);
   Mz(index, i) = NUM(index, i+13);
end

% Evaluate Longitudinal Force Coefficient
ux = zeros(201, 5);
for i = 1:5
   for j = 1:201
      ux(j, i) = Fx(j, i)/(Fz(i)*10^3); 
   end
end

% Plot ux vs Slip
% figure; hold on;
% for i = 1:5
%    plot(Slip, ux(index, i)); 
% end
% legend('ux [2kN]', 'ux [4kN]', 'ux [6kN]', 'ux [8kN]', 'ux [10kN]');
% xlabel('Slip [-]');
% ylabel('ux [-]');
% title('ux vs Slip for a range of Fz');

% Evaluate Lateral Force Coefficient
uy = zeros(201, 5);
for i = 1:5
    for j = 1:201
       uy(j, i) =  Fy(j, i)/(Fz(i)*10^3);
    end
end

% Plot uy vs Side Slip
% figure; hold on;
% for i = 1:5
%    plot(SideSlip, uy(index, i)); 
% end
% legend('uy [2kN]', 'uy [4kN]', 'uy [6kN]', 'uy [8kN]', 'uy [10kN]');
% xlabel('SideSlip [-]');
% ylabel('uy [-]');
% title('uy vs Slip for a range of Fz');

% Calculate and Plot Lever Arm t[mm] at Fz=4kN
t = -Mz(index, 2)./Fy(index, 2)*10^3;

% figure; hold on;
% plot(SideSlip, t);
% title('Lever Arm vs SideSlip at Fz=4kN');
% xlabel('SideSlip [-]');
% ylabel('t[mm]');

% Plot Gough Diagram
% figure; hold on;
% for i = 1:5
%     plot(Mz(index, i), Fy(index, i));
% end
% 
% for i = index
%    plot(Mz(i, 1:5), Fy(i, 1:5)); 
% end
% grid on;
% title('Fy vs Mz in ranges of Fz and alpha');
% xlabel('Mz [Nm]');
% ylabel('Fy [N]');

% INTERACTION OF TIRE-ROAD FORCES IN LONGITUDINAL AND LATERAL DIRECTIONS
% Evaluate and Plot Fy as a function of Fx at Fz = 4kN and Camber = 0 for different
% side slip
indeces = [111 121 131 141 151];
Fy0 = Fy(indeces(1:5), 2); % [N]
Fx0 = Fz(2)*uxp(2); % [N]
Fyn = zeros(201, 5);
for i = 1:5
    for j = index
        Fyn(j, i) = Fy0(i).*sqrt(1-(Fx(j, 2)/Fx0)^2); 
    end
end

% figure; hold on;
% for i = 1:5
%    plot(Fx(index, 2), Fyn(index, i)); 
% end
% legend('alpha = 2', 'alpha = 4', 'alpha = 6', 'alpha = 8', 'alpha = 10');
% title('Fy vs Fx for a range of alpha');
% xlabel('Fx [N]');
% ylabel('Fy [N]');

% Evaluate and Plot Side Slip Stiffness as a function of Fx at different values of
% Fz

C = zeros(201, 5);
for i = 1:5
   for j = index
       if (Fx(j, i) < uxp(i)*Fz(i))
           C(j, i) = BCDside(i)*sqrt(1-(Fx(j, i)/(uxp(i)*Fz(i)))^2);
       else
           C(j, i) = 0;
       end
   end
end

% figure; hold on;
% for i = 1:5
%    plot(Fx(index, i), C(index, i)); 
% end
% legend('Fz = 2kN', 'Fz = 4kN', 'Fz = 6kN', 'Fz = 8kN', 'Fz = 10kN');
% title('C vs Fx for a range of Fz');
% xlabel('Fx [N]');
% ylabel('C [N/deg]');

% Evaluate and Plot Lateral Force Coefficient uy as a function of ux at Fz=4kN
uyn = zeros(201, 1);

for i = index
   uyn(i) = max(uy(index, 2))*sqrt(1-(ux(i, 2)/uxp(2))^2); 
end

% figure; hold on;
% plot(ux(index, 2), uyn(index));
% title('uy vs ux at Fz = 4kN');
% xlabel('ux [-]');
% ylabel('uy [-]');