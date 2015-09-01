% Read B&K for test result on 77H PFW Pump and VDM Unit 
% Test Date: 2014-02-21

path(path,'C:\Users\Dr. Ed Graesserr\Documents\Kirk_Crofoot\kjc\kjcChecks')
path(path,'C:\Users\Dr. Ed Graesserr\Documents\ThirdOctave')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all; clear global

data_folder_BandK_file  = 'C:\Users\Dr. Ed Graesserr\Documents\Pump_Flow\Pump_633_Paco_2014\Paco_2014_BandK_Test_Data\Processed_Excels_07_03_14\';
data_BandK_xls_filename = '26 June 14 pt1 Autospectrum reject on.xlsx';

Removed_chans = [35];

data_folder_mat_file    = 'C:\Users\Dr. Ed Graesserr\Documents\Pump_Flow\Pump_633_Paco_2014\Paco_mat_data\';
data_mat_filename       = 'Paco_2014_Des_Curve_Test_1_1101_2014_06_26';

BandK_data_folder_xls_file = [data_folder_BandK_file data_BandK_xls_filename];
BandK_data_folder_mat_file = [data_folder_mat_file data_mat_filename];

InputFileType = 2;  % Equals 1 if loading measured data from B&K xlsx file.
                    % Equals 2 if loading measured data from saved Matlab (*.mat) file
                    
NumFiles = 1;

A_sheet1 = 'BK.data';  Oper1 = ', 1100 rpm, 3500 gpm, 69.3 ft head';

if InputFileType == 1

f_A_NB_SPL_range =   'I11:P102411';
A_NB_Vib_range =   'CA11:DZ102411';
f_A_OTO_SPL_range =  'A11:H49';
A_OTO_Vib_range =  'Z11:BY49';
f_A_SynOTO_SPL_range =  'Q11:X50';
A_SynOTO_Vib_range =  'EB11:GA50';

% Load B&K Auto Spectrum data from Excel file

A_NB_dB      = zeros(102401,60,6);
A_OTO_dB     = zeros(39,60,6);
A_SynOTO_dB  = zeros(40,60,6);

% data_full = zeros(102411,186);
freq_A_NB_SPL_dB     = zeros(102411,8);
freq_A_OTO_SPL_dB    = zeros(39,8);
freq_A_SynOTO_SPL_dB = zeros(40,8);
A_NB_SBN_dB          = zeros(102411,53);
A_OTO_SBN_dB         = zeros(39,53);
A_SynOTO_SBN_dB      = zeros(40,53);

