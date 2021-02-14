function [y1] = trainedModel_conjugate_10_adapt(x1)
%MYNEURALNETWORKFUNCTION neural network simulation function.
%
% Auto-generated by MATLAB, 11-Feb-2021 23:37:55.
%
% [y1] = myNeuralNetworkFunction(x1) takes these arguments:
%   x = Qx4 matrix, input #1
% and returns:
%   y = Qx1 matrix, output #1
% where Q is the number of samples.

%#ok<*RPMT0>

% ===== NEURAL NETWORK CONSTANTS =====

% Input 1
x1_step1.xoffset = [-1;-1;-1;-0.999999999999325];
x1_step1.gain = [1;1;1;1.00000000000034];
x1_step1.ymin = -1;

% Layer 1
b1 = [-2.3010794273102610497;-2.2295850555045433339;0.74013108615206646412;-1.3324569395845742292;-1.920402517316460056;-0.575015239821047075;-0.79928168366212370977;2.195716608847011031;2.0653824602567247837;2.4069551386114644842];
IW1_1 = [0.54368006171929461612 -1.9424601642553127601 1.0103018019607807876 1.0586010177411298017;0.14723359150657105987 1.4608054730223627438 -1.1648641244778776827 -1.3720960594585538406;-0.85913218415904768488 1.7504788577631356095 1.0832282494994152078 -0.61137188171625067579;0.23045845514706278512 0.87966293524128302828 1.4851517244480592073 -1.6477061285012752911;0.097763169410351041799 2.2382071900445352775 1.1209960570363439736 -0.51598788527999983611;-1.2423004042507486133 -1.3910367598679145296 0.97400080213602890922 1.188101493906959405;-1.4243418237661835679 -0.49094726191782755986 1.4000623064534707396 1.2017013098033471064;-0.096046270667661026721 3.0630907260496567091 0.16606589117279266232 -0.48991727462085504774;1.4201402495770685253 0.97110566448776902693 0.50148354060504707341 1.5549484113175138233;0.14549861788340051616 2.1768762609595762036 -0.79225854250469940343 -1.4154626832260199798];

% Layer 2
b2 = -0.20778050012194262952;
LW2_1 = [-0.18889775040326625688 0.20286838598640574705 0.030006946524532160381 0.37750975874873288207 -0.75026854871871739849 -0.032870206044688501934 0.04185251777050370825 -0.71311533902785007033 0.025444068723349130834 0.501180149311889922];

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
