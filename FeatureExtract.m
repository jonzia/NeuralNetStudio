% Feature Extraction for Neural Network Training
% Created by: Jonathan Zia
% Center for Cognitive Ubiquitous Computing, Arizona State University
% Last Edited: Wednesday, March 9, 2016

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% THIS FILE IS CALLED BY THE FOLLOWING SCRIPT:
% Main.m through trialR02.m

% This program inputs the training dataset and performs the
% desired feature extraction. The output of this program is a variable
% number of time series, each of which contains the value of one parameter
% over the desired timeframe. This data is then used to train the neural
% network found in ModElmanNetwork_parfor.m.
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

% Import data file
D_0 = importdata(DataInput);

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% USER-DEFINED DATA PROCESSING
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

% End USER-DEFINED DATA PROCESSING

% Once the data is processed, it is placed in the matrix D
% Temporary Example:
D = zeros(4,1000);
D(1:3,:) = rand(3,1000);
for i = 1:1000
    D(4,i) = D(1,i)*D(2,i)*D(3,i);
end
dSize = size(D);

% Assembling data matrix for neural network training
tInputs = D(1:3,:);       % Training inputs
tOutputs = D(4,:);      % Training outputs
iSize = size(tInputs);