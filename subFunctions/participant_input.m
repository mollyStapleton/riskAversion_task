% 
% argindlg = inputdlg({'Participant ID','Gender (M/F)','Age'},'',1,{'','',''});
% if isempty(argindlg)
%     participantInfo.name            = 'NULL';
%     %participant.number = 99
%     % 9;  
% else   
%     participantInfo                 = struct;
%     participantInfo.ID              = upper(argindlg{1});
%     participantInfo.gender          = argindlg{2};
%     participantInfo.age             = argindlg{3};
% 
% end
% 
% % generate folder for participant data 
% 
% pt_folder = [base_path 'data\' participantInfo.ID '\'];
% if ~exist(pt_folder)
% 
%     mkdir(pt_folder);
% 
% end
