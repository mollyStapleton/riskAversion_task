% generate stimulus reward distributions 
%----------------------------------------------------
clc 
clear all 
close all hidden

% rewardVals = [1:99];
figure;
X=[0:1:100];
%%%% Using a folded Gaussian - authored by Konstantinos Tsetsos
% subplot(2,1,2);
iters=100000;
up_thr=100;
mu_mat=[40 40 60 60];
sd_mat=[5 15 5 15];
for i=1:4;
    mu=mu_mat(i);sd=sd_mat(i); % low-safe
    R = (randn(1,iters)*sd+mu);
     
    R((R<=mu | R>=up_thr))=[]; % censor
    Q=mu-(R-mu); % replicated for lower end
    R=[Q R]; %combine
    folded(i,:)=[mean(R) std(R)]
    histogram(R,'BinEdges',X);hold on;
end
%----------------------------------------

legend('High-Safe', 'High-Risky', 'Low-Safe', 'Low-Risky');