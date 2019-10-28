function varargout = pic3(varargin)
% PIC3 MATLAB code for pic3.fig
%      PIC3, by itself, creates a new PIC3 or raises the existing
%      singleton*.
%
%      H = PIC3 returns the handle to a new PIC3 or the handle to
%      the existing singleton*.
%
%      PIC3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PIC3.M with the given input arguments.
%
%      PIC3('Property','Value',...) creates a new PIC3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before pic3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to pic3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help pic3

% Last Modified by GUIDE v2.5 26-Nov-2018 22:51:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @pic3_OpeningFcn, ...
                   'gui_OutputFcn',  @pic3_OutputFcn, ...
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


% --- Executes just before pic3 is made visible.
function pic3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to pic3 (see VARARGIN)

% Choose default command line output for pic3
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes pic3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = pic3_OutputFcn(hObject, eventdata, handles) 
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
set(handles.axes1,'visible','off');
set(handles.axes2,'visible','off');
set(handles.axes3,'visible','off');
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile({'*.*';'*.bmp';'*.jpg';'*.tif';'*.jpg'},'选择图像');
image=[pathname,filename];%合成路径+文件名
global m1;
m1=imread(image);%读取图像
axes(handles.axes1);%%使用图像，操作在坐标1
imshow(m1);%在坐标axes1显示原图
global op;
op=[0 0 0 0 0 0 0 0 0]

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
global m2;
m2=I;
set(handles.edit1,'string',num2str(get(hObject,'value')));
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





% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global m2;
global op;
I=m2;
[m,n]=size(I);
SE=strel('arbitrary',op);
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
        if ((op(1)==0||(op(1)==1&&m2(i-1,j-1)==1)) && (op(2)==0||(op(2)==1&&m2(i-1,j)==1)) && (op(3)==0||(op(3)==1&&m2(i-1,j+1)==1)) && (op(4)==0||(op(4)==1&&m2(i,j-1)==1)) && (op(5)==0||(op(5)==1&&m2(i,j)==1)) && (op(6)==0||(op(6)==1&&m2(i,j+1)==1)) && (op(7)==0||(op(7)==1&&m2(i+1,j-1)==1)) && (op(8)==0||(op(8)==1&&m2(i+1,j)==1)) && (op(9)==0||(op(9)==1&&m2(i+1,j+1)==1))) 
            I(i,j)=1;
        else
            I(i,j)=0;
        end
    end
end
axes(handles.axes3);
imshow(I)

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global m2;
global op;
I=m2;
[m,n]=size(I);
SE=strel('arbitrary',op);
BW2=imdilate(m2,SE);
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
        if ((op(9)==1&&m2(i-1,j-1)==1) || (op(8)==1&&m2(i-1,j)==1) || (op(7)==1&&m2(i-1,j+1)==1) || (op(6)==1&&m2(i,j-1)==1) || (op(5)==1&&m2(i,j)==1) || (op(4)==1&&m2(i,j+1)==1) || (op(3)==1&&m2(i+1,j-1)==1) || (op(2)==1&&m2(i+1,j)==1) || (op(1)==1&&m2(i+1,j+1)==1))
            I(i,j)=1;
        else
            I(i,j)=0;
        end
    end
end
axes(handles.axes3);
imshow(I)

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global m2;
global op;
I=m2;
[m,n]=size(I);
SE=strel('arbitrary',op);
BW2=imerode(m2,SE);
BW2=imdilate(m2,SE);
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

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
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



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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


% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global op;
button_state = get(hObject,'Value')  
if button_state==get(hObject,'Max')
    op(1)=1;
else button_state==get(hObject,'Min')
    op(1)=0;
end

% Hint: get(hObject,'Value') returns toggle state of togglebutton1


% --- Executes on button press in togglebutton2.
function togglebutton2_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global op;
button_state = get(hObject,'Value')  
if button_state==get(hObject,'Max')
    op(2)=1;
else button_state==get(hObject,'Min')
    op(2)=0;
end
% Hint: get(hObject,'Value') returns toggle state of togglebutton2


% --- Executes on button press in togglebutton3.
function togglebutton3_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global op;
button_state = get(hObject,'Value')  
if button_state==get(hObject,'Max')
    op(3)=1;
else button_state==get(hObject,'Min')
    op(3)=0;
end
% Hint: get(hObject,'Value') returns toggle state of togglebutton3


% --- Executes on button press in togglebutton4.
function togglebutton4_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global op;
button_state = get(hObject,'Value')  
if button_state==get(hObject,'Max')
    op(4)=1;
else button_state==get(hObject,'Min')
    op(4)=0;
end
% Hint: get(hObject,'Value') returns toggle state of togglebutton4


% --- Executes on button press in togglebutton5.
function togglebutton5_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global op;
button_state = get(hObject,'Value')  
if button_state==get(hObject,'Max')
    op(5)=1;
else button_state==get(hObject,'Min')
    op(5)=0;
end
% Hint: get(hObject,'Value') returns toggle state of togglebutton5


% --- Executes on button press in togglebutton6.
function togglebutton6_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global op;
button_state = get(hObject,'Value')  
if button_state==get(hObject,'Max')
    op(6)=1;
else button_state==get(hObject,'Min')
    op(6)=0;
end
% Hint: get(hObject,'Value') returns toggle state of togglebutton6


% --- Executes on button press in togglebutton7.
function togglebutton7_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global op;
button_state = get(hObject,'Value')  
if button_state==get(hObject,'Max')
    op(7)=1;
else button_state==get(hObject,'Min')
    op(7)=0;
end
% Hint: get(hObject,'Value') returns toggle state of togglebutton7


% --- Executes on button press in togglebutton8.
function togglebutton8_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global op;
button_state = get(hObject,'Value')  
if button_state==get(hObject,'Max')
    op(8)=1;
else button_state==get(hObject,'Min')
    op(8)=0;
end
% Hint: get(hObject,'Value') returns toggle state of togglebutton8


% --- Executes on button press in togglebutton9.
function togglebutton9_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global op;
button_state = get(hObject,'Value')  
if button_state==get(hObject,'Max')
    op(9)=1;
else button_state==get(hObject,'Min')
    op(9)=0;
end
% Hint: get(hObject,'Value') returns toggle state of togglebutton9



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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
