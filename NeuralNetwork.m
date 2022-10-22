clc; clear; close all;
format shortG ,format compact

format shortG ,format compact

load('EURUSD_D1.mat');
uczacy  = EURUSD_NN(1:3000,:);
testowy = EURUSD_NN(3001:end,:); 

zmienne = uczacy(:,1:9);
t = uczacy(:,1);
y = uczacy(:,10);

zmienne_t  =  testowy(:,1:9);
t_t = testowy(:,1);
y_t = testowy(:,10);

inputs = zmienne';
targets = y';

hiddenLayerSize = 10;
trainFcn = 'trainlm';
net = feedforwardnet(hiddenLayerSize,trainFcn);

net.divideParam.trainRatio  = .7;
net.divideParam.valRatio    = .15;
net.divideParam.testRatio   = .15;

% zmiana funkcji aktywacji
net.layers{1}.transferFcn = 'tansig';   % <-  logsig,  tansig, purelin
net.layers{2}.transferFcn = 'purelin';  % <-  logsig,  tansig, purelin
    
[net,tr] = train(net,inputs,targets);

outputs = net(inputs);
errors = gsubtract(targets,outputs);
performance = perform(net,targets,outputs);

% view(net);

outputs = outputs';

figure(1);
plot(t,y,t,outputs,'--');
title('Wykres dla danych ucz¹cych');
legend('Oryginalne dane Y','Przewidywane wartoœci Y');

figure(2);
k = sqrt(length(errors));
hist(errors, k);
title('Rozk³ad b³êdów na zbiorze testowym');

figure(3);
plotperform(tr);
title('Zale¿noœæ liczby epok uczenia i b³êdu');
xlabel('Liczby epok uczenia');
ylabel('B³¹d œredniokwadratowy MSE');

inputs_t  = zmienne_t';
outputs_t = net(inputs_t);
outputs_t = outputs_t';

figure(4);
plot(t_t,y_t,t_t,outputs_t,'r--');
title('Wykres dla danych testuj¹cych');
legend('Oryginalne dane Y','Przewidywane wartoœci Y');

disp('wartoœci oryginalne,  przewidywane, ró¿nica')
[y_t outputs_t outputs_t-y_t]
min = min(outputs_t-y_t)
max = max(outputs_t-y_t)