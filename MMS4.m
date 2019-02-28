
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MMS4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Jan R. Wessel, University of Iowa, January 2016
%   Email: jan-wessel@uiowa.edu / www.wessellab.org
%
%   Psychtoolbox 3.0.12 / Matlab 2015a
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initiate
addpath(genpath(fileparts(which('MMS4.m'))));
addpath(genpath('/home/guest/Documents/MATLAB/eeg/shared/handles'));clc; clear;

% Subject info
data = MMS4_data;

% Initialize
settings = MMS4_initialize(data);

% Experiment
MMS4_backend(settings,data);

% Outro
MMS4_outro(settings);