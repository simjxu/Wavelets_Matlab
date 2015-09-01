function[]=kjclook5_db_logx(filename,pathname,bgfilename,bgpathname,gainoffset,bggainoffset)
%low frequency highlighting of autospectra

%[filename,pathname]=uigetfile
ll=sprintf('load ''%s%s''',pathname,filename)
eval (ll)

openfigures=findobj('Type','figure');
openfigures=sort(openfigures);
if isempty(openfigures)
    openfigures=[0 0];
end
lastfig=round(openfigures(size(openfigures,1)));
fig1=lastfig+1;
fig2=lastfig+2;

normalize=0; % normalization flag
psvec=['b','g','r','c','m','y','k'];
%f=freq;
db=10*log10(A)+gainoffset;
clear A

[Nch,Nf]=size(db);  %Nch is number of channels, Nf is the number of spectral lines
%fs=3200*2.56;  % fs??
%nlines=Nf-1;%12800;  % nlines is one less than the number of spectral lines ??
%Nfft=2.56*nlines;  %Nfft is number of lines used by the FFT?
%df=fs/Nfft;  % df is frequency spacing (typically 1/4 Hz spacing)
f=freq; %(0:(Nf-1))*df;  % f is used, but maybe freq should be.

ch_num=1:Nch;

dbmin=-60;
dbmax=60;

%--background overlay
bg='';
try
    ll=sprintf('load ''%s%s''',bgpathname,bgfilename)
eval (ll)
bgdb=10*log10(A)+bggainoffset;
bgf=freq;
catch
    bg='NoGo';
end
%--

if(normalize),
    db=db-max(db')'*ones(1,Nf);
    dbmin=-40;
    dbmax=0;
end
figure(fig1)
set(fig1,'position',[4    32   494   665]);
f=f(1:2000);db=db(1:size(db,1),1:2000);
imagesc(f,ch_num,db,[dbmin,dbmax])
axis xy
colorbar
set(gca,'ytick',[2:2:Nch])
title(sprintf('Autospectrum of %s',filename))
%title('LEFT to select channel, MIDDLE to overplot,RIGHT to quit')

figure(fig2)
set(fig2,'position',[504   219   515   478]);

flag=1;
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
    h=plot(f,db(ich,:),psvec(ps_ind),f(iw),db(ich,iw),'.');
    if bg=='NoGo'
    else
        hold on
    plot(bgf,bgdb(ich,:),psvec(ps_ind+1),bgf(iw),bgdb(ich,iw),'.');
    end
   set(h(2),'Markersize',20);
    xlabel('Frequency (Hz)')
    ylabel('Spectrum Level dB')
    title(sprintf('FIle %s, Channel %g, cursor at %g Hz',filename,ch_num(ich),f(iw)))
    grid on
end
end


