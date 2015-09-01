%% Predict values example
clear,clc

% Insert zero-rotor data
magbase = [23.131 18.692 15.291 27.37 15.692 36.347 56.949 29.408 ...
    66.773];
phasebase = [162.514 310.052 108.139 310.071 337.36 283.559 353.968 ...
    214.632 299.237];

% Convert the magnitudes and phases for the zero-rotor data into an A 
% matrix with complex values
A = zeros(9,1);
for j = 1:9
    A(j)=mp2complex(magbase(j),phasebase(j));
end

% Insert trial weight magnitude and phase
magtrialwt = 0.53;
phasetrialwt = 0;

% Convert to complex notation
U=mp2complex(magtrialwt,phasetrialwt);

% Insert trial weight data
mag1stdata = [22.896 22.908 17.113 23.295 13.467 31.609 45.98 44.758 ...
    71.429];
phase1stdata = [181.529 308.361 112.893 310.491 357.747 344.899 38.756 ...
    255.395 350.849];

% Convert the magnitudes and phases for the trial weight into a B matrix
% with complex values
B = zeros(9,1);
for j = 1:9
    B(j)=mp2complex(mag1stdata(j),phase1stdata(j));
end

% Calculate the response coefficient
alpha=(B-A)/U;

% Insert the weight 0.53 at location 5.5 (90 degrees from starting location
% 3.5)
W1mag = 0.53;
W1phase = 90*pi/180;

% Convert the weight matrix into complex form
W1 = mp2complex(W1mag,W1phase);

% Calculate the predicted move after performing rotation (rotation matrix
% in complex is multiplying the vector by exp(i*theta)
predictcomplex = exp(i*W1phase)*alpha*W1mag+A

% Display prediction values in magnitude and phase
predictmag = abs(predictcomplex)
predictphs = angle(predictcomplex)*180/pi

%% Predict values example
clear,clc

% Insert zero-rotor data
magbase = [50.35 16.74 67.58 25.79 9.56 82.2 39.95 29.89 98.83];
phasebase = [217.3 6.3 115.2 219 70.8 113.7 182.4 325.5 112.5];

% Convert the magnitudes and phases for the zero-rotor data into an A 
% matrix with complex values
A = zeros(9,1);
for j = 1:9
    A(j)=mp2complex(magbase(j),phasebase(j));
end

% Insert trial weight magnitude and phase
magtrialwt = 0.33;
phasetrialwt = 0;

% Convert to complex notation
U=mp2complex(magtrialwt,phasetrialwt);

% Insert trial weight data
mag1stdata = [57.75 22.4 93.79 29.56 9.8 114.04 60.85 36.33 135.21];
phase1stdata = [223.1 25.1 122.9 215.1 86.2 128.9 204.4 1.6 133.7];

% Convert the magnitudes and phases for the trial weight into a B matrix
% with complex values
B = zeros(9,1);
for j = 1:9
    B(j)=mp2complex(mag1stdata(j),phase1stdata(j));
end

% Calculate the response coefficient
alpha=(B-A)/U;

% Insert the weight 0.53 at location 5.5 (90 degrees from starting location
% 3.5)
W1mag = 0.6;
W1phase = 5*22.5+0.344*45;

% Convert the weight matrix into complex form
W1 = mp2complex(W1mag,W1phase);

% Calculate the predicted move after performing rotation (rotation matrix
% in complex is multiplying the vector by exp(i*theta)
predictcomplex = (mp2complex(abs((B-A)*exp(1i*W1phase*pi/180))*W1mag/magtrialwt ...
    ,angle((B-A)*exp(1i*W1phase*pi/180))*180/pi)).'+A

% Display prediction values in magnitude and phase
predictmag = abs(predictcomplex)
predictphs = angle(predictcomplex)*180/pi;

for k = 1:9
    if predictphs(k) < 0
        predictphs(k) = 360+predictphs(k);
    end
end
predictphs

%%
alphamag = [27.873 25.733 85.771 12.766 7.892 123.8 85.222 64.881 169.6];
alphaphs = [9 357 254 303 96 273 349 169 286];

for k = 1:9
    alpha2(k)=mp2complex(alphamag(k),alphaphs(k));
end
alpha2

%%

%% Predict values example
clear,clc

% Insert zero-rotor data
magbase = [50.35 16.74 67.58 25.79 9.56 82.2 39.95 29.89 98.83];
phasebase = [217.3 6.3 115.2 219 70.8 113.7 182.4 325.5 112.5];

% Convert the magnitudes and phases for the zero-rotor data into an A 
% matrix with complex values
A = zeros(9,1);
for j = 1:9
    A(j)=mp2complex(magbase(j),phasebase(j));
end

% Insert trial weight magnitude and phase
magtrialwt = 0.7065;
phasetrialwt = 0;

% Convert to complex notation
U=mp2complex(magtrialwt,phasetrialwt);

% Insert trial weight data
mag1stdata = [38.83 1.3 44.67 27.84 7.15 21.41 14.32 26.19 11.86];
phase1stdata = [214.8 304.1 149.5 225 39.8 161 1 220.2 277.7];

% Convert the magnitudes and phases for the trial weight into a B matrix
% with complex values
B = zeros(9,1);
for j = 1:9
    B(j)=mp2complex(mag1stdata(j),phase1stdata(j));
end

% Calculate the response coefficient
alpha=(B-A)/U;

% Insert the weight 0.53 at location 5.5 (90 degrees from starting location
% 3.5)
W1mag = 0.62;
W1phase = 2.126;

% Convert the weight matrix into complex form
W1 = mp2complex(W1mag,W1phase);

% Calculate the predicted move after performing rotation (rotation matrix
% in complex is multiplying the vector by exp(i*theta)
predictcomplex = (mp2complex(abs((B-A)*exp(1i*W1phase*pi/180))*W1mag/magtrialwt ...
    ,angle((B-A)*exp(1i*W1phase*pi/180))*180/pi)).'+A

% Display prediction values in magnitude and phase
predictmag = abs(predictcomplex)
predictphs = angle(predictcomplex)*180/pi;

for k = 1:9
    if predictphs(k) < 0
        predictphs(k) = 360+predictphs(k);
    end
end
predictphs
