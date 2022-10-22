function [imported_data, Data_Text, Data_Num, w1, k1, w2, k2] = data_import(file_import)

% Import danych z formatu CSV (MT4 RT Loader from MT4 - EOD data)
% Dane z plikow CSV sa pobierane z katalogu roboczego np. 
% C:\MATLAB\R2012a\bin\work.

% Dane uzyte do testow i trenowania ponizszej sieci zostaly 
% pobrane z serwisu STOOQ.PL. 

% Dane historyczne zawieraja dane od poczatku notowan pary EUR/USD. 
% Do testow mozna takze uzyc danych wyeksportowanych z platformy brokerskiej 
% np. MT4 za pomoca narzedzia MT4 RT Loader w formacie jak ponizej:

% Date,Open,High,Low,Close,Volume,OpenInt
% 2005-12-08,1.17130,1.18500,1.17010,1.18110,13288,0.0
% 2005-12-09,1.18100,1.18370,1.17640,1.18120,6400,0.0
% 2005-12-11,1.17870,1.17870,1.17870,1.17870,1,0.0
% 2005-12-12,1.17870,1.19760,1.17870,1.19550,17709,0.0

imported_data   = importdata(file_import);
[w1, k1]        = size(imported_data.data);
[w2,k2]         = size(imported_data.textdata);
Data_Num        = imported_data.data(1:w1,1:4);
Data_Text       = imported_data.textdata(2:w2, 1);