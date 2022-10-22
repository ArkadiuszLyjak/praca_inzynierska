function disp2file(Differ_Teach, Differ_Test, Div_Scale, hiddenLayerSize, ...
    trainFcn, net, tr, Inputs_Teach, Inputs_Test)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% Zapisywanie wynikow do pliku %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fileID = fopen('zrzut_danych.txt', 'w');    % 'a' - dodaj na koniec pliku
message = ferror(fileID);                   % 'w' - nadpisz
fseek(fileID, 0, 'eof');
fprintf(fileID, '\n');

fprintf(fileID, 'Wp�. podzia�u danych:              %1.1f',                    Div_Scale);
fprintf(fileID, '\nDane ucz�ce:                        %1.0f%%',                (1 - Div_Scale) * 100);
fprintf(fileID, '\nDane testuj�ce:                     %1.0f%%\n\n',            (1 - (1 - Div_Scale)) * 100);
fprintf(fileID, 'Rozmiar macierzy danych ucz�cych:      x_teach = [%d, %d]\n',  size(Inputs_Teach));
fprintf(fileID, 'Rozmiar macierzy danych testuj�cych:   x_test  = [%d, %d]\n\n',size(Inputs_Test));

fprintf(fileID, 'Maksymalne b��dy prognozy dla danych ucz�cych:\n');
fprintf(fileID, 'Maksymalne odchylenie prognozy w g�r�: +%1.4f\n',   max(Differ_Teach));
fprintf(fileID, 'Maksymalne odchylenie prognozy w d�:  %1.4f\n\n',  min(Differ_Teach));

fprintf(fileID, 'Maksymalne b��dy prognozy dla danych testuj�cych:\n');
fprintf(fileID, 'Maksymalne odchylenie prognozy w g�r�: +%1.4f\n',   max(Differ_Test));
fprintf(fileID, 'Maksymalne odchylenie prognozy w d�:  %1.4f\n',    min(Differ_Test));

fprintf(fileID, '\n');
fprintf(fileID, '\nNeurony w warstwie ukrytej:         %d',            hiddenLayerSize);
fprintf(fileID, '\nAlgorytm trenuj�cy:                 %s',            trainFcn);
fprintf(fileID, '\nDane trenuj�ce:                     %1.2f',         net.divideParam.trainRatio);
fprintf(fileID, '\nDane sprawdzaj�ce:                  %1.2f',         net.divideParam.valRatio);
fprintf(fileID, '\nDane testuj�ce:                     %1.2f',         net.divideParam.testRatio);
fprintf(fileID, '\nFunkcja aktywacji w warstwie {1}:   %s',            net.layers{1}.transferFcn);
fprintf(fileID, '\nFunkcja aktywacji w warstwie {2}:   %s',            net.layers{2}.transferFcn);
fprintf(fileID, '\n');
fprintf(fileID, '\nLiczba epok uczenia:                %d (Best: %d)', tr.num_epochs, tr.best_epoch);
fprintf(fileID, '\nCzas uczenia sieci:                 %1.2f sek.',    tr.time(1, length(tr.time)));
fprintf(fileID, '\nGradient:                           %1.4e',         tr.gradient(length(tr.gradient)));
fprintf(fileID, '\n############################################################');
fclose(fileID);