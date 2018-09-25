function [best_similarity, best_index] = reuse(new_case, retrieved_cases)
%percorre os retrieved_cases e verifica se é suficientemente parecido com
%base no grau de pertença

    similarity_threshold = 0.1;
    
    new_caseTablePertencas = calc_pertenca_fullrow(new_case);
    
    retrieved_case_pertencas = [];
    
    for i = 1:size(retrieved_cases,1)
        
       retrieved_case.Latitude = retrieved_cases{i,'Lattitude'};
       retrieved_case.Longitude = retrieved_cases{i,'Longtitude'};
       
       retrieved_caseFullPertenca = calc_pertenca_fullrow(retrieved_case);
       
       retrieved_case_pertencas = [retrieved_case_pertencas; retrieved_caseFullPertenca];
    end
    
    similarity_count = [];
    
    for i = 1:size(retrieved_case_pertencas,1)
        
        current_count = 0;
        
        for j = 1:size(retrieved_case_pertencas,2)
            
            if abs(retrieved_case_pertencas{i,j} - new_caseTablePertencas{1,j}) <= similarity_threshold
                current_count = current_count + 1;
            end
        end
        
        similarity_count = [similarity_count current_count/29];
    end
    
    [best_similarity best_index] = max(similarity_count)
    
    %disp();
    
    
%     best_case = 0;
%     
%     for i = 1:size(retrieved_cases,1)
% 
%         if abs(retrieved_cases{i,'grauDePertenca'} - grauPertencaNewCase) < similarity_threshold
%             best_case = i;
%             break;
%         end
%     end

end