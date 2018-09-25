function [out1] = fuzz_price_build_new(new_case)
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
%     new_case5.Longitude = 145.03130;
    
    
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
        fis_price = addvar(fis_price,'input',strcat('pertenca', councilName),[0 1]);
    end
    
    %output1 - price
    %TL(price) = BARATO, MEDIO-BARATO, MEDIO, MEDIO-CARO, CARO
    fis_price = addvar(fis_price,'output','buildingAreaPrice',[2648 10946]);
   
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
        councilPrice = council_prices_table{i,'buildingAreaPrice'};
        
        fis_price=addmf(fis_price,'input',i,char(councilName),'gaussmf',[0.01 1]);

    end
    %plotmf(fis_price,'input',1)
    
    %   OUTPUT
    %   -------------------
    %   intervalo completo [2648.7 - 10944.2], ~1659 por intervalo (400)
    %
    %   TERMOS LINGUISTICOS
    %                                 media
    %   BARATO          [2648 - 4300] 3474
    %   MEDIO-BARATO    [4300 - 5960] 5130
    %   MEDIO           [5960 - 7620] 6790
    %   MEDIO-CARO      [7620 - 9280] 8450
    %   CARO            [9280 - 10945] 10113
    fis_price=addmf(fis_price,'output',1,'barato','trapmf',[2648 2648 (2648+4300)/2 4700]);
    fis_price=addmf(fis_price,'output',1,'medio-barato','trimf',[4000 (4300+5960)/2 6300]);
    fis_price=addmf(fis_price,'output',1,'medio','trimf',[5560 (5960+7620)/2 8020]);
    fis_price=addmf(fis_price,'output',1,'medio-caro','trimf',[7220 (7620+9280)/2 9680]);
    fis_price=addmf(fis_price,'output',1,'caro','trapmf',[8880 (9280+10946)/2 10946 10946]);
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
        
        buildingAreaPrice = council_prices_table{i,'buildingAreaPrice'};
        output = 0;
        
        if (buildingAreaPrice >= 2648) && (buildingAreaPrice <= 4300) %BARATO
            output = 1;
            
        elseif (buildingAreaPrice >= 4300) && (buildingAreaPrice <= 5960) %MEDIO-BARATO
            output = 2;
            
        elseif (buildingAreaPrice >= 5960) && (buildingAreaPrice <= 7620) %MEDIO
            output = 3;
            
        elseif (buildingAreaPrice >= 7620) && (buildingAreaPrice <= 9280) %MEDIO-CARO
            output = 4;
            
        elseif (buildingAreaPrice >= 9280) && (buildingAreaPrice <= 10945) %CARO
            output = 5;
        end

        rule(1,nInputs + 1) = output; %set output
        ruleList = [ruleList; rule];
        
    end
    
    fis_price = addrule(fis_price,ruleList);
    showrule(fis_price)

    out1 = evalfis(input, fis_price);

   %plotmf(fis_price,'input',1);
   %plotmf(fis_price,'output',1);
    
end

