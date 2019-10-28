function varargout = ps(varargin)
% PS MATLAB code for ps.fig
%      PS, by itself, creates a new PS or raises the existing
%      singleton*.
%
%      H = PS returns the handle to a new PS or the handle to
%      the existing singleton*.
%
%      PS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PS.M with the given input arguments.
%
%      PS('Property','Value',...) creates a new PS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ps_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ps_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ps

% Last Modified by GUIDE v2.5 20-Jan-2019 14:14:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ps_OpeningFcn, ...
                   'gui_OutputFcn',  @ps_OutputFcn, ...
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


% --- Executes just before ps is made visible.
function ps_OpeningFcn(hObject, eventdata, handles, varargin)
set(handles.axes1,'visible','off');
set(handles.axes2,'visible','off');
set(handles.axes3,'visible','off');
set(handles.axes4,'visible','off');
set(handles.axes5,'visible','off');
set(handles.axes6,'visible','off');
set(handles.uipanel1,'visible','off');
set(handles.uipanel15,'visible','off');
set(handles.uipanel17,'visible','off');
set(handles.uipanel18,'visible','off');
set(handles.uipanel19,'visible','off');
set(handles.uipanel20,'visible','off');
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ps (see VARARGIN)

% Choose default command line output for ps
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ps wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ps_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_5_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_6_Callback(hObject, eventdata, handles)
set(handles.uipanel1,'visible','on');
% hObject    handle to Untitled_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function Untitled_8_Callback(hObject, eventdata, handles)
set(handles.uipanel15,'visible','on');
% hObject    handle to Untitled_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_9_Callback(hObject, eventdata, handles)
set(handles.uipanel17,'visible','on');
% hObject    handle to Untitled_9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_10_Callback(hObject, eventdata, handles)
set(handles.uipanel18,'visible','on');
global op;
op=[0 0 0 0 0 0 0 0 0]
% hObject    handle to Untitled_10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_11_Callback(hObject, eventdata, handles)
set(handles.uipanel19,'visible','on');
% hObject    handle to Untitled_11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_12_Callback(hObject, eventdata, handles)
set(handles.uipanel20,'visible','on');
% hObject    handle to Untitled_12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
[filename,pathname]=uigetfile({'*.*';'*.bmp';'*.jpg';'*.tif';'*.jpg'},'选择图像');
image=[pathname,filename];%合成路径+文件名
global m1;
m1=imread(image);%读取图像
axes(handles.axes1);%%使用图像，操作在坐标1
imshow(m1);%在坐标axes1显示原图
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_4_Callback(hObject, eventdata, handles)
global m1
folder_name = uigetdir(pwd,'title')
cd(folder_name)                %把当前工作目录切换到图片存储文件夹
imwrite(m1,'save.png')
% hObject    handle to Untitled_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_14_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_15_Callback(hObject, eventdata, handles)
global m1;
axes(handles.axes4);
imhist(m1);
% hObject    handle to Untitled_15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_16_Callback(hObject, eventdata, handles)
global m1;
if (ndims(m1)==3)
    m1=rgb2gray(m1);
end
axes(handles.axes2);%%使用图像，操作在坐标1
imshow(m1);%在坐标axes1显示原图
axes(handles.axes5);
imhist(m1);
% hObject    handle to Untitled_16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function uipushtool2_ClickedCallback(hObject, eventdata, handles)
[filename,pathname]=uigetfile({'*.*';'*.bmp';'*.jpg';'*.tif';'*.jpg'},'选择图像');
image=[pathname,filename];%合成路径+文件名
global m1;
m1=imread(image);%读取图像
axes(handles.axes1);%%使用图像，操作在坐标1
imshow(m1);%在坐标axes1显示原图
% hObject    handle to uipushtool2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function uipushtool3_ClickedCallback(hObject, eventdata, handles)
global m1
folder_name = uigetdir(pwd,'title')
cd(folder_name)                %把当前工作目录切换到图片存储文件夹
imwrite(m1,'save.png')
% hObject    handle to uipushtool3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
global m1;
I=m1;
I=double(I);
I=256-1-I;
I=uint8(I);
axes(handles.axes2);%%使用图像，操作在坐标1
imshow(I)
axes(handles.axes5);
imhist(I);
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
global m1;
global k;
global b;
[m,n]=size(m1);
I=double(m1);
I=I.*k+b;
axes(handles.axes2);
imshow(uint8(I))
axes(handles.axes5);
imhist(uint8(I))
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
global m1;
global c;
I=double(m1);
I=c*log(1+I);
axes(handles.axes2);
imshow(uint8(I))
axes(handles.axes5);
imhist(uint8(I))
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)

% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
global m1;
RGB = m1;
[R, C, K] = size(RGB);
cnt = zeros(K, 256);
for i = 1 : R
    for j = 1 : C
        for k = 1 : K
            cnt(k, RGB(i, j, k) + 1) = cnt(k, RGB(i, j, k) + 1) + 1;
        end
    end
end
f = zeros(3, 256);
f = double(f); cnt = double(cnt);
 
for k = 1 : K
    for i = 1 : 256
        f(k, i) = cnt(k, i) / (R * C);
    end
end
 
for k = 1 : K
    for i = 2 : 256
        f(k, i) = f(k, i - 1) + f(k, i);
    end
end
 
for k = 1 : K
    for i = 1 : 256
        f(k, i) = f(k, i) * 255;
    end
end
 
for i = 1 : R
    for j = 1 : C
        for k = 1 : K
            RGB(i, j, k) = f(k, RGB(i, j, k) + 1);
        end
    end
end
RGB=uint8(RGB);
axes(handles.axes2);
imshow(RGB)
axes(handles.axes5);
imhist(RGB);
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global k;
k=str2double(get(hObject,'String'));
if(isempty(k))
    set(hObject,'Value','1.0');
end
% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global b;
b=str2double(get(hObject,'String'));
if(isempty(b))
    set(hObject,'Value','0');
end
% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global c;
c=str2double(get(hObject,'String'));
if(isempty(c))
    set(hObject,'Value','1');
end
% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global m1;
MID=get(hObject,'Value');
I=im2double(m1);
[m,n]=size(m1);
for i=1:m
    for j=1:n
        if I(i,j)<MID
            I(i,j)=0;
        else
            I(i,j)=1;
        end
    end
end
axes(handles.axes2);
imshow(I)
axes(handles.axes5);
imhist(I);
set(handles.edit4,'string',num2str(get(hObject,'value')));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider



% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.slider1,'Value',str2num(get(hObject,'String')));
global m1;
MID=str2num(get(hObject,'String'));
I=im2double(m1);
[m,n]=size(m1);
for i=1:m
    for j=1:n
        if I(i,j)<MID
            I(i,j)=0;
        else
            I(i,j)=1;
        end
    end
end
axes(handles.axes2);
imshow(I)
axes(handles.axes5);
imhist(I);
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


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
global m1;
axes(handles.axes1);
I = imcrop(m1)
clc
axes(handles.axes2);
imshow(I)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when selected object is changed in uibuttongroup2.
function uibuttongroup2_SelectionChangedFcn(hObject, eventdata, handles)
tString=get(hObject,'tag');
global option;
switch tString
    case 'radiobutton3'
        option=3;
    case 'radiobutton4'
        option=5;
    case 'radiobutton5'
        option=7;
    case 'radiobutton6'
        option=9;
end
% hObject    handle to the selected object in uibuttongroup2 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
global option;
set(handles.edit16,'string',num2str(option));
global m1;
I=m1;
[m,n]=size(I);
edge=(option-1)/2;
I=double(I);
I2=I;
for i=(1+edge):(m-edge)
    for j=(1+edge):(m-edge)
        G=I(i-edge:i+edge,j-edge:j+edge);
        MID=median(G(:));
        I2(i,j)=MID;
    end
end
axes(handles.axes2);
imshow(uint8(I2));
axes(handles.axes5);
imhist(uint8(I2));
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
global option;
set(handles.edit16,'string',num2str(option));
global m1;
I=m1;
[m,n]=size(I);
edge=(option-1)/2;
I=double(I);
I2=I;
for i=(1+edge):(m-edge)
    for j=(1+edge):(m-edge)
        G=I(i-edge:i+edge,j-edge:j+edge);
        SUM=sum(sum(G));
        I2(i,j)=SUM/(option*option);
    end
