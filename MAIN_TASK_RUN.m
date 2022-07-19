

if eyelink_record
    Eyelink('command', 'record_status_message "TRIAL %d/%d"', itrial, 120);
    Eyelink('message', 'TRIALID %d', itrial);
    Eyelink('message', num2str(encodeIdx.trial_start));
    disp(['trial_start:' num2str(encodeIdx.trial_start)]);
    
end

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

trigger(encodeIdx.intertrial);
if eyelink_record
    Eyelink('message', num2str(encodeIdx.intertrial));
    disp(['iti_on:', num2str(encodeIdx.intertrial)]);
end

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

trigger(encodeIdx.fix_spot_on);
if eyelink_record
    Eyelink('message', num2str(encodeIdx.fix_spot_on));
    disp(['fix_spot_on:', num2str(encodeIdx.fix_spot_on)]);
end

%------------------------------------------------------------------
% STIMULUS PRESENTATION SETUP
%----------------------------------------------------------------------

% coords for left stimuli
xl = fix_x - 280;
xr = fix_x + 200 ;
y_stim = fix_y - 50;
Screen('TextFont', w, 'Agathodaimon');
Screen('TextSize', w, 150);


if stiml(itrial)== 1
    % LOW-SAFE
    DrawFormattedText(w, blockStimuli{1}, xl, 'center', [0 0 0]);
    txt_left = 1;
elseif stiml(itrial) == 2
    % LOW-RISKY
    DrawFormattedText(w, blockStimuli{2}, xl, 'center', [0 0 0]);
    txt_left = 2;
elseif stiml(itrial) == 3
    % HIGH-SAFE
    DrawFormattedText(w, blockStimuli{3}, xl, 'center', [0 0 0]);
    txt_left = 3;
elseif stiml(itrial) == 4
    % HIGH-RISKY
    DrawFormattedText(w, blockStimuli{4}, xl, 'center', [0 0 0]);
    txt_left = 4;
end

% RIGHT STIMULUS
if stimr(itrial)== 1
    % LOW-SAFE
    DrawFormattedText(w, blockStimuli{1}, xr, 'center', [0 0 0]);
    txt_right = 1;
elseif stimr(itrial) == 2
    % LOW-RISKY
    DrawFormattedText(w, blockStimuli{2}, xr, 'center', [0 0 0]);
    txt_right = 2;
elseif stimr(itrial) == 3
    % HIGH-SAFE
    DrawFormattedText(w, blockStimuli{3}, xr, 'center', [0 0 0]);
    txt_right = 3;
elseif stimr(itrial) == 4
    % HIGH-RISKY
    DrawFormattedText(w, blockStimuli{4}, xr, 'center', [0 0 0]);
    txt_right = 4;
end

 %---------------------------------------------------------------------
 %----------- DISPLAY STIMULUS ----------------------------
 %---------------------------------------------------------------------

stimuliOn = Screen('flip', w, [], 1);
stimOn    = GetSecs;
stimOnMin = ceil(stimOn + timing.stimOnMin).*1000;
errorresp = false;
trigger(encodeIdx.stim_on_wait);
if eyelink_record
    Eyelink('message', num2str(encodeIdx.stim_on_wait));
    disp(['stimulus_on_wait:', num2str(encodeIdx.stim_on_wait)]);
