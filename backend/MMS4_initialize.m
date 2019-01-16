function settings = MMS4_initialize(data)

% testmode (no vibration)
settings.testmode = 0;

% eeg
if data.eeg == 1; EEGtrigger(0); settings.eeg = 1; else settings.eeg = 0; end

% reset rng
rng(sum(100*clock),'twister');

% handles
if settings.testmode == 0; settings.daq = DaqDeviceIndex; end

% trialnumbers
if data.training == 0
    settings.general.odd_v = 4; % per block
    settings.general.odd_a = 4; % per block
    settings.general.odd_h = 4; % per block
    settings.general.sta = 48; % per block
    settings.general.blocks = 4;
else 
    settings.general.odd_v = 0; % per block
    settings.general.odd_a = 0; % per block
    settings.general.odd_h = 0; % per block
    settings.general.sta = 10; % per block
    settings.general.blocks = 1;
end

% stimuli
settings.layout.size.fixation = 150;
settings.layout.size.intro = 40;
settings.layout.size.arrows = 150;
settings.layout.color.fixation = [255 255 255];
settings.layout.color.arrows = [255 255 255];
settings.layout.color.intro = [255 255 255];
settings.layout.color.options = [0 255 0; 255 0 0; 0 0 255; 255 255 0; 255 0 255; 0 255 255; ...
              255 127 0; 127 255 0; 127 0 255; 255 255 127; 255 127 255; 127 255 255; ...  
              255 0 127; 0 255 127; 0 127 255]; % green = 1

% durations
settings.duration.fixation = .5;
settings.duration.vibration = .3;
settings.duration.cue = .5; % difference between cue ONSET and stimulus ONSET
settings.duration.stimulus = 1;
settings.duration.slowfb = 1;
settings.duration.trial = 2.5;
settings.duration.ITIjitter = [100 200 300 400 500];

% folders and files
settings.files.outfolder = fullfile(fileparts(which('MMS3.m')),'out',filesep);
clocktime = clock; hrs = num2str(clocktime(4)); mins = num2str(clocktime(5));
settings.files.outfile = ['Subject_' num2str(data.Nr) '_' date '_' hrs '.' mins 'h.mat'];

% sounds
settings.sound.srate = 44100;
settings.sound.duration = .2;
settings.sound.standardfreq = 600;
InitializePsychSound(1);
settings.sound.audiohandle = PsychPortAudio('Open', [], [], 0, settings.sound.srate, 1);
asamples = 0:1/settings.sound.srate:settings.sound.duration;
settings.sound.standardsound = sin(2* pi * settings.sound.standardfreq * asamples);
load(fullfile(fileparts(which('MMS3.m')),'backend','novelsounds.mat'));
settings.sound.novelsounds = novelsounds;

% screen
screens = Screen('Screens');
settings.screen.Number = max(screens);
[settings.screen.outwindow, settings.screen.outwindowdims] = Screen('Openwindow',settings.screen.Number, 0); % make screen, black bg
Priority(MaxPriority(settings.screen.outwindow)); % prioritize

% psychtoolbox initialize
HideCursor; ListenChar(2); % hide cursor
KbName('UnifyKeyNames'); % unify keyboard
KbCheck; WaitSecs(0.1); GetSecs; % dummy calls

% testmode responses
settings.keys.left = KbName('q');
settings.keys.right = KbName('p');

% prepare fonts
Screen('TextFont',settings.screen.outwindow,'Helvetica'); % arial
Screen('TextStyle', settings.screen.outwindow, 0); % make normal

% stimuli
settings.stimuli.right = ['Screen(' char(39) 'FillPoly' char(39) ', settings.screen.outwindow ,settings.layout.color.arrows, [settings.screen.outwindowdims(3)/2 settings.screen.outwindowdims(4)/2+settings.layout.size.arrows/3; settings.screen.outwindowdims(3)/2 settings.screen.outwindowdims(4)/2-settings.layout.size.arrows/3 ; settings.screen.outwindowdims(3)/2+settings.layout.size.arrows/2 settings.screen.outwindowdims(4)/2]); ' ...
        'Screen(' char(39) 'FillPoly' char(39) ', settings.screen.outwindow ,settings.layout.color.arrows, [settings.screen.outwindowdims(3)/2-settings.layout.size.arrows/2 settings.screen.outwindowdims(4)/2-settings.layout.size.arrows/6; settings.screen.outwindowdims(3)/2-settings.layout.size.arrows/2 settings.screen.outwindowdims(4)/2+settings.layout.size.arrows/6; settings.screen.outwindowdims(3)/2 settings.screen.outwindowdims(4)/2+settings.layout.size.arrows/6; settings.screen.outwindowdims(3)/2 settings.screen.outwindowdims(4)/2-settings.layout.size.arrows/6;]); '];
settings.stimuli.left = ['Screen(' char(39) 'FillPoly' char(39) ', settings.screen.outwindow ,settings.layout.color.arrows, [settings.screen.outwindowdims(3)/2 settings.screen.outwindowdims(4)/2+settings.layout.size.arrows/3; settings.screen.outwindowdims(3)/2 settings.screen.outwindowdims(4)/2-settings.layout.size.arrows/3 ; settings.screen.outwindowdims(3)/2-settings.layout.size.arrows/2 settings.screen.outwindowdims(4)/2]); '...
        'Screen(' char(39) 'FillPoly' char(39) ', settings.screen.outwindow ,settings.layout.color.arrows, [settings.screen.outwindowdims(3)/2+settings.layout.size.arrows/2 settings.screen.outwindowdims(4)/2-settings.layout.size.arrows/6; settings.screen.outwindowdims(3)/2+settings.layout.size.arrows/2 settings.screen.outwindowdims(4)/2+settings.layout.size.arrows/6; settings.screen.outwindowdims(3)/2 settings.screen.outwindowdims(4)/2+settings.layout.size.arrows/6; settings.screen.outwindowdims(3)/2 settings.screen.outwindowdims(4)/2-settings.layout.size.arrows/6;]); '];