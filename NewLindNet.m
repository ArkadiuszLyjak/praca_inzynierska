clc;
% clear
close all;

Inputs_Test_NewLind = con2seq(Inputs_Test(8, 1:1000));
Xi = Inputs_Test_NewLind(1:4);
X = Inputs_Test_NewLind(5:(end-1));
timex = time(5:(end-1));
T = Inputs_Test_NewLind(6:end);
net = newlind(X,T,Xi);
% view(net)
Y = net(X,Xi);
T = T';
Y = Y';
plot(Y);