end
axes(handles.axes2);
imshow(uint8(I2));
axes(handles.axes5);
imhist(uint8(I2));
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu6.
function popupmenu6_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Tem choise;
choise=get(handles.popupmenu6,'value');
set(handles.edit16,'string',num2str(choise));
Tems(:,:,1)=[1 2 1;0 0 0;-1 -2 -1];
Tems(:,:,2)=[1 0 -1;2 0 -2;1 0 -1];
Tems(:,:,3)=[1 1 1;0 0 0;-1 -1 -1];
Tems(:,:,4)=[-1 0 1;-1 0 1;-1 0 1];
Tems(:,:,5)=[1 1 1;1 -8 1;1 1 1];
if choise==3||choise==4||choise==5||choise==6||choise==7
    Tem=Tems(:,:,choise-2);
end
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu6


% --- Executes during object creation, after setting all properties.
function popupmenu6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
global m1 choise Tem;
I=m1;
[m,n]=size(I);
I=double(I);
if choise==1
        for i=1:(m-1)
            for j=1:(m-1)
                G=abs(I(i,j)-I(i+1,j))+abs(I(i,j)-I(i,j+1));
                I2(i,j)=G;
            end
        end
        
elseif choise==2
        for i=1:(m-1)
            for j=1:(m-1)
                G=abs(-I(i,j)+I(i+1,j+1))+abs(-I(i+1,j)+I(i,j+1));
                I2(i,j)=G;
            end
        end
       
else
        for i=2:(m-1)
            for j=2:(m-1)
                G=I(i-1:i+1,j-1:j+1);
                I2(i,j)=sum(sum(G.*Tem));
            end
        end
end
axes(handles.axes2);
imshow(uint8(I2));
axes(handles.axes5);
imhist(uint8(I2));
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
global m1;
m1 = imnoise(m1, 'salt & pepper',0.5);
axes(handles.axes2);
imshow(uint8(m1));
axes(handles.axes5);
imhist(uint8(m1));
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
global m1;
m1 = imnoise(m1, 'gaussian',0.5);
axes(handles.axes2);
imshow(uint8(m1));
axes(handles.axes5);
imhist(uint8(m1));
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
global m1;
I=m1;
F = fftshift(fft2(I));                     % 对图像进行二维 DFT(fft2)，并移至中心位置
magn = log(abs(F));                        % 加 log 是便于显示，缩小值域
phase = log(angle(F)*180/pi);              % 转换为度数
axes(handles.axes7);
imshow(log(F), [])
axes(handles.axes8);
imshow(phase, [])
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global m1;
MID=get(hObject,'Value');
I=im2double(m1);
[m,n]=size(m1);
for i=1:m
    for j=1:n
        if I(i,j)<MID
            I(i,j)=0;
        else
            I(i,j)=1;
        end
    end
end
axes(handles.axes2);
imshow(I)
global m2;
m2=I;
set(handles.edit5,'string',num2str(get(hObject,'value')));
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.slider2,'Value',str2num(get(hObject,'String')));
global m1;
MID=str2num(get(hObject,'String'));
I=im2double(m1);
[m,n]=size(m1);
for i=1:m
    for j=1:n
        if I(i,j)<MID
            I(i,j)=0;
        else
            I(i,j)=1;
        end
    end
end
axes(handles.axes2);
imshow(I)
global m2;
m2=I;
% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in togglebutton2.
function togglebutton2_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global op;
button_state = get(hObject,'Value')  
if button_state==get(hObject,'Max')
    op(1)=1;
else button_state==get(hObject,'Min')
    op(1)=0;
end
set(handles.edit6,'string',num2str(op(1)));
% Hint: get(hObject,'Value') returns toggle state of togglebutton2


% --- Executes on button press in togglebutton3.
function togglebutton3_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global op;
button_state = get(hObject,'Value')  
if button_state==get(hObject,'Max')
    op(2)=1;
else button_state==get(hObject,'Min')
    op(2)=0;
end
set(handles.edit7,'string',num2str(op(2)));
% Hint: get(hObject,'Value') returns toggle state of togglebutton3


% --- Executes on button press in togglebutton4.
function togglebutton4_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global op;
button_state = get(hObject,'Value')  
if button_state==get(hObject,'Max')
    op(3)=1;
else button_state==get(hObject,'Min')
    op(3)=0;
end
set(handles.edit8,'string',num2str(op(3)));
% Hint: get(hObject,'Value') returns toggle state of togglebutton4


% --- Executes on button press in togglebutton5.
function togglebutton5_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global op;
button_state = get(hObject,'Value')  
if button_state==get(hObject,'Max')
    op(4)=1;
else button_state==get(hObject,'Min')
    op(4)=0;
