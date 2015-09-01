%% Not working solution to the balance problem from lab.
clear,clc

base_mag = [5.49; 4.92; 7.10; 9.52; 1.54; 5.29; 4.87; 13.44; 6.16];
base_phase =([174.3; 273.5; 226.0; 252.5; 3.2; 227.8; 28.9; 249.4; 311.3]./180).*pi;
base = complex(base_mag.*cos(base_phase), base_mag.*sin(base_phase))

first_mag = [90.96; 11.15; 130.70; 44.31; 15.53; 73.85; 4.23; 20.24; 27.24];
first_phase = ([89.2; 280; 351.1; 75.1; 288.4; 341.4; 313; 87.4; 305.8]./180).*pi;
first = complex(first_mag.*cos(first_phase), first_mag.*sin(first_phase))

trial = 0+.52i;

alpha = (first-base)./trial

Weights=-(alpha.'*base)/(alpha.'*alpha)
%alpha.'*alpha*W+alpha.'*base=0

%mag and phase of Correction Weights
abs(Weights)
((pi+atan(imag(Weights)/real(Weights)))/pi)*180

%%

S = 0;

for k = 1:9
    S= S+first(k)^2;
end

R = S/9;

for k = 1:9
    alphaprime(k)*first(k)/R;
end

alphaprime=alphaprime.';

Weights2=-(alphaprime.'*base)/(alphaprime.'*alpha)

%% Working solution to Sample Goodman problem
clear,clc

base_mag = [1;1;0];
base_phase =([0;180;0]./180).*pi;
base = complex(base_mag.*cos(base_phase), base_mag.*sin(base_phase))

% first_mag = [90.96; 11.15; 130.70; 44.31; 15.53; 73.85; 4.23; 20.24; 27.24];
% first_phase = ([89.2; 280; 351.1; 75.1; 288.4; 341.4; 313; 87.4; 305.8]./180).*pi;
% first = complex(first_mag.*cos(first_phase), first_mag.*sin(first_phase))

% trial = 0+.52i;

alphamag = [3 2;5 2;5 3];
alphaphs = [0 180;0 180;0 180];

for k = 1:2
    for l = 1:3
        alpha(l,k)=mp2complex(alphamag(l,k),alphaphs(l,k));
    end
end

Weights=(alpha.'*alpha)^-1*(-alpha.'*base)
%alpha.'*alpha*W+alpha.'*base=0

%mag and phase of Correction Weights
abs(Weights)
((pi+atan(imag(Weights)/real(Weights)))/pi)*180

%%
clear,clc


base = [4;5-i];

% first_mag = [90.96; 11.15; 130.70; 44.31; 15.53; 73.85; 4.23; 20.24; 27.24];
% first_phase = ([89.2; 280; 351.1; 75.1; 288.4; 341.4; 313; 87.4; 305.8]./180).*pi;
first = [1+1i;2+0i];

trial = 1;

% trial = 0+.52i;

alpha = (first-base)./trial

Weights=(alpha.'*alpha)^-1*(-alpha.'*base)
%alpha.'*alpha*W+alpha.'*base=0

%mag and phase of Correction Weights
abs(Weights)
((pi+atan(imag(Weights)/real(Weights)))/pi)*180
%% 2nd attempt
clear,clc

base_mag = [5.49; 4.92; 7.10; 9.52; 1.54; 5.29; 4.87; 13.44; 6.16];
base_phase =([174.3; 273.5; 226.0; 252.5; 3.2; 227.8; 28.9; 249.4; 311.3]./180).*pi;
base = complex(base_mag.*cos(base_phase), base_mag.*sin(base_phase))

first_mag = [90.96; 11.15; 130.70; 44.31; 15.53; 73.85; 4.23; 20.24; 27.24];
first_phase = ([89.2; 280; 351.1; 75.1; 288.4; 341.4; 313; 87.4; 305.8]./180).*pi;
first = complex(first_mag.*cos(first_phase), first_mag.*sin(first_phase))

trial = 0+.52i;

alpha = (first-base)./trial

Weights=((-alpha)'*(-alpha))^-1*(-alpha'*base)
%alpha.'*alpha*W+alpha.'*base=0

%mag and phase of Correction Weights
abs(Weights)
((pi+atan(imag(Weights)/real(Weights)))/pi)*180

%% Next iteration
epsilon = base+alpha*Weights;

alpha2 = zeros(9,1); 

R = sqrt(sum(epsilon.^2)/3);

for k = 1:9
    alpha2(k)=alpha(k)*abs(epsilon(k)/R);
end

alphaI = alpha2'*alpha
baseI = alpha2'*base

WeightsI=((-alphaI)'*(-alphaI))^-1*(-alphaI'*baseI)

%% Next iteration
epsilon = base+alpha*Weights;

alpha2 = zeros(3,2); 

R = sqrt(sum(epsilon.^2)/3);

for k = 1:3
    for l = 1:2
        alpha2(k,l)=alpha(k,l)*abs(epsilon(k)/R);
    end
end

alphaI = alpha2'*alpha
baseI = alpha2'*base

WeightsI=((-alphaI)'*(-alphaI))^-1*(-alphaI'*baseI)



