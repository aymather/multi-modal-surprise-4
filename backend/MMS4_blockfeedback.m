function MMS4_blockfeedback(settings,trialseq,it)

% columns
id = MMS4_columns;

% shorten
OW = settings.screen.outwindow;
OWD = settings.screen.outwindowdims;
COL = settings.layout.color.fixation;
SIZ = settings.layout.size.intro;

if it == size(trialseq,1) || trialseq(it,id.blo) ~= trialseq(it+1,id.blo)
    
    % set font size
    Screen('TextSize',settings.screen.outwindow,settings.layout.size.intro);
    
    % make trials
    blocktrials = trialseq(trialseq(:,id.blo) == trialseq(it,id.blo),:);

    % VERBAL
    cortrials = blocktrials(blocktrials(:,id.acc)==1,:);
    errtrials = blocktrials(blocktrials(:,id.acc)==2,:);
    misstrials = blocktrials(blocktrials(:,id.acc)==99,:);

    % get verbal parameters
    gort = round(mean(cortrials(:,id.rt)));

    % disp
    DrawFormattedText(OW, ['Reaction time: ' num2str(gort*1000) ' ms'], 'center', 4.5*SIZ, COL); % set text
    DrawFormattedText(OW, ['Errors: ' num2str(size(errtrials,1))], 'center', 5.5*SIZ, COL); % set text
    DrawFormattedText(OW, ['Misses: ' num2str(size(misstrials,1))], 'center', 6.5*SIZ, COL); % set text

    % GENERAL DISPLAY
    DrawFormattedText(OW, 'Last block:', 'center', 2*SIZ, COL); % set text
    if it == size(trialseq,1)
        DrawFormattedText(OW, 'Thank you for your participation!', 'center', 1*SIZ, [255 255 255]); % set text
    else
        DrawFormattedText(OW, ['You can take a break now (Block ' num2str(trialseq(it,id.blo)) '/' num2str(trialseq(end,id.blo)) ')'], 'center', 1*SIZ, [255 255 255]); % set text
    end    
    DrawFormattedText(OW, 'Press any key to continue...', 'center', OWD(4)-2*SIZ, COL); % set text
    
    Screen('Flip', OW); % update screen
    % wait
    WaitSecs(1); KbWait(-1); 
   
    % count back in (resets font also)
    MMS4_intro(settings,trialseq,it);
    
end