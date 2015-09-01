function varargout = kjcchecks(varargin)
global filename pathname tbox tbox2 refnum  bgfilename bgpathname gainoffset bggainoffset
% EJGCHECKS Application M-file for kjcchecks.fig
%    FIG = EJGCHECKS launch kjcchecks GUI.
%    EJGCHECKS('callback_name', ...) invoke the named callback.

% Last Modified by GUIDE v2.5 25-Jul-2014 15:48:45

if isempty(gainoffset)
    gainoffset=0;
end
if isempty(bggainoffset)
    bggainoffset=0;
end
if isempty(refnum)
    refnum=1;
end



if nargin == 0  % LAUNCH GUI

    fig = openfig(mfilename,'reuse');

    % Generate a structure of handles to pass to callbacks, and store it.
    handles = guihandles(fig);
    guidata(fig, handles);
    tbox=handles.text1;
    tbox2=handles.text2;
    cohbutton1=handles.pushbutton2;
    cohbutton2=handles.pushbutton11;
    set(cohbutton1,'String','Coherence, gamma')
    set(cohbutton2,'String','Coherence, gamma^2')
    if nargout > 0
        varargout{1} = fig;
    end

elseif ischar(varargin{1}) % INVOKE NAMED SUBFUNCTION OR CALLBACK

    try
        [varargout{1:nargout}] = feval(varargin{:}); % FEVAL switchyard
    catch
        disp(lasterr);
    end
%     set(tbox,'String',filename)
%     set(tbox2,'String',bgfilename)

end

% hObject=findobj('Tag','pushbutton10');
% a(:,:,1) = rand(16,128);
% a(:,:,2) = rand(16,128);
% a(:,:,3) = rand(16,128);
% set(hObject,'CData',a)

%| ABOUT CALLBACKS:
%| GUIDE automatically appends subfunction prototypes to this file, and
%| sets objects' callback properties to call them through the FEVAL
%| switchyard above. This comment describes that mechanism.
%|
%| Each callback subfunction declaration has the following form:
%| <SUBFUNCTION_NAME>(H, EVENTDATA, HANDLES, VARARGIN)
%|
%| The subfunction name is composed using the object's Tag and the
%| callback type separated by '_', e.g. 'slider2_Callback',
%| 'figure1_CloseRequestFcn', 'axis1_ButtondownFcn'.
%|
%| H is the callback object's handle (obtained using GCBO).
%|
%| EVENTDATA is empty, but reserved for future use.
%|
%| HANDLES is a structure containing handles of components in GUI using
%| tags as fieldnames, e.g. handles.figure1, handles.slider2. This
%| structure is created at GUI startup using GUIHANDLES and stored in
%| the figure's application data using GUIDATA. A copy of the structure
%| is passed to each callback.  You can store additional information in
%| this structure at GUI startup, and you can change the structure
%| during callbacks.  Call guidata(h, handles) after changing your
%| copy to replace the stored original so that subsequent callbacks see
%| the updates. Type "help guihandles" and "help guidata" for more
%| information.
%|
%| VARARGIN contains any extra arguments you have passed to the
%| callback. Specify the extra arguments by editing the callback
%| property in the inspector. By default, GUIDE sets the property to:
%| <MFILENAME>('<SUBFUNCTION_NAME>', gcbo, [], guidata(gcbo))
%| Add any extra arguments after the last argument, before the final
%| closing parenthesis.



% --------------------------------------------------------------------
function varargout = pushbutton1_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.pushbutton1.

%Autospectrum
global filename pathname bgfilename bgpathname gainoffset bggainoffset
% ejglook1_db_logx(filename,pathname, bgfilename, bgpathname, gainoffset, bggainoffset)
kjclook1_db_logx(filename,pathname, bgfilename, bgpathname, gainoffset, bggainoffset)


% --------------------------------------------------------------------
function varargout = pushbutton2_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.pushbutton2.

%Coherence Gamma
global filename pathname refnum
kjclook2_db_logx(filename,pathname,refnum,0)


% --------------------------------------------------------------------
function varargout = pushbutton3_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.pushbutton3.
global filename pathname
if isempty(pathname),pathname=[pwd '/'],end
[filename,pathname]=uigetfile('*_a.mat','Pick a set',pathname);
set(handles.text1,'String',filename);
set(handles.edt_atitle,'String',['Autospectrum of ' filename]);
set(handles.edt_ftitle,'String',['File: ' filename]);

