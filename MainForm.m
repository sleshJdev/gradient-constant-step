function varargout = MainForm(varargin)
disp('MainForm()');
% MAINFORM MATLAB code for MainForm.fig
%      MAINFORM, by itself, creates a new MAINFORM or raises the existing
%      singleton*.
%
%      H = MAINFORM returns the handle to a new MAINFORM or the handle to
%      the existing singleton*.
%
%      MAINFORM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINFORM.M with the given input arguments.
%
%      MAINFORM('Property','Value',...) creates a new MAINFORM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MainForm_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MainForm_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MainForm

% Last Modified by GUIDE v2.5 13-Mar-2015 23:02:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MainForm_OpeningFcn, ...
                   'gui_OutputFcn',  @MainForm_OutputFcn, ...
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


% --- Executes just before MainForm is made visible.
function MainForm_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MainForm (see VARARGIN)

% Choose default command line output for MainForm
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MainForm wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%--- Settings section ---%
rotate3d on;
addpath util\
%--- Preparation section ---%
clc;
disp('MainForm_OpeningFcn()');


% --- Outputs from this function are returned to the command line.
function varargout = MainForm_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

disp('MainForm_OutputFcn()');

% --- Executes on button press in runButton.
function runButton_Callback(hObject, eventdata, handles)
% hObject    handle to runButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    x1 = str2double(get(handles.startXEdit, 'String'));
    x2 = str2double(get(handles.endXEdit, 'String')); 
    y1 = str2double(get(handles.startYEdit, 'String'));
    y2 = str2double(get(handles.endYEdit, 'String'));    
    e  = str2double(get(handles.precisionEdit, 'String'));      
    ox = str2double(get(handles.originXEdit, 'String')); 
    oy = str2double(get(handles.originYEdit, 'String')); 
    s = str2double(get(handles.stepEdit, 'String'));     
    [vMin, point, path] = gsfs(x1, x2, y1, y2, e, ox, oy, s);   
    set(handles.xMinText, 'String', vMin(1));
    set(handles.yMinText, 'String', vMin(2));
    set(handles.zMinText, 'String', vMin(3));
    [xM, yM] = meshgrid(x1:0.1:x2,y1:0.1:y2);
    zM = f2v2(xM, yM);
    surf(handles.mainAxes, xM, yM, zM); 
    hold on;
    [xM, yM] = meshgrid(x1:0.1:x2,...
                        y1:0.1:y2);
    zM       = f2v2(xM, yM);
    mesh(handles.mainAxes, xM, yM, zM);
    hold on;
    plot3(handles.mainAxes, path(1,:), path(2,:), path(3,:),...
                    '--rs','LineWidth',1,...
                    'MarkerEdgeColor','r',...
                    'MarkerFaceColor','r',...
                    'MarkerSize',2)
    plot3(handles.mainAxes, point(1), point(2), f2v2(point(1),point(2)),...
                    '--rs','LineWidth',5,...
                    'MarkerEdgeColor','r',...
                    'MarkerFaceColor','r',...
                    'MarkerSize',10)
    hold off;
