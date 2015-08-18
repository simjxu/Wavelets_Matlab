%% Haar Wavelets
%% Setup
clear
totalpts = 100;
incr = 2*pi/totalpts;
%% Input Sine wave function (f = 1Hz, A = 1)
for i=1:totalpts
    t(i) = (i-1)*incr;         % time increments of pi/10
    sinewave(i) = sin(t(i));
end

figure(1)
scatter(t,sinewave,'filled')

%% Haar transform, level 1
% Trend Subsignal
for i=1:totalpts/2
    a1(i) = (sinewave(2*i-1)+sinewave(2*i))/sqrt(2);
end

% Fluctuation Subsignal
for i=1:totalpts/2
    d1(i) = (sinewave(2*i-1)-sinewave(2*i))/sqrt(2);
end

haarTransform1 = [a1 d1];

figure(2)
scatter(t,haarTransform1,'filled')

%% Haar transform, level 2
for i=1:totalpts/4
    a2(i) = (a1(2*i-1)+a1(2*i))/sqrt(2);
end

% Fluctuation Subsignal
for i=1:totalpts/4
    d2(i) = (a1(2*i-1)-a1(2*i))/sqrt(2);
end

haarTransform2 = [a2 d2 d1];

figure(3)
scatter(t,haarTransform2,'filled')