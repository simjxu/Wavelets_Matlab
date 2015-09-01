function[]=kjclook1_db_logx(filename,pathname,bgfilename,bgpathname,gainoffset,bggainoffset)
%plots autospectra

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

%20050809djm for some reason, the dynamic range was hard-coded, fixed it to
%just do max and min values.  Would probably be good to allow this to be
%user-defined at some point
dbmax=max(max(db));
dbmin=min(min(db));
% dbmin=-60;
% dbmax=60;
%/20050809djm

%--background overlay
try
    ll=sprintf('load ''%s%s''',bgpathname,bgfilename)
    eval (ll)
    bgdb=10*log10(A)+bggainoffset;
    bgf=freq;
    bg='justfine'
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
imagesc(f,ch_num,db,[dbmin,dbmax])
axis xy
try
    colorbar
catch
    errordlg(lasterr)
end
set(gca,'ytick',[2:2:Nch])
% title(sprintf('Autospectrum of %s',filename))
aTit = get(findobj('Tag','edt_atitle'));
title(strrep(aTit.String,'_','\_'))
xLab = get(findobj('Tag','edt_axlabel'));
yLab = get(findobj('Tag','edt_aylabel'));
xlabel(xLab.String);
ylabel(yLab.String);

%title('LEFT to select channel, MIDDLE to overplot,RIGHT to quit')
minF = get(findobj('Tag','edt_amin'));
maxF = get(findobj('Tag','edt_amax'));
xlim([minF.Value maxF.Value]);
figure(fig2)
set(fig2,'position',[504   219   515   478]);

flag=1;
ps_ind=1;
while(flag),
    figure(fig1)
    [fp,chp,mouse]=ginput(1);
    % 20050809djm warning! Shift key now counts as gui input in R14(???) need to fix this..
    if mouse == 3
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
%% >>> kjc 2/26/07        
        xScale=get(findobj('Tag','pm_xscale'));
        if xScale.Value == 1
            h=semilogx(f,db(ich,:),psvec(ps_ind),f(iw),db(ich,iw),'.','Linewidth',2);
        elseif xScale.Value == 2
            h=plot(f,db(ich,:),psvec(ps_ind),f(iw),db(ich,iw),'.','Linewidth',2);
        end
        
%% <<<        
%         xlim([10 3000])
        setXlim()   %>> kjc 2/22/07

        if strcmp(bg,'NoGo')
        else
%% >>> kjc 2/26/07        
        xScale=get(findobj('Tag','pm_xscale'));
         hold on
        if xScale.Value == 1
            semilogx(bgf,bgdb(ich,:),psvec(ps_ind+1),bgf(iw),bgdb(ich,iw),'.','Linewidth',2);
        elseif xScale.Value == 2
            plot(bgf,bgdb(ich,:),psvec(ps_ind+1),bgf(iw),bgdb(ich,iw),'.','Linewidth',2);
        end
%% <<<
%             xlim([10 12800])
         setXlim() %>> kjc 2/22/07
         
        end
        set(h(2),'Markersize',10);
        fTit = get(findobj('Tag','edt_ftitle'));
        xLab = get(findobj('Tag','edt_fxlabel'));
        yLab = get(findobj('Tag','edt_fylabel'));
        xlabel(xLab.String)
        ylabel(yLab.String)
%         title(strrep(sprintf('File %s, Channel %g, cursor at %g Hz',filename,ch_num(ich),f(iw)),'_','\_'));
        title(strrep(sprintf('%s, Channel %g, cursor at %g Hz',fTit.String,ch_num(ich),f(iw)),'_','\_'));
        grid on
    end
end

%% >>> kjc 2/22/07

function setXlim()
% check to see if x limits were provided and are valid numbers
    try
        xmin = get(findobj('Tag','edt_minFreq'));
        xmax = get(findobj('Tag','edt_maxFreq'));
        xmin = str2double(xmin.String);
        xmax = str2double(xmax.String);
        if ~isnan(xmin) && ~isnan(xmax)
            xlim([xmin xmax]);
        end

    catch
        errmsg = lasterr;
        error(errmsg);
    end
    
%% <<<

