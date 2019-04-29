function varargout = FrequencyAnalysis(varargin)
% FREQUENCYANALYSIS MATLAB code for FrequencyAnalysis.fig
%      FREQUENCYANALYSIS, by itself, creates a new FREQUENCYANALYSIS or raises the existing
%      singleton*.
%
%      H = FREQUENCYANALYSIS returns the handle to a new FREQUENCYANALYSIS or the handle to
%      the existing singleton*.
%
%      FREQUENCYANALYSIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FREQUENCYANALYSIS.M with the given input arguments.
%
%      FREQUENCYANALYSIS('Property','Value',...) creates a new FREQUENCYANALYSIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FrequencyAnalysis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FrequencyAnalysis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FrequencyAnalysis

% Last Modified by GUIDE v2.5 05-Dec-2018 16:24:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FrequencyAnalysis_OpeningFcn, ...
                   'gui_OutputFcn',  @FrequencyAnalysis_OutputFcn, ...
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


% --- Executes just before FrequencyAnalysis is made visible.
function FrequencyAnalysis_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FrequencyAnalysis (see VARARGIN)


% Choose default command line output for FrequencyAnalysis
handles.output = hObject;


handles.part=000;
handles.fileName = ('PYF01_contraction 4.csv');%
handles.gender = 11;%
handles.age = 1;%
handles.outfilename= ('MainReport.csv'); %
handles.channel=30;
handles.entropy=0;
handles.cov_percentage=0;
handles.Intensity=0;
handles.diff=0;
handles.mean_RMS=0;
handles.x_mags=[];
handles.freqstate=0;
handles.epoch_ms=1000;
handles.medfreq=0;
handles.f=[];
handles.mdfmapstate=0;
handles.plotsize=[];
handles.Data_rms=[];
handles.mdfmin=0;
handles.mdfmax=100;
handles.xcg=0;
handles.ycg=0;
handles.values=[];
% axes(handles.map_figure)
% %plot(raw_signal, x,y, 'r.')
% plot(handles.currentData)
set(handles.slider1, 'Value', 0.5);

handles.min=0;
handles.max=0;

handles.currentData=zeros(10000,59);
% axes(handles.mdf_plot);
% rmsfreq(handles.currentData(:,handles.channel),100,0,0);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FrequencyAnalysis wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FrequencyAnalysis_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
Data=handles.currentData;
guidata(hObject, handles);
position=get(handles.slider1,'Value');
n=size(Data,1);
% Time=1:n;
% Time=Time';
Data= detrend(Data);

x_mid = ceil(position*10000)
Data_2s = Data(x_mid-249:x_mid+250,:); 
% Time_2s = Time(x_mid-499:x_mid+500,:);
if handles.freqstate==1
handles.x_mags=abs(fft(Data_2s));
end
ch1_diff = 30;
ch2_diff = 31;

handles.epoch_ms = size(Data_2s,1);
%Data_rms=zeros(handles.epoch_ms,64);

% Processing
Data_diff = Data_2s(:,ch1_diff) - Data_2s(:,ch2_diff);
for j = 1:59 %for every channel
    Data_rms(:,j) = rms(Data_2s(:,j),handles.epoch_ms,0,0); %  RMS using an epoch length of 'epoch_ms' ms
    %Data_rms is a vector in which each column corresponds to the rms
    %vector of each channel     
    Data_diff_rms = rms(Data_diff,handles.epoch_ms,0,0); 
    %Data_diff_rms is the RMS of the difference computade with ch1_diff and
    %ch2_diff
end

if handles.freqstate==1
    axes(handles.fftplot);
    handles.medfreq=update_fft(handles.x_mags(:,handles.channel),handles.epoch_ms,0,0,handles.freqstate,...
        handles.channel);
    set(handles.fftplot,'XLim',[0 500]);
    set(handles.fftplot,'YLim',[0 0.3]);
    set(handles.med_freq_disp,'String',num2str(handles.medfreq));
    
    axes(handles.mdfplot_figure);
    for j = 1:59 %for every channel
        Data_mdf(:,j) = mdf(Data_2s(:,j),handles.epoch_ms,0,0);
    end
    handles.Data_mdf=Data_mdf;
    mdfmap_plot(handles.Data_mdf,handles.mdfmin,handles.mdfmax);
