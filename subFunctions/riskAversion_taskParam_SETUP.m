
    %---------------------------------------------
    % SET UP TASK PARAMS
    %---------------------------------------------
    % 16 POTENTIAL STIMULI SYMBOLS 
    symbolStim = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j',...
        'k', 'l', 'm', 'n', 'o', 'p'};
    % COUNTERBALANCE BLOCK ORDER PER PARTICIPANT 
    % blockOrder = [1 1 1 1 2 2 2 2]; % 1 = Gaussian, 2 = Bimodal 
    blockOrder = [2 2 2 2 1 1 1 1]; % 1 = Gaussian, 2 = Bimodal 
    % possible stimulus combinations 
    stimCombos    = {[1 3; 1 4; 2 3; 2 4],...  %% different [1 2 3 4]
            [1 2],...                 %% both high [5]
            [3 4]...                  %% both low  [6]
            [3 1; 4 1; 3 2; 4 2],...  %% different [7 8 9 10]
            [2 1],...                 %% both high [11]
            [4 3]};                   %% both low  [12]

    timing.ITI          = 1.5;
    timing.fixOn        = 0.5;
    timing.stimOnMin    = 0.8;
    timing.delay        = 0.8;
    timing.choice       = 0.8;
    timing.reward       = 1.5;

