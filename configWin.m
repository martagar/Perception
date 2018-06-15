function varargout = configWin(varargin)
% CONFIGWIN MATLAB code for configWin.fig
%      CONFIGWIN, by itself, creates a new CONFIGWIN or raises the existing
%      singleton*.
%
%      H = CONFIGWIN returns the handle to a new CONFIGWIN or the handle to
%      the existing singleton*.
%
%      CONFIGWIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONFIGWIN.M with the given input arguments.
%
%      CONFIGWIN('Property','Value',...) creates a new CONFIGWIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before configWin_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to configWin_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help configWin

% Last Modified by GUIDE v2.5 10-Jun-2017 17:54:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @configWin_OpeningFcn, ...
                   'gui_OutputFcn',  @configWin_OutputFcn, ...
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
end

% --- Executes just before configWin is made visible.
function configWin_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to configWin (see VARARGIN)

% Choose default command line output for configWin
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes configWin wait for user response (see UIRESUME)
% uiwait(handles.figure1);
end

% --- Outputs from this function are returned to the command line.
function varargout = configWin_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
load('utiles.mat');

h_v = imshow(rec_off, 'Parent', handles.iconRecV);
set(h_v,'AlphaData',alpha_rec);
h_a = imshow(rec_off, 'Parent', handles.iconRecA);
set(h_a,'AlphaData',alpha_rec);
end

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fondo = capFondo(1);
axes(handles.panelBack);
imshow(flipdim(fondo,2),[]);
mov = recVideo(1,fondo,handles);
switch mov
    case 1
        textLabel = 'Derecha';
    case -1
        textLabel = 'Izquierda';
    case 0
        textLabel = '<no move>';        
end
set(handles.textMov, 'String', textLabel);
end
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global elementos
global errorRuido;
errorRuido = str2double(get(handles.editErrorRuido, 'String'));
recVoz(handles,elementos,6);
end



function editErrorRuido_Callback(hObject, eventdata, handles)
% hObject    handle to editErrorRuido (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editErrorRuido as text
%        str2double(get(hObject,'String')) returns contents of editErrorRuido as a double
end

% --- Executes during object creation, after setting all properties.
function editErrorRuido_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editErrorRuido (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);
end
