function id = MMS4_columns(verbose)

if nargin < 1; verbose = 0; end

if verbose == 0
    id.num = 1;
    id.blo = 2;
    id.odd_v = 3;
    id.odd_a = 4;
    id.odd_h = 5;
    id.dir = 6;
    id.rt = 7;
    id.rdir = 8;
    id.acc = 9;
    id.time = 10;
    id.iti = 11;
else
    id.num = 1; disp('id.num = 1: trialnum');
    id.blo = 2; disp('id.blo = 2; blocknum');
    id.odd_v = 3; disp('id.odd_v = 3; oddball visual (0/1)');
    id.odd_a = 4; disp('id.odd_a = 4; oddball audio (0/1)');
    id.odd_h = 5; disp('id.odd_h = 5; oddball haptic (0/1)');
    id.dir = 6; disp('id.dir = 6; direction (1-left, 2-right)');
    id.rt = 7; disp('id.rt = 7; rt');
    id.rdir = 8; disp('id.rdir = 8; response direction');
    id.acc = 9; disp('id.acc = 9;   accuracy, 1=cor go,2=err,99=miss');
    id.time = 10; disp('id.time = 10; trial time');
    id.iti = 11; disp('id.iti = 11; iti');
end