end
set(handles.edit9,'string',num2str(op(4)));
% Hint: get(hObject,'Value') returns toggle state of togglebutton5


% --- Executes on button press in togglebutton6.
function togglebutton6_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global op;
button_state = get(hObject,'Value')  
if button_state==get(hObject,'Max')
    op(5)=1;
else button_state==get(hObject,'Min')
    op(5)=0;
end
set(handles.edit10,'string',num2str(op(5)));
% Hint: get(hObject,'Value') returns toggle state of togglebutton6


% --- Executes on button press in togglebutton7.
function togglebutton7_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global op;
button_state = get(hObject,'Value')  
if button_state==get(hObject,'Max')
    op(6)=1;
else button_state==get(hObject,'Min')
    op(6)=0;
end
set(handles.edit11,'string',num2str(op(6)));
% Hint: get(hObject,'Value') returns toggle state of togglebutton7


% --- Executes on button press in togglebutton8.
function togglebutton8_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global op;
button_state = get(hObject,'Value')  
if button_state==get(hObject,'Max')
    op(7)=1;
else button_state==get(hObject,'Min')
    op(7)=0;
end
set(handles.edit12,'string',num2str(op(7)));
% Hint: get(hObject,'Value') returns toggle state of togglebutton8


% --- Executes on button press in togglebutton9.
function togglebutton9_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global op;
button_state = get(hObject,'Value')  
if button_state==get(hObject,'Max')
    op(8)=1;
else button_state==get(hObject,'Min')
    op(8)=0;
end
set(handles.edit13,'string',num2str(op(8)));
% Hint: get(hObject,'Value') returns toggle state of togglebutton9


% --- Executes on button press in togglebutton10.
function togglebutton10_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global op;
button_state = get(hObject,'Value')  
if button_state==get(hObject,'Max')
    op(9)=1;
else button_state==get(hObject,'Min')
    op(9)=0;
end
set(handles.edit14,'string',num2str(op(9)));
% Hint: get(hObject,'Value') returns toggle state of togglebutton10



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
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



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
global m2;
global op;
I=m2;
[m,n]=size(I);
SE=strel('arbitrary',op);
BW2=imerode(m2,SE);
axes(handles.axes2);
imshow(BW2) 
set(handles.edit2,'string',num2str(op(1)));
set(handles.edit3,'string',num2str(op(2)));
set(handles.edit4,'string',num2str(op(3)));
set(handles.edit5,'string',num2str(op(4)));
set(handles.edit6,'string',num2str(op(5)));
set(handles.edit7,'string',num2str(op(6)));
set(handles.edit8,'string',num2str(op(7)));
set(handles.edit9,'string',num2str(op(8)));
set(handles.edit10,'string',num2str(op(9)));
for i=2:m-1
    for j=2:n-1
        if ((op(1)==0||(op(1)==1&&m2(i-1,j-1)==1)) && (op(2)==0||(op(2)==1&&m2(i-1,j)==1)) && (op(3)==0||(op(3)==1&&m2(i-1,j+1)==1)) && (op(4)==0||(op(4)==1&&m2(i,j-1)==1)) && (op(5)==0||(op(5)==1&&m2(i,j)==1)) && (op(6)==0||(op(6)==1&&m2(i,j+1)==1)) && (op(7)==0||(op(7)==1&&m2(i+1,j-1)==1)) && (op(8)==0||(op(8)==1&&m2(i+1,j)==1)) && (op(9)==0||(op(9)==1&&m2(i+1,j+1)==1))) 
            I(i,j)=1;
        else
            I(i,j)=0;
        end
    end
end
axes(handles.axes3);
imshow(I)
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
global m2;
global op;
I=m2;
[m,n]=size(I);
SE=strel('arbitrary',op);
BW2=imdilate(m2,SE);
axes(handles.axes2);
imshow(BW2) 
set(handles.edit2,'string',num2str(op(1)));
set(handles.edit3,'string',num2str(op(2)));
set(handles.edit4,'string',num2str(op(3)));
set(handles.edit5,'string',num2str(op(4)));
set(handles.edit6,'string',num2str(op(5)));
set(handles.edit7,'string',num2str(op(6)));
set(handles.edit8,'string',num2str(op(7)));
set(handles.edit9,'string',num2str(op(8)));
set(handles.edit10,'string',num2str(op(9)));
for i=2:m-1
    for j=2:n-1
        if ((op(9)==1&&m2(i-1,j-1)==1) || (op(8)==1&&m2(i-1,j)==1) || (op(7)==1&&m2(i-1,j+1)==1) || (op(6)==1&&m2(i,j-1)==1) || (op(5)==1&&m2(i,j)==1) || (op(4)==1&&m2(i,j+1)==1) || (op(3)==1&&m2(i+1,j-1)==1) || (op(2)==1&&m2(i+1,j)==1) || (op(1)==1&&m2(i+1,j+1)==1))
            I(i,j)=1;
        else
            I(i,j)=0;
        end
    end
