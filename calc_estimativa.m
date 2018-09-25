function[newCaseBuildFuzzPrice, newCaseLandFuzzPrice, estimativa_final] = calc_estimativa(new_case, retrieved_cases, best_case_index)
%alinea d) 3.
format short
    council_prices_table = readtable('CouncilAreaPrices.txt', 'Delimiter', ',', 'Format', '%f%C%f%f');

    newCaseBuild = new_case.BuildingArea;
    newCaseLand = new_case.Landsize;
    
    %newCaseBuildFuzzPrice = fuzz_price_build(char(new_case.CouncilArea));
    newCaseBuildFuzzPrice = fuzz_price_build_new(new_case);
    %newCaseLandFuzzPrice = fuzz_price_land(char(new_case.CouncilArea));
    newCaseLandFuzzPrice = fuzz_price_land_new(new_case);
    
%     %PREÇOS OFICIAIS DA TABELA
%     councilBuildPrice = 0;
%     councilLandPrice = 0;
%     
%     for i=1:size(council_prices_table,1)
%         
%         councilName = council_prices_table{i,'CouncilName'};
%         
%         if(strcmp(char(new_case.CouncilArea),char(councilName))) == 1
%             councilBuildPrice = council_prices_table{i,'buildingAreaPrice'};
%             councilLandPrice = council_prices_table{i,'landsizePrice'};
%         end
%     end

    estimativa = (newCaseBuild * newCaseBuildFuzzPrice) + (newCaseLand * newCaseLandFuzzPrice);
    
    bestCasePrice = retrieved_cases{best_case_index, 'Price'};

    estimativa_final = round((0.4 * estimativa) + (0.6 * bestCasePrice));
    
end