clear all;

cd 'C:\Users\User\Desktop\95 data sample\DATA'

% fid = fopen('2008254225202E001_101.data', 'r', 'l', 'US-ASCII');
% 
% tline = fgetl(fid);
% while ischar(tline)
%     disp(tline);
%     tline = fgetl(fid);
% end
% 
% fclose(fid);
dataArray=[];


fid = fopen('2008254225202E001_101.data')
r1 = fread(fid,19, 'char=>char');
r2 = fread(fid,1, 'uint32');
r3 = fread(fid,1, 'uint16');
r4 = fread(fid,5, 'char=>char');
r5 = fread(fid,2, 'uint8');
dataInput = fread(fid, 'float32');

[x y] = size(dataInput);
colums= x/r3;
dataArray = reshape(dataInput, 32, colums)';


% while(isempty(dataLine)==0)
%     dataArray=[dataArray; dataLine]
%     dataLine = fread(fid, 32, 'float32')'
% 
% end
%m2 = fread(fid,[32 100], 'char=>char');
fclose(fid);
% 
% fid = fopen('2008254225202E001_101.data')
% m2 = fread(fid,[100 1], '*float32');
% fclose(fid



fidW = fopen('testData000-101.data','w');
w1 = fwrite(fidW,r1', 'char*1');
w2 = fwrite(fidW,r2, 'uint32');
w3 = fwrite(fidW,r3, 'uint16');
w4 = fwrite(fidW,r4', 'char*1');
w5 = fwrite(fidW,r5, 'uint8');
fclose(fidW);

