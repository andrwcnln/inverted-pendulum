load('trainedModel_coarse_tree.mat')
load('scaling_factors.mat')
Mdl = trainedModel_coarse_tree.RegressionTree;
saveLearnerForCoder(Mdl,'model');
