% DATA Project 5
g=9.81;                                                 % \m/s^2\     acceleration of gravity 
m=970;                                          % \kg\         vehicle mass
l=2.3;                                                %  \m\          wheel base
J_z=m*l^2/12;                                           %  \kgm^2\  yaw moment of inertia
a=1.15;                                               % \m\          distance front axle -centre of gravity projection  
hG=0.5;                                            % \m\          height of the centre of gravity
b=l-a;                                                    % \m\          distance rear axle -centre of gravity projection
Fz1=m*g/2;                 % \N\ front wheel vertical force
Fz2=m*g/2;                      % \N\ rear wheel vertical force
C_1=1493.5;                       %  \N/rad\ front axle lateral stiffness
C_2=1493.5;                    %  \N/rad\ rear axle lateral stiffness
M_z_alpha1=151.3566;        %  \Nm/rad\ front axle stiffenss of the self aligning moment
M_z_alpha2=151.3566;       %  \Nm/rad\ rear axle stiffenss of the self aligning moment
f0=0.013;                                                           % \-\ rolling resistance
K=0.00000651;                                                            % \s^2/m^2\ rolling resistance
rho=1.3;                                                   % \kg/m^3\  air density