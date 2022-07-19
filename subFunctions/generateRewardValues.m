function [stimulus_reward_vec] = generateRewardValues(rewardDists)

mu_mat=[40 40 60 60];
sd_mat=[5 15 5 15];
rewards2use = NaN(240, 4);
% each stimulus shown 6 times within 12 combinations
% 12 combinations shown 10 times each 
% within a single block each stimulus shown 60 times 


k = [0 0 0 0];
for istim = 1:4
    while k(istim) == 0 

        dist2run = rewardDists{istim};
    
        for itrials = 1:240

            randIdx(itrials) = randi([1 length(dist2run)]);

        end

            tmp_rewardVector = dist2run(randIdx);

            if round(mean(tmp_rewardVector)) == mu_mat(istim) && round(std(tmp_rewardVector)) == sd_mat(istim)
                
                rewards2use(:, istim) = round(tmp_rewardVector);
                k(istim) = 1;

            end
                
    end     
                 
end
                stimulus_reward_vec = rewards2use;
end


