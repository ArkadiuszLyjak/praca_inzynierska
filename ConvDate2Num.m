function [Date2Num, YearNum] = ConvDate2Num(formatIn, w2, Data_Text)

% Konwersja daty na liczbe - [732654;732655;732657;] ...

YearNum     = zeros(length(Data_Text), 1);
Date2Num    = zeros(length(Data_Text), 1);

for j = 1:w2-1
    Date2Num(j, 1)  = datenum(Data_Text(j,1), formatIn);
    YearNum(j, 1)   = year(Data_Text(j,1), formatIn);
end