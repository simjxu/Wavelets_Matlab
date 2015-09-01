% Read 95 data file for...
disp('Read 95 header...');
% cd 'C:\Users\User\Desktop\95 data sample\DATA'

dataArray=[];

% Get header info
fid = fopen('C:\Users\User\Desktop\CTF\1vrms1000hz\DATA\2014157105935E004_01_001.data')

% Time start
r1 = fread(fid,19, 'char=>char');

% Sampling rate
r2 = fread(fid,1, 'uint32');

% Number of channels
r3 = fread(fid,1, 'uint16');

% Unimportant
r4 = fread(fid,5, 'char=>char');
r5 = fread(fid,2, 'uint8');

%Read data
dataInput = fread(fid, 'float32');

[x y] = size(dataInput);
colums= x/r3;
dataArray = reshape(dataInput, 32, colums)';

fclose(fid);
disp('Done read');
