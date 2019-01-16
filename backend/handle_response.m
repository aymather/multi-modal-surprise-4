% Collect response from handle
%   Jan R Wessel 2016, www.wessellab.org
% Usage:
%   startttime = handle_response(daq, onoff, side, speed)
% Inputs:
%   daq (int) = daq number from DaqDeviceIndex
%   ms (int) = record for how long? (ms)
% Outputs:
%   RT (int) = RT in ms
%   Resp (int) = 1: left handle, 2 = right handle
%   traces (ms x 2 matrix) = raw traces from both handles
% Connectors on DAQ:
%   1: Left handle
%   2: Right handle
% Needs:
%   % DaqAInScanJRW, which is the original PTB function, edited for compatibility with R2015a; where bitcmp doesn't work
function [RT,Resp,traces] = handle_response(daq,ms)

% settings
DAQoptions.channel = [8 9]; % 8 = single pin A0 (#1), 9 = single pin A1 (#2)
DAQoptions.srate = 1000; % sampling rate 1000 Hz
DAQoptions.range = ones(size(DAQoptions.channel)); % default gain
DAQoptions.count = ms; % actually DAQoptions.srate/1000 * ms; but for 1000Hz this is faster
DAQoptions.ms = ms;

% begin scan
DAQoptions.begin = 1;
DAQoptions.continue = 0;
DAQoptions.end = 0;
DaqAInScanJRW(daq,DAQoptions);

% scan
DAQoptions.continue = 1; DAQoptions.begin = 0;
starttime = GetSecs;
while GetSecs - starttime < ms/1000    
    DaqAInScanJRW(daq,DAQoptions);
end
% end scan
DAQoptions.continue = 0; DAQoptions.end = 1;
traces = DaqAInScanJRW(daq,DAQoptions);

% compute RT
leftr = find(traces(:,1)>1,1,'first');
rightr = find(traces(:,2)>1,1,'first');
if isempty(leftr) && isempty(rightr)
    RT = 0; Resp = 0;
elseif ~isempty(leftr) && ~isempty(rightr)
    [RT,Resp] = min([leftr rightr]);
elseif ~isempty(leftr)
    RT = leftr; Resp = 1;
elseif ~isempty(rightr)
    RT = rightr; Resp = 2;
end