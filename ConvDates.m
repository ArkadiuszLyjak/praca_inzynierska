function [YearNum, Date2Num, WeekDayNum, MonthNum, DayOfMonth, ...
    OpenPrice, HighPrice, LowPrice, ClosePrice, Row_Dt_Num, Col_Dt_Num, ...
    SMA7, SMA11, SMA23, SMA200, DiffCloseOpen, ...
    Targets] = ConvDates(w1, w2, Data_Text, Data_Num)

% Konwersja daty na liczbe - [732654;732655;732657;] ...
formatIn = 'yyyy-mm-dd';
[Date2Num, YearNum] = ConvDate2Num(formatIn, w2, Data_Text);

% Wyliczenie numeru dnia tygodnia - 1, 2, 3, 4, 5, 6, 7 ...
Size_Dt_Num = size(Date2Num);  
WeekDayNum = zeros(length(Date2Num), 1);
for n0 = 1:Size_Dt_Num
WeekDayNum(n0, 1) = weekday(Date2Num(n0, 1));
end

% Wyliczenie numeru miesiaca. Styczen = 1, Luty = 2 itd.
MonthNum = zeros(length(Date2Num), 1);
for n1 = 1:Size_Dt_Num
MonthNum(n1, 1) = month(Date2Num(n1, 1));
end

% Wyliczenie dnia miesiaca. 1, 2, 3 ... 30, 31 ...
DayOfMonth = zeros(length(Date2Num), 1);
for n2 = 1:Size_Dt_Num
DayOfMonth(n2, 1) = day(Date2Num(n2, 1));
end

OpenPrice  = Data_Num(:, 1);
HighPrice  = Data_Num(:, 2);
LowPrice   = Data_Num(:, 3);
ClosePrice = Data_Num(:, 4);

% dane do obliczen pobierane z Data_Num
[Row_Dt_Num, Col_Dt_Num] = size(Data_Num); 
[SMA7, SMA11, SMA23, SMA200] = mov_averages(Data_Num, Row_Dt_Num);

% Roznica miedzy cena otwarcia a cena zamkniecia (Close - Open)
DiffCloseOpen = zeros(length(Data_Num), 1);
for j = 1:w1
DiffCloseOpen(j, 1) = Data_Num(j, 4) - Data_Num(j, 1);
end

% Obliczenie targetu. Target jest cena zamkniecia z dnia "nastepnego"
Targets = zeros(length(Data_Num), 1);
for d = 1:Row_Dt_Num % 11280
    if d < Row_Dt_Num
        Targets(d, 1) = Data_Num(d+1, 4);
    else
        Targets(d, 1) = Data_Num(d, 4);  
    end
end