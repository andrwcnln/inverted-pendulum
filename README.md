# inverted-pendulum
Repository for my for my 4th Year Engineering Project, 'Control of an inverted pendulum using machine learning'.

This code is was written/created using MATLAB and Simulink.

'main_training.m' is used to generate a training data set, by simulating many different initial conditions of an inverted pendulum controlled by a de-tuned PID controller. This system is contained as a Simulink model in 'pid_ss.slx'.

'state_space.m' is a function which returns the state_space representation of an inverted pendulum system based on the input parameters.

'scaling.m' can be used to scale the data to between -1 and 1, while saving the scaling factors.

Once this data has been generated, the MATLAB Regression Learner and Neural Network Fittting tools can be used to train and export machine learning models.

'ml_ss.slx' is the Simulink model for machine learning regression models. Once a model has been trained, 'model_for_simulink.m' can be used to convert it to a Simulink-able format. Changing the name of the model in the MATLAB function block of 'ml_ss.slx' and making sure the scaling factors are in the workspace will allow the model to control the pendulum.

'nn_ss.slx' is the Simulink model for the neural networks. When using the Neural Network Fitting tool, the network can be exported as a Simulink block. Simply placing this in position in the subsystem and loading scaling factors should allow a nerual network to control the pendulum.

'anim.m' generates the an output gif file of the system. All it needs in the workspace is a Simulink output object called 'out' with fields 'x', 'phi', 'x_dot' and 'phi_dot'. This will be generated when running any of the Simulink models.
