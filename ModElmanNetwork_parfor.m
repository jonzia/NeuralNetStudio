% Modified Elman Network for FoG Prediction (Rev 02)
% Created by: Jonathan Zia
% Center for Cognitive Ubiquitous Computing, Arizona State University
% Last Edited: Wednesday, March 9, 2016

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% THIS FILE CALLS THE FOLLOWING SCRIPTS:
% loadValues.m
% ModFeedforward_R02.m
% ModBackpropagation_R02.m
% ModWeights_R02.m
% Shift.m

% THIS FILE IS CALLED BY THE FOLLOWING SCRIPT:
% Main.m through trialR02.m

% Once training data is extracted from the training dataset,
% the data is then used to train a recurrent neural network using the
% Elman LRN architecture.

% The current design of the network utilizes L input units and N layers of
% M hidden units. Each hidden unit layer has one context unit layer with
% fixed weight one. All other weights are adjusted by backpropagation.
% There is one output unit; the output unit is trained to output a value
% between 0 and 1. The L inputs to the network are based on the dataset
% being imported.
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

% Training data sets from FeatureExtraction.m
tSize = size(tInputs);

% Initializing input units
num_inputs = tSize(1,1);
X = zeros(num_inputs,f);

% Initializing hidden units
Y = zeros(layers,num_hidden,f);  % Hidden Nodes

% Throwing an error if # input units > # hidden units per layer
if num_inputs > num_hidden
    error('Number of hidden units does not exceed number of input units.');
end

% Initializing weight matrices
W = 0.05*rand(num_hidden,num_hidden,layers);
W(num_inputs+1:end,:,1) = 0;    % Zeroing unused weights in input layer
W0 = 0.05*rand(num_hidden,1);
% The weight matrix is defined as follows: Each column contains the set of
% weights that originate from different input nodes and point to the same
% output node. For example, if there are 3 input nodes and 3 hidden nodes,
% the first column would contain the weights W1, W4, and W7, all of which
% originate from each of the three input nodes and point towards the same
% hidden node Y1. The matrix W0 the set of weights that point from the
% hidden nodes Y to the output node. Since there should be more hidden
% units per row than input units, some of the weights in the weight matrix
% will not be used.
H = 0.05*rand(num_hidden,num_hidden,layers);
% This matrix is analogous to the previous ones, however contains the
% weights originating from the context nodes and pointing toward the hidden
% nodes via the Elman feedback architecture.

% Neural network settings
o = zeros(1,f);                         % Initializing output vector (o(t))
targets = zeros(1,f);                   % Initializing target output vector
d_k = zeros(1,f);                       % Initializing output unit error term
d_h_w = zeros(layers,num_hidden,f);     % Initializing hidden unit error terms
d_h_h = zeros(layers,num_hidden,f-1);   % Initializing context unit error terms
outputs_1 = zeros(2,tSize(1,2));        % Initializing matrix for analysis of network output
outputs_2 = zeros(num_hidden,layers,tSize(1,2)); % Initializing matrix for analysis of hidden weights
outputs_3 = zeros(num_hidden,layers,tSize(1,2)); % Initializing matrix for analysis of context weights
outputs_4 = zeros(num_hidden,tSize(1,2));        % Initializing matrix for analysis of output weights

% Training the neural network
h = waitbar(0,'Network Training Progress'); % Initializing the progress bar
tic; % Logging the start time of the training (this may take a while)
for i = 1:tSize(1,2) % Main loop
    tic;
    % Loading values into input and target vectors
    loadValues
    
    for z = 1:T % Iterating T times per training sample
        % FEEDFORWARD COMPONENT
        ModFeedforward_R02
        % BACKPROPAGATION THROUGH TIME
        ModBackpropagation_R02
        % UPDATING WEIGHTS
        ModWeights_R02
    end % End iterative loop
    
    % Collecting data for analysis in ModFogPredict
    outputs_1(1,i) = o(1,1);
    outputs_1(2,i) = targets(1,1);
    for m = 1:num_hidden
        for l = 1:layers
            outputs_2(m,l,i) = W(m,m,l);    % Sampling diagonal weight values
            outputs_3(m,l,i) = H(m,m,l);    % Sampling diagonal weight values
        end
    end
    outputs_4(:,i) = W0(:,1);
    
    % Shifting input and target values
    Shift
    time = toc;
    
    % Printing progress
    clc
    prog = i/tSize(1,2);
    waitbar(prog,h)
    timeRemaining = round(time*(tSize(1,2)-i)/60);
    if timeRemaining >= 2
        TimeRemaining = ['Time Remaining: ' int2str(timeRemaining) ' minutes for trial ' int2str(loop_1)]
    else
        timeRemaining = round(time*(tSize(1,2)-i));
        TimeRemaining = ['Time Remaining: ' int2str(timeRemaining) ' seconds for trial ' int2str(loop_1)]
    end
    TrialsRemaining = ['Trials Remaining: ' int2str(parameters_size(1,1)-loop_1)]
    
end % End main loop
toc;
close(h)
