function[cell_array] = custom_table2cell_array(table)
%receives a table and creates a cell array with its data that can be
%displayed in a uitable.

    cell_array_temp = table2cell(table);

    for i = 1:size(cell_array_temp,1)
    
        for j = 1:size(cell_array_temp,2)
            %disp(cell_array_temp{i,j});
            if isnumeric(cell_array_temp{i,j}) == 0
                cell_array(i,j) = {char(cell_array_temp{i,j})};
            else
                cell_array(i,j) = {cell_array_temp{i,j}};
            end
        
        end
        
    end

end