end

max_rms = max(Data_rms);
set(handles.disp_max,'String',num2str(max_rms));

%entropy Calculation
% entropy=zeros(n,1);
rms_sq=Data_rms.^2;
sum_rms_sq=sum(rms_sq);
probability=rms_sq./sum_rms_sq;
handles.entropy=-1*sum(probability.*log2(probability));

%CoV calculation
means=mean(Data_rms);       % Calculate mean RMS 
std_dev=std(Data_rms);       % Calculated S.D
cov=std_dev./means; 
handles.cov_percentage=cov*100;

%mean RMS
handles.mean_RMS=means;

%Build the feature 'diff' 
handles.diff = log10(Data_diff_rms);

%Build the feature 'Intensity'
handles.Intensity = log10( (1/59)*sum(Data_rms)); %calculate the Intensity
%plot(handles.currentData);

%map figure
axes(handles.map_figure)
handles.Data_rms=Data_rms;
[handles.xcg,handles.ycg]=map_print(handles.Data_rms,handles.min,handles.max);

hObject.UserData=[handles.part handles.age handles.gender handles.entropy ...
    handles.cov_percentage handles.Intensity handles.diff handles.xcg ...
    handles.ycg handles.mean_RMS];

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in export_button.
function export_button_Callback(hObject, eventdata, handles)
% hObject    handle to export_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
guidata(hObject, handles);
slider1_Callback(hObject, eventdata, handles);
%h=findobj('Tag','slider1');
values=hObject.UserData
% handles.values=[handles.part handles.age handles.gender handles.entropy ...
%     handles.cov_percentage handles.Intensity handles.diff handles.xcg ...
%     handles.ycg handles.mean_RMS]
dlmwrite(handles.outfilename,values,'-append')
guidata(hObject, handles);


function participant_text_Callback(hObject, eventdata, handles)
% hObject    handle to participant_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of participant_text as text
%        str2double(get(hObject,'String')) returns contents of participant_text as a double
handles.part = get(hObject,'Value');
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function participant_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to participant_text (see GCBO)
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


% --- Executes on selection change in age_popup.
function age_popup_Callback(hObject, eventdata, handles)
% hObject    handle to age_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns age_popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from age_popup
handles.age = get(hObject,'Value');
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function age_popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to age_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in gender_popup.
function gender_popup_Callback(hObject, eventdata, handles)
% hObject    handle to gender_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns gender_popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from gender_popup
%handles.gender = get(hObject,'String')
handles.gender = get(hObject,'Value')+10;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function gender_popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gender_popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function raw_signal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to raw_signal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate raw_signal



function min_num_Callback(hObject, eventdata, handles)
% hObject    handle to min_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of min_num as text
%        str2double(get(hObject,'String')) returns contents of min_num as a double
axes(handles.map_figure)
handles.min=str2num(get(hObject,'String'));
slider1_Callback(hObject, eventdata, handles)
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function min_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to min_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function max_num_Callback(hObject, eventdata, handles)
% hObject    handle to max_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of max_num as text
%        str2double(get(hObject,'String')) returns contents of max_num as a double
axes(handles.map_figure)
handles.max=str2num(get(hObject,'String'));
slider1_Callback(hObject, eventdata, handles)
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function max_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to max_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in loadfile.
function loadfile_Callback(hObject, eventdata, handles)
% hObject    handle to loadfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.raw_signal);
handles.fileName=uigetfile({'*.*'},...
                          'File Selector');
C = strsplit(handles.fileName,'.');
tf = strcmp( C{2},'mat')
if tf == 1
    load(handles.fileName)
    handles.currentData=Data;
    handles.currentData=mono2bi(handles.currentData);
else
    handles.currentData=csvread(handles.fileName);
    handles.currentData=mono2bi(handles.currentData);
