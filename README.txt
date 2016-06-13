Recurrent Neural Network (RNN) Open Source Code

This program trains and analyzes recurrent neural networks (RNNs) as well as non-recurrent feedforward networks.

ARCHITECTURE:
The number of input units in the network is defined by the number of data channels (number of input vectors) while the number of output units is fixed to one. The user may define both the number of hidden layers as well as the number of hidden units per layer. The context units are fixed, as each hidden unit has an associated context unit. The network is updated through backpropagation through time (BPTT) with a maximum memory defined by the user to conserve computational resources. The user may also define other parameters such as the iterations per training sample, learning rate, and others in Main.m.

This program works for both recurrent and non-recurrent networks, and any number of different neural network architectures can be tested at once. The program is automatically formatted for parallel processing across computer cores.

HOW TO USE:

1. Open all of the MATLAB files.

2. In Main.m, specify the neural network architecture(s) to be tested.

3. In trialR02.m, specify the training data file and the file used to test the network.

4. Run the program. The program will produce four graphs:
	- Network outputs vs. desired outputs during training.
	- Change in hidden unit weights over time.
	- Change in context unit weights over time.
	- Network outputs vs. desired outputs after training.

NOTE:

The data matrices should be formatted as follows:
ROW1 (input vector) --->
.
.
.
RowN (input vector) --->
Row(N+1) (output vector) --->