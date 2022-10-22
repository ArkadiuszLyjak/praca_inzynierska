function static_loop()

% Siec podczas uczenia ma tendencje do wytrenowania z bledem "grubym",
% na skutek, którego wynik obliczeñ/treningu mo¿e znacz¹co odbiegaæ od 
% wyników statystycznych osi¹ganych poprzez
% wielokrotne próby trenowania. W celu jego wyeliminowania siec mo¿na
% trenowaæ wielokrotnie za pomoc¹ pêtli do osi¹gniecia b³êdu wyników
% mniejszego od statystycznego.

clear maxx minn mean_maxx mean_minn

n = 15;

for k = 1:n
    
clear tr netw1

[netw1, tr]         = train(net, Inputs_Teach, Targets_Teach);
Outputs_Teach       = netw1(Inputs_Teach);
Differ_Teach        = Outputs_Teach-Targets_Teach;

maxx(k, 1) = max(Differ_Teach);
minn(k, 1) = min(Differ_Teach);

mean_maxx = mean(maxx);
mean_minn = mean(minn);

% Zapisywanie do pliku txt
fileIDD = fopen('max_min_Differ_Teach.txt', 'a');
fseek(fileIDD, 0, 'eof');
fprintf(fileIDD, '%1.4f %1.4f', maxx(k, 1), minn(k, 1));
fprintf(fileIDD, '\n');

if (maxx(k, 1) > 0.0639 || minn(k, 1) < -0.0394) && k < 10
    fprintf('k = %d   ||  max %1.4f mean_max %1.4f || min %1.4f mean_min %1.4f\n', ...
        k, maxx(k, 1), mean_maxx, minn(k, 1), mean_minn);   
elseif (maxx(k, 1) > 0.0639 || minn(k, 1) < -0.0394) && (k >= 10 && k <=15)
    fprintf('k = %d  ||  max %1.4f mean_max %1.4f || min %1.4f mean_min %1.4f\n', ...
        k, maxx(k, 1), mean_maxx, minn(k, 1), mean_minn);   
end
if (maxx(k, 1) <= 0.0639 && minn(k, 1) >= -0.0394) 
    break
end
end

fprintf('\n');
fclose(fileIDD);