end

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

                trigger(encodeIdx.error_resp);
                    if eyelink_record
                        Eyelink('message', num2str(encodeIdx.error_resp));
                        disp(['response_type:', num2str(encodeIdx.error_resp)]);
                    end

            end
        end
    
    end

    if ~errorresp

        
                go_col = [0 255 0];
                Screen('DrawDots', w, [fix_x fix_y], 10, go_col, [], 2);
                stimuliOn = Screen('flip', w, [], 1);
                KbWait;
                [keyIsDown, secs, press_key, deltaSecs] = KbCheck();
                

                trigger(encodeIdx.stim_on_go);
                if eyelink_record
                    Eyelink('message', num2str(encodeIdx.stim_on_go));
                    disp(['stimulus_on_go:', num2str(encodeIdx.stim_on_go)]);
                end

                %--------------------------------------------------------------
                %----------- WAIT FOR RESPONSE ----------------------------
                %--------------------------------------------------------------

                if keyIsDown == 1
                
                    trigger(encodeIdx.response);
                    trigger(encodeIdx.delay);
                    if eyelink_record
                        Eyelink('message', num2str(encodeIdx.response));
                        disp(['response:', num2str(encodeIdx.response)]);
                        Eyelink('message', num2str(encodeIdx.delay));
                        disp(['delay:', num2str(encodeIdx.delay)]);
                    end
                
                    % reaction time: time to respond from stimulus onset
                    dataOut.RT(itrial) = GetSecs-stimOn;
                
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
                        rewChosen = stimulus_reward_vec(itrial, stimr(itrial));
                    elseif press_key(left)
                        cd 'C:\Users\jf22662\OneDrive - University of Bristol\Documents\MATLAB\riskaversion_task\drawn_stimuli';
                        centeredChoiceRect = CenterRectOnPointd(choiceRect, fix_x-80, fix_y);
                        choice_image = imread(['left_choice.png']);
                        image_choice = Screen('MakeTexture', w, choice_image);
                        Screen('DrawTexture', w, image_choice, [], centeredChoiceRect);   rewChosen = stimulus_reward_vec(itrial, stiml(itrial));
                    end
                
                    %%%% retain a cumulative sum of rewards and display after every
                    %%%% stimulus selection
                
                    cumReward = cumReward;
                    if cumReward == 0 
                        Screen(w,'DrawText',['Total Reward: ' ], [fix_x-100], [fix_y+80], [0 0 0]);   % draw instuctions
                    else 
                        Screen(w,'DrawText',['Total Reward: ' num2str(cumReward)], [fix_x-100], [fix_y+80], [0 0 0]);   % draw instuctions
                    end
                
                    Screen('TextFont', w, 'Times');
                    Screen('TextSize', w, 32);
                    Screen(w,'DrawText',['Total Reward: ' num2str(cumReward)], [fix_x-100], [fix_y+80], [0 0 0]);   % draw instuctions
                    WaitSecs(timing.delay);
                    
                    Screen('flip', w, [], 1);
                    trigger(encodeIdx.cum_reward_pre);
                    if eyelink_record
                        Eyelink('message', num2str(encodeIdx.cum_reward_pre));
                        disp(['choice_displayed:', num2str(encodeIdx.cum_reward_pre)]);
                    end
                    WaitSecs(timing.choice);
                    
                
                    %---------------------------------------------------------------------
                    %---------------DISPLAY REWARD FEEDBACK--------------------------
                    %---------------------------------------------------------------------
                    cumReward = cumReward + rewChosen;
                    Screen(w,'DrawText',['Total Reward: ' num2str(cumReward)], [fix_x-100], [fix_y+80], [0 0 0]);   % draw instuctions
                
                    if press_key(right)
                
                        Screen(w,'DrawText',[num2str(stimulus_reward_vec(itrial, stimr(itrial)))],fix_x-5,fix_y-80,[255 255 255], [128 128 128]);
                        rewChosen = stimulus_reward_vec(itrial, stimr(itrial));
                        dataOut.choice(itrial) = 1;
                
                    elseif press_key(left)
                
                        Screen(w,'DrawText',[num2str(stimulus_reward_vec(itrial, stiml(itrial)))],fix_x-5,fix_y-80,[255 255 255], [128 128 128]);
                        rewChosen = stimulus_reward_vec(itrial, stiml(itrial));
                        dataOut.choice(itrial) = 2;
                    end
                
                    rewardFeedback = Screen('Flip', w);
                    WaitSecs(timing.reward); 
                
                    trigger(encodeIdx.reward_on);
                    trigger(encodeIdx.cum_reward_post);
                
                    if eyelink_record
                        Eyelink('message', num2str(encodeIdx.reward_on));
                        disp(['feedback_on:', num2str(encodeIdx.reward_on)]);
                        Eyelink('message', num2str(encodeIdx.cum_reward_post));
                        disp(['total_feedback_on:', num2str(encodeIdx.cum_reward_post)]);
                    end
                
                    dataOut.reward(itrial)          = rewChosen;
                end

                trigger(encodeIdx.correct_resp);
                if eyelink_record
                    Eyelink('message', num2str(encodeIdx.correct_resp));
                    disp(['response_type:', num2str(encodeIdx.correct_resp)]);
                end

        end
        
        