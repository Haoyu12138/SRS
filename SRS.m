function varargout = SRS(varargin)
% SRS MATLAB code for SRS.fig
%      SRS, by itself, creates a new SRS or raises the existing
%      singleton*.
%
%      H = SRS returns the handle to a new SRS or the handle to
%      the existing singleton*.
%
%      SRS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SRS.M with the given input arguments.
%
%      SRS('Property','Value',...) creates a new SRS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SRS_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SRS_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SRS

% Last Modified by GUIDE v2.5 01-Mar-2019 10:03:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SRS_OpeningFcn, ...
                   'gui_OutputFcn',  @SRS_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before SRS is made visible.
function SRS_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SRS (see VARARGIN)


% Choose default command line output for SRS
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SRS wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SRS_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_title2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_title2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_title2 as text
%        str2double(get(hObject,'String')) returns contents of edit_title2 as a double


% --- Executes during object creation, after setting all properties.
function edit_title2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_title2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_NEW.
function pushbutton_NEW_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_NEW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
recorder = audiorecorder(44100,16,1);
recordblocking(recorder,2);
y = getaudiodata(recorder);
plot(handles.axes_NEW,y);
[c1,c2]=vad(y);
h=y(c1:c2,1);
handles.a=mfcc(h,44100);
guidata(hObject, handles);

% --- Executes on button press in pushbutton_COM.
function pushbutton_COM_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_COM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global s;
mfcc1=handles.a1;
mfcc2=handles.a2;
mfcc3=handles.a3;
mfcc4=handles.a4;
mfccin=handles.a;
diston=dtw(mfccin',mfcc1');
distoff=dtw(mfccin',mfcc2');
distone=dtw(mfccin',mfcc3');
disttwo=dtw(mfccin',mfcc4');
DIST=[diston,distoff,distone,disttwo];
mindist=min(DIST);

if mindist==diston
    set(handles.edit4,'string','result is A')
   
elseif mindist==distoff
    set(handles.edit4,'string','result is B')
    
elseif mindist==distone
    set(handles.edit4,'string','result is C')
   
elseif mindist==disttwo
    set(handles.edit4,'string','result is D')
   
else
    set(handles.edit4,'string','result is invalid')
end

function edit_title1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_title1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_title1 as text
%        str2double(get(hObject,'String')) returns contents of edit_title1 as a double


% --- Executes during object creation, after setting all properties.
function edit_title1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_title1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_intro_Callback(hObject, eventdata, handles)
% hObject    handle to edit_intro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_intro as text
%        str2double(get(hObject,'String')) returns contents of edit_intro as a double


% --- Executes during object creation, after setting all properties.
function edit_intro_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_intro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_ON.
function pushbutton_ON_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_ON (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
recorder1 = audiorecorder(44100,16,1);
recordblocking(recorder1,2);
y1 = getaudiodata(recorder1);
plot(handles.axes_ON,y1);
[c1,c2]=vad(y1);
h1=y1(c1:c2,1);
handles.a1=mfcc(h1,44100);
guidata(hObject, handles);


% --- Executes on button press in pushbutton_OFF.
function pushbutton_OFF_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_OFF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
recorder2 = audiorecorder(44100,16,1);
recordblocking(recorder2,2);
y2 = getaudiodata(recorder2);
plot(handles.axes_OFF,y2);
[c1,c2]=vad(y2);
h2=y2(c1:c2,1);
handles.a2=mfcc(h2,44100);
guidata(hObject, handles);

% --- Executes on button press in pushbutton_ONE.
function pushbutton_ONE_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_ONE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
recorder3 = audiorecorder(44100,16,1);
recordblocking(recorder3,2);
y3 = getaudiodata(recorder3);
plot(handles.axes_ONE,y3);
[c1,c2]=vad(y3);
h3=y3(c1:c2,1);
handles.a3=mfcc(h3,44100);
guidata(hObject, handles);

% --- Executes on button press in pushbutton_TWO.
function pushbutton_TWO_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_TWO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
recorder4 = audiorecorder(44100,16,1);
recordblocking(recorder4,2);
y4 = getaudiodata(recorder4);
plot(handles.axes_TWO,y4);
[c1,c2]=vad(y4);
h4=y4(c1:c2,1);
handles.a4=mfcc(h4,44100);
guidata(hObject, handles);



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