for kk = 1:NumFiles
    eval(['freq_A_NB_SPL_dB     = xlsread(''' BandK_data_folder_xls_file ''',' strcat('A_sheet',num2str(kk)) ',''' f_A_NB_SPL_range ''');'])
    eval(['freq_A_OTO_SPL_dB    = xlsread(''' BandK_data_folder_xls_file ''',' strcat('A_sheet',num2str(kk)) ',''' f_A_OTO_SPL_range ''');'])
    eval(['freq_A_SynOTO_SPL_dB = xlsread(''' BandK_data_folder_xls_file ''',' strcat('A_sheet',num2str(kk)) ',''' f_A_SynOTO_SPL_range ''');'])
    eval(['A_NB_SBN_dB     = xlsread(''' BandK_data_folder_xls_file ''',' strcat('A_sheet',num2str(kk)) ',''' A_NB_Vib_range ''');'])
    eval(['A_OTO_SBN_dB    = xlsread(''' BandK_data_folder_xls_file ''',' strcat('A_sheet',num2str(kk)) ',''' A_OTO_Vib_range ''');'])
    eval(['A_SynOTO_SBN_dB = xlsread(''' BandK_data_folder_xls_file ''',' strcat('A_sheet',num2str(kk)) ',''' A_SynOTO_Vib_range ''');'])

    freq_NB     = freq_A_NB_SPL_dB(:,1);
    freq_OTO    = freq_A_OTO_SPL_dB(:,1);
    freq_SynOTO = freq_A_SynOTO_SPL_dB(:,1);
    
    A_NB_FBN_case = (20)^2*10.^(freq_A_NB_SPL_dB(:,2:6)/10);  % Discharge Hydrophone pair, P2 (Pa_rms / 1e-6 Pa_rms)^2  Note: Use 20 as leading factor because 20 = 20e-6/1e-6, for FBN uPa ref
       A_NB_FBN = A_NB_FBN_case(:,[5 4 3 1 2]);  % Five hydrophones organized as follows:
                    % Suction Hydrophone P1  
                    % Discharge Hydrophone P1 
                    % Suction Hydrophone, P2 
                    % Discharge Hydrophone pair, P2 
    A_NB_ABN_case = 10.^(freq_A_NB_SPL_dB(:,7:8)/10);  % Microphones P2 and P1 (Pa_rms / 20e-6 Pa_rms)^2
       A_NB_ABN = A_NB_ABN_case(:,[2 1]);        % Microphones P1 and P2
    A_NB_SBN_case = (1/9.81)^2*10.^(A_NB_SBN_dB/10); % (g_rms  / 1e-6 g_rms)^2   Note: Use 1/9.81 as leading factor for ug SBN ref
       A_NB_Pump2_Floor   = A_NB_SBN_case(:,(6)-5);       % Seismic Accel on floor/foundation of P2
       A_NB_SBN_R1        = A_NB_SBN_case(:,(39:46)-7);   % Ring on P1 inlet
%        A_NB_SBN_R2        = A_NB_SBN_case(:,(31:38)-6);   % Ring on P2 inlet
       A_NB_SBN_R2_1        = A_NB_SBN_case(:,(31:34)-6);   % 1st four of Ring on P2 inlet
       A_NB_SBN_R2_2        = ones(length(freq_NB),1);   % removed channel on processed Ring on P2 inlet
       A_NB_SBN_R2_3        = A_NB_SBN_case(:,(36:38)-7);   % lasr three of Ring on P2 inlet
       A_NB_SBN_R2        = [A_NB_SBN_R2_1 A_NB_SBN_R2_2 A_NB_SBN_R2_3];   % Ring on P2 inlet
       A_NB_SBN_R3        = A_NB_SBN_case(:,(7:14)-5);    % Ring on supply header
       A_NB_Pump1_Case    = A_NB_SBN_case(:,(57)-8);      % Radial on P1 case
       A_NB_Pump1_VAT     = A_NB_SBN_case(:,(50:52)-7);   % Triax VAT at P1 discharge flange
       A_NB_Pump2_Case    = A_NB_SBN_case(:,(59)-8);      % Radial on P2 case
       A_NB_Pump2_VAT     = A_NB_SBN_case(:,(15:17)-5);   % Triax VAT at P2 discharge flange
       A_NB_Motor1_Frame  = A_NB_SBN_case(:,(58)-8);      % Radial on P1 motor housing
       A_NB_Motor1_VAT    = A_NB_SBN_case(:,(53:55)-7);   % Triax VAT at motor foot/base
       A_NB_Motor2_Frame  = A_NB_SBN_case(:,(60)-8);      % Radial on P2 motor housing
       A_NB_Motor2_VAT    = A_NB_SBN_case(:,(47:2:49)-7); % Triax VAT at motor foot/base
       A_NB_Orifice       = A_NB_SBN_case(:,(48)-7);      % On pipe near orifice
       A_NB_HX_inlet_VAT  = A_NB_SBN_case(:,(19:21)-6);   % Triax VAT at HX inlet pipe flange
       A_NB_HX_outlet_VAT = A_NB_SBN_case(:,(22:24)-6);   % Triax VAT at HX outlet pipe flange
       A_NB_Slab          = A_NB_SBN_case(:,(29:30)-6);   % Seismic accel pair on slab (vertical)
       A_NB_Pit           = A_NB_SBN_case(:,(25:26)-6);   % Seismic accel pair in pit (vertical)
       A_NB_Tblock        = A_NB_SBN_case(:,(27:28)-6);   % Seismic accel pair on Tblock far side of pit (vertical)
    
    A_OTO_FBN_case = (20)^2*10.^(freq_A_OTO_SPL_dB(:,2:6)/10);  % Discharge Hydrophone pair, P2 (Pa_rms / 1e-6 Pa_rms)^2  Note: Use 20 as leading factor because 20 = 20e-6/1e-6, for FBN uPa ref
       A_OTO_FBN = A_OTO_FBN_case(:,[5 4 3 1 2]);  % Five hydrophones organized as follows:
                    % Suction Hydrophone P1  
                    % Discharge Hydrophone P1 
                    % Suction Hydrophone, P2 
                    % Discharge Hydrophone pair, P2 
    A_OTO_ABN_case = 10.^(freq_A_OTO_SPL_dB(:,7:8)/10);  % Microphones P2 and P1 (Pa_rms / 20e-6 Pa_rms)^2
       A_OTO_ABN = A_OTO_ABN_case(:,[2 1]);        % Microphones P1 and P2
    A_OTO_SBN_case = (1/9.81)^2*10.^(A_OTO_SBN_dB/10); % (g_rms  / 1e-6 g_rms)^2   Note: Use 1/9.81 as leading factor for ug SBN ref
       A_OTO_Pump2_Floor   = A_OTO_SBN_case(:,(6)-5);       % Seismic Accel on floor/foundation of P2
       A_OTO_SBN_R1        = A_OTO_SBN_case(:,(39:46)-7);   % Ring on P1 inlet
%        A_OTO_SBN_R2        = A_OTO_SBN_case(:,(31:38)-6);   % Ring on P2 inlet
       A_OTO_SBN_R2_1        = A_OTO_SBN_case(:,(31:34)-6);   % 1st four of Ring on P2 inlet
       A_OTO_SBN_R2_2        = ones(length(freq_OTO),1);   % removed channel on processed Ring on P2 inlet
       A_OTO_SBN_R2_3        = A_OTO_SBN_case(:,(36:38)-7);   % lasr three of Ring on P2 inlet
       A_OTO_SBN_R2        = [A_OTO_SBN_R2_1 A_OTO_SBN_R2_2 A_OTO_SBN_R2_3];   % Ring on P2 inlet
       A_OTO_SBN_R3        = A_OTO_SBN_case(:,(7:14)-5);    % Ring on supply header
       A_OTO_Pump1_Case    = A_OTO_SBN_case(:,(57)-8);      % Radial on P1 case
       A_OTO_Pump1_VAT     = A_OTO_SBN_case(:,(50:52)-7);   % Triax VAT at P1 discharge flange
       A_OTO_Pump2_Case    = A_OTO_SBN_case(:,(59)-8);      % Radial on P2 case
       A_OTO_Pump2_VAT     = A_OTO_SBN_case(:,(15:17)-5);   % Triax VAT at P2 discharge flange
       A_OTO_Motor1_Frame  = A_OTO_SBN_case(:,(58)-8);      % Radial on P1 motor housing
       A_OTO_Motor1_VAT    = A_OTO_SBN_case(:,(53:55)-7);   % Triax VAT at motor foot/base
       A_OTO_Motor2_Frame  = A_OTO_SBN_case(:,(60)-8);      % Radial on P2 motor housing
       A_OTO_Motor2_VAT    = A_OTO_SBN_case(:,(47:2:49)-7); % Triax VAT at motor foot/base
       A_OTO_Orifice       = A_OTO_SBN_case(:,(48)-7);      % On pipe near orifice
       A_OTO_HX_inlet_VAT  = A_OTO_SBN_case(:,(19:21)-6);   % Triax VAT at HX inlet pipe flange
       A_OTO_HX_outlet_VAT = A_OTO_SBN_case(:,(22:24)-6);   % Triax VAT at HX outlet pipe flange
       A_OTO_Slab          = A_OTO_SBN_case(:,(29:30)-6);   % Seismic accel pair on slab (vertical)
       A_OTO_Pit           = A_OTO_SBN_case(:,(25:26)-6);   % Seismic accel pair in pit (vertical)
       A_OTO_Tblock        = A_OTO_SBN_case(:,(27:28)-6);   % Seismic accel pair on Tblock far side of pit (vertical)
%        A_OTO_Pump2_Floor   = A_OTO_SBN_case(:,(6)-5);       % Seismic Accel on floor/foundation of P2
%        A_OTO_SBN_R1        = A_OTO_SBN_case(:,(39:46)-6);   % Ring on P1 inlet
%        A_OTO_SBN_R2        = A_OTO_SBN_case(:,(31:38)-6);   % Ring on P2 inlet
%        A_OTO_SBN_R3        = A_OTO_SBN_case(:,(7:14)-5);    % Ring on supply header
%        A_OTO_Pump1_Case    = A_OTO_SBN_case(:,(57)-7);      % Radial on P1 case
%        A_OTO_Pump1_VAT     = A_OTO_SBN_case(:,(50:52)-6);   % Triax VAT at P1 discharge flange
%        A_OTO_Pump2_Case    = A_OTO_SBN_case(:,(59)-7);      % Radial on P2 case
%        A_OTO_Pump2_VAT     = A_OTO_SBN_case(:,(15:17)-5);   % Triax VAT at P2 discharge flange
%        A_OTO_Motor1_Frame  = A_OTO_SBN_case(:,(58)-7);      % Radial on P1 motor housing
%        A_OTO_Motor1_VAT    = A_OTO_SBN_case(:,(53:55)-6);   % Triax VAT at motor foot/base
%        A_OTO_Motor2_Frame  = A_OTO_SBN_case(:,(60)-7);      % Radial on P2 motor housing
%        A_OTO_Motor2_VAT    = A_OTO_SBN_case(:,(47:2:49)-6); % Triax VAT at motor foot/base
%        A_OTO_Orifice       = A_OTO_SBN_case(:,(48)-6);      % On pipe near orifice
%        A_OTO_HX_inlet_VAT  = A_OTO_SBN_case(:,(19:21)-6);   % Triax VAT at HX inlet pipe flange
%        A_OTO_HX_outlet_VAT = A_OTO_SBN_case(:,(22:24)-6);   % Triax VAT at HX outlet pipe flange
%        A_OTO_Slab          = A_OTO_SBN_case(:,(29:30)-6);   % Seismic accel pair on slab (vertical)
%        A_OTO_Pit           = A_OTO_SBN_case(:,(25:26)-6);   % Seismic accel pair in pit (vertical)
%        A_OTO_Tblock        = A_OTO_SBN_case(:,(27:28)-6);   % Seismic accel pair on Tblock far side of pit (vertical)

    A_SynOTO_FBN_case = (20)^2*10.^(freq_A_SynOTO_SPL_dB(:,2:6)/10);  % Discharge Hydrophone pair, P2 (Pa_rms / 1e-6 Pa_rms)^2  Note: Use 20 as leading factor because 20 = 20e-6/1e-6, for FBN uPa ref
       A_SynOTO_FBN = A_SynOTO_FBN_case(:,[5 4 3 1 2]);  % Five hydrophones organized as follows:
                    % Suction Hydrophone P1  
                    % Discharge Hydrophone P1 
                    % Suction Hydrophone, P2 
                    % Discharge Hydrophone pair, P2 
    A_SynOTO_ABN_case = 10.^(freq_A_SynOTO_SPL_dB(:,7:8)/10);  % Microphones P2 and P1 (Pa_rms / 20e-6 Pa_rms)^2  Note: data are already referred to 20 uPa (std for microphone)
       A_SynOTO_ABN = A_SynOTO_ABN_case(:,[2 1]);        % Microphones P1 and P2
    A_SynOTO_SBN_case = (1/9.81)^2*10.^(A_SynOTO_SBN_dB/10); % (g_rms  / 1e-6 g_rms)^2   Note: Use 1/9.81 as leading factor for ug SBN ref
       A_SynOTO_Pump2_Floor   = A_SynOTO_SBN_case(:,(6)-5);       % Seismic Accel on floor/foundation of P2
       A_SynOTO_SBN_R1        = A_SynOTO_SBN_case(:,(39:46)-7);   % Ring on P1 inlet
%        A_SynOTO_SBN_R2        = A_SynOTO_SBN_case(:,(31:38)-6);   % Ring on P2 inlet
       A_SynOTO_SBN_R2_1        = A_SynOTO_SBN_case(:,(31:34)-6);   % 1st four of Ring on P2 inlet
       A_SynOTO_SBN_R2_2        = ones(length(freq_SynOTO),1);   % removed channel on processed Ring on P2 inlet
       A_SynOTO_SBN_R2_3        = A_SynOTO_SBN_case(:,(36:38)-7);   % lasr three of Ring on P2 inlet
       A_SynOTO_SBN_R2        = [A_SynOTO_SBN_R2_1 A_SynOTO_SBN_R2_2 A_SynOTO_SBN_R2_3];   % Ring on P2 inlet
       A_SynOTO_SBN_R3        = A_SynOTO_SBN_case(:,(7:14)-5);    % Ring on supply header
       A_SynOTO_Pump1_Case    = A_SynOTO_SBN_case(:,(57)-8);      % Radial on P1 case
       A_SynOTO_Pump1_VAT     = A_SynOTO_SBN_case(:,(50:52)-7);   % Triax VAT at P1 discharge flange
       A_SynOTO_Pump2_Case    = A_SynOTO_SBN_case(:,(59)-8);      % Radial on P2 case
       A_SynOTO_Pump2_VAT     = A_SynOTO_SBN_case(:,(15:17)-5);   % Triax VAT at P2 discharge flange
       A_SynOTO_Motor1_Frame  = A_SynOTO_SBN_case(:,(58)-8);      % Radial on P1 motor housing
       A_SynOTO_Motor1_VAT    = A_SynOTO_SBN_case(:,(53:55)-7);   % Triax VAT at motor foot/base
       A_SynOTO_Motor2_Frame  = A_SynOTO_SBN_case(:,(60)-8);      % Radial on P2 motor housing
       A_SynOTO_Motor2_VAT    = A_SynOTO_SBN_case(:,(47:2:49)-7); % Triax VAT at motor foot/base
       A_SynOTO_Orifice       = A_SynOTO_SBN_case(:,(48)-7);      % On pipe near orifice
       A_SynOTO_HX_inlet_VAT  = A_SynOTO_SBN_case(:,(19:21)-6);   % Triax VAT at HX inlet pipe flange
       A_SynOTO_HX_outlet_VAT = A_SynOTO_SBN_case(:,(22:24)-6);   % Triax VAT at HX outlet pipe flange
       A_SynOTO_Slab          = A_SynOTO_SBN_case(:,(29:30)-6);   % Seismic accel pair on slab (vertical)
       A_SynOTO_Pit           = A_SynOTO_SBN_case(:,(25:26)-6);   % Seismic accel pair in pit (vertical)
       A_SynOTO_Tblock        = A_SynOTO_SBN_case(:,(27:28)-6);   % Seismic accel pair on Tblock far side of pit (vertical)
%        A_SynOTO_Pump2_Floor   = A_SynOTO_SBN_case(:,(6)-5);       % Seismic Accel on floor/foundation of P2
%        A_SynOTO_SBN_R1        = A_SynOTO_SBN_case(:,(39:46)-6);   % Ring on P1 inlet
%        A_SynOTO_SBN_R2        = A_SynOTO_SBN_case(:,(31:38)-6);   % Ring on P2 inlet
%        A_SynOTO_SBN_R3        = A_SynOTO_SBN_case(:,(7:14)-5);    % Ring on supply header
%        A_SynOTO_Pump1_Case    = A_SynOTO_SBN_case(:,(57)-7);      % Radial on P1 case
%        A_SynOTO_Pump1_VAT     = A_SynOTO_SBN_case(:,(50:52)-6);   % Triax VAT at P1 discharge flange
%        A_SynOTO_Pump2_Case    = A_SynOTO_SBN_case(:,(59)-7);      % Radial on P2 case
%        A_SynOTO_Pump2_VAT     = A_SynOTO_SBN_case(:,(15:17)-5);   % Triax VAT at P2 discharge flange
%        A_SynOTO_Motor1_Frame  = A_SynOTO_SBN_case(:,(58)-7);      % Radial on P1 motor housing
%        A_SynOTO_Motor1_VAT    = A_SynOTO_SBN_case(:,(53:55)-6);   % Triax VAT at motor foot/base
%        A_SynOTO_Motor2_Frame  = A_SynOTO_SBN_case(:,(60)-7);      % Radial on P2 motor housing
%        A_SynOTO_Motor2_VAT    = A_SynOTO_SBN_case(:,(47:2:49)-6); % Triax VAT at motor foot/base
%        A_SynOTO_Orifice       = A_SynOTO_SBN_case(:,(48)-6);      % On pipe near orifice
%        A_SynOTO_HX_inlet_VAT  = A_SynOTO_SBN_case(:,(19:21)-6);   % Triax VAT at HX inlet pipe flange
%        A_SynOTO_HX_outlet_VAT = A_SynOTO_SBN_case(:,(22:24)-6);   % Triax VAT at HX outlet pipe flange
%        A_SynOTO_Slab          = A_SynOTO_SBN_case(:,(29:30)-6);   % Seismic accel pair on slab (vertical)
%        A_SynOTO_Pit           = A_SynOTO_SBN_case(:,(25:26)-6);   % Seismic accel pair in pit (vertical)
%        A_SynOTO_Tblock        = A_SynOTO_SBN_case(:,(27:28)-6);   % Seismic accel pair on Tblock far side of pit (vertical)
    
    freq = freq_NB.';
    A = [A_NB_FBN ...
         A_NB_ABN ...
         A_NB_Pump2_Floor ...
         A_NB_SBN_R1 ...
         A_NB_SBN_R2 ...
         A_NB_SBN_R3 ...
         A_NB_Pump1_Case ...
         A_NB_Pump1_VAT ...
         A_NB_Pump2_Case ...
         A_NB_Pump2_VAT ...
         A_NB_Motor1_Frame ...
         A_NB_Motor1_VAT ...
         A_NB_Motor2_Frame ...
         A_NB_Motor2_VAT ...
         A_NB_Orifice ...
         A_NB_HX_inlet_VAT ...
         A_NB_HX_outlet_VAT ...
         A_NB_Slab ...
         A_NB_Pit ...
         A_NB_Tblock ].';
%     save_filename = strcat(eval(['BandK_data_folder_mat_file']),'_',eval(['A_sheet' num2str(kk) '']),'_NB_a');
%     save_filename = strrep(eval(['save_filename']),'.','_')
    save_filename = strcat(eval(['BandK_data_folder_mat_file']),'_NB_a');
    eval(['save ''' save_filename ''' freq A';])
    A_NB_dB(:,:,kk)     = 10*log10(A.');
    
    freq = freq_OTO.';
    A = [A_OTO_FBN ...
         A_OTO_ABN ...
         A_OTO_Pump2_Floor ...
         A_OTO_SBN_R1 ...
         A_OTO_SBN_R2 ...
         A_OTO_SBN_R3 ...
         A_OTO_Pump1_Case ...
         A_OTO_Pump1_VAT ...
         A_OTO_Pump2_Case ...
         A_OTO_Pump2_VAT ...
         A_OTO_Motor1_Frame ...
         A_OTO_Motor1_VAT ...
         A_OTO_Motor2_Frame ...
         A_OTO_Motor2_VAT ...
         A_OTO_Orifice ...
         A_OTO_HX_inlet_VAT ...
         A_OTO_HX_outlet_VAT ...
         A_OTO_Slab ...
         A_OTO_Pit ...
         A_OTO_Tblock ].';
%     save_filename = strcat(eval(['BandK_data_folder_mat_file']),'_',eval(['A_sheet' num2str(kk) '']),'_OTO_a');
%     save_filename = strrep(eval(['save_filename']),'.','_')
    save_filename = strcat(eval(['BandK_data_folder_mat_file']),'_OTO_a');
    eval(['save ''' save_filename ''' freq A';])
    A_OTO_dB(:,:,kk) = 10*log10(A.');

    freq = freq_SynOTO.';
    A = [A_SynOTO_FBN ...
         A_SynOTO_ABN ...
         A_SynOTO_Pump2_Floor ...
         A_SynOTO_SBN_R1 ...
         A_SynOTO_SBN_R2 ...
         A_SynOTO_SBN_R3 ...
         A_SynOTO_Pump1_Case ...
         A_SynOTO_Pump1_VAT ...
         A_SynOTO_Pump2_Case ...
         A_SynOTO_Pump2_VAT ...
         A_SynOTO_Motor1_Frame ...
         A_SynOTO_Motor1_VAT ...
         A_SynOTO_Motor2_Frame ...
         A_SynOTO_Motor2_VAT ...
         A_SynOTO_Orifice ...
         A_SynOTO_HX_inlet_VAT ...
         A_SynOTO_HX_outlet_VAT ...
         A_SynOTO_Slab ...
         A_SynOTO_Pit ...
         A_SynOTO_Tblock ].';
%     save_filename = strcat(eval(['BandK_data_folder_mat_file']),'_',eval(['A_sheet' num2str(kk) '']),'_SynOTO_a');
%     save_filename = strrep(eval(['save_filename']),'.','_')
    save_filename = strcat(eval(['BandK_data_folder_mat_file']),'_SynOTO_a');
    eval(['save ''' save_filename ''' freq A';])
    A_SynOTO_dB(:,:,kk) = 10*log10(A.');
    
    disp(strcat('Completed step #', num2str(kk),' of 6'))
end; clear kk
clear *range 

eval(['save ''' BandK_data_folder_mat_file ''' freq_NB freq_OTO freq_SynOTO A_NB_dB A_OTO_dB A_SynOTO_dB A_sheet* Oper* '])

end

if InputFileType == 2

eval(['load ''' BandK_data_folder_mat_file ''''])

end

for kk = 1:NumFiles
    eval(['title_info = strcat(strrep(A_sheet' num2str(kk) ', ''_'', '' ''), Oper' num2str(kk) ')'])
    figure
    semilogx(freq_OTO,A_OTO_dB(:,1:2,kk),'Linewidth',1)
    hold on
    semilogx(freq_SynOTO,A_SynOTO_dB(:,1:2,kk),':','Linewidth',1)
    semilogx(freq_NB,A_NB_dB(:,1:2,kk),'Linewidth',1)
    eval(['title(''FBN Hydrophones (' title_info ')'')'])
    ylabel('FBN (dB re: 1 uPa)')
    legend('P1 Suction','P1 Discharge')
    xlim([1 13000])
    xlabel('(Hz)')
    xlim([1 13000])
    grid on
end
