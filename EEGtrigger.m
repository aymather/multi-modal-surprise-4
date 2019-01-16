function EEGtrigger(trigger)
% Jan R Wessel 2016
% Needs pp.m and compiled ppmex.mex64 (compiled from ppmex.c) in matlab path
% I made several changes to these files to make them work, so keep them
% together with this file!
bintrigger = dec2bin(trigger,8); % convert trigger into binary with at least 9 bits
thebyte = logical(bintrigger(:)'-'0'); % convert to byte

pp(uint8(1:9),[false fliplr(thebyte)],false,'parport0',uint64(888));
pp(uint8(1:9),zeros(1,9),false,'parport0',uint64(888));