function varargout = main_gui(varargin)
% MAIN_GUI MATLAB code for main_gui.fig
%      MAIN_GUI, by itself, creates a new MAIN_GUI or raises the existing
%      singleton*.
%
%      H = MAIN_GUI returns the handle to a new MAIN_GUI or the handle to
%      the existing singleton*.
%
%      MAIN_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN_GUI.M with the given input arguments.
%
%      MAIN_GUI('Property','Value',...) creates a new MAIN_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main_gui

% Last Modified by GUIDE v2.5 06-Sep-2018 23:52:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @main_gui_OutputFcn, ...
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


% --- Executes just before main_gui is made visible.
function main_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main_gui (see VARARGIN)

% Choose default command line output for main_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in loadCaseLibraryButton.
function loadCaseLibraryButton_Callback(hObject, eventdata, handles)
% hObject    handle to loadCaseLibraryButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    clc

    %get n cases from gui
    n_cases = str2double(get(handles.totalCases, 'string'));
    %get table from gui
    caseLibraryTable = handles.caseLibraryTable;

    %get n cases from case library
    case_library = calc_grau_pertenca(n_cases);
    
    handles.case_library=case_library;
    guidata(hObject,handles);
    %get case table ready for uitable
    ca = custom_table2cell_array(case_library);
    
    %set table data
    set(caseLibraryTable,'Data', ca);
    set(caseLibraryTable,'ColumnName',{'Suburb';'Address';'Rooms';'Type';'Price';'Method';'SellerG';'Date';'Distance';...
        'Postcode';'Bedroom2';'Bathroom';'Car';'Landsize';'BuildingArea';'YearBuilt';'Latitude';'Longitude';'Regionname';...
        'Propertycount';'MyKey';'CouncilArea';'distancia';'grauPertenca';});


