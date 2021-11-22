fc = 77.0e9;

%Transmitted power (W)
Ps = 3e-3;

%Antenna Gain (linear)
G =  10000;

%Minimum Detectable Power
Pe = 1e-10;

%RCS of a car
RCS = 100;

%Speed of light
c = 3*10^8;

lambda = c/fc 


Range = ((Ps*G*(lambda)^2*RCS)/(Pe*(4*pi)^3))^(1/4)