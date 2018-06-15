function varargout = mainWin(varargin)
% MAINWIN MATLAB code for mainWin.fig
%      MAINWIN, by itself, creates a new MAINWIN or raises the existing
%      singleton*.
%
%      H = MAINWIN returns the handle to a new MAINWIN or the handle to
%      the existing singleton*.
%
%      MAINWIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINWIN.M with the given input arguments.
%
%      MAINWIN('Property','Value',...) creates a new MAINWIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mainWin_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mainWin_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mainWin

% Last Modified by GUIDE v2.5 10-Jun-2017 17:53:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mainWin_OpeningFcn, ...
                   'gui_OutputFcn',  @mainWin_OutputFcn, ...
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

% --- Executes just before mainWin is made visible.
function mainWin_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mainWin (see VARARGIN)

% Choose default command line output for mainWin
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
end


% --- Outputs from this function are returned to the command line.
function varargout = mainWin_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

load('utiles.mat');
global empezado 
empezado = 0;
h_v = imshow(rec_off, 'Parent', handles.iconRecV);
set(h_v,'AlphaData',alpha_rec);
h_a = imshow(rec_off, 'Parent', handles.iconRecA);
set(h_a,'AlphaData',alpha_rec);

axes(handles.panelGame);
axis off;
global panelImg
imshow(panelImg);
global puntos
puntos = 0;

global insertados
insertados = zeros(1,length(elementos));
insertados(7) = 1;

global partidas
partidas = 0;
global ranking
ranking = zeros(1,100);
end

function panelElement=insertarElement(objStr,col,panelElement)
    panelElement(1,col) = objStr;
end

function [panelElement,insertados,puntos]=nextGen(panelElement,panelImg,imagenes,insertados,elemento,movimiento,handles,puntos,nivel,alpha)
    insertados(insertados(1:nivel)~=0) = insertados(insertados(1:nivel)~=0)+1;
    
    pintado = 0;
    modificado = 0;
    
    [fil,col] = find(panelElement ~= 0);
    for j = 1:length(fil)
        valor = panelElement(fil(j),col(j));
        
        if fil(j) == 9
            puntos = puntos + (panelElement(10,col(j)) == 7)*50;
        end
        
        if elemento == valor
            if valor > 0 && valor < 7
                panelElement(fil(j),col(j)) = 0;
                col(j) = col(j) + movimiento;
                if col(j) > size(panelElement,2)
                    col(j)=1;
                elseif col(j) == 0
                    col(j) = size(panelElement,2);
                end
                panelElement(fil(j),col(j)) = valor;
            elseif modificado == 0
                panelElement(fil(j),col(j)) = 0;
                panelElement(fil(j),col(j)+1) = 0;
                col(j) = col(j) + movimiento;
                if col(j) > size(panelElement,2)-1
                    col(j)=1;
                elseif col(j) == 0
                    col(j) = size(panelElement,2)-1;
                end
                panelElement(fil(j),col(j)) = valor;
                panelElement(fil(j),col(j)+1) = valor;
                modificado = 1;
            end
        end
        if valor > 0 && valor < 7
            aux = panelImg(((fil(j)-1)*60)+1:(fil(j)*60),((col(j)-1)*60)+1:(col(j)*60),:);
            
            ind = find(alpha{valor}~=0);
            aux_R = aux(:,:,1); img_R = imagenes{valor}(:,:,1);
            aux_G = aux(:,:,2); img_G = imagenes{valor}(:,:,2);
            aux_B = aux(:,:,3); img_B = imagenes{valor}(:,:,3);
            
            aux_R(ind) = img_R(ind); aux_G(ind) = img_G(ind); aux_B(ind) = img_B(ind);  
            aux(:,:,1) = aux_R; aux(:,:,2) = aux_G; aux(:,:,3) = aux_B;
            
            panelImg(((fil(j)-1)*60)+1:(fil(j)*60),((col(j)-1)*60)+1:(col(j)*60),:) = aux;
        elseif pintado == 0
            aux = panelImg(((fil(j)-1)*60)+1:(fil(j)*60),((col(j)-1)*60)+1:(60+(col(j)*60)),:);
            
            ind = find(alpha{valor}~=0);
            aux_R = aux(:,:,1); img_R = imagenes{valor}(:,:,1);
            aux_G = aux(:,:,2); img_G = imagenes{valor}(:,:,2);
            aux_B = aux(:,:,3); img_B = imagenes{valor}(:,:,3);
            
            aux_R(ind) = img_R(ind); aux_G(ind) = img_G(ind); aux_B(ind) = img_B(ind);  
            aux(:,:,1) = aux_R; aux(:,:,2) = aux_G; aux(:,:,3) = aux_B;
            
            panelImg(((fil(j)-1)*60)+1:(fil(j)*60),((col(j)-1)*60)+1:(60+(col(j)*60)),:) = aux;
            pintado = 1;
        end
    end
    
    set(handles.textPuntos, 'String', num2str(puntos));
    axes(handles.panelGame);
    imshow(panelImg);
    
    panelElement=[zeros(1,size(panelElement,2));panelElement];
    panelElement(size(panelElement,1)-1,:)=[];
