function [trialseq,traces] = MMS4_backend(settings,data)

% shorthands
FC = settings.layout.color.fixation;
OW = settings.screen.outwindow;

% columns
id = MMS4_columns;

% sequence
trialseq = MMS4_sequence(settings);

% prepare first cues
[videocue,hapticcue] = MMS4_cues(settings,trialseq,1);

% response traces
traces = zeros(size(trialseq,1),settings.duration.stimulus*1000,2);

% intro
MMS4_intro(settings,trialseq,1);

% trial loop
for it = 1:size(trialseq,1)
    
    % log time
    if it == 1; begintime = GetSecs; end
    trialseq(it,id.time) = GetSecs - begintime;
    
    % fixation
    DrawFormattedText(OW, '+', 'center', 'center', FC);
    trialstart = Screen('Flip', OW);
    WaitSecs(settings.duration.fixation);
    
    % cue
    MMS4_cuedisplay(settings,trialseq,videocue,it,id);
    
    % stimulus
    if trialseq(it,id.dir) == 1; eval(settings.stimuli.left); else eval(settings.stimuli.right); end
    Screen('Flip', OW); % update screen
    if settings.eeg == 1; EEGtrigger(2); end
    
    % response
    if settings.testmode == 1
         [trialseq(it,id.rt),trialseq(it,id.rdir)] = MMS3_manualresponse(settings);
    else [trialseq(it,id.rt),trialseq(it,id.rdir),traces(it,:,:)] = handle_response(settings.daq,settings.duration.stimulus*1000);
    end
    if trialseq(it,id.rdir) == 0; trialseq(it,id.acc) = 99; else if trialseq(it,id.rdir) == trialseq(it,id.dir); trialseq(it,id.acc) = 1; else trialseq(it,id.acc) = 2; end; end
    
    % missfb / fixation
    if trialseq(it,id.rdir) == 0
        DrawFormattedText(OW, 'TOO SLOW!', 'center', 'center', [255 0 0]); Screen('Flip', OW);
        WaitSecs(settings.duration.slowfb);
    end
    DrawFormattedText(OW, '+', 'center', 'center', FC); Screen('Flip', OW);
    
    % prep next stimulus
    if it < size(trialseq,1); [videocue,hapticcue] = MMS4_cues(settings,trialseq,it+1); end
    
    % save
    save(fullfile(settings.files.outfolder,settings.files.outfile),'trialseq','settings','data');
    
    % iti
    ITI = (settings.duration.trial - (GetSecs - trialstart) + trialseq(it,id.iti)/1000);
    WaitSecs(ITI);
    
    % blockfeedback
    MMS4_blockfeedback(settings,trialseq,it);
    
end

% fullsave
save(fullfile(settings.files.outfolder,settings.files.outfile),'trialseq','settings','traces','data');