% --------------------------------------------------------------------
function varargout = pushbutton4_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.pushbutton4.
global bgfilename bgpathname 
if isempty(bgpathname),bgpathname=[pwd '/'],end
[bgfilename,bgpathname]=uigetfile('*_a.mat','Pick Background set',bgpathname);
set(handles.text2,'String',bgfilename);


% --------------------------------------------------------------------
function varargout = popupmenu2_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.popupmenu2.
disp('popupmenu2 Callback not implemented yet.')


% --------------------------------------------------------------------
function varargout = popupmenu3_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.popupmenu3.
% Reference number picking
global refnum
refnum=get(h,'Value');
disp('popupmenu3 Callback not implemented yet.')




% --------------------------------------------------------------------
function varargout = popupmenu4_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.popupmenu4.
global gainoffset
TestGainStatus=get(h,'Value');
switch(TestGainStatus)
    case 1
        gainoffset=0;
    case 2
        gainoffset=20;
    case 3
        gainoffset=40;
    case 4
        gainoffset=-20;
    case 5
        gainoffset=-40;
end



% --------------------------------------------------------------------
function varargout = popupmenu5_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.popupmenu5.

global bggainoffset
BGGainStatus=get(h,'Value');
switch(BGGainStatus)
    case 1
        bggainoffset=0;
    case 2
        bggainoffset=20;
    case 3
        bggainoffset=40;
    case 4
        bggainoffset=-20;
    case 5
        bggainoffset=-40;
end


% --------------------------------------------------------------------
function varargout = pushbutton7_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.pushbutton7.
%disp('pushbutton7 Callback not implemented yet.')
%djmarrayth
global filename pathname bgfilename bgpathname gainoffset bggainoffset
kjclook5_db_logx(filename,pathname, bgfilename, bgpathname, gainoffset, bggainoffset)

% --------------------------------------------------------------------
function varargout = pushbutton8_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.pushbutton8.

%Cross Spectrum
global filename pathname bgfilename bgpathname gainoffset bggainoffset refnum
kjclook4_db_logx(filename,pathname, refnum)


% --------------------------------------------------------------------
function varargout = pushbutton9_Callback(h, eventdata, handles, varargin)

%Low Freq Cross Spectrum
global filename pathname bgfilename bgpathname gainoffset bggainoffset refnum
kjclook6_db_logx(filename,pathname, refnum)


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%transfer function
global filename pathname bgfilename bgpathname gainoffset bggainoffset refnum

kjclook7_db_logx(filename,pathname,bgfilename,bgpathname,gainoffset,bggainoffset, refnum)




% --------------------------------------------------------------------
function varargout = pushbutton11_Callback(h, eventdata, handles, varargin)

%Coherence gamma squared
global filename pathname refnum
kjclook2_db_logx(filename,pathname,refnum,1)



function edt_minFreq_Callback(hObject, eventdata, handles)
% hObject    handle to edt_minFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edt_minFreq as text
%        str2double(get(hObject,'String')) returns contents of edt_minFreq as a double

val = str2double(get(hObject,'String'));
if isnan(val)
    set(hObject,'String',get(hObject,'Value'));
    errordlg('Min freq must be a numeric value');
else
    set(hObject,'Value',val);
end

% --- Executes during object creation, after setting all properties.
function edt_minFreq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edt_minFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edt_maxFreq_Callback(hObject, eventdata, handles)
% hObject    handle to edt_maxFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edt_maxFreq as text
%        str2double(get(hObject,'String')) returns contents of edt_maxFreq as a double

val = str2double(get(hObject,'String'));
if isnan(val)
    set(hObject,'String',get(hObject,'Value'));
    errordlg('Max freq must be a numeric value');
else
    set(hObject,'Value',val);
end

% --- Executes during object creation, after setting all properties.
function edt_maxFreq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edt_maxFreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pm_xscale.
function pm_xscale_Callback(hObject, eventdata, handles)
% hObject    handle to pm_xscale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns pm_xscale contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_xscale


