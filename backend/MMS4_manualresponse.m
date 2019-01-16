function [RT,rdir] = MMS4_manualresponse(settings) 

% initialize
stimonset = GetSecs;
rdir = 0; RT = 0; % preassign
DisableKeysForKbCheck('empty'); % enable all keys

% get to checking
while (GetSecs - stimonset) <= settings.duration.stimulus

     % check
    [keytoggle, endtime, keycode] = KbCheck;

    % classify
    if keycode(settings.keys.left)==1
        rdir = 1;
        DisableKeysForKbCheck(find(keycode)); % disable key
        RT = endtime - stimonset;
        break
    elseif keycode(settings.keys.right)==1
        rdir = 2;
        DisableKeysForKbCheck(find(keycode)); % disable key
        RT = endtime - stimonset;
        break
    end

    WaitSecs(0.001); % prevent overload
    
end
if settings.eeg == 1; EEGtrigger(3); end