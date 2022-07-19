% Setup Eyelink for Risk Aversion Experiment 
% LAB: 4D11

disp('ET calibrating')
[el, info] = ELconfig(w, ['S',num2str(info.SubNo),info.Session_type, num2str(info.Session_No),info.Block_type,num2str(info.Block_No)], info, screenNumber);
el.callback = [];
EyelinkDoTrackerSetup(el);
disp('ET calibration done! >>>>>>>>>>')
