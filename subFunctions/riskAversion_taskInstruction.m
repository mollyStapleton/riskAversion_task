%%%% SCRIPT PRINT THE INSTRUCTIONS FOR THE RISK AVERSION STUDY
   
    Screen('TextFont', w, 'Times');
    Screen('TextSize', w, 25); 
%     DrawFormattedText(w, [''], 'center', [], [255 255 255]);
    DrawFormattedText(w, ['Thank you for taking part in this study'], 'center', fix_y-100, [255 255 255]);
    DrawFormattedText(w, ['You will complete 8 sets of 120 trials'], 'center', fix_y-50, [255 255 255]);
    DrawFormattedText(w, ['Please maintaing your gaze on the CENTRAL FIXATION CROSS for the duration of the study'], 'center', fix_y,[255 255 255]);
    Screen('TextStyle', w, 1);
    DrawFormattedText(w, ['During trials: PLEASE TRY NOT TO BLINK'], 'center', fix_y+50, [255 255 255]);
    Screen('TextStyle', w, 0);
    DrawFormattedText(w, ['You will be given breaks to blink between trials and at the end of each set'], 'center', fix_y+100, [255 255 255]);
    DrawFormattedText(w, ['Press SPACE to continue'], 'center', fix_y+200,[255 255 255])
    Screen('flip', w);
    WaitSecs(2);
    [secs, press_key, deltaSecs] = KbStrokeWait();
    
    if press_key(space)


        Screen('TextSize', w, 30); 
        Screen('TextStyle', w, 1);
        DrawFormattedText(w, ['TASK INSTRUCTIONS'], 'center', fix_y-300, [255 255 255]);
        Screen('TextSize', w, 25);
        Screen('TextStyle', w, 0);
        DrawFormattedText(w, ['Your task is obtain as many points as possible over the course of this study'], 'center', fix_y-200, [255 255 255]);
        DrawFormattedText(w, ['Within each set of 120 trials, you will be presented with 4 different stimuli'], 'center', fix_y-150, [255 255 255]);
        DrawFormattedText(w, ['Each of these stimuli have been assigned to return you either a HIGH or LOW reward'], 'center', fix_y-100, [255 255 255]);
        DrawFormattedText(w, ['On each trial, you will be presented with TWO of these stimuli, presented either side of the fixation cross'], 'center', fix_y-50, [255 255 255]);
        DrawFormattedText(w, ['On each trial, your task is to select the stimulus that will give you the HIGHEST number of points'], 'center', fix_y, [255 255 255]);
        DrawFormattedText(w, ['On each trial, make your choice by pressing the LEFT or RIGHT ARROW key'], 'center', fix_y+50, [255 255 255]);
        DrawFormattedText(w, ['On each trial, you will be shown your running points total and the points gained by your choice'], 'center', fix_y+100, [255 255 255]);

        DrawFormattedText(w, ['You will now complete a series of practice trials'], 'center', fix_y+200, [255 255 255]);
        DrawFormattedText(w, ['Press SPACE to Start'], 'center', fix_y+250,[255 255 255]);
        Screen('flip', w);
        WaitSecs(2);
        [secs, press_key, deltaSecs] = KbStrokeWait();
 

    end

  
    if press_key(space)
        % run practice trials
%         [secs, press_key, deltaSecs] = KbStrokeWait();
        practice_RUN;
      
    end  
        
        Screen(w,'FillRect',[128 128 128]);
        Screen('TextSize', w, 40); 
        Screen('TextStyle', w, 1);
        DrawFormattedText(w, ['The study will now begin'], 'center', fix_y, [255 255 255]);
        Screen('TextSize', w, 30); 
        Screen('TextStyle', w, 1);
        DrawFormattedText(w, ['Press SPACE to BEGIN'], 'center', fix_y+250,[255 255 255]);
        [secs, press_key, deltaSecs] = KbStrokeWait();
        Screen('flip', w);
        WaitSecs(2);


  

    