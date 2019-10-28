function varargout = picture(varargin)
% PICTURE MATLAB code for picture.fig
%      PICTURE, by itself, creates a new PICTURE or raises the existing
%      singleton*.
%
%      H = PICTURE returns the handle to a new PICTURE or the handle to
%      the existing singleton*.
%
%      PICTURE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PICTURE.M with the given input arguments.
%
%      PICTURE('Property','Value',...) creates a new PICTURE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before picture_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to picture_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help picture

% Last Modified by GUIDE v2.5 29-Oct-2018 17:16:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @picture_OpeningFcn, ...
                   'gui_OutputFcn',  @picture_OutputFcn, ...
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


% --- Executes just before picture is made visible.
function picture_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to picture (see VARARGIN)

% Choose default command line output for picture
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes picture wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = picture_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile({'*.*';'*.bmp';'*.jpg';'*.tif';'*.jpg'},'选择图像');
image=[pathname,filename];%合成路径+文件名
global m1;
m1=imread(image);%读取图像
axes(handles.axes1);%%使用图像，操作在坐标1
imshow(m1);%在坐标axes1显示原图
axes(handles.axes3);
imhist(m1);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global m1;
I=m1;
I=double(I);
I=256-1-I;
I=uint8(I);
axes(handles.axes2);%%使用图像，操作在坐标1
imshow(I)
axes(handles.axes4);
imhist(I);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global m1;
global k;
global b;
[m,n]=size(m1);
I=double(m1);
I=I.*k+b;
axes(handles.axes2);
imshow(uint8(I))
axes(handles.axes4);
imhist(uint8(I))


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global m1;
global c;
I=double(m1);
I=c*log(1+I);
axes(handles.axes2);
imshow(uint8(I))
axes(handles.axes4);
imhist(uint8(I))

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
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
axes(handles.axes4);
imhist(RGB);

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
axes(handles.axes4);
imhist(I);
set(handles.edit8,'string',num2str(get(hObject,'value')));
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



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.slider1,'Value',str2num(get(hObject,'String')));
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
global k;
k=str2double(get(hObject,'String'));
if(isempty(k))
    set(hObject,'Value','1.0');
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
global b;
b=str2double(get(hObject,'String'));
if(isempty(b))
    set(hObject,'Value','0');
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



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global c;
c=str2double(get(hObject,'String'));
if(isempty(c))
    set(hObject,'Value','1');
end
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


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global s;
val=get(handles.popupmenu4,'value');
S=3:2:9;
s=S(val);
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global m1 s;
I=m1;
[m,n]=size(I);
edge=(s-1)/2;
I=double(I);
I2=I;
for i=(1+edge):(m-edge)
    for j=(1+edge):(m-edge)
        G=I(i-edge:i+edge,j-edge:j+edge);
        SUM=sum(sum(G));
        I2(i,j)=SUM/(s*s);
    end
end
axes(handles.axes2);
imshow(uint8(I2));
axes(handles.axes4);
imhist(uint8(I2));

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global m1 s;
I=m1;
[m,n]=size(I);
edge=(s-1)/2;
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
axes(handles.axes4);
imhist(uint8(I2));

% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Tem choise;
choise=get(handles.popupmenu6,'value');
Tems(:,:,1)=[1 2 1;0 0 0;-1 -2 -1];
Tems(:,:,2)=[1 0 -1;2 0 -2;1 0 -1];
Tems(:,:,3)=[1 1 1;0 0 0;-1 -1 -1];
Tems(:,:,4)=[-1 0 1;-1 0 1;-1 0 1];
Tems(:,:,5)=[1 1 1;1 -8 1;1 1 1];
if choise==3||choise==4||choise==5||choise==6||choise==7
    Tem=Tems(:,:,choise-2);
end
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
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
axes(handles.axes4);
imhist(uint8(I2));

% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global m1;
I=m1;
F = fftshift(fft2(I));                     % 对图像进行二维 DFT(fft2)，并移至中心位置
magn = log(abs(F));                        % 加 log 是便于显示，缩小值域
phase = log(angle(F)*180/pi);              % 转换为度数
axes(handles.axes5);
imshow(log(F), [])
axes(handles.axes6);
imshow(phase, [])
