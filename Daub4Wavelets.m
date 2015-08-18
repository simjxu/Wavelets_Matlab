%% Daubechies 4 Wavelets
%% Setup
clear, clc
totalpts = 100;
incr = 2*pi/totalpts;
%% Input Sine wave function (f = 1Hz, A = 1)
for i=1:totalpts
    t(i) = (i-1)*incr;         % time increments of pi/10
    sinewave(i) = sin(t(i));
end

figure(1)
scatter(t,sinewave,'filled')

%% Daubechies transform, level 1
% Trend Subsignal
alp1 = (1+sqrt(3))/(4*sqrt(2));
alp2 = (3+sqrt(3))/(4*sqrt(2));
alp3 = (3-sqrt(3))/(4*sqrt(2));
alp4 = (1-sqrt(3))/(4*sqrt(2));

bet1 = (1-sqrt(3))/(4*sqrt(2));
bet2 = (sqrt(3)-3)/(4*sqrt(2));
bet3 = (3+sqrt(3))/(4*sqrt(2));
bet4 = (-1-sqrt(3))/(4*sqrt(2));

% Define Daub4 scaling signal
Vm = zeros(1,totalpts);
Vm(1) = alp1; Vm(2) = alp2; Vm(3) = alp3; Vm(4) = alp4;

% Calculate Trend Subsignal
a1 = zeros(1,totalpts/2);
for i=1:totalpts/2
    Vm
    a1(i) = dot(sinewave,Vm);
    Vm = circshift(Vm,[0,2]);       % circularly shift the array
end

% Define Daub4 wavelets
Wm = zeros(1,totalpts);
Wm(1) = bet1; Wm(2) = bet2; Wm(3) = bet3; Wm(4) = bet4;

% Calculate Fluctuation Subsignal
d1 = zeros(1,totalpts/2);
for i=1:totalpts/2
    d1(i) = dot(sinewave,Wm);
    Wm = circshift(Wm,[0,2]);
end

daub4Transform1 = [a1 d1];

figure(2)
scatter(t,daub4Transform1,'filled')