end
update_single(handles.currentData,handles.channel);
handles.plotsize=get(handles.raw_signal,'XLim');
set(handles.slider1, 'min', handles.plotsize(1));
set(handles.slider1, 'max', handles.plotsize(2)/10000);
set(handles.mdf_plot, 'XLim',[handles.plotsize(1) handles.plotsize(2)]);
Data2=handles.currentData(ceil(end/2)-499:ceil(end/2)+500,:);
for j = 1:59 %for every channel
    Data_rms(:,j) = rms(Data2,1000,0,0); %  RMS using an epoch length of 'epoch_ms' ms
end
max_rms = max(Data_rms);
set(handles.disp_max,'String',num2str(max_rms+0.8*max_rms));
set(handles.max_num,'String',num2str(max_rms+0.8*max_rms))
handles.max=max_rms+0.8*max_rms;
slider1_Callback(hObject, eventdata, handles);
% frequencybutton_Callback(hObject, eventdata, handles);


if handles.freqstate==1
    axes(handles.fftplot);
    handles.medfreq=update_fft(handles.x_mags(:,handles.channel),handles.epoch_ms,0,0,handles.freqstate,...
        handles.channel);
    set(handles.fftplot,'XLim',[0 500]);
    set(handles.fftplot,'YLim',[0 0.3]);
    set(handles.med_freq_disp,'String',num2str(handles.medfreq));
    
    axes(handles.mdf_plot);
    rmsfreq(handles.currentData(:,handles.channel),100,0,0);
    set(handles.mdf_plot, 'XLim',[handles.plotsize(1) handles.plotsize(2)])
end

guidata(hObject, handles);

function chan_num_Callback(hObject, eventdata, handles)
% hObject    handle to chan_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of chan_num as text
%        str2double(get(hObject,'String')) returns contents of chan_num as a double
axes(handles.raw_signal);
handles.channel=str2double(get(hObject,'String'));
update_single(handles.currentData,handles.channel);
if handles.freqstate == 1
axes(handles.mdf_plot);
rmsfreq(handles.currentData(:,handles.channel),100,0,0);
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function chan_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to chan_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in filter_button.
function filter_button_Callback(hObject, eventdata, handles)
% hObject    handle to filter_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
y=bandpass_filter(handles.currentData);
handles.currentData=y;
axes(handles.raw_signal);
update_single(handles.currentData,handles.channel);
axes(handles.fftplot)
slider1_Callback(hObject, eventdata, handles);
if handles.freqstate==1
axes(handles.mdf_plot);
rmsfreq(handles.currentData(:,handles.channel),100,0,0);    
end


% update_fft(handles.x_mags(:,handles.channel),handles.epoch_ms,0,0,handles.freqstate,...
%     handles.channel);
set(handles.fftplot,'XLim',[0 500]);
set(handles.fftplot,'YLim',[0 0.3]);
guidata(hObject, handles);


% --- Executes on button press in frequencybutton.
function frequencybutton_Callback(hObject, eventdata, handles)
% hObject    handle to frequencybutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of frequencybutton
handles.freqstate=get(hObject,'Value');
slider1_Callback(hObject, eventdata, handles);
if handles.freqstate == 1
axes(handles.mdf_plot);
rmsfreq(handles.currentData(:,handles.channel),100,0,0);
end

guidata(hObject, handles);



function min_mdf_Callback(hObject, eventdata, handles)
% hObject    handle to min_mdf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of min_mdf as text
%        str2double(get(hObject,'String')) returns contents of min_mdf as a double
axes(handles.mdfplot_figure)
handles.mdfmin=str2num(get(hObject,'String'));
slider1_Callback(hObject, eventdata, handles);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function min_mdf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to min_mdf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function max_mdf_Callback(hObject, eventdata, handles)
% hObject    handle to max_mdf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of max_mdf as text
%        str2double(get(hObject,'String')) returns contents of max_mdf as a double
axes(handles.mdfplot_figure)
handles.mdfmax=str2num(get(hObject,'String'));
slider1_Callback(hObject, eventdata, handles)
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function max_mdf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to max_mdf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function uitoggletool4_OnCallback(hObject, eventdata, handles)
% hObject    handle to uitoggletool4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.xcord=ginput(1);
set(handles.slider1, 'Value', handles.xcord(1)/10000);
slider1_Callback(hObject, eventdata, handles);
guidata(hObject, handles);
