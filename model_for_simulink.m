clear all;
clc;
load('trainedModel_linear.mat')
load('main_scaling_factors.mat')
Mdl = trainedModel_linear.LinearModel;
saveLearnerForCoder(Mdl,'model');
