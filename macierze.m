clc
% clear
close all
format compact

A = linspace(1,8,8);
B = logspace(1,3,8);
P = ones(2,2);
Z = zeros(2,3);
E = eye(3);
K = A(1,2:6);
W = [P Z E(1:2,:); A];
Size = size(W);
RR = [W;W];
RD = RR';
MN = RD*RR;
MN(2:7, 2:7) = zeros(6,6);
k0 = find(MN>25  & MN<120);
k1 = find(MN>=30 & MN<45);

MN_size = size(MN);
MN_dims = ndims(MN);
mnoznik = MN_size(1,1) * MN_size(1,2);

j = 1;
for m = 1:MN_size(1,1)    
    for n = 1:MN_size(1,2)        
        MN(m,n) = j
        j = j + 1;
        pause(0.05);

    end
end