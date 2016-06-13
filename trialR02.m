% Function: Calling Scripts for Independent Neural Network Trials
% Created by: Jonathan Zia
% Center for Cognitive Ubiquitous Computing, Arizona State University
% Last Edited: Wednesday, March 9, 2016

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% THIS FILE CALLS THE FOLLOWING SCRIPTS:
% FeatureExtract.m
% ModElmanNetwork_parfor.m
    % loadValues.m
    % ModFeedforward_R02.m
    % ModBackpropagation_R02.m
    % ModWeights_R02.m
    % Shift.m
% ModFOGPredict_parfor.m

% This function is nested within the parfor loop of PDGAIT_parfor.m and
% serves to implement each trial based on the variables inputted from
% PDGAIT_parfor.m. A function is needed due to the nature of parallel
% processing in MATLAB, as this code was initially located within the
% previous iterations of PDGAIT and has not otherwise been modified.

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

function trialR02(loop_1,k,n,parameters,parameters_size,Accuracy)

    UDP = parameters(loop_1,3);             % Defining UDP
    % Inputting the training data and extracting desired parameters:
    % Specify input file name
    DataInput = 'S01R01.txt';
    FeatureExtract

    % Training the Elman Network:
        % Neural network settings
        T = parameters(loop_1,1);          % Number of iterations per training sample
        f = parameters(loop_1,2);          % Defining frame length for neural network memory
        num_hidden = parameters(loop_1,5); % Defining number of hidden units per layer
        layers = parameters(loop_1,4);     % Defining number of layers in neural network
    ModElmanNetwork_parfor

    % Analyzing the effectiveness of the Elman Network in predicting FOG:
        % Inputting the experimental data and extracting desired parameters:
        % Specify input file name
        DataInput = 'S01R02.txt';
        FeatureExtract
        % Specify number of weights to plot (must have integer square root)
        num_plots = num_hidden^2;
    ModFOGPredict_parfor

end
