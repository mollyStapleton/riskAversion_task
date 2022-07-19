%%% BASE SCRIPT FOR RISK AVERSION TASK %%%%
%%%% Author: Molly Stapleton
%%%%%%%%% Date: June 2022
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% based and adapted from Moeller, M., et al. (2021). 
% "An association between prediction errors and risk-seeking: Theory and behavioral evidence." 
% PLoS Comput Biol 17(7): e1009213.
%--------------------------------------------------------------------------

clc 
clear all 
close all hidden 

eyelink_record = 0; %change to 1 if recording data using eyelink tracker 

%---------------------------------------------------------------------
%%%% SET PATHS FOR SAVING DATA 
%-------------------------------------------------------------------------
% can be changed according to which computer data is being run on 

base_path = ['C:\Users\jf22662\OneDrive - University of Bristol\Documents\MATLAB\riskaversion_task\'];

%----------------------------------------------------------------
%%% SETUP TASK PARAMETERS
%------------------------------------------------------------------------

riskAversion_taskParam_SETUP;

%----------------------------------------------
% Psychtoolbox Keyboard Setup
% return information about the keyboard used 
%---------------------------------------------------------
KbName('UnifyKeyNames');
[idx, names, all]   = GetKeyboardIndices();
info.kbqdev = [idx(strcmpi(names, 'ATEN USB KVMP w. OSD')), idx(strcmpi(names, 'Current Designs, Inc. 932')),...
    idx(strcmpi(names, 'Apple Internal Keyboard / Trackpad')), idx(strcmpi(names, ''))];

keyList             = zeros(1, 256);
right               = KbName('rightarrow');
left                = KbName('leftarrow');
space               = KbName('space');
enter               = KbName('return');
keyList(KbName({'ESCAPE','SPACE', 'RETURN', 'rightarrow', 'leftarrow'})) = 1;

PsychHID('KbQueueCreate', info.kbqdev, keyList);
PsychHID('KbQueueStart', info.kbqdev);
PsychHID('KbQueueFlush', info.kbqdev);
%--------------------------------------------------------------------
% PARTICIPANT INFORMATION 
%-----------------------------------------------------------------------

participant_input;

%--------------------------------------------------------------------------
% GENERATE THE GAUSSIAN DISTRIBUTIONS FOR EACH OF THE 4 STIMULI 
%--------------------------------------------------------------------------------

[rewardDists_gauss] = beta_distr;

% figure(1);
% set(gca, 'FontName', 'Times');
% set(gca, 'FontSize', 12);
% figName = ['rew_dist'];
% print(figName, '-dpdf');

      
% -----------------------------------------------------
%%%% OPEN TASK WINDOW 
%------------------------------------------------------------------

AssertOpenGL;
Screen('Preference', 'TextRenderer', 1); % smooth text
smallWindow4Debug    =  [];

PsychDefaultSetup(2);
% PsychDebugWindowConfiguration
[w, rect] = Screen('OpenWindow', 1, [128 128 128], [0 0 1000 800], 32, 2);

% find the centre coordinates, may be used for reference for the placement
% of other stimuli
[xCenter, yCenter] = RectCenter(rect);

%------------------------------------------------------------------
%-------- get screen resolution and flip/frame info ------------
%------------------------------------------------------------------

% returns minimal amount of time between frames
ifi = Screen('GetFlipInterval', w);
% determines the resfresh ratre of the screen ifi = 1/hertz
hertz = FrameRate(w);
% Length of time and number of frames used for each image drawn
numSecs = 1;
numFrames = round(numSecs / ifi);
waitframes = 1;
% numFrames = 25;
% get pixels for the window size
[screenXpixels, screenYpixels] = Screen('WindowSize', w);
% find the centre coordinates, may be used for reference for the placement
% of other stimuli
[xCenter, yCenter] = RectCenter(rect);
screenOnset = Screen('Flip', w);
tic;


%---------------------------------------------------------------------
% ------ RUN MAIN TASK -------------------------------------
%--------------------------------------------------------------------------
fix_x = xCenter;
fix_y = yCenter;
    
riskAversion_taskInstruction;
[secs, press_key, deltaSecs] = KbStrokeWait();

% load in structure that specifies timestamp identifiers
encodeIdx = taskEncodes;

if press_key(space)

        if eyelink_record
            % setup eyelink
            % includes configuration 
            % includes calibration 
            setup_ET_bristol;
        end


        cumReward = 0;
        
        for iblock = 1: blockOrder

            Screen(w,'FillRect',[128 128 128]);
            Screen('TextFont', w, 'times');
            Screen('TextSize', w, 30); 
            Screen('TextStyle', w, 1);
            DrawFormattedText(w, ['Set' num2str(iblock) '/8' ], 'center', fix_y, [255 255 255]);

            trigger(encodeIdx.block_start);
            if eyelink_record
                Eyelink('message', num2str(encodeIdx.block_start));
                disp(['block_start:' num2str(encodeIdx.block_start)]);
            end
                % each block requires a mew set of four stimuli, mapped to the
                % same four distributions 
    
                % select 60 reward values from the distributions to be
                % assigned to each of the 4 separate stimuli on a single
                % block 

                % counterbalanced block design, whether want gaussian or
                % bimodal distribution for reward distribution generation 
                if blockOrder(iblock) == 1

                    [stimulus_reward_vec] = generateGaussRewardValues(rewardDists_gauss, 60);

                elseif blockOrder(iblock) == 2

                    [stimulus_reward_vec] = bimodal_distr;

                end

                % randomly choose 4 of the 16 symbols and assign them to
                % distributions and remove them from the array so that they 
                % cannot be resampled on the next block 

                blockStimuli = [];
                randStimIdx = randperm(length(symbolStim));
                blockStimuli = symbolStim(randStimIdx(1:4));
                symbolStim(randStimIdx(1:4)) = [];

                [stimIdx, cndIdx, stiml, stimr] =  selectStimulusRisk;

            for itrial = 1: length(stimIdx)

                MAIN_TASK_RUN;

                %-----------------------------------------------------------------------
                %----------- STORAGE OF TASK RELEVANT INFORMATION------------------
                %-----------------------------------------------------------------------
                 
%                 dataOut.ptID(itrial)            = participantInfo.ID;
                dataOut.trialNum(itrial)        = itrial;
                dataOut.blockNum(itrial)        = iblock;
                dataOut.stim_left(itrial)       = stiml(itrial);
                dataOut.stim_right(itrial)      = stimr(itrial);
                dataOut.block_left_stim(itrial) = blockStimuli{stiml(itrial)};
                dataOut.block_right_stim(itrial)= blockStimuli{stimr(itrial)};
                dataOut.blockType(itrial)       = blockOrder(iblock);
               
             end
        
        end
end

%%%%% something here to storage the data to relevant participant folder


