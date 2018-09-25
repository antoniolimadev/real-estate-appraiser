function[tabelaCasas] = calc_grau_pertenca(totalHouses)
%calcula o grau de pertenca para cada casa

    %lista de casas ja com a respectiva distancia ao centro
    tabelaCasas = calc_distancias(totalHouses);
    totalCasas = height(tabelaCasas);
    %lista de concelhos com a distancia da casa mais perto e mais longe
    tabelaCouncils = readtable('CouncilLocationsMinMax.txt', 'Delimiter', ',', 'Format', '%C%f%f%f%f');
    totalCouncils = height(tabelaCouncils);
    
    for i = 1:totalCasas
        %concelho da casa
        casaCouncil = tabelaCasas{i,{'CouncilArea'}};

        %procura o concelho da casa na tabela de conselhos
        %e calcula o grau de pertenca baseado no min e max
        for index = 1:totalCouncils
            if(find(strcmp(char(casaCouncil),char(tabelaCouncils{index,1})))) == 1

                min = tabelaCouncils{index,4};
                max = tabelaCouncils{index,5};
                
                grauDePertenca(i) = 1 - ((table2array(tabelaCasas(i,{'distancia'})) - min)/(max-min));
            end
        end
    end
    
    
    %arredondar o grau com 5 casas    
    for i = 1:totalCasas
        grauDePertenca(i) = round(grauDePertenca(i), 5);
    end

    grauDePertenca = grauDePertenca';
    grauDePertenca = array2table(grauDePertenca);
    
    tabelaCasas = [tabelaCasas grauDePertenca];
    
    fprintf('%d samples read.\n', totalHouses);
    
    %------------------------------------------------------------------
    
%     tabelaOrdenada = sortrows(aux_case_library,'distancia','descend');
%     max = table2array(tabelaOrdenada(1,{'distancia'}));
%     min = table2array(tabelaOrdenada(height(distancia),{'distancia'}));
%     
%    % for i = 1:numberOfSamples
%    %     distanciaNormalizada(i) = (table2array(aux_case_library(i,{'distancia'})) - min)/(max-min)
%     %end
%     
%     for n = 1:totalSamples
%         grauDePertenca(n) = round(1 - (table2array(aux_case_library(n,{'distancia'})) - min)/(max-min), 5);
%     end
%     
%     grauDePertenca = grauDePertenca';
%     grauDePertenca = array2table(grauDePertenca);
%     
%     aux_case_library = [aux_case_library grauDePertenca];
    
%     disp('Writing to file...');
%     writetable(aux_case_library,'SamplesGrauPertenca.csv');
%     disp('Done.');

end










