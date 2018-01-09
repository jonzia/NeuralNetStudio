% Open-Source Recurrent Neural Network (RNN) for App Designer
% Created By: Jonathan Zia
% Emory University / Georgia Institute of Technology
% Last Edited: Monday, January 8th, 2018

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% THIS FILE CALLS THE FOLLOWING SCRIPTS:
% trialR02.m, which calls:
% FeatureExtract.m
% ModElmanNetwork_parfor.m
    % loadValues.m
    % ModFeedforward_R02.m
    % ModBackpropagation_R02.m
    % ModWeights_R02.m
    % Shift.m
% ModFOGPredict_parfor.m

% This program trains RNNs with architectures partially defined by the
% user. Two datasets are required: one dataset to train the networks and
% another to analyze their effectivenss. Though this program is designed
% with the capability to analyze any number of recurrent networks with the
% same dataset, it may also be used to train and analyze a single network
% as well, with or without recurrent capabilities.

% Please see the README file for more information on the RNN architecture.

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

% Each row in the following matrix represents a different neural network
% architecture to be tested (different trials). Each column represents a
% different parameter that may be adjusted by the user. (1) T, number of
% iterations per training sample, (2) f, memory length of RNN, (3) [extra
% parameter: may be set by the user for data formatting in
% FeatureExtract.m, (4) n, hidden layers, (5) m, units per hidden layer.
parameters = app.UITable.Data;
parameters_size = size(parameters);
parameters = [parameters(:,1:2) ones(parameters_size(1,1),1) parameters(:,3:4)];
    %10 100 1 1 3;
    %100 1 1 1 5;
    %10 100 1 3 3;
% In the above examples, the first row represents a RNN with 10 iterations
% per training sample (beware of overfitting), 100 samples of memory, the
% user-defined parameter (UDP) set to 1, 1 hidden layer, and 3 units in the
% hidden layer. The second row represents a non-recurrent network with a
% slightly different architecture, while the third row represents an RNN
% with a more complex architecture.

parameters_size = size(parameters);
k = app.ThresholdSteepness.Value;      % Threshold steepness (default = 1)
n = app.LearningRate.Value;   % Network learning rate (default = 0.05)

tData = fullfile(app.TrainingData.Value);
eData = fullfile(app.ExperimentalData.Value);

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% Network Training and Analysis
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
parfor loop_1 = 1:parameters_size(1,1)    % Changing trial number
 
    trialR02(loop_1,k,n,parameters,tData,eData)
    
end

disp('$$$ Get Money $$$')