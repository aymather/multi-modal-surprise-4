% Vibrates the response handles
%   Jan R Wessel 2016, www.wessellab.org
% Usage:
%   startttime = vibrate_handle(daq, onoff, side, speed)
% Inputs:
%   daq (int) = daq number from DaqDeviceIndex
%   onoff (bool) = 1: vibration on, 2: all vibration off
%   side (str) = 'left', right', 'both'
%   speed (str) = 'slow', 'fast'
% Connectors on DAQ:
%   21: Fast left (Port A, Pin 0)
%   22: Slow left (Port A, Pin 1)
%   32: Fast right (Port B, Pin 0)
%   33: Slow right (Port B, Pin 1)
%   29: Common ground
function starttime = vibrate_handle(daq, onoff, side, speed)

% checkarg
if exist('side','var') && sum(strcmpi({'left','right','both'},side))==0
    error(['Side option ' side ' not recognized.']);
end
if exist('speed','var') && sum(strcmpi({'fast','slow','both'},speed)) == 0
    error(['Speed option ' speed ' not recognized.']);
end

% constants
portA = 0;
portB = 1;

% Config both Digital IO ports for outputs
DaqDConfigPort(daq, portA, 0);
DaqDConfigPort(daq, portB, 0);

% Flip appropriate pin
if ~onoff
    DaqDOut(daq, portA, '00000000'); % reset all
    DaqDOut(daq, portB, '00000000'); % reset all
else
    % Speed
    if strcmpi(speed,'slow'); pin = 1;
    elseif strcmpi(speed,'fast'); pin = 0;
    else % both
        pin = log(3)/log(2);
    end
    % Write pin to port(s)
    if strcmpi(side,'left')
        DaqDOut(daq, portA, 2^pin);
    elseif strcmpi(side,'right')
        DaqDOut(daq, portB, 2^pin);
    else % both
        DaqDOut(daq, portA, 2^pin);
        DaqDOut(daq, portB, 2^pin);
    end
end

% output
starttime = GetSecs;