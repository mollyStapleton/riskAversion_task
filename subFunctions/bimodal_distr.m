function [rewardDists] = bimodal_distr

% return 4 separate bimodal reward distributions 
% 120 trials with 10 x 12 stimulus combinations 

%EG HIGH-SAFE (EV = 60)
%  0.8 * 75 + 0.2 * 0 = 60
%  ev_mat =[40 40 60 60];

    reward_size = [50 200 75 300];
    reward_trials = [48 12 48 12];

% a single stimulus will be shown 60 times in a single block 
% 80% = 48 trials, 20% = 12 trials 

    rewardDists = zeros(60,4);
    
    for i = 1:4

        rewardDists((1:reward_trials(i)), i) = reward_size(i);

        % randomize the reward values 

        for ipres = 1: 60
            tmp_idx(ipres) = randi([1 length(rewardDists(:, i))]);
        end

        rewardDists(:, i) = rewardDists(tmp_idx, i);

    end


end 