function[retrieved_indexes, similarities] = retrieve(case_library, new_case, similarity_threshold)
   
    weighting_factors = [1 2 2 0.5 0.5 1 1 2 2];
    
    Type_sim = get_Type_similarities();
    CouncilArea_sim = get_CouncilArea_similarities();
    
    Rooms_value_norm = get_Normalized(new_case.Rooms, 0, 7);
    %Price_value_norm = get_Normalized(new_case.Price, 170000, 9000000);
    Bedroom2_value_norm = get_Normalized(new_case.Bedroom2, 0, 7);
    Bathroom_value_norm = get_Normalized(new_case.Bathroom, 1, 5);
    Car_value_norm = get_Normalized(new_case.Car, 0, 9);
    Landsize_value_norm = get_Normalized(new_case.Landsize, 0, 42800);
    BuildingArea_value_norm = get_Normalized(new_case.BuildingArea, 0, 934);
    YearBuilt_value_norm = get_Normalized(new_case.YearBuilt, 1863, 2019);
    
    retrieved_indexes = [];
    similarities = [];

    for i=1:size(case_library,1)

        distances = zeros(1,size(weighting_factors,2));
        
        %Rooms
        distances(1,1) = calculate_normalized_distance(Rooms_value_norm, get_Normalized(case_library{i,'Rooms'}, 0, 7));
        
        %Type
        distances(1,2) = calculate_local_distance(Type_sim, case_library{i,'Type'}, new_case.Type);

        %Price
        %distances(1,3) = calculate_normalized_distance(Price_value_norm, get_Normalized(case_library{i,'Price'}, 170000, 9000000));
        
        %Bedroom2
        distances(1,3) = calculate_normalized_distance(Bedroom2_value_norm, get_Normalized(case_library{i,'Bedroom2'}, 0, 7));
        
        %Bathroom
        distances(1,4) = calculate_normalized_distance(Bathroom_value_norm, get_Normalized(case_library{i,'Bathroom'}, 1, 5));
        
        %Car
        distances(1,5) = calculate_normalized_distance(Car_value_norm, get_Normalized(case_library{i,'Car'}, 0, 9));
        
        %Landsize
        distances(1,6) = calculate_normalized_distance(Landsize_value_norm, get_Normalized(case_library{i,'Landsize'}, 0, 42800));
       
        %BuildingArea
        distances(1,7) = calculate_normalized_distance(BuildingArea_value_norm, get_Normalized(case_library{i,'BuildingArea'}, 0, 934));
        
        %YearBuilt
        distances(1,8) = calculate_normalized_distance(YearBuilt_value_norm, get_Normalized(case_library{i,'YearBuilt'}, 1863, 2019));
        
        %CouncilArea
        if strcmp(char(case_library{i,'CouncilArea'}), new_case.CouncilArea) == 1
            distances(1,9) = 1;
        else
            distances(1,9) = 0.5;
        end
        
        %DistanciaCentro
        %distances(1,11) =  calculate_normalized_distance(case_library{i,'grauDePertenca'}, new_case.DistanciaCentro);

        
        final_similarity = round((distances * weighting_factors')/sum(weighting_factors),5);
        
        if final_similarity >= similarity_threshold
            retrieved_indexes = [retrieved_indexes i];
            similarities = [similarities final_similarity];
            fprintf('Case %d out of %d has a similarity of %.2f%%...\n', i, size(case_library,1), final_similarity*100);
        end

    end
    
    
end


%---------------------------------------------------
function [norm] = get_Normalized(value, min, max)

    norm =(value-min)/(max-min);

end

function [Type_sim] = get_Type_similarities()
    
    % h - house; 
    % u - unit, duplex; 
    % t - townhouse;
    Type_sim.categories = categorical({'h', 't', 'u'});

    Type_sim.similarities = [
        % h   t   u 
          1.0 0.7 0.4 % h
          0.7 1.0 0.3 % t
          0.2 0.3 1.0 % u
    ];
end

function [CouncilArea_sim] = get_CouncilArea_similarities()
    
    CouncilArea_sim.categories = categorical({'Port Phillip City Council', 'Stonnington City Council', 'Boroondara City Council',...
        'Yarra City Council','Melbourne City Council','Monash City Council','Bayside City Council','Glen Eira City Council',...
        'Darebin City Council','Moreland City Council','Whitehorse City Council','Moonee Valley City Council',...
        'Maribyrnong City Council','Hobsons Bay City Council','Manningham City Council','Banyule City Council','Kingston City Council',...
        'Maroondah City Council','Greater Dandenong City Council','Knox City Council','Brimbank City Council',...
        'Casey City Council','Frankston City Council', 'Nillumbik Shire Council','Hume City Council',...
        'Macedon Ranges Shire Council','Whittlesea City Council','Wyndham City Council','Melton City Council'});

    CouncilArea_sim.similarities = [
        % h   t   u 
          1.0 0.7 0.4 % h
          0.7 1.0 0.3 % t
          0.2 0.3 1.0 % u
    ];
end

function [res] = calculate_local_distance(sim, val1, val2)

    i1 = find(sim.categories == val1);
    i2 = find(sim.categories == val2);
    res = sim.similarities(i1,i2);
end

function [res] = calculate_normalized_distance(val1, val2)

    res = 1 - abs(val1 - val2);
end







