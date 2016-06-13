% Analyzing the Effectiveness of the LRN
% Created by: Jonathan Zia
% Center for Cognitive Ubiquitous Computing, Arizona State University
% Last Edited: Wednesday, March 9, 2016

% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% THIS FILE IS CALLED BY THE FOLLOWING SCRIPT:
% Main.m through trialR02.m

% This program utilizes the neural network trained in
% ModElmanNetwork_parfor.m in order to determine the capability of this
% network to predict phenomena. The outputs of this program are
% plots featuring the results of training the Elman Network as well as a
% quantification of the accuracy of the neural network.
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

% The array outputs_1 from ModElmanNetwork_parfor.m contains the outputs of
% the neural network after each training event in the first row. In the
% second row are the training outputs. The arrays outputs_2 and outputs_3
% contain a sampling of the hidden and context weight values respectively
% after each training event. Finally, the array output_4 contains the
% values of the hidden weights in the final layer after each training
% event. These arrays will be used to determine convergence.

% The first part of this program will be used to analyze the neural network
% trained in ElmanNetwork_parfor.m, specifically to see whether the network
% outputs approached the training outputs over time and whether the network
% weights were able to converge to the proper values.
dSample = UDP;

% Plotting training outputs vs. network outputs
figure(1)
hold on
plot(outputs_1(1,:),'-k')
plot(outputs_1(2,:),'-r')
hold off
grid on
title('Training Outputs vs. Network Outputs');
xlabel('Sample'); ylabel('Value');
legend('Training Outputs','Network Outputs');

% Saving Figure 1
s1 = int2str(T);
s2 = int2str(f);
s3 = int2str(dSample);
s4 = int2str(layers);
s5 = int2str(num_hidden);
fileName = ['Fig1T' s1 'f' s2 'D' s3 'N' s4 'M' s5 '.fig'];
savefig(fileName);

% Plotting hidden weights over time
figure(2)
hold on
counter = 1; temp = zeros(1,tSize(1,2));
for m = 1:num_hidden
    for l = 1:layers
        temp(1,:) = outputs_2(m,l,:);
        subplot(num_hidden,layers,counter);
        plot(temp)
        counter = counter + 1;
    end
end
hold off

% Saving Figure 2
fileName = ['Fig2T' s1 'f' s2 'D' s3 'N' s4 'M' s5 '.fig'];
savefig(fileName);

% Plotting context weights over time
figure(3)
hold on
counter = 1; temp = zeros(1,tSize(1,2));
for m = 1:num_hidden
    for l = 1:layers
        temp(1,:) = outputs_3(m,l,:);
        subplot(num_hidden,layers,counter);
        plot(temp)
        counter = counter + 1;
    end
end
hold off

% Saving Figure 3
fileName = ['Fig3T' s1 'f' s2 'D' s3 'N' s4 'M' s5 '.fig'];
savefig(fileName);

% The second part of this program will feed a second training set into the
% neural network and test the accuracy of the neural network.
% As FeatureExtraction)parfor.m is run immediately before this script, the
% relevant variables are tInputs, tOutputs, W, H, num_inputs, layers,
% num_hidden, k.

% Collecting network outputs for a new data set after training
FoG_out = zeros(1,iSize(1,2));

Y = zeros(layers,num_hidden,2);
X = zeros(num_inputs,1);

for i = 1:iSize(1,2)
    X(:,1) = tInputs(:,i);
    for l = 1:layers
        if l == 1
            for m = 1:num_hidden
               temp = dot(X(:,1),W(1:num_inputs,m,l)) + dot(Y(l,:,2),H(:,m,l));
               Y(l,m,1) = 1/(1 + exp(-k*temp));
            end
        else
            for m = 1:num_hidden
               temp = dot(Y(l-1,:,1),W(:,m,l)) + dot(Y(l,:,2),H(:,m,l));
               Y(l,m,1) = 1/(1 + exp(-k*temp));   
            end
        end
    end
    temp = dot(Y(layers,:,1),W0(:,1));
    FoG_out(1,i) = 1/(1 + exp(-k*temp));
    Y(:,:,2) = Y(:,:,1);
end

% Plotting the results
figure(4)
title('Network Outputs After Training');
xlabel('Sample'); ylabel('Value');
hold on
plot(tOutputs,'-k')
plot(FoG_out,'-r')
hold off
grid on
legend('Desired Outputs','Network Outputs');

% Saving Figure 4
fileName = ['Fig4T' s1 'f' s2 'D' s3 'N' s4 'M' s5 '.fig'];
savefig(fileName);