function totalCases_Callback(hObject, eventdata, handles)
% hObject    handle to totalCases (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of totalCases as text
%        str2double(get(hObject,'String')) returns contents of totalCases as a double


% --- Executes during object creation, after setting all properties.
function totalCases_CreateFcn(hObject, eventdata, handles)
% hObject    handle to totalCases (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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



function carEdit_Callback(hObject, eventdata, handles)
% hObject    handle to carEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of carEdit as text
%        str2double(get(hObject,'String')) returns contents of carEdit as a double


% --- Executes during object creation, after setting all properties.
function carEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to carEdit (see GCBO)
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



function landsizeEdit_Callback(hObject, eventdata, handles)
% hObject    handle to landsizeEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of landsizeEdit as text
%        str2double(get(hObject,'String')) returns contents of landsizeEdit as a double


% --- Executes during object creation, after setting all properties.
function landsizeEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to landsizeEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function priceEdit_Callback(hObject, eventdata, handles)
% hObject    handle to priceEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of priceEdit as text
%        str2double(get(hObject,'String')) returns contents of priceEdit as a double


% --- Executes during object creation, after setting all properties.
function priceEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to priceEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function buildingareaEdit_Callback(hObject, eventdata, handles)
% hObject    handle to buildingareaEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of buildingareaEdit as text
%        str2double(get(hObject,'String')) returns contents of buildingareaEdit as a double


% --- Executes during object creation, after setting all properties.
function buildingareaEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to buildingareaEdit (see GCBO)
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



function yearbuiltEdit_Callback(hObject, eventdata, handles)
% hObject    handle to yearbuiltEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yearbuiltEdit as text
%        str2double(get(hObject,'String')) returns contents of yearbuiltEdit as a double


% --- Executes during object creation, after setting all properties.
function yearbuiltEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yearbuiltEdit (see GCBO)
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


% --- Executes on selection change in typePopup.
function typePopup_Callback(hObject, eventdata, handles)
% hObject    handle to typePopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns typePopup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from typePopup


% --- Executes during object creation, after setting all properties.
function typePopup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to typePopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

options = char('h','t','u');
set(hObject,'string',options);

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function roomsEdit_Callback(hObject, eventdata, handles)
% hObject    handle to roomsEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of roomsEdit as text
%        str2double(get(hObject,'String')) returns contents of roomsEdit as a double


% --- Executes during object creation, after setting all properties.
function roomsEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to roomsEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bedroom2Edit_Callback(hObject, eventdata, handles)
% hObject    handle to bedroom2Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bedroom2Edit as text
%        str2double(get(hObject,'String')) returns contents of bedroom2Edit as a double


% --- Executes during object creation, after setting all properties.
function bedroom2Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bedroom2Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bathroomEdit_Callback(hObject, eventdata, handles)
% hObject    handle to bathroomEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bathroomEdit as text
%        str2double(get(hObject,'String')) returns contents of bathroomEdit as a double


% --- Executes during object creation, after setting all properties.
function bathroomEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bathroomEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in councilPopup.
function councilPopup_Callback(hObject, eventdata, handles)
% hObject    handle to councilPopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns councilPopup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from councilPopup


% --- Executes during object creation, after setting all properties.
function councilPopup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to councilPopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

options = char('Banyule City Council','Port Phillip City Council', 'Stonnington City Council', 'Boroondara City Council',...
        'Yarra City Council','Melbourne City Council','Monash City Council','Bayside City Council','Glen Eira City Council',...
        'Darebin City Council','Moreland City Council','Whitehorse City Council','Moonee Valley City Council',...
        'Maribyrnong City Council','Hobsons Bay City Council','Manningham City Council','Banyule City Council','Kingston City Council',...
        'Maroondah City Council','Greater Dandenong City Council','Knox City Council','Brimbank City Council',...
        'Casey City Council','Frankston City Council', 'Nillumbik Shire Council','Hume City Council',...
        'Macedon Ranges Shire Council','Whittlesea City Council','Wyndham City Council','Melton City Council');
set(hObject,'string',options);

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in retrieveButton.
function retrieveButton_Callback(hObject, eventdata, handles)
% hObject    handle to retrieveButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    %create new case
    new_case.Rooms = str2double(get(handles.roomsEdit, 'string'));
    contents = cellstr(get(handles.typePopup, 'String'));
    typeValue = contents(get(handles.typePopup, 'Value'));
    new_case.Type = char(typeValue);
    %new_case.Price = str2double(get(handles.priceEdit, 'string'));
    new_case.Bedroom2 = str2double(get(handles.bedroom2Edit, 'string'));
    new_case.Bathroom = str2double(get(handles.bathroomEdit, 'string'));
    new_case.Car = str2double(get(handles.carEdit, 'string'));
    new_case.Landsize = str2double(get(handles.landsizeEdit, 'string'));
    new_case.BuildingArea = str2double(get(handles.buildingareaEdit, 'string'));
    new_case.YearBuilt = str2double(get(handles.yearbuiltEdit, 'string'));
    contents = cellstr(get(handles.councilPopup, 'String'));
    councilValue = contents(get(handles.councilPopup, 'Value'));
    new_case.CouncilArea = char(councilValue);
    %new_case.DistanciaCentro = 0.5;
    new_case.Latitude = str2double(get(handles.latitudeEdit, 'string'));
    new_case.Longitude = str2double(get(handles.longitudeEdit, 'string'));
    
    disp(new_case);

    %get similarity_threshold and how many similar cases to show
    similarity_threshold = str2double(get(handles.similarityEdit, 'string'));
    howMany = str2double(get(handles.howmanyEdit, 'string'));
    
    %read case library from guidata
    case_library = handles.case_library;
    %retrieve similar cases
    [retrieved_indexes, similarities] = retrieve(case_library, new_case, similarity_threshold);
    

    retrieved_cases = table();
    for i = 1:size(retrieved_indexes,2)
        retrieved_cases = [retrieved_cases; case_library(retrieved_indexes(i),:)];
        %disp(case_library(retrieved_indexes(i),:));
    end
    
    retrieved_indexes = retrieved_indexes';
    retrieved_indexes = array2table(retrieved_indexes);
    similarities = similarities';
    similarities = array2table(similarities);
    
    retrieved_cases = [similarities retrieved_cases];
    retrieved_cases = [retrieved_indexes retrieved_cases];
    
    %sort by similarities
    retrieved_cases = sortrows(retrieved_cases, 'similarities', 'descend');

    %take top10
    if howMany > size(retrieved_cases,1)
        howMany = size(retrieved_cases,1);
    end
    retrieved_cases = retrieved_cases(1:howMany,:);

    disp(retrieved_cases);
    
    retrieveTable = handles.retrieveTable;
    ca = custom_table2cell_array(retrieved_cases);
    
    %set table data with closest cases
    set(retrieveTable,'Data', ca);
    set(retrieveTable,'ColumnName',{'Index';'Similarity';'Suburb';'Address';'Rooms';'Type';'Price';'Method';'SellerG';'Date';'Distance';...
        'Postcode';'Bedroom2';'Bathroom';'Car';'Landsize';'BuildingArea';'YearBuilt';'Latitude';'Longitude';'Regionname';...
        'Propertycount';'MyKey';'CouncilArea';'distancia';'grauPertenca';});
    
    %save new case to guidata
    handles.new_case = new_case;
    handles.retrieved_cases = retrieved_cases;
    guidata(hObject,handles);



function howmanyEdit_Callback(hObject, eventdata, handles)
% hObject    handle to howmanyEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of howmanyEdit as text
%        str2double(get(hObject,'String')) returns contents of howmanyEdit as a double


% --- Executes during object creation, after setting all properties.
function howmanyEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to howmanyEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function similarityEdit_Callback(hObject, eventdata, handles)
% hObject    handle to similarityEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of similarityEdit as text
%        str2double(get(hObject,'String')) returns contents of similarityEdit as a double


% --- Executes during object creation, after setting all properties.
function similarityEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to similarityEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function latitudeEdit_Callback(hObject, eventdata, handles)
% hObject    handle to latitudeEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of latitudeEdit as text
%        str2double(get(hObject,'String')) returns contents of latitudeEdit as a double


% --- Executes during object creation, after setting all properties.
function latitudeEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to latitudeEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function longitudeEdit_Callback(hObject, eventdata, handles)
% hObject    handle to longitudeEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of longitudeEdit as text
%        str2double(get(hObject,'String')) returns contents of longitudeEdit as a double


% --- Executes during object creation, after setting all properties.
function longitudeEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to longitudeEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in reuse1Button.
function reuse1Button_Callback(hObject, eventdata, handles)
% hObject    handle to reuse1Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    new_case = handles.new_case;
    
    %set(handles.bestCaseLabel, 'string', strcat('Grau Pertença (New Case): ', num2str(grauPertencaNewCase)));
    
    retrieved_cases = handles.retrieved_cases;
    [best_similarity best_case_index] = reuse(new_case, retrieved_cases);
    
    if(best_similarity < 0.75)
        best_case_index = 0;
    end
    
    if best_case_index > 0
        a='Best Case -> Index: ';
        index = num2str(best_case_index);
        b=' Price: ';
        price = num2str(retrieved_cases{best_case_index, 'Price'});
        bestCaseString = sprintf('%s %s %s %s', a, index, b, price);
        set(handles.finalPriceEdit, 'string', num2str(price));
    else
        bestCaseString = 'Best Case -> No cases similar enough found.';
        best_case_index = 1; % passa a ser o caso com maior similarity para ser usado no REUSE 2
    end
    
    set(handles.bestCaseLabel, 'string', bestCaseString);
    
    
    %save best_case_index to guidata
    handles.best_case_index = best_case_index;
    handles.best_similarity = best_similarity;
    guidata(hObject,handles);
    
    

% --- Executes on button press in reuse2Button.
function reuse2Button_Callback(hObject, eventdata, handles)
% hObject    handle to reuse2Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    new_case = handles.new_case;
    retrieved_cases = handles.retrieved_cases;
    best_case_index = handles.best_case_index;
    
    [m2_building m2_land estimativa_final] = calc_estimativa(new_case, retrieved_cases, best_case_index);
    
    set(handles.estimationLabel, 'string', strcat('Final Estimation: ', num2str(estimativa_final)));
    set(handles.finalPriceEdit, 'string', num2str(estimativa_final));
    
    set(handles.casam2Label, 'string', strcat('Building m2: ', num2str(round(m2_building,1))));
    set(handles.terrenom2Label, 'string', strcat('Land m2: ', num2str(round(m2_land,1))));
    
    
    best_similarity = handles.best_similarity;
    if(best_similarity > 0.6)
        set(handles.retainCheck, 'Value', 1);
    end
    
    



function finalPriceEdit_Callback(hObject, eventdata, handles)
% hObject    handle to finalPriceEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of finalPriceEdit as text
%        str2double(get(hObject,'String')) returns contents of finalPriceEdit as a double


% --- Executes during object creation, after setting all properties.
function finalPriceEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to finalPriceEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in retainCheck.
function retainCheck_Callback(hObject, eventdata, handles)
% hObject    handle to retainCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of retainCheck


% --- Executes on button press in saveHistoryButton.
function saveHistoryButton_Callback(hObject, eventdata, handles)
% hObject    handle to saveHistoryButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


    new_case = handles.new_case;
    new_price = str2double(get(handles.finalPriceEdit, 'string'));
    retain = get(handles.retainCheck, 'Value');

    save_history(new_case, new_price, retain);
