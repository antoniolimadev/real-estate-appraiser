function[tabelaDistancias] = calc_distancias_casa_council(totalHouses)
%calcula o grau de pertenca para cada casa
clc
   
    fileName = 'Melbourne_Samples.xlsx';
    council_locations = readtable('CouncilLocations.txt', 'Delimiter', ',', 'Format', '%C%f%f');
    case_library = readtable(fileName);
    tabelaDistancias = table();

    for i = 1:totalHouses
       
        new_case.CouncilArea = case_library{i, 'CouncilArea'};
        new_case.Latitude = case_library{i, 'Lattitude'};
        new_case.Longitude = case_library{i, 'Longtitude'};
        
%         distancias = zeros(1,29);

        currentHouse = table(i, 'VariableNames',{'Index'});

        for j = 1:size(council_locations,1);
            
            council.Name = council_locations{j, 'CouncilName'};
            council.Latitude = council_locations{j, 'Latitude'};
            council.Longitude = council_locations{j, 'Longitude'};
            
            %distancias(1,j) = calc_single_distancia(new_case, council);
            distancia = round(haversine([new_case.Latitude, new_case.Longitude], [council.Latitude council.Longitude]),3);
            
            councilName = strrep(char(council.Name), ' ', '');
            
            %currentCouncil = table(distancia, 'VariableNames',{strcat('Council', num2str(j))});
            currentCouncil = table(distancia, 'VariableNames',{councilName});
            currentHouse = [currentHouse currentCouncil];
            
        end
        tabelaDistancias = [tabelaDistancias; currentHouse];
%         disp(distancias);
    end


end










