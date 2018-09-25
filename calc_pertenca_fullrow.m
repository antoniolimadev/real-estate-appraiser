function [currentHousePertencas] = calc_pertenca_fullrow(new_case)
%recebe uma casa e calcula o grau de pertenca a todos os concelhos
%     new_case.CouncilArea = 'Banyule City Council';
%     new_case.Latitude = -37.73880;
%     new_case.Longitude = 145.05810;

    council_locations = readtable('CouncilLocations.txt', 'Delimiter', ',', 'Format', '%C%f%f');
    currentHouse = table();
    
    % calcular distancias da casa a todos os concelhos
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
    %--------------------------------------------------
    
    %normalizar as distancias e calcular grau de pertenca
    
    min_distancia = min(currentHouse{:,1:size(currentHouse,2)});
    max_distancia = max(currentHouse{:,1:size(currentHouse,2)});
    
    currentHousePertencas = table();
    
    for j = 1:29

        columnName = currentHouse.Properties.VariableNames{1,j};
        grauDePertenca = 1 - (((currentHouse{1,j} - min_distancia))/(max_distancia - min_distancia));

        currentCouncil = table(grauDePertenca, 'VariableNames',{columnName});
        currentHousePertencas = [currentHousePertencas currentCouncil];

    end
    %----------------------------------------------------
end














