clear all; % Clear all variables
clc; % Clear command line
load('trainedModel_linear.mat') % Load desired model
load('main_scaling_factors.mat') % Load appropriate scaling factors
Mdl = trainedModel_linear.LinearModel; % Save model to Mdl
saveLearnerForCoder(Mdl,'model'); % Save in a format that can be interpreted by Simulink
