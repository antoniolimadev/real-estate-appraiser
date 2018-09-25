function [] = create_council_table()
%cria uma tabela em ficheiro com as localizacoes dos concelhos
%ordenadas pelo nome

    councilNames = {
        'Port Phillip City Council',
        'Stonnington City Council',
        'Boroondara City Council',
        'Yarra City Council',
        'Melbourne City Council',
        'Monash City Council',
        'Bayside City Council',
        'Glen Eira City Council',
        'Darebin City Council',
        'Moreland City Council',
        'Whitehorse City Council',
        'Moonee Valley City Council',
        'Maribyrnong City Council',
        'Hobsons Bay City Council',
        'Manningham City Council',
        'Banyule City Council',
        'Kingston City Council',
        'Maroondah City Council',
        'Greater Dandenong City Council',
        'Knox City Council',
        'Brimbank City Council',
        'Casey City Council',
        'Frankston City Council', 
        'Nillumbik Shire Council',
        'Hume City Council',
        'Macedon Ranges Shire Council',
        'Whittlesea City Council',
        'Wyndham City Council',
        'Melton City Council'
       };
    
    councilNameArray = cellstr(councilNames);
    T = table();
    
    sz = size(councilNameArray);
    councilNumber = sz(:,1);

    for i = 1:councilNumber
        
        name = char(councilNameArray(i,1));
        [x, y] = get_lat_lon_from_google(name);
        % cast para double para o matlab nao arredondar as casas decimais
        latitude = double(x);
        longitude = double(y);

        T1 = table(councilNameArray(i,1), round(latitude,5), round(longitude,5),'VariableNames',{'CouncilName','Latitude', 'Longitude'});
        T = [T;T1];
    end
    
    sorted = sortrows(T, 'CouncilName');
    
    disp('Writing to file...');
    writetable(sorted,'CouncilLocations.txt');
    disp('Done.');

end




