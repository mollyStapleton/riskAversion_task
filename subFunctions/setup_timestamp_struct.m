function [trialTimestamp] = setup_timestamp_struct();

    trialTimestamp.block_start           = NaN(1, 2);
    trialTimestamp.block_end             = NaN(1, 2);
    
    trialTimestamp.trial_start           = NaN(1, 2);
    trialTimestamp.fix_spot_on           = NaN(1, 2);
    trialTimestamp.stim_on               = NaN(1, 2);
    trialTimestamp.key_down              = NaN(1, 2);
    trialTimestamp.cum_reward_pre        = NaN(1, 2);
    trialTimestamp.reward_on             = NaN(1, 2);
    trialTimestamp.cum_reward_post       = NaN(1, 2);
    trialTimestamp.intertrial            = NaN(1, 2);
    trialTimestamp.trial_end             = NaN(1, 2);




end
