function [A,B,C,D] = state_space(M,m,b,I,g,l) % Function that takes in pendulum paramters and reurns state-space matrices
% Test parameters
% M = .5;
% m = 0.2;
% b = 0.1;
% I = 0.006;
% g = 9.8;
% l = 0.3;

denom = I*(M+m)+M*m*l^2; % Denominator for A and B

% Generate matrices
A = [0      1              0           0;
     0 -(I+m*l^2)*b/denom  (m^2*g*l^2)/denom   0;
     0      0              0           1;
     0 -(m*l*b)/denom       m*g*l*(M+m)/denom  0];
B = [     0;
     (I+m*l^2)/denom;
          0;
        m*l/denom];
C = [1 0 0 0;
     0 0 1 0];
D = [0;
     0];
end
