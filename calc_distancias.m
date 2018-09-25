function[sortedTableDistancias] = calc_distancias(howManyHouses)
% calcula a distancia de cada casa ao centro do concelho e guarda numa tabela
% no fim orderna por concelho e por distancia ao centro

format long;

    fileName = 'Melbourne_Samples.xlsx';
    council_locations = readtable('CouncilLocations.txt', 'Delimiter', ',', 'Format', '%C%f%f');
    case_library = readtable(fileName);
    
    if howManyHouses == 0
        aux_case_library = case_library;
    else
        aux_case_library = case_library(1:howManyHouses,:);
    end
    
    %numberOfSamples = height(case_library);
    totalSamples = height(aux_case_library);
    totalCouncils = height(council_locations);

    
    %percorre a tabela de samples e vai à tabela de concelhos ver a localizacao
    for i = 1:totalSamples
        sampleCouncil = aux_case_library{i,{'CouncilArea'}};
        %disp(case_library{i,{'CouncilArea'}});
        
        %index = 1;
        for index = 1:totalCouncils
            if(find(strcmp(char(sampleCouncil),char(council_locations{index,1})))) == 1
                councilLat = council_locations{index,2};
                councilLon = council_locations{index,3};
            end
        end
        
        sampleLocation = aux_case_library{i, {'Lattitude', 'Longtitude'}};
        
        distancia(i) = round(haversine([councilLat, councilLon], sampleLocation),3);
      
    end
    
    distancia = distancia';
    distancia = array2table(distancia);
    
    
%     disp(height(aux_case_library));
%     disp(height(distancia));

   % case_library = [case_library distancia];
    aux_case_library = [aux_case_library distancia];
    
    sortedTableDistancias = sortrows(aux_case_library, {'CouncilArea', 'distancia'});
    
  
%--------------------------------------------------------------
%{
    T = case_library(1:5,:);
    
   disp(T);
   distancia = distancia';
   distancia = array2table(distancia);
   disp(distancia);
   
   T2 = [T distancia];
   disp(T2);
       
    howManyHouses = 1;
    numberOfCouncils = 0;
    
    councilAreaNames = case_library{1:howManyHouses, {'CouncilArea'}};
    
    %ficamos apenas com a coluna dos council names
    councilAreaNames = case_library{:,22}; 

    %remove duplicados
    councilAreaNames = unique(councilAreaNames);
    

    %aqui so ta a ir buscar o primeiro elemento do councilAreaNames,
    % é preciso meter isto num for e criar um array com os nomes todos
    councilAreaStrings = char(councilAreaNames(:,1));
    
    %disp(councilAreaStrings);
    
    %aqui so ta a ir buscar a localizaçao do primeiro council
    % é preciso meter isto num for e criar um array com os councils todos
    [councilLatitude, councilLongitude] = get_lat_lon_from_google('Banyule City Council');
    
    houseLocations = case_library{1:howManyHouses, {'Lattitude', 'Longtitude'}};
    
    distancia = haversine([councilLatitude, councilLongitude], houseLocations)
    
    %}
    
end