function [] = calc_pertenca_casa_council(totalHouses)

    tabelaDistancias = calc_distancias_casa_council(totalHouses);

    tabelaPertencas = table();
    
    for i = 1:size(tabelaDistancias,1)

        min_distancia = min(tabelaDistancias{i,2:size(tabelaDistancias,2)});
        max_distancia = max(tabelaDistancias{i,2:size(tabelaDistancias,2)});

        currentHouse = table(i, 'VariableNames',{'Index'});  

        for j = 2:30

            columnName = tabelaDistancias.Properties.VariableNames{1,j};
            grauDePertenca = 1 - (((tabelaDistancias{i,j} - min_distancia))/(max_distancia - min_distancia));

            currentCouncil = table(grauDePertenca, 'VariableNames',{columnName});
            currentHouse = [currentHouse currentCouncil];

        end

        tabelaPertencas = [tabelaPertencas; currentHouse];
    end
    
    disp('Creating tabelaPertencas.txt...');
    writetable(tabelaPertencas,'tabelaPertencas.txt');
    disp('Done.');
end