end


% --- Executes on button press in bottonStart.
function bottonStart_Callback(hObject, eventdata, handles)
% hObject    handle to bottonStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global empezado insertados panelElement puntos elementos panelImg imagenes niveles partidas ranking alpha
fondo = 0;

if empezado == 0
    % Captura del fondo
    set(handles.bottonStart,'String','Parar');
    set(handles.textRanking, 'Visible', 'Off');
    fondo = capFondo(1);
    empezado = 1;
    partidas = partidas + 1;
    set(handles.textPuntos, 'String', num2str(puntos));
    set(handles.textLevel, 'String', num2str(1));
    
    panelElement(10,4:5) = 7;
    while empezado   
        nivel = find(niveles <= puntos);
        nivel = nivel(end);
        
        elemento = recVoz(handles,elementos,nivel);
        mov = recVideo(1,fondo,handles);
        if ~empezado
            break;
        end
        switch mov
            case 1
                textLabel = 'Derecha';
            case -1
                textLabel = 'Izquierda';
            case 0
                textLabel = '<no move>';        
        end
        set(handles.textMov, 'String', textLabel);
        set(handles.textLevel, 'String', num2str(nivel));
        
        ciclo = find(insertados(1:nivel) == 10);
        if ~isempty(ciclo)
            insertados(ciclo) = 0;
        end

        if ~all(insertados(1:nivel) >= 1)
            elm = find(insertados(1:nivel) == 0);
            pos = elm(randi(length(elm),1));
            insertados(pos) = 1;
            panelElement=insertarElement(pos,randi(8,1),panelElement);
        end
        [panelElement,insertados,puntos]=nextGen(panelElement,panelImg,imagenes,insertados,elemento,mov,handles,puntos,nivel,alpha);
        pause(0.1);
    end
else
    pause(0.5);
    ranking(partidas) = puntos;
    set(handles.textRanking, 'String', ['MEJOR PUNTUACIÓN ' 10 num2str(max(ranking)) 10 10 'Partida Actual' 10 num2str(puntos)]);
    set(handles.textRanking, 'Visible', 'On');
    load('utiles_reiniciables.mat');
    h_v = imshow(rec_off, 'Parent', handles.iconRecV);
    set(h_v,'AlphaData',alpha_rec);
    h_a = imshow(rec_off, 'Parent', handles.iconRecA);
    set(h_a,'AlphaData',alpha_rec);
    imshow(zeros(size(fondo)), 'Parent', handles.demoFinger);
    puntos = 0;
    insertados = zeros(1,length(elementos));
    insertados(7) = 1;
    imshow(panelImg);
    empezado = 0;
    set(handles.bottonStart,'String','Empezar');
end
end
% --- Executes on button press in bottonConfig.
function bottonConfig_Callback(hObject, eventdata, handles)
% hObject    handle to bottonConfig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
configWin;
end


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
global empezado;
empezado = 0;
delete(hObject);
end
