function disp2file(Differ_Teach, Differ_Test, Div_Scale, hiddenLayerSize, ...
    trainFcn, net, tr, Inputs_Teach, Inputs_Test)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% Zapisywanie wynikow do pliku %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fileID = fopen('zrzut_danych.txt', 'w');    % 'a' - dodaj na koniec pliku
message = ferror(fileID);                   % 'w' - nadpisz
fseek(fileID, 0, 'eof');
fprintf(fileID, '\n');

fprintf(fileID, 'Wpó³. podzia³u danych:              %1.1f',                    Div_Scale);
fprintf(fileID, '\nDane ucz¹ce:                        %1.0f%%',                (1 - Div_Scale) * 100);
fprintf(fileID, '\nDane testuj¹ce:                     %1.0f%%\n\n',            (1 - (1 - Div_Scale)) * 100);
fprintf(fileID, 'Rozmiar macierzy danych ucz¹cych:      x_teach = [%d, %d]\n',  size(Inputs_Teach));
fprintf(fileID, 'Rozmiar macierzy danych testuj¹cych:   x_test  = [%d, %d]\n\n',size(Inputs_Test));

fprintf(fileID, 'Maksymalne b³êdy prognozy dla danych ucz¹cych:\n');
fprintf(fileID, 'Maksymalne odchylenie prognozy w górê: +%1.4f\n',   max(Differ_Teach));
fprintf(fileID, 'Maksymalne odchylenie prognozy w dó³:  %1.4f\n\n',  min(Differ_Teach));

fprintf(fileID, 'Maksymalne b³êdy prognozy dla danych testuj¹cych:\n');
fprintf(fileID, 'Maksymalne odchylenie prognozy w górê: +%1.4f\n',   max(Differ_Test));
fprintf(fileID, 'Maksymalne odchylenie prognozy w dó³:  %1.4f\n',    min(Differ_Test));

fprintf(fileID, '\n');
fprintf(fileID, '\nNeurony w warstwie ukrytej:         %d',            hiddenLayerSize);
fprintf(fileID, '\nAlgorytm trenuj¹cy:                 %s',            trainFcn);
fprintf(fileID, '\nDane trenuj¹ce:                     %1.2f',         net.divideParam.trainRatio);
fprintf(fileID, '\nDane sprawdzaj¹ce:                  %1.2f',         net.divideParam.valRatio);
fprintf(fileID, '\nDane testuj¹ce:                     %1.2f',         net.divideParam.testRatio);
fprintf(fileID, '\nFunkcja aktywacji w warstwie {1}:   %s',            net.layers{1}.transferFcn);
fprintf(fileID, '\nFunkcja aktywacji w warstwie {2}:   %s',            net.layers{2}.transferFcn);
fprintf(fileID, '\n');
fprintf(fileID, '\nLiczba epok uczenia:                %d (Best: %d)', tr.num_epochs, tr.best_epoch);
fprintf(fileID, '\nCzas uczenia sieci:                 %1.2f sek.',    tr.time(1, length(tr.time)));
fprintf(fileID, '\nGradient:                           %1.4e',         tr.gradient(length(tr.gradient)));
fprintf(fileID, '\n############################################################');
fclose(fileID);