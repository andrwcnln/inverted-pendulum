function [y1] = trainedModel_levenberg_10(x1)
%MYNEURALNETWORKFUNCTION neural network simulation function.
%
% Auto-generated by MATLAB, 04-Feb-2021 10:35:07.
%
% [y1] = myNeuralNetworkFunction(x1) takes these arguments:
%   x = Qx4 matrix, input #1
% and returns:
%   y = Qx1 matrix, output #1
% where Q is the number of samples.

%#ok<*RPMT0>

% ===== NEURAL NETWORK CONSTANTS =====

% Input 1
x1_step1.xoffset = [-1;-1;-1;-1];
x1_step1.gain = [1;1;1;1];
x1_step1.ymin = -1;

% Layer 1
b1 = [-1.4720254151414386978;-1.3371136433248886899;0.90428202678119207203;-0.99345021086324447612;-0.85886950072269796497;-0.47606890545909852364;-1.2463363832446101576;0.91234465102610817766;1.3414219722044959937;0.71344734564392109366];
IW1_1 = [0.0091677118791535245484 -4.0582145283425692384 0.18098824794304174679 -0.57425524573361808045;0.00027913204940485333329 1.9084261485361844191 -1.6972576435442867648 3.6619992731821704446;-1.0702934717236194384 1.7689079232751081516 1.0977076687712636893 -0.74279335729577200542;-0.012568446768626926474 3.9300774202119530543 1.1215989153194276806 -1.8298235546322654255;-0.011606722645089429663 3.8724051969635389092 0.80029954503283085021 -1.2670734976351021306;-1.2166044693149131728 -1.0592293092506259722 1.0823584080926638151 1.2337864247379528582;0.014247379612890093831 -4.575744060521627965 -0.66476422763899323254 2.0745757080608342449;-0.011768060334724422117 4.776566343176173568 -0.15349741036522343562 0.20102478129100531667;0.00088628512708363257379 1.7090890060180445875 -1.0842500838339326208 2.8270816053574154836;-0.0083954181275678208679 3.5846954619792543717 -0.23224976493019708346 0.54379062340625694549];

% Layer 2
b2 = 0.075432174278944191803;
LW2_1 = [1.7787104691711030924 -0.56750342339988535389 -0.00053336941088661066028 2.8461124770021659636 -3.6107919241406380984 -0.00052819779258572350459 -0.88362155554401566881 -4.0172708926139462093 -0.66810547171882650463 5.5716399573433958992];

% Output 1
y1_step1.ymin = -1;
y1_step1.gain = 1;
y1_step1.xoffset = -1;

% ===== SIMULATION ========

% Dimensions
Q = size(x1,1); % samples

% Input 1
x1 = x1';
xp1 = mapminmax_apply(x1,x1_step1);

% Layer 1
a1 = tansig_apply(repmat(b1,1,Q) + IW1_1*xp1);

% Layer 2
a2 = repmat(b2,1,Q) + LW2_1*a1;

% Output 1
y1 = mapminmax_reverse(a2,y1_step1);
y1 = y1';
end

% ===== MODULE FUNCTIONS ========

% Map Minimum and Maximum Input Processing Function
function y = mapminmax_apply(x,settings)
y = bsxfun(@minus,x,settings.xoffset);
y = bsxfun(@times,y,settings.gain);
y = bsxfun(@plus,y,settings.ymin);
end

% Sigmoid Symmetric Transfer Function
function a = tansig_apply(n,~)
a = 2 ./ (1 + exp(-2*n)) - 1;
end

% Map Minimum and Maximum Output Reverse-Processing Function
function x = mapminmax_reverse(y,settings)
x = bsxfun(@minus,y,settings.ymin);
x = bsxfun(@rdivide,x,settings.gain);
x = bsxfun(@plus,x,settings.xoffset);
end
