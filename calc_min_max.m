function[] = calc_min_max(totalHouses)
%calcula a casa com maior e menor distancia ao centro para cada concelho

    tabelaCouncils = readtable('CouncilLocations.txt', 'Delimiter', ',', 'Format', '%C%f%f');
    tabelaDistancias = calc_distancias(totalHouses);
    totalCouncils = height(tabelaCouncils);
    
    %tabela((strcmp(a.CouncilArea, 'Banyule City Council') == 1),:)
    for i = 1:totalCouncils
        
        %sub tabela com todas as casas do concelho com index i
        subTabela = tabelaDistancias((strcmp(tabelaDistancias.CouncilArea, char(tabelaCouncils{i,1})) == 1),:);
        min(i) = round(table2array(subTabela(1,{'distancia'})),3);
        max(i) = round(table2array(subTabela(height(subTabela),{'distancia'})),3);
    end

    min = min';
    min = array2table(min);
    max = max';
    max = array2table(max);
    
    tabelaCouncils = [tabelaCouncils min];
    tabelaCouncils = [tabelaCouncils max];
    
    disp('Writing to file...');
    writetable(tabelaCouncils,'CouncilLocationsMinMax.txt');
    disp('Done.');
end