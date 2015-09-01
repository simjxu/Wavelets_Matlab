%plot narrowband and oto - 4/25 pump test data 

load('C:\Users\User\Desktop\2014115141608E003_01_001_oto')


clear chan
clear chanlist
clear unit
clear unit_list


%Change column start and end to user's preference
col_start = 1;
col_end = 32;


figure
    for kk = 1:col_end-col_start+1
        unit_list(kk,1:2) = '()';
    end
    
    chanlist = [col_start:col_end]';
    
    for kk = 1:col_end - col_start + 1
    chan(kk,:) = ' Chan ';
    end

    for kk = 1:col_end - col_start + 1
    unit(kk,:) = ', Units: ';
    end
 
 
chanlists = [chan num2str(chanlist) unit  unit_list];


semilogx(cfreq, y3o(:, col_start:col_end))
title('One-Third Octave Plot')
xlabel('Center Frequency (Hz)')

    
legend(chanlists, 'Location', 'NorthEast')
grid on


figure
loglog(freq, Axx(:, col_start:col_end))
title('Narrowband Plot')
xlabel('Frequency (Hz)')
ylabel('Amplitude (Units)')
legend(chanlists, 'Location', 'NorthEast')
grid on