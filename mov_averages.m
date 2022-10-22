function [SMA7, SMA11, SMA23, SMA200] = mov_averages(Data_Num, Row_Dt_Num)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% Srednie kroczace oraz wskazniki (ewentualnie) %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% Srednia kroczaca SMA7 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Col_Price = 4; % Kolumna danych z 1-Open, 2-High, 3-Low, 4-Close
% Wyliczenie/Przypisanie pierwszej pozycji
SMA7(1, 1) = Data_Num(1, Col_Price);  
SMA_Period_1 = 7;
for j = 2:Row_Dt_Num
    if j <= SMA_Period_1
        k = j;
    else
        k = SMA_Period_1;
    end
    SMA7(j, 1) = 0; 
    for i = (j-k+1):j
        SMA7(j, 1) = SMA7(j, 1) + Data_Num(i, Col_Price);              
    end
    SMA7(j, 1) = SMA7(j, 1) / k;    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% Srednia wykladnicza SMA11 %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Wyliczenie/Przypisanie pierwszej pozycji
SMA11(1, 1) = Data_Num(1, Col_Price); 
SMA_Period_2 = 11;
for j = 2:Row_Dt_Num
    if j <= SMA_Period_2
        k = j;
    else
        k = SMA_Period_2;
    end
    SMA11(j, 1) = 0; 
    for i = (j-k+1):j
        SMA11(j, 1) = SMA11(j, 1) + Data_Num(i, Col_Price);              
    end
    SMA11(j, 1) = SMA11(j, 1) / k;    
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% Srednia wykladnicza SMA23 %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Wyliczenie/Przypisanie pierwszej pozycji
SMA23(1, 1) = Data_Num(1, Col_Price); 
SMA_Period_3 = 23;
for j = 2:Row_Dt_Num
    if j <= SMA_Period_3
        k = j;
    else
        k = SMA_Period_3;
    end
    SMA23(j, 1) = 0; 
    for i = (j-k+1):j
        SMA23(j, 1) = SMA23(j, 1) + Data_Num(i, Col_Price);              
    end
    SMA23(j, 1) = SMA23(j, 1) / k;    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%% Srednia wykladnicza SMA200 %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Wyliczenie/Przypisanie pierwszej pozycji
SMA200(1, 1) = Data_Num(1, Col_Price);  
SMA_Period_4 = 200;
for j = 2:Row_Dt_Num
    if j <= SMA_Period_4
        k = j;
    else
        k = SMA_Period_4;
    end
    SMA200(j, 1) = 0; 
    for i = (j-k+1):j
        SMA200(j, 1) = SMA200(j, 1) + Data_Num(i, Col_Price);              
    end
    SMA200(j, 1) = SMA200(j, 1) / k;    
end
end