end
axes(handles.axes3);
imshow(I)
% hObject    handle to pushbutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton22.
function pushbutton22_Callback(hObject, eventdata, handles)
global m2;
global op;
I=m2;
[m,n]=size(I);
SE=strel('arbitrary',op);
BW2=imerode(m2,SE);
BW2=imdilate(m2,SE);
axes(handles.axes2);
imshow(BW2) 
set(handles.edit2,'string',num2str(op(1)));
set(handles.edit3,'string',num2str(op(2)));
set(handles.edit4,'string',num2str(op(3)));
set(handles.edit5,'string',num2str(op(4)));
set(handles.edit6,'string',num2str(op(5)));
set(handles.edit7,'string',num2str(op(6)));
set(handles.edit8,'string',num2str(op(7)));
set(handles.edit9,'string',num2str(op(8)));
set(handles.edit10,'string',num2str(op(9)));
for i=2:m-1
    for j=2:n-1
        if ((op(1)==0||(op(1)==1&&m2(i-1,j-1)==1)) && (op(2)==0||(op(2)==1&&m2(i-1,j)==1)) && (op(3)==0||(op(3)==1&&m2(i-1,j+1)==1)) && (op(4)==0||(op(4)==1&&m2(i,j-1)==1)) && (op(5)==0||(op(5)==1&&m2(i,j)==1)) && (op(6)==0||(op(6)==1&&m2(i,j+1)==1)) && (op(7)==0||(op(7)==1&&m2(i+1,j-1)==1)) && (op(8)==0||(op(8)==1&&m2(i+1,j)==1)) && (op(9)==0||(op(9)==1&&m2(i+1,j+1)==1))) 
            I(i,j)=1;
        else
            I(i,j)=0;
        end
    end
end
for i=2:m-1
    for j=2:n-1
        if ((op(1)==1&&m2(i-1,j-1)==1) || (op(2)==1&&m2(i-1,j)==1) || (op(3)==1&&m2(i-1,j+1)==1) || (op(4)==1&&m2(i,j-1)==1) || (op(5)==1&&m2(i,j)==1) || (op(6)==1&&m2(i,j+1)==1) || (op(7)==1&&m2(i+1,j-1)==1) || (op(8)==1&&m2(i+1,j)==1) || (op(9)==1&&m2(i+1,j+1)==1))
            I(i,j)=1;
        else
            I(i,j)=0;
        end
    end
end
axes(handles.axes3);
imshow(I)
% hObject    handle to pushbutton22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton23.
function pushbutton23_Callback(hObject, eventdata, handles)
global m2;
global op;
I=m2;
[m,n]=size(I);
SE=strel('arbitrary',op);
BW2=imdilate(m2,SE);
BW2=imerode(m2,SE);
axes(handles.axes1);
imshow(BW2) 
set(handles.edit2,'string',num2str(op(1)));
set(handles.edit3,'string',num2str(op(2)));
set(handles.edit4,'string',num2str(op(3)));
set(handles.edit5,'string',num2str(op(4)));
set(handles.edit6,'string',num2str(op(5)));
set(handles.edit7,'string',num2str(op(6)));
set(handles.edit8,'string',num2str(op(7)));
set(handles.edit9,'string',num2str(op(8)));
set(handles.edit10,'string',num2str(op(9)));
for i=2:m-1
    for j=2:n-1
        if ((op(1)==1&&m2(i-1,j-1)==1) || (op(2)==1&&m2(i-1,j)==1) || (op(3)==1&&m2(i-1,j+1)==1) || (op(4)==1&&m2(i,j-1)==1) || (op(5)==1&&m2(i,j)==1) || (op(6)==1&&m2(i,j+1)==1) || (op(7)==1&&m2(i+1,j-1)==1) || (op(8)==1&&m2(i+1,j)==1) || (op(9)==1&&m2(i+1,j+1)==1))
            I(i,j)=1;
        else
            I(i,j)=0;
        end
    end