% --- Executes during object creation, after setting all properties.
function pm_xscale_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_xscale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edt_amin_Callback(hObject, eventdata, handles)
% hObject    handle to edt_amin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edt_amin as text
%        str2double(get(hObject,'String')) returns contents of edt_amin as a double

val = str2double(get(hObject,'String'));
if isnan(val)
    set(hObject,'String',get(hObject,'Value'));
    errordlg('Min freq must be a numeric value');
else
    set(hObject,'Value',val);
end


% --- Executes during object creation, after setting all properties.
function edt_amin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edt_amin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edt_amax_Callback(hObject, eventdata, handles)
% hObject    handle to edt_amax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edt_amax as text
%        str2double(get(hObject,'String')) returns contents of edt_amax as a double

val = str2double(get(hObject,'String'));
if isnan(val)
    set(hObject,'String',get(hObject,'Value'));
    errordlg('Max freq must be a numeric value');
else
    set(hObject,'Value',val);
end


% --- Executes during object creation, after setting all properties.
function edt_amax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edt_amax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edt_atitle_Callback(hObject, eventdata, handles)
% hObject    handle to edt_atitle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edt_atitle as text
%        str2double(get(hObject,'String')) returns contents of edt_atitle as a double


% --- Executes during object creation, after setting all properties.
function edt_atitle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edt_atitle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edt_axlabel_Callback(hObject, eventdata, handles)
% hObject    handle to edt_axlabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edt_axlabel as text
%        str2double(get(hObject,'String')) returns contents of edt_axlabel as a double


% --- Executes during object creation, after setting all properties.
function edt_axlabel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edt_axlabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edt_aylabel_Callback(hObject, eventdata, handles)
% hObject    handle to edt_aylabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edt_aylabel as text
%        str2double(get(hObject,'String')) returns contents of edt_aylabel as a double


% --- Executes during object creation, after setting all properties.
function edt_aylabel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edt_aylabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edt_ftitle_Callback(hObject, eventdata, handles)
% hObject    handle to edt_ftitle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edt_ftitle as text
%        str2double(get(hObject,'String')) returns contents of edt_ftitle as a double


% --- Executes during object creation, after setting all properties.
function edt_ftitle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edt_ftitle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edt_fxlabel_Callback(hObject, eventdata, handles)
% hObject    handle to edt_fxlabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edt_fxlabel as text
%        str2double(get(hObject,'String')) returns contents of edt_fxlabel as a double


% --- Executes during object creation, after setting all properties.
function edt_fxlabel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edt_fxlabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edt_fylabel_Callback(hObject, eventdata, handles)
% hObject    handle to edt_fylabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edt_fylabel as text
%        str2double(get(hObject,'String')) returns contents of edt_fylabel as a double


% --- Executes during object creation, after setting all properties.
function edt_fylabel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edt_fylabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pm_options.
function pm_options_Callback(hObject, eventdata, handles)
% hObject    handle to pm_options (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns pm_options contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pm_options

% --- Executes during object creation, after setting all properties.
function pm_options_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pm_options (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in rb_autospectra.
function rb_autospectra_Callback(hObject, eventdata, handles)
% hObject    handle to rb_autospectra (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rb_autospectra


% --- Executes on button press in rb_freq.
function rb_freq_Callback(hObject, eventdata, handles)
% hObject    handle to rb_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rb_freq


% --------------------------------------------------------------------
function panel_options_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to panel_options (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

o = get(handles.panel_options,'SelectedObject');
str = get(o,'String');

switch str
    case 'Autospectra'
        set(handles.panel_autospectra,'Visible','on');
        set(handles.panel_freq,'Visible','off');
    case 'Frequency'
        set(handles.panel_autospectra,'Visible','off');
        set(handles.panel_freq,'Visible','on');
end


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
close all;
delete(hObject);


% --- Executes on button press in ckbx_chan.
function ckbx_chan_Callback(hObject, eventdata, handles)
% hObject    handle to ckbx_chan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ckbx_chan

if get(hObject,'Value')
    try
        [f p] = uigetfile('*.xls','Select Channel File');
        [num, txt]= xlsread([p f]);
        whos txt
        setappdata(handles.figure1,'chanText',txt);
        
    catch
        errordlg(lasterr);
    end
end
