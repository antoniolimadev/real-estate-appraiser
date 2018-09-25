function [out1] = fuzz_price_land_new(new_case)
% clc
%     new_case1.CouncilArea = 'Banyule City Council';
%     new_case1.Latitude = -37.73880;
%     new_case1.Longitude = 145.05810;
%     
%     new_case2.CouncilArea = 'Port Phillip City Council';
%     new_case2.Latitude = -37.88042;
%     new_case2.Longitude = 144.98180;
%     
%     new_case3.CouncilArea = 'Whittlesea City Council';
%     new_case3.Latitude = -37.65898;
%     new_case3.Longitude = 145.08245;
%     
%     new_case4.CouncilArea = 'Melbourne City Council';
%     new_case4.Latitude = -37.83660;
%     new_case4.Longitude = 144.98270;
%     
%     new_case5.CouncilArea = 'Stonnington City Council';
%     new_case5.Latitude = -37.84160;
%     new_case5.Longitude = 144.96306;

%     new_case6.CouncilArea = 'Melbourne City Council';
%     new_case6.Latitude = -37.81333;
%     new_case6.Longitude = 144.98233;

    
    
    new_caseTablePertencas = calc_pertenca_fullrow(new_case);
    input = table2array(new_caseTablePertencas(1,:));
    
    %new_caseTablePertencas = new_caseTablePertencas(:,1:4);
    %input = [1 0.591604322527016 0.826122194513716 0.622402327514547];
    
    %read table with council prices
    council_prices_table = readtable('CouncilAreaPrices.txt', 'Delimiter', ',', 'Format', '%f%C%f%f');
    %council_prices_table = sortrows(council_prices_table, 'buildingAreaPrice', 'descend');
    council_prices_table = sortrows(council_prices_table, 'CouncilName', 'ascend');
    fis_price = newfis('fis_price_build');
    
    % ADICIONAR VARIAVEIS LINGUISTICAS
    % --------------------------------
    % addvar(a,varType,varName,varBounds)
    % a: nome da estrutura FIS
    % varType: tipo de variável (pode ser ‘input’ ou ‘output’)
    % varName: nome da variável (por exemplo, ‘comida’)
    % varBounds: limites do domínio da variável (por exemplo, [0 5])
    
    %INPUT - graus de pertenca da nova casa
    
    for i = 1:size(new_caseTablePertencas,2)
        
        councilName = strrep(char(council_prices_table{i,2}), ' ', '');
        fis_price = addvar(fis_price,'input',strcat('council', councilName),[0 1]);
    end
    
    %output1 - price
    %TL(price) = BARATO, MEDIO-BARATO, MEDIO, MEDIO-CARO, CARO
    fis_price = addvar(fis_price,'output','landsizePrice',[58 5051]);
   
    % ADICIONAR FUNCOES DE PERTENCA PARA CADA TERMO LINGUISTICO
    % ---------------------------------------------------------
    % addmf(a,varType,varIndex,mfName,mfType,mfParams)
    % a: nome da estrutura FIS
    % varType: tipo de variável (pode ser ‘input’ ou ‘output’)
    % varIndex: índice da variável de input ou de output (1, 2, ..., conforme a ordem de criação da variável)
    % mfName: nome da função de pertença para as variáveis linguísticas (por exemplo, ‘boa’, ‘fraca’, ‘excelente’)
    % mfType: tipo de função de pertença (‘gaussmf’, ‘trapmf’, ‘trimf’, etc)
    % mfParams: parâmetros para a função de pertença
    %   gaussmf: [standard_deviation mean_value]
    %   trapmf: [x1 x2 x3 x4] x coords of the trapezoid
    %   trimf: [x1 x2 x3] x coords of the triangle

    % INPUT
    for i = 1:size(new_caseTablePertencas,2)
        
        councilName = council_prices_table{i,'CouncilName'};
        
        fis_price=addmf(fis_price,'input',i,char(councilName),'gaussmf',[0.01 1]);

    end
    %plotmf(fis_price,'input',1);
    
    %   OUTPUT
    %   -------------------
    %   intervalo completo [58.4 - 5050.3], ~1022 por intervalo (250)
    %
    %   TERMOS LINGUISTICOS
    %                                   media
    %   BARATO          [58 - 1080]     569
    %   MEDIO-BARATO    [1080 - 2102]   1591
    %   MEDIO           [2102 - 3124]   2613
    %   MEDIO-CARO      [3124 - 4146]   3635
    %   CARO            [4146 - 5151]   4648
    fis_price=addmf(fis_price,'output',1,'barato','trapmf',[58 58 (58+1080)/2 1330]);
    fis_price=addmf(fis_price,'output',1,'medio-barato','trimf',[850 (1080+2102)/2 2252]);
    fis_price=addmf(fis_price,'output',1,'medio','trimf',[1852 (2102+3124)/2 3374]);
    fis_price=addmf(fis_price,'output',1,'medio-caro','trimf',[2874 (3124+4146)/2 4296]);
    fis_price=addmf(fis_price,'output',1,'caro','trapmf',[3906 (4146+5151)/2 5151 5151]);
    %plotmf(fis_price,'output',1);
    % ADICIONAR REGRAS
    % ----------------
    %
    %   rule = [ m1, m2, mi..., n1, n2, ni..., w, o]
    %   mi - i variaveis de entrada
    %   ni - i variaveis de saida
    %   w - peso da regra
    %   o - operador (1 (AND); 2 (OR); -1 (NOT); 0 (Nenhum))
    %
    
    ruleList = [];
    
    nInputs = size(new_caseTablePertencas,2); %29
    
    for i=1:size(new_caseTablePertencas,2)
        
        rule = zeros(1,nInputs + 3);
        rule(1,i) = 1; %set the current input to 1
        rule(1,nInputs + 2) = 1; %set weight to 1
        rule(1,nInputs + 3) = 1; %set operator to AND (irrelevant)
        
        landsizePrice = council_prices_table{i,'landsizePrice'};
        output = 0;
        
        if (landsizePrice >= 58) && (landsizePrice <= 1080) %BARATO
            output = 1;
            
        elseif (landsizePrice >= 1080) && (landsizePrice <= 2102) %MEDIO-BARATO
            output = 2;
            
        elseif (landsizePrice >= 2102) && (landsizePrice <= 3124) %MEDIO
            output = 3;
            
        elseif (landsizePrice >= 3124) && (landsizePrice <= 4146) %MEDIO-CARO
            output = 4;
            
        elseif (landsizePrice >= 4146) && (landsizePrice <= 5151) %CARO
            output = 5;
        end

        rule(1,nInputs + 1) = output; %set output
        ruleList = [ruleList; rule];
        
    end
    
    fis_price = addrule(fis_price,ruleList);
    showrule(fis_price);

    out1 = evalfis(input, fis_price);

   %plotmf(fis_price,'input',1);
   %plotmf(fis_price,'output',1);
    
end

