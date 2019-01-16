function [videocue,hapticcue] = MMS4_cues(settings,trialseq,it)

id = MMS4_columns;

% audio
if trialseq(it,id.odd_a) == 1
    wavdata = settings.sound.novelsounds{sum(trialseq(1:it,id.odd_a))}';
else wavdata = settings.sound.standardsound;
end
PsychPortAudio('FillBuffer', settings.sound.audiohandle, wavdata);
    
% video
if trialseq(it,id.odd_v) == 1
    % color
    r1 = randperm(length(settings.layout.color.options)-1);
    colors = 2:length(settings.layout.color.options);
    color = colors(r1(1));
    % symbol
    r1 = randperm(9);
    symbols = 1:9;
    symbol = symbols(r1(1));
else    color = 1; % green
        symbol = 10; % circle
end
videocue = MMS4_makevisualcue(settings,symbol,color);
%videocue = ['DrawFormattedText(settings.screen.outwindow,' char(39) '+' char(39) ',' char(39) 'center' char(39) ',' char(39) 'center' char(39) ', [' num2str(FC) ']);'];

% haptic
if trialseq(it,id.odd_h) == 1
    hapticcue = 'fast';
else hapticcue = 'slow';
end