end
for i=2:m-1
    for j=2:n-1
        if ((op(1)==0||(op(1)==1&&m2(i-1,j-1)==1)) && (op(2)==0||(op(2)==1&&m2(i-1,j)==1)) && (op(3)==0||(op(3)==1&&m2(i-1,j+1)==1)) && (op(4)==0||(op(4)==1&&m2(i,j-1)==1)) && (op(5)==0||(op(5)==1&&m2(i,j)==1)) && (op(6)==0||(op(6)==1&&m2(i,j+1)==1)) && (op(7)==0||(op(7)==1&&m2(i+1,j-1)==1)) && (op(8)==0||(op(8)==1&&m2(i+1,j)==1)) && (op(9)==0||(op(9)==1&&m2(i+1,j+1)==1))) 
            I(i,j)=1;
        else
            I(i,j)=0;
        end
    end
end
axes(handles.axes3);
imshow(I)
% hObject    handle to pushbutton23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton24.
function pushbutton24_Callback(hObject, eventdata, handles)
global m1;
I=m1;
if (ndims(I)==3)
    m1=rgb2gray(I);
end
[m,n]=size(I);
cnt = zeros(1, 256);
for i = 1 : m
    for j = 1 : n
        cnt(1, I(i, j) + 1) = cnt(1, I(i, j) + 1) + 1;
    end
end
f = zeros(1, 256);
f = double(f); 
cnt = double(cnt);
%计算每个像素在整幅图像中的比例  
maxPro = 0.0;
kk = 0;
for i = 1 : 256
    f(i) = cnt(i) / m / n;
    if (f(i) > maxPro)
        maxPro = f(i);
        kk = i;
    end
end

%遍历灰度级[0,255]  
threshold=0;deltaMax = 0;
%float w0, w1, u0tmp, u1tmp, u0, u1, u, deltaTmp, deltaMax = 0;
for i = 1 : 256     % i作为阈值
    w0 = 0; w1 = 0; u0tmp = 0; u1tmp = 0; u0 = 0; u1 = 0; u = 0; deltaTmp = 0;
    for j = 1 : 256
        if (j <= i)   %背景部分  
            w0 = w0 + f(j);
            u0tmp = u0tmp + j * f(j);
        else   %前景部分  
            w1 = w1 + f(j);
            u1tmp = u1tmp + j * f(j);
        end
    end
    u0 = u0tmp / w0;
    u1 = u1tmp / w1;
    u = u0tmp + u1tmp;
    deltaTmp = w0 * (u0 - u) * (u0 - u) + w1 * (u1 - u) * (u1 - u);
    if (deltaTmp > deltaMax)
        deltaMax = deltaTmp;
        threshold = i;
    end
end
set(handles.edit15,'string',num2str(threshold));
for i=1:m
    for j=1:n
        if I(i,j)<threshold
            I(i,j)=0;
        else
            I(i,j)=256;
        end
    end
end
axes(handles.axes3);
imshow(I)
% hObject    handle to pushbutton24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton25.
function pushbutton25_Callback(hObject, eventdata, handles)
global m1;
J=imadjust(m1,[0.1 0.9],[0 1],1);
BW1=edge(m1,'sobel');
sobelBW1=im2uint8(BW1)+J;
axes(handles.axes3);
imshow(sobelBW1)
% hObject    handle to pushbutton25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton27.
function pushbutton27_Callback(hObject, eventdata, handles)
global m1;
J=imadjust(m1,[0.1 0.9],[0 1],1);
BW2=edge(m1,'roberts');
robertBW2=im2uint8(BW2)+J;
axes(handles.axes3);
imshow(sobelBW2)
% hObject    handle to pushbutton27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton28.
function pushbutton28_Callback(hObject, eventdata, handles)
global m1;
J=imadjust(m1,[0.1 0.9],[0 1],1);
BW3=edge(I,'prewitt');
prewittBW3=im2uint8(BW3)+J;
axes(handles.axes3);
imshow(prewittBW3)
% hObject    handle to pushbutton28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton29.
function pushbutton29_Callback(hObject, eventdata, handles)
global m1;
J=imadjust(m1,[0.1 0.9],[0 1],1);
BW5=edge(I,'canny');
cannyBW5=im2uint8(BW5)+J;
axes(handles.axes3);
imshow(cannyBW5)
% hObject    handle to pushbutton29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
