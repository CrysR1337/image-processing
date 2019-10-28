function varargout = otsu(varargin)
% OTSU MATLAB code for otsu.fig
%      OTSU, by itself, creates a new OTSU or raises the existing
%      singleton*.
%
%      H = OTSU returns the handle to a new OTSU or the handle to
%      the existing singleton*.
%
%      OTSU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OTSU.M with the given input arguments.
%
%      OTSU('Property','Value',...) creates a new OTSU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before otsu_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to otsu_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help otsu

% Last Modified by GUIDE v2.5 09-Dec-2018 18:21:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @otsu_OpeningFcn, ...
                   'gui_OutputFcn',  @otsu_OutputFcn, ...
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


% --- Executes just before otsu is made visible.
function otsu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to otsu (see VARARGIN)

% Choose default command line output for otsu
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes otsu wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = otsu_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
set(handles.axes1,'visible','off');
set(handles.axes2,'visible','off');
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile({'*.*';'*.bmp';'*.jpg';'*.tif';'*.jpg'},'选择图像');
image=[pathname,filename];%合成路径+文件名
global m1;
m1=imread(image);%读取图像
if (ndims(m1)==3)
    m1=rgb2gray(m1);
end
axes(handles.axes2);%%使用图像，操作在坐标1
imshow(m1);%在坐标axes1显示原图
axes(handles.axes4);
imhist(m1);
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
global m1;
I=m1;
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
set(handles.edit1,'string',num2str(threshold));
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
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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
