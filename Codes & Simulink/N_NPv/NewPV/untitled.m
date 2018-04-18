function varargout = untitled(varargin)
% UNTITLED MATLAB code for untitled.fig
%      UNTITLED, by itself, creates a new UNTITLED or raises the existing
%      singleton*.
%
%      H = UNTITLED returns the handle to a new UNTITLED or the handle to
%      the existing singleton*.
%
%      UNTITLED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED.M with the given input arguments.
%
%      UNTITLED('Property','Value',...) creates a new UNTITLED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled

% Last Modified by GUIDE v2.5 06-Feb-2018 23:20:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled_OutputFcn, ...
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


% --- Executes just before untitled is made visible.
function untitled_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled (see VARARGIN)

% Choose default command line output for untitled
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = untitled_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%PV Data
clc
Iscn=str2num(get(handles.isc,'string'));;
Vocn=str2num(get(handles.voc,'string'));;
Ns=str2num(get(handles.ns,'string'));;
Tc=str2num(get(handles.tc,'string'));;
a=str2num(get(handles.a,'string'));;   
G=str2num(get(handles.g,'string'));;
Rs=str2num(get(handles.rs,'string'));;
Rp=str2num(get(handles.rp,'string'));;
L=str2num(get(handles.l,'string'));;
W=str2num(get(handles.w,'string'));;
alfa=str2num(get(handles.ang_pv,'string'));;
cita=str2num(get(handles.ang_s,'string'));;
S_L=str2num(get(handles.s_l,'string'));;
S_W=str2num(get(handles.s_w,'string'));
N_U=str2num(get(handles.n_m,'string'));
U_L=(S_L/(((N_U)*((cosd(alfa))+((sind(alfa))/tand(cita))))-(((sind(alfa))/tand(cita))-1+cosd(cita))))
U_W=S_W;
A_U=U_L*U_W
%const
K=1.38065e-23;     %Boltzman const
q=1.602e-19;       %electron charge
Kv=-.123;          %Temp voltage const
Ki=.0032;          %Temp Current const
Tnc=25;            %nominal temp
Tn=Tnc+273;
Gn=1000;           %nominal irridiance
Eg=1.12;           %Band gap at 25 deg cel
%system data
T=Tc+273;          
Pitch_L= (U_L*cosd(alfa))+((U_L*sind(alfa))/(tand(cita)))
Pitch_W= U_W;
A_NU=(Pitch_L*Pitch_W)         %Area needed for unit
A_NT=A_NU-((U_L*sind(alfa))/(tand(cita))*Pitch_W)
Ipvn=Iscn;
Vt=(Ns*K*T)/q;
Ipv=(G/Gn)*(Ipvn+Ki*(T-Tn));
Ion=Ipvn/(exp(Vocn/(a*Vt))-1);
Io=Ion*((T/Tn)^3)*exp((((q*Eg)/a*K))*((1/Tn)-(1/T)));

I= zeros(100,1);
i=1;
I(1,1)=Iscn;

for V=0:.1:Vocn;
    I(i+1)= Ipv-Io*(exp((V+I(i,1)*Rs)/(a*Vt))-1)-((V+(I(i,1)*Rs))/Rp);
    V1(i)=V;
    P(i)=V*I(i);
    n(i)=P(i)/(G*L*W);  %PV effichincy
    i=i+1;
end
V1(i)=V1(i-1);
P(i)=P(i-1);
n(i)=n(i-1);
V1=transpose(V1);
axes(handles.axes1)
plot(V1,I,'r');
xlabel('V(Vlots)');
ylabel('I(Amp)');
grid on
axes(handles.axes2)
plot(V1,P,'b');
xlabel('V(Vlots)');
ylabel('Power(W)');
grid on
axes(handles.axes3)
plot(V1,n*100,'g');
xlabel('V(Vlots)');
ylabel('Efficiency %');
grid on
Pmax= max(P)
P_o=.90*Pmax
N=(N_U*A_U)/(L*W)
Power=N*P_o*10^-3
Power_d=Power*24
set(handles.st1,'string',Pitch_L)
set(handles.st2,'string',Pitch_W)
set(handles.st3,'string',A_NU)
set(handles.st4,'string',N)
set(handles.st5,'string',P_o)
set(handles.st6,'string',Power)
set(handles.st7,'string',Power_d)



function s_l_Callback(hObject, eventdata, handles)
% hObject    handle to s_l (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of s_l as text
%        str2double(get(hObject,'String')) returns contents of s_l as a double


% --- Executes during object creation, after setting all properties.
function s_l_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s_l (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function s_w_Callback(hObject, eventdata, handles)
% hObject    handle to s_w (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of s_w as text
%        str2double(get(hObject,'String')) returns contents of s_w as a double


% --- Executes during object creation, after setting all properties.
function s_w_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s_w (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function n_m_Callback(hObject, eventdata, handles)
% hObject    handle to n_m (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of n_m as text
%        str2double(get(hObject,'String')) returns contents of n_m as a double


% --- Executes during object creation, after setting all properties.
function n_m_CreateFcn(hObject, eventdata, handles)
% hObject    handle to n_m (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function g_Callback(hObject, eventdata, handles)
% hObject    handle to g (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of g as text
%        str2double(get(hObject,'String')) returns contents of g as a double



function isc_Callback(hObject, eventdata, handles)
% hObject    handle to isc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of isc as text
%        str2double(get(hObject,'String')) returns contents of isc as a double
