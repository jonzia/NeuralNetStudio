% Feature Extraction for Neural Network Training
% Created by: Jonathan Zia
% Emory University / Georgia Institute of Technology
% Last Edited: Monday, January 8, 2018

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
% If pre-processing of data is required, please write/insert code here.
% Else, simply comment out the TEMPORARY EXAMPLE code.



% Once the data is processed, place the data in matrix D, which has the
% same format shown in the README file.
D = D_0;
% End USER-DEFINED DATA PROCESSING

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% TEMPORARY EXAMPLE
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% The code below is a temporary example: the network is trained to accept
% three random input vectors and converge to a fixed output of 0.5
D = zeros(4,1000); % Defining matrix D
D(1:3,:) = rand(3,1000); % Generating random inputs
for i = 1:1000
    D(4,i) = 0.5; % Generating fixed output
end
% End TEMPORARY EXAMPLE


% Assembling data matrix for neural network training
dSize = size(D);
temp1 = dSize(1,1)-1; temp2 = dSize(1,1);
tInputs = D(1:temp1,:);       % Training inputs
tOutputs = D(temp2,:);        % Training outputs
iSize = size(tInputs);