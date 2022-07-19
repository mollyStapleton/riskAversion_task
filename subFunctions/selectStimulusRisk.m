function [stimIdx, cndIdx, stim_idx_l, stim_idx_r] =  selectStimulusRisk

tmp_idx = 1:12;
stimAll = repmat(tmp_idx, 1, 10)';
rndStim = randperm(length(stimAll));
stimIdx = stimAll(rndStim);

% possible stimulus combinations 
stimCombos = [1 3; 1 4; 2 3; 2 4;,...  %% different [1 2 3 4]
              1 2;,...                 %% both high [5]
              3 4;,...                  %% both low  [6]
              3 1; 4 1; 3 2; 4 2;,...  %% different [7 8 9 10]
              2 1;,...                 %% both high [11]
              4 3];                   %% both low  [12]

for istim = 1: length(stimIdx)
        stimCombo2run = stimCombos(stimIdx(istim, :));
    for idir = 1:2
        if idir == 1 % left stimulus 

               stim_idx_l(istim) =  stimCombos(stimIdx(istim), idir);
               
        elseif idir == 2    

                stim_idx_r(istim) =  stimCombos(stimIdx(istim), idir);
        end

    end

    %%% assign condition number 

    if stimIdx(istim)>= 1 && stimIdx(istim) <=4
        cndIdx(istim) = 1; %%%% different
    elseif stimIdx(istim) >= 7 && stimIdx(istim) <= 10
        cndIdx(istim) = 1; %%%% different
    elseif stimIdx(istim) == 5 || stimIdx(istim) == 11
        cndIdx(istim) = 2; %%%% both high 
    elseif stimIdx(istim) == 6 || stimIdx(istim) == 12
        cndIdx(istim) = 3; %%% both low 
    end


end
end