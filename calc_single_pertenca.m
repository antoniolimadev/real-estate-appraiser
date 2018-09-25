function[grauDePertenca] = calc_grau_pertenca(new_case)


    tabelaCouncils = readtable('CouncilLocationsMinMax.txt', 'Delimiter', ',', 'Format', '%C%f%f%f%f');
    totalCouncils = height(tabelaCouncils);
    
    %procura o concelho da casa na tabela de conselhos
    %e calcula o grau de pertenca baseado no min e max
    for index = 1:totalCouncils
        if(find(strcmp(char(new_case.CouncilArea),char(tabelaCouncils{index,1})))) == 1

            councilLat = tabelaCouncils{index,2};
            councilLon = tabelaCouncils{index,3};
            min = tabelaCouncils{index,4};
            max = tabelaCouncils{index,5};
            
            distanciaAoCentro = round(haversine([councilLat, councilLon], [new_case.Latitude new_case.Longitude]),3);

            grauDePertenca = 1 - ((distanciaAoCentro - min)/(max-min));
        end
    end
    

end