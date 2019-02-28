function MMS4_cuedisplay(settings,trialseq,videocue,it,id)

% cue: video
eval(videocue); cuetime = Screen('Flip', settings.screen.outwindow); % display cue

% cue: audio
PsychPortAudio('Start', settings.sound.audiohandle, 1, 0, 1); % play audio

if settings.eeg == 1; EEGtrigger(1); end

% cue: vibration
offset = .02;
if trialseq(it,id.odd_h) == 1
    vibrate_handle(settings.daq, 1, 'both', 'fast'); % vibration on, vibrate both motors to begin with to account for long ramp-up time for left slow motor
    WaitSecs(offset); % Wait 10 ms, then turn off fast
    vibrate_handle(settings.daq, 1, 'both', 'slow'); % now the actual differential vibration slow / fast
    WaitSecs(settings.duration.vibration - offset);
    vibrate_handle(settings.daq, 0); % vibration off
end

% wait cue interval
while GetSecs - cuetime < settings.duration.cue; WaitSecs(.0001); end