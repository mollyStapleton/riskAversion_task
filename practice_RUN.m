%%%% RUN A SET OF 15 PRACTICE TRIALS 
%%%%% THE FIRST 5 WLL HAVE WRITTEN INSTRUCTIONS 
%%%%%% THE LAST 10 WILL NOT

% practiceCombos = {[1 3; 1 4; 2 3; 2 4],...  %% different [1 2 3 4]
%     [1 2],...                 %% both high [5]
%     [3 4]...                  %% both low  [6]
%     [3 1; 4 1; 3 2; 4 2],...  %% different [7 8 9 10]
%     [2 1],...                 %% both high [11]
%     [4 3]};                   %% both low  [12]

pl = [1 1 2 2 1 3 3 4 3 4 2 4];
pr = [3 4 3 4 2 4 1 1 2 2 1 3];
pstimuli = {'v', 'w', 'x', 'y'};
[stimulus_reward_vec_pract] = generateGaussRewardValues(rewardDists_gauss, 6);
cumReward = 0;

for ptrial = 1:12
        %---------------------------------------------------------------------
        %----------- SET INTERTRIAL INTERVAL-------------------
        %---------------------------------------------------------------------
        Screen('BlendFunction', w, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
        
        iti_col = [0 0 0]; %FIX SPOT BLACK DURING ITI 
        
        fix_x = xCenter;
        fix_y = yCenter;
        stim_radius = 15;
        
        Screen(w,'FillRect',[128 128 128]);
        
        baseRect = [15 15 50 20];
        Rotated_fixation(w, baseRect, fix_x, fix_y, [255 255 255], [45, 135]);
        
        ITI       = Screen('flip', w);
        
        
        WaitSecs(timing.ITI);
        
        %---------------------------------------------------------------------
        %---------PRESENT FIXATION SPOT---------------------------------
        %---------------------------------------------------------------------
        
        fix_col = [255 255 255]; %create white fixation dot
        dot_col = [255 0 0];
        
        Rotated_fixation(w, baseRect, fix_x, fix_y, [255 255 255], [0,90]);
        Screen('DrawDots', w, [fix_x fix_y], 10, dot_col, [], 2);
        
        fixOnset = Screen('Flip', w, [], 1);
        WaitSecs(timing.fixOn);
        
        %------------------------------------------------------------------
        % STIMULUS PRESENTATION SETUP
        %----------------------------------------------------------------------
        
        % coords for left stimuli
        xl = fix_x - 280;
        xr = fix_x + 200 ;
        y_stim = fix_y - 50;
        Screen('TextFont', w, 'Agathodaimon');
        Screen('TextSize', w, 150);
        
        
        if pl(ptrial)== 1
            % LOW-SAFE
            DrawFormattedText(w, pstimuli{1}, xl, 'center', [0 0 0]);
            txt_left = 1;
        elseif pl(ptrial) == 2
            % LOW-RISKY
            DrawFormattedText(w, pstimuli{2}, xl, 'center', [0 0 0]);
            txt_left = 2;
        elseif pl(ptrial) == 3
            % HIGH-SAFE
            DrawFormattedText(w, pstimuli{3}, xl, 'center', [0 0 0]);
            txt_left = 3;
        elseif pl(ptrial) == 4
            % HIGH-RISKY
            DrawFormattedText(w, pstimuli{4}, xl, 'center', [0 0 0]);
            txt_left = 4;
        end
        
        % RIGHT STIMULUS
        if pr(ptrial)== 1
            % LOW-SAFE
            DrawFormattedText(w, pstimuli{1}, xr, 'center', [0 0 0]);
            txt_right = 1;
        elseif pr(ptrial) == 2
            % LOW-RISKY
            DrawFormattedText(w, pstimuli{2}, xr, 'center', [0 0 0]);
            txt_right = 2;
        elseif pr(ptrial) == 3
            % HIGH-SAFE
            DrawFormattedText(w, pstimuli{3}, xr, 'center', [0 0 0]);
            txt_right = 3;
        elseif pr(ptrial) == 4
            % HIGH-RISKY
            DrawFormattedText(w, pstimuli{4}, xr, 'center', [0 0 0]);
            txt_right = 4;
        end
         %---------------------------------------------------------------------
         %----------- DISPLAY STIMULUS ----------------------------
         %---------------------------------------------------------------------
        
        stimuliOn = Screen('flip', w, [], 1);
        stimOn    = GetSecs;
        stimOnMin = ceil(stimOn + timing.stimOnMin).*1000;
        errorresp = false;

        %%%% set a timer over which to perform this check
        t0 = clock;
        while etime(clock, t0) <= timing.stimOnMin
                [~, keyTime, keyCode, deltaSecs] = KbCheck();
                if keyCode(right) || keyCode(left) % if the key is pressed check if it was before the green dot turned on 
                    if keyTime - stimOn <= timing.stimOnMin  %%% if key is within 0.8s from stim on
                        Screen(w,'FillRect',[128 128 128]);
                        Screen('TextFont', w, 'Times');
                        Screen('TextSize', w, 40);
                        DrawFormattedText(w, ['Too Fast!'], 'center', fix_y,[255 255 255]);
                        Screen('flip', w);
                        WaitSecs(2);
                        errorresp = true;
                        
                    end
                end
        
        end
        if ~errorresp

            go_col = [0 255 0];
            Screen('DrawDots', w, [fix_x fix_y], 10, go_col, [], 2);
            stimuliOn = Screen('flip', w, [], 1);
            KbWait;
            [keyIsDown, ~, press_key, deltaSecs] = KbCheck();
                    
                                   if keyIsDown == 1
                                    %---------------------------------------------------
                                    %%% HIGHLIGHT CHOSEN STIMULUS
                                    %-------------------------------------------------------
                                
                                    rewChosen = [];
                                    choiceRect = [0 0 100 100];
                                   
                                    if press_key(right)
                                        
                                        cd 'C:\Users\jf22662\OneDrive - University of Bristol\Documents\MATLAB\riskaversion_task\drawn_stimuli';
                                        centeredChoiceRect = CenterRectOnPointd(choiceRect, fix_x+80, fix_y);
                                        choice_image = imread(['right_choice.png']);
                                        image_choice = Screen('MakeTexture', w, choice_image);
                                        Screen('DrawTexture', w, image_choice, [], centeredChoiceRect);
                                        rewChosen = stimulus_reward_vec_pract(ptrial, pr(ptrial));
                                    elseif press_key(left)
                                        cd 'C:\Users\jf22662\OneDrive - University of Bristol\Documents\MATLAB\riskaversion_task\drawn_stimuli';
                                        centeredChoiceRect = CenterRectOnPointd(choiceRect, fix_x-80, fix_y);
                                        choice_image = imread(['left_choice.png']);
                                        image_choice = Screen('MakeTexture', w, choice_image);
                                        Screen('DrawTexture', w, image_choice, [], centeredChoiceRect);   rewChosen = stimulus_reward_vec_pract(ptrial, pl(ptrial));
                                    end
                                
                                    %%%% retain a cumulative sum of rewards and display after every
                                    %%%% stimulus selection
                                
                                    cumReward = cumReward;
                                    Screen('TextFont', w, 'Times');
                                    Screen('TextSize', w, 32);
                                    cumReward = cumReward + rewChosen;
                                    if cumReward == 0 
                                        Screen(w,'DrawText',['Total Reward: ' ], [fix_x-100], [fix_y+80], [0 0 0]);   % draw instuctions
                                    else 
                                        Screen(w,'DrawText',['Total Reward: ' num2str(cumReward)], [fix_x-100], [fix_y+80], [0 0 0]);   % draw instuctions
                                    end
                
                                    WaitSecs(timing.delay);
                                    Screen('flip', w, [], 1);
                                    WaitSecs(timing.choice);
                                    
                                
                                    %---------------------------------------------------------------------
                                    %---------------DISPLAY REWARD FEEDBACK--------------------------
                                    %---------------------------------------------------------------------
                                
                                    cumReward = cumReward + rewChosen;
                                    Screen(w,'DrawText',['Total Reward: ' num2str(cumReward)], [fix_x-100], [fix_y+80], [0 0 0]);   % draw instuctions
                                
                                    if press_key(right)
                                
                                        Screen(w,'DrawText',[num2str(stimulus_reward_vec_pract(ptrial, pr(ptrial)))],fix_x-5,fix_y-80,[255 255 255], [128 128 128]);
                                        rewChosen = stimulus_reward_vec_pract(ptrial, pr(ptrial));
                                        dataOut.choice(ptrial) = 1;
                                
                                    elseif press_key(left)
                                
                                        Screen(w,'DrawText',[num2str(stimulus_reward_vec_pract(ptrial, pl(ptrial)))],fix_x-5,fix_y-80,[255 255 255], [128 128 128]);
                                        rewChosen = stimulus_reward_vec_pract(ptrial, pl(ptrial));
                                        dataOut.choice(ptrial) = 2;
                                    end
                                
                                    rewardFeedback = Screen('Flip', w);
                                    WaitSecs(timing.reward); 
                                   end
        else
            continue;
        end      
end

