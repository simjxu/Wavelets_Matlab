function[]=kjclook7_db_logx(filename,pathname,bgfilename,bgpathname,gainoffset,bggainoffset,refch)
% Quicklook7 - computes frf of data

%refch=input('Reference (e.g. 1): ');
%if isempty(refch),refch=1;end
%refch=1
%[filename,pathname]=uigetfile
openfigures=findobj('Type','figure');
openfigures=sort(openfigures);
if isempty(openfigures)
    openfigures=[0 0];
end
lastfig=round(openfigures(size(openfigures,1)));
fig1=lastfig+1;
fig2=lastfig+2;

ll=sprintf('load ''%s%s''',pathname,filename)
eval (ll)
refsuffix=strcat('_c',num2str(refch));
filename2=strrep(filename,'_a',refsuffix);
ll=sprintf('load ''%s%s''',pathname,filename2)
eval (ll)

[Nch,Nf]=size(C);  %Nch is number of channels, Nf is the number of spectral lines
Nch=Nch+refch;
%fs=3200*2.56;  % fs??
%nlines=Nf-1;%12800;  % nlines is one less than the number of spectral lines ??
%Nfft=2.56*nlines;  %Nfft is number of lines used by the FFT?
%df=fs/Nfft;  % df is frequency spacing (typically 1/4 Hz spacing)
f=freq; %(0:(Nf-1))*df;  % f is used, but maybe freq should be.

% Temporary Fix to format of data - new conversion scripts don't need this
%C=C.';

ch_num=refch+1:Nch;
numch=Nch-refch;

% cross=10*log10(abs(C(ch_num-refch,1:Nf)));%./(sqrt(A(ch_num,1:Nf)).*sqrt((ones(numch,1)*A(refch,1:Nf))));
ll=sprintf('load ''%s%s''',pathname,filename)
eval (ll)
frf=20*log10(abs(C(ch_num-refch,1:Nf))./A(ones(1,length(ch_num))*refch,1:Nf));


%--background underlay
try
    ll=sprintf('load ''%s%s''',bgpathname,bgfilename)
    eval (ll)    
    refsuffix=strcat('_c',num2str(refch));
    bgfilename2=strrep(bgfilename,'_a',refsuffix);
    ll=sprintf('load ''%s%s''',bgpathname,bgfilename2)
    eval (ll)
    bgfrf=20*log10(abs(C(ch_num-refch,1:Nf))./A(ones(1,length(ch_num))*refch,1:Nf));%20*log10(A)+bggainoffset;
    bgf=freq;
    bg='justfine'
catch
    bg='NoGo';
end
%--

figure(fig1)
set(fig1,'position',[4    32   494   665]);
imagesc(f,ch_num,frf)
axis xy
colorbar
set(gca,'ytick',[2:2:Nch])
title(sprintf('FRF of %s, Ref Num %g',filename,refch))


figure(fig2)
set(fig2,'position',[504   219   515   478]);

flag=1;

% while(flag),
%     figure(fig1)
%     [fp,chp,mouse]=ginput(1);
%     if mouse == 3,
%         flag=0;
%     else
%         [junk,ich]=min(abs(chp-ch_num));
%         [junk,iw]=min(abs(f-fp));
%         figure(fig2)
%         h=plot(f,frf(ich,:),f(iw),frf(ich,iw),'.');
%         set(h(2),'Markersize',20);
%         xlabel('Frequency (Hz)')
%         ylabel('Cross Spectrum')
%         title(sprintf('FIle %s, Ref Num %g, Channel %g, cursor at %g Hz',filename,refch,ch_num(ich),f(iw)))
%         grid
%     end
% end
psvec=['b','g','r','c','m','y','k'];
ps_ind=1;
while(flag),
    figure(fig1)
    [fp,chp,mouse]=ginput(1);
    if mouse == 3,
        flag=0;
    else
    [junk,ich]=min(abs(chp-ch_num));
    [junk,iw]=min(abs(f-fp));
    figure(fig2)
    if mouse == 2,
        hold on
        ps_ind=ps_ind+1;
        if ps_ind>length(psvec),
            ps_ind=1;
        end
    else
        hold off
        ps_ind=1;
    end
    h=plot(f,frf(ich,:),psvec(ps_ind),f(iw),frf(ich,iw),'.');%h=plot(f,db(ich,:),psvec(ps_ind),f(iw),db(ich,iw),'.');
    %-----background plotting----
    if strcmp(bg,'NoGo')
    else
        hold on
    plot(bgf,bgfrf(ich,:),psvec(ps_ind+1),bgf(iw),bgfrf(ich,iw),'.');
    end
    %-----/background plotting---
    set(h(2),'Markersize',20);
    xlabel('Frequency (Hz)')
    ylabel('Spectrum Level dB')
    title(sprintf('FRF, File %s, Ref Num %g, Channel %g, cursor at %g Hz',filename,refch,ch_num(ich),f(iw)))
    grid on
end
end

