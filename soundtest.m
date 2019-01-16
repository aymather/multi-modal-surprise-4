settings.sound.srate = 44100;
settings.sound.duration = .2;
settings.sound.standardfreq = 600;
InitializePsychSound(1);
settings.sound.audiohandle = PsychPortAudio('Open', [], [], 0, settings.sound.srate, 1);
asamples = 0:1/settings.sound.srate:settings.sound.duration;
settings.sound.standardsound = sin(2* pi * settings.sound.standardfreq * asamples);
wavdata = settings.sound.standardsound; % fill soundbuffer
PsychPortAudio('FillBuffer', settings.sound.audiohandle, wavdata);
PsychPortAudio('Start', settings.sound.audiohandle, 1, 0, 1);
WaitSecs(.5);
PsychPortAudio('Close');