function figCreation(tr, Targets_Test, Targets_Teach, Inputs_Teach, ...
        Inputs_Test, Outputs_Teach, Outputs_Test, Errors_Test, Date2Num)

% close all
% clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% figura 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig1 = figure;
startDateTeach = Inputs_Teach(1, 1);
startDateTest = Inputs_Test(1, 1);
endDateTeach = Inputs_Teach(1, end);
endDateTest = Inputs_Test(1, end);
xDataTeach = linspace(startDateTeach, endDateTeach, 10);
xDataTest = linspace(startDateTest, endDateTest, 10);

% Wykres dla danych ucz¹cych - zestawienie danych uczacych Targets_Teach 
% z odpowiedzia sieci Outputs_Teach

s(1) = subplot(2,1,1);
plot(Inputs_Teach(1, :), Targets_Teach(1, :), Inputs_Teach(1, :), ...
    Outputs_Teach(1, :), '--');
title('Wykres dla danych ucz¹cych');
legend('Oryginalne dane Y', 'Przewidywane wartoœci Y');
axis tight
grid on
s(2) = subplot(2,1,2);
plot(Inputs_Test(1, :), Targets_Test(1, :), Inputs_Test(1, :), ...
    Outputs_Test(:, 1), 'r--');
title('Wykres dla danych testuj¹cych');
legend('Oryginalne dane Y', 'Przewidywane wartoœci Y');
axis tight
grid on
set(s(1), 'XTick', xDataTeach)
set(s(2), 'XTick', xDataTest)
for i = 1:2
    datetick(s(i),'x','yyyy','keepticks')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% figura 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Zale¿noœæ liczby epok uczenia i b³êdu

fig2 = figure;
plotperform(tr);
title('Zale¿noœæ liczby epok uczenia i b³êdu');
xlabel('Liczby epok uczenia');
ylabel('B³¹d œredniokwadratowy MSE')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% figura 3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig3 = figure;
k_sqrt  = sqrt(length(Errors_Test));
hist(Errors_Test, k_sqrt);
title('Rozk³ad b³êdów na zbiorze testowym');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% figura 4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig4 = figure;
plottrainstate(tr);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% figura 5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig5 = figure;
plotregression(Targets_Teach, Outputs_Teach);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% figura 6 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

howMany = 35; % wyswietla xxx ostatnich rekordow
% Wyswietlanie (tylko!) dla dowolnego pliku
DataNumber = Date2Num(end - howMany:end, 1);
% o dowolnym rozm. Wyswietla ostatnie
Prognosis = Outputs_Test(end - howMany:end, 1);
% np. 25 rekordow (25 dni wstecz od daty koncowej w pliku)
RealNumber = Targets_Test(1, end - howMany:end);      

fig6 = figure;
hh = plot(DataNumber, Prognosis, DataNumber, RealNumber);

axis tight
grid on

datetick('x','dd-mm-yyyy', 'keeplimits', 'keepticks')
set(hh,'LineWidth', 2, {'LineStyle'}, {'-';'-'})
set(hh,{'Marker'}, {'square'; 'square'})
set(hh,{'Color'},{'b'; 'g'})
xlabel('Data')
ylabel('Cena')
title('Rzeczywiste i prognozowane wartosci pary walutowej EUR/USD');
legend('Przewidywane wartoœci Y', 'Rzeczywiste dane Y');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% figura 7 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Obliczenia z calosci danych testujacych

Outputs_TestAPX = zeros(length(Outputs_Test), 1);
Targets_TestAPX = zeros(1, length(Targets_Test));

DataNumberAPX = Date2Num(((end - length(Outputs_Test)):end-1), 1);
DataNumberAPX1 = zeros(length(DataNumberAPX), 1);

for k = 1:length(DataNumberAPX) 
    % (11280 - 1129(10151)) : 11280(Razem-1129)
    DataNumberAPX1(k, 1) = DataNumberAPX(k, 1);
end

for i = 1:length(Outputs_Test)
    Targets_TestAPX(1, i) = Targets_Test(1, i);
end

for j = 1:length(Outputs_Test)
    Outputs_TestAPX(j, 1) = Outputs_Test(j, 1);
end

% Obliczenia z calosci danych testujacych
DataAmount = length(Outputs_Test);  % to jest dokladnie 1129
X = linspace(-10, 10, DataAmount);
OT = Outputs_Test';                 %(1:DataAmount, 1)';
TT = Targets_Test;                  %(1, 1:DataAmount);

% Aproksymacja wynikow prognozy w celu ustalenia sygnalow BUY i SELL
pFit1 = polyfit(X, OT, 25);
fVal1 = polyval(pFit1, X);
fVal2 = -fVal1;

% Obliczenie szczytow i dolkow. BTW. F-kcja findpeaks znajduje tylko
% maksima funkcji. Odwrocenie (pomnozenie przez (-1)) i ponowne
% zastosowanie w/w funkcji znajduje rowniez minima.

[pks1,locs1] = findpeaks(fVal1);
[pks2,locs2] = findpeaks(fVal2);
pks2 = -pks2;

fig7 = figure; 
hh = plot(DataNumberAPX1, Outputs_TestAPX, DataNumberAPX1, ...
    Targets_TestAPX, DataNumberAPX1, fVal1);
axis tight
grid on
datetick('x','dd-mm-yyyy', 'keeplimits', 'keepticks')
set(hh,'LineWidth', 1, {'LineStyle'}, {'-';'-';'-'})
set(hh,{'Marker'}, {'.'; '.'; '.'})
set(hh,{'Color'},{'b'; 'g'; 'r'})
xlabel('Data')
ylabel('Cena')
title('Rzeczywiste i prognozowane wartosci pary walutowej EUR/USD');
legend('Przewidywane wartoœci Y', 'Rzeczywiste dane Y', 'Dane aproksymowane');

hold on

for k = 1:length(pks1)
text((DataNumberAPX1(locs1(k))),(pks1(k)), ...
      '\color{red} \fontsize{30} \downarrow\fontsize{24}Sell')
end

for j = 1:length(pks2)
 text((DataNumberAPX1(locs2(j))),(pks2(j)), ...
      '\color{blue} \fontsize{30} \uparrow\fontsize{24}Buy')
end
 
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Ustawienie parametrow wyswietlania okien na pulpicie %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figDisplay(fig1, fig2, fig3, fig4, fig5, fig6, fig7)
% figDisplay(fig7)