function [] = save_history(new_case, new_price, retain)
clc
    %Rooms, Type, Bedroom2, Bathroom, Car, Landsize,BuildingArea, 
    %YearBuilt, CouncilArea, Latitude, Longitude, Price, Retain
    % %f%s%f%f%f%f%f%f%s%f%f
    history_table = readtable('history.txt', 'Delimiter', ',', 'Format', '%f%s%f%f%f%f%f%f%s%f%f%f%f');

%     new_case.Rooms = 2;
%     new_case.Type = 'h';
%     new_case.Bedroom2 = 2;
%     new_case.Bathroom = 1;
%     new_case.Car = 2;
%     new_case.Landsize = 225;
%     new_case.BuildingArea = 119;
%     new_case.YearBuilt = 1910;
%     new_case.CouncilArea = 'Banyule City Council';
%     new_case.Latitude = -37.7501;
%     new_case.Longitude = 145.0505;

    
    T1 = table(new_case.Rooms, {new_case.Type}, new_case.Bedroom2, new_case.Bathroom, new_case.Car, new_case.Landsize,...
        new_case.BuildingArea, new_case.YearBuilt, {new_case.CouncilArea}, new_case.Latitude, new_case.Longitude,...
        new_price, retain,...
    'VariableNames',{'Rooms', 'Type', 'Bedroom2', 'Bathroom', 'Car', 'Landsize','BuildingArea',...
    'YearBuilt', 'CouncilArea', 'Latitude', 'Longitude', 'Price', 'Retain'});
    
    history_table = [history_table; T1];

    disp('Updating history...');
    writetable(history_table,'history.txt');
    disp('Done.');
%     disp(history_table);    
end

