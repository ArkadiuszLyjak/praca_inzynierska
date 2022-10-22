function disp2screen(Differ_Teach, Differ_Test, Inputs_Test, Targets_Test, Outputs_Test)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% Wypisanie wynikow na ekran %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('nr originalne   prognoza     roznica    rozpietosc(max-min)    korpus')

max_min = zeros(1, length(Inputs_Test));
corpses = zeros(1, length(Inputs_Test));

for i = 1:length(Targets_Test)
    
    max_min(1, i) = (Inputs_Test(6, i) - Inputs_Test(7, i)); % High - Low
    corpses(1, i) = (Inputs_Test(8, i) - Inputs_Test(5, i)); % Close - Open
    
% %     Opcja dla sytuacji, gdzie liczba zmiennych zostaje skrocona do piêciu
%     max_min(1, i) = (Inputs_Test(3, i) - Inputs_Test(4, i)); % High - Low
%     corpses(1, i) = (Inputs_Test(5, i) - Inputs_Test(4, i)); % Close - Open
    
    if (Differ_Test(1, i) > 0 && corpses(1, i) > 0)
% %             fprintf('Differ_Test(1, i = %d) = %1.4f corpses(1, i) = %1.4f\n', i, Differ_Test(1, i), corpses(1, i));
            fprintf('%d\t %1.4f      %1.4f      +%1.4f         %1.4f           +%1.4f\n', ...
            i, Targets_Test(i), Outputs_Test(i), Differ_Test(i), max_min(1, i), ...
            corpses(1, i));
        
    elseif (Differ_Test(1, i) < 0 && corpses(1, i) < 0)
% %             fprintf('Differ_Test(1, i = %d) = %1.4f corpses(1, i) = %1.4f\n', i, Differ_Test(1, i), corpses(1, i));
            fprintf('%d\t %1.4f      %1.4f      %1.4f         %1.4f           %1.4f\n', ...
            i, Targets_Test(i), Outputs_Test(i), Differ_Test(i), max_min(1, i), ...
            corpses(1, i));
        
    elseif (Differ_Test(1, i) > 0 && corpses(1, i) < 0)
% %             fprintf('Differ_Test(1, i = %d) = %1.4f corpses(1, i) = %1.4f\n', i, Differ_Test(1, i), corpses(1, i));
            fprintf('%d\t %1.4f      %1.4f      +%1.4f         %1.4f           %1.4f\n', ...
            i, Targets_Test(i), Outputs_Test(i), Differ_Test(i), max_min(1, i), ...
            corpses(1, i));
        
    elseif (Differ_Test(1, i) < 0 && corpses(1, i) > 0)
% %             fprintf('Differ_Test(1, i = %d) = %1.4f corpses(1, i) = %1.4f\n', i, Differ_Test(1, i), corpses(1, i));
            fprintf('%d\t %1.4f      %1.4f      %1.4f         %1.4f           +%1.4f\n', ...
            i, Targets_Test(i), Outputs_Test(i), Differ_Test(i), max_min(1, i), ...
            corpses(1, i));
        
    end
    
    if i >= length(Targets_Test)
        fprintf('\n')
    end
end

disp('Obliczenia dla danych ucz¹cych')
fprintf('[Uczenie]  Maksymalne odchylenie prognozy w górê: +%1.4f\n',   max(Differ_Teach));
fprintf('[Uczenie]  Maksymalne odchylenie prognozy w dó³:  %1.4f\n\n',  min(Differ_Teach));

disp('Obliczenia dla danych testuj¹cych')
fprintf('[Test]     Maksymalne odchylenie prognozy w górê: +%1.4f\n',   max(Differ_Test));
fprintf('[Test]     Maksymalne odchylenie prognozy w dó³:  %1.4f\n\n',  min(Differ_Test));

