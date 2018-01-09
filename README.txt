Recurrent Neural Network (RNN) Open Source Code

This program trains and analyzes recurrent neural networks (RNNs) as well as non-recurrent feedforward networks.

ARCHITECTURE:
The number of input units in the network is defined by the number of data channels (number of input vectors) while the number of output units is fixed to one. The user may define both the number of hidden layers as well as the number of hidden units per layer. The context units are fixed, as each hidden unit has an associated context unit. The network is updated through backpropagation through time (BPTT) with a maximum memory defined by the user to conserve computational resources. The user may also define other parameters such as the iterations per training sample, learning rate, and others in Main.m.

This program works for both recurrent and non-recurrent networks, and any number of different neural network architectures can be tested at once. The program is automatically formatted for parallel processing across computer cores.

HOW TO USE:

1. Download all of the MATLAB files.

NOTE: The only modification to the source code required by the user is as follows. FeatureExtraction.m contains code for pre-processing the input data. If pre-processing code is NOT required, please follow the directions present in the comments of the source code. If pre-processing IS required, the desired pre-processing code can be inserted in the specified location. Once these modifications are complete, no further coding is required by the user.

2. Open RNN.mlapp to setup experiments.
	- Specify the name of the file containing the training data file (see NOTE below for correct file format -- .txt files only).
	- Specify the name of the file containing additional data for testing the network with the same format as the training data.
	- Specify the number of neural networks to test.
	- For each network, specify the parameters:
		- Iterations per training sample
		- Memory length (# of training datapoints) for BPTT algorithm
			- "1" for feedforward layered network WITHOUT backpropagation
			- >1 for a recurrent network WITH backpropagation
			(i.e. for ML = 5, data will backpropagate through 5 samples)
		- Number of hidden layers
		- Units per hidden layer.
	- For all networks, specify the threshold steepness (default 1).
	- For all networks, specify the learning rate (default 0.05).
	
3. Run the program. The MATLAB command window displays number of trials remaining as well as time remaining per trial. Note that although the source code contains 'waitbar' capability, parallel processing in MATLAB currently does not allow for this graphical interface.

4. The program will produce four graphs:
	- Network outputs vs. target outputs during training (Figure 1)
	- Change in selected hidden unit weights over time (Figure 2)
	- Change in selected context unit weights over time (Figure 3)
	- Network outputs vs. target outputs after training (Figure 4).
The name of each figure specifies the neural network architecture used to generate the data in the figure, and each figure is stored in the folder containing the downloaded source code.

NOTE:

The data matrices should be formatted as follows:
ROW1 (input vector) --->
.
.
.
RowN (input vector) --->
Row(N+1) (output vector) --->
