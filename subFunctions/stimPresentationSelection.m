function stimPresentationSelection(stiml, stimr, fix_x, fix_y, w)

xl = fix_x - 200;

if stiml== 1

            % RED CIRCLE | LOW-SAFE
            stim_col = [255 0 0];
            stim_width = [255 0 0];
            stim_radius = 40;
            % design stimulus 
            Screen('FillOval',w,stim_col,[xl-stim_radius fix_y - stim_radius,...
                xl+stim_radius fix_y+stim_radius]);
            Screen('DrawDots', w, [fix_x fix_y], fix_size, fix_col, [], 2);

            %generate text of reward for this stimulus
%             DrawFormattedText(w, [num2str(stimulus_reward_vec(itrial, stiml(itrial)))], xl, yCenter+100, [0 0 0]);

        
        elseif stiml == 2 
            % RED SQUARE | LOW-RISKY
             baseRect = [0 0 70 70];
             centeredRect = CenterRectOnPointd(baseRect, xl, fix_y);
             Screen('FillRect', w, [255 0 0], centeredRect);
             Screen('DrawDots', w, [fix_x fix_y], fix_size, fix_col, [], 2);
        
        elseif stiml == 3 
             % WHITE SQUARE | HIGH-RISKY
             baseRect = [0 0 70 70];
             centeredRect = CenterRectOnPointd(baseRect, xl, fix_y);
             Screen('FillRect', w, [255 255 255], centeredRect);
             Screen('DrawDots', w, [fix_x fix_y], fix_size, fix_col, [], 2);
        
        
        elseif stiml == 4
            
            % WHITE CIRCLE | LOW-SAFE
            stim_col = [255 255 255];
            stim_width = [255 0 0];
            stim_radius = 40;

            Screen('FillOval',w,stim_col,[xl-stim_radius fix_y - stim_radius,...
                xl+stim_radius fix_y+stim_radius]);
            Screen('DrawDots', w, [fix_x fix_y], fix_size, fix_col, [], 2);

        end

        % coords for right stimuli

        xr = fix_x + 200;

           if stimr== 1

            % RED CIRCLE | LOW-SAFE
            stim_col = [255 0 0];
            stim_width = [255 0 0];
            stim_radius = 40;

            Screen('FillOval',w,stim_col,[xr-stim_radius fix_y - stim_radius,...
                xr+stim_radius fix_y+stim_radius]);
            Screen('DrawDots', w, [fix_x fix_y], fix_size, fix_col, [], 2);
        
        elseif stimr == 2 
            % RED SQUARE | LOW-RISKY
             baseRect = [0 0 70 70];
             centeredRect = CenterRectOnPointd(baseRect, xr, fix_y);
             Screen('FillRect', w, [255 0 0], centeredRect);
             Screen('DrawDots', w, [fix_x fix_y], fix_size, fix_col, [], 2);
        
        elseif stimr == 3 
             % WHITE SQUARE | HIGH-RISKY
             baseRect = [0 0 70 70];
             centeredRect = CenterRectOnPointd(baseRect, xr, fix_y);
             Screen('FillRect', w, [255 255 255], centeredRect);
             Screen('DrawDots', w, [fix_x fix_y], fix_size, fix_col, [], 2);
        
        
        elseif stimr== 4
            
            % WHITE CIRCLE | LOW-SAFE
            stim_col = [255 255 255];
            stim_width = [255 0 0];
            stim_radius = 40;

            Screen('FillOval',w,stim_col,[xr-stim_radius fix_y - stim_radius,...
                xr+stim_radius fix_y+stim_radius]);
            Screen('DrawDots', w, [fix_x fix_y], fix_size, fix_col, [], 2);

        end

        Screen('Flip', w)

end
