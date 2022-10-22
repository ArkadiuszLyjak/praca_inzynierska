clc;
close all;
clear;

% clearvars all -except imported_data Data_Text Data_Num w1 k1 w2 k2 ...
%                 YearNum Date2Num WeekDayNum MonthNum DayOfMonth ...
%                 OpenPrice HighPrice LowPrice ClosePrice Row_Dt_Num ...
%                 Col_Dt_Num SMA7 SMA11 SMA23 SMA200 DiffCloseOpen Targets

% load nn_2_variables.mat;

format compact

origFormat = get(0, 'format');
format('short');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Import i konwersja danych wejsciowych %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

file_import = 'EURUSD_STOOQ.csv';
% file_import = 'USD_I_STOOQ.csv';
% file_import = 'CHFPLN_STOOQ.csv';
% file_import = 'WIG20_STOOQ.csv';
% file_import = 'acp_d.csv';

[imported_data, Data_Text, Data_Num, w1, k1, w2 ,k2] = data_import(file_import);

% % Funkcja przygotowujaca dane wejsciowe do sieci.
[YearNum, Date2Num, WeekDayNum, MonthNum, DayOfMonth, OpenPrice, ...
    HighPrice, LowPrice, ClosePrice, Row_Dt_Num, Col_Dt_Num, SMA7, ...
    SMA11, SMA23, SMA200, DiffCloseOpen, Targets] = ConvDates(w1, w2, ...
    Data_Text, Data_Num);

%  Zlozenie danych liczbowych w macierz danych wejsciowych Inputs w formacie:
%  (1)  Data przekonwertowana na liczbe
%  (2)  Dzien tygodnia, 1 - niedziale, 2 - pon., 3 - sroda, ...
%  (3)  Dzien miesiaca, 1, 2, 3, 4, 5 ...
%  (4)  Miesiac, 1 - styczen, 2 - luty, ...
%  (5)  OpenPrice    - cena otwarcia sesji
%  (6)  HighPrice    - najwyzsza cena sesji
%  (7)  LowPrice     - najnizsza cena sesji
%  (8)  ClosePrice   - cena zamkniecia sesji
%  (9)  Roznica miedzy cena otwarcia a cena zamkniecia (Close - Open)
%  (10) SMA7
%  (11) SMA11
%  (12) SMA23
%  (13) SMA200

% (1) 7.199e+05    7.199e+05    7.199e+05    7.199e+05    7.199e+05
% (2)              2            3            4            5            6
% (3)              4            5            6            7            8
% (4)              1            1            1            1            1
% (5)         0.5353        0.535       0.5352       0.5353       0.5354
% (6)         0.5353        0.535       0.5352       0.5353       0.5354
% (7)         0.5353        0.535       0.5352       0.5353       0.5354
% (8)         0.5353        0.535       0.5352       0.5353       0.5354
% (9)              0            0            0            0            0
% (10)        0.5353      0.53515      0.53517       0.5352      0.53524
% (11)        0.5353      0.53515      0.53517       0.5352      0.53524
% (12)        0.5353      0.53515      0.53517       0.5352      0.53524
% (13)        0.5353      0.53515      0.53517       0.5352      0.53524
 
% Macierz danych wejsciowych
Inputs = [Date2Num WeekDayNum DayOfMonth MonthNum OpenPrice HighPrice ...
            LowPrice DiffCloseOpen SMA11 SMA200];

% Transpozycja danych wejsciowych oraz danych uczacych
Inputs    = Inputs';
Targets   = Targets'; 

% Podzial na dane: uczace i testujace - dane uczace X,  testujace Y.
% Div_Scale = 1 / 10 oznacza podzial 90% / 10%, uczace / testujace. 
% Div_Scale = 2 / 10 oznacza podzial 80% / 20%, uczace / testujace. 
% Div_Scale = 3 / 10 oznacza podzial 70% / 30%, uczace / testujace. 
% Div_Scale = 4 / 10 oznacza podzial 60% / 40%, uczace / testujace. 
% Div_Scale = 5 / 10 oznacza podzial 50% / 50%, uczace / testujace. 

[Row_Inputs_Size, Col_Inputs_Size] = size(Inputs);
relative_num = 1;
Div_Scale = relative_num / 10;

Col_Resizer     = (Col_Inputs_Size - Col_Inputs_Size * (Div_Scale));
Inputs_Teach    = Inputs(:, 1:Col_Resizer);
Targets_Teach   = Targets(1, 1:Col_Resizer);

[Row_Data_Teach, Col_Data_Teach] = size(Inputs_Teach);
Inputs_Test     = Inputs(:, Col_Resizer:end);
Targets_Test    = Targets(1, Col_Resizer:end);

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%% Utworzenie i trenowanie sieci neuronowej %%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hiddenLayerSize = 13;           % Liczba neuronow ukrytych
trainFcn        = 'trainlm';    % funkcja trenujaca
net             = feedforwardnet(hiddenLayerSize, trainFcn);
% % net             = elmannet(1:2,10);
% % net             = cascadeforwardnet(hiddenLayerSize,trainFcn);

% % % W tym, w danych uczacych nastepuje kolejny wewnetrzny podzial: 
net.divideParam.trainRatio  = 0.7;  
net.divideParam.valRatio    = 0.15; 
net.divideParam.testRatio   = 0.15; 

% % % zmiana funkcji aktywacji w warstwie ukrytej i wyjsciowej
net.layers{1}.transferFcn = 'tansig';   % <-  logsig,  tansig, purelin
net.layers{2}.transferFcn = 'purelin';  % <-  logsig,  tansig, purelin

net = init(net);

[netw1, tr]         = train(net, Inputs_Teach, Targets_Teach);
Outputs_Teach       = netw1(Inputs_Teach);
Differ_Teach        = Outputs_Teach-Targets_Teach;

Errors_Teach        = gsubtract(Targets_Teach, Outputs_Teach);
Performance_Teach   = perform(netw1, Targets_Teach, Outputs_Teach);

% view(net);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Testowanie wytrenowanej sieci na nowych, nieznanych dotad danych %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Outputs_Test        = netw1(Inputs_Test);
Differ_Test         = Outputs_Test-Targets_Test;
Errors_Test         = gsubtract(Targets_Test, Outputs_Test);
Performance_Test    = perform(netw1, Targets_Test, Outputs_Test);
Outputs_Test        = Outputs_Test';

figCreation(tr, Targets_Test, Targets_Teach, Inputs_Teach, Inputs_Test, ...
            Outputs_Teach, Outputs_Test, Errors_Test, Date2Num);

% disp2screen(Differ_Teach, Differ_Test, Inputs_Test, Targets_Test, Outputs_Test);

disp2file(Differ_Teach, Differ_Test, Div_Scale, hiddenLayerSize, trainFcn, ...
            net, tr, Inputs_Teach, Inputs_Test);

set(0,'format', origFormat);
% save ('NN_2_Variables');

disp('####### KONIEC OBLICZEÑ #######')