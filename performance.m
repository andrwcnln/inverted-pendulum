% Set up ranges for initial conditions
x_init = [-5:0.1:5];
x_dot_init = 0;
phi_init = [-0.3:0.1:0.3];
phi_dot_init = 0;
i = 1;
full_output = struct('x',[],'phi',[],'u',[],'x_dot',[],'phi_dot',[],'u_dot',[]); % Initialise output struct
j = 1;
% Initialise pendulum parameters
M = 4;
m = 1.6;
coeff = 0.8;
I = 0.048;
g = 9.81;
l = 2.4;
[A,B,C,D] = state_space(M,m,coeff,I,g,l); % Create state-space matrices from parameters
output = [];

% Iterate through initial conditions
for a = [1:length(x_init)]
    for b = [1:length(phi_init)]
        % Create a Simulink input object based upon initial conditions and state-space matrices
        init_input = "[" + string(x_init(a)) + " " + string(x_dot_init) + " " + string(phi_init(b)) + " " + string(phi_dot_init) + "]";
        A_input = "[" + string(A(1,1)) + " " + string(A(1,2)) + " " + string(A(1,3)) + " " + string(A(1,4)) + ";" + string(A(2,1)) + " " + string(A(2,2)) + " " + string(A(2,3)) + " " + string(A(2,4)) + ";" + string(A(3,1)) + " " + string(A(3,2)) + " " + string(A(3,3)) + " " + string(A(3,4)) + ";" + string(A(4,1)) + " " + string(A(4,2)) + " " + string(A(4,3)) + " " + string(A(4,4)) + "]";
        B_input = "[" + string(B(1,1)) + ";" + string(B(2,1)) + ";" + string(B(3,1)) + ";" + string(B(4,1)) + "]";
        C_input = "[" + string(C(1,1)) + " " + string(C(1,2)) + " " + string(C(1,3)) + " " + string(C(1,4)) + ";" + string(C(2,1)) + " " + string(C(2,2)) + " " + string(C(2,3)) + " " + string(C(2,4)) + "]";
        D_input = "[" + string(D(1,1)) + ";" + string(D(2,1)) + "]";
        in(i) = Simulink.SimulationInput("nn_ss");
        in(i) = in(i).setBlockParameter("nn_ss/State-Space","InitialCondition",init_input,"nn_ss/State-Space","A",A_input,"nn_ss/State-Space","B",B_input,"nn_ss/State-Space","C",C_input,"nn_ss/State-Space","D",D_input);
        i = i+1;
        i
    end
end

% Simulate all generated simulations
for a = [1:i-1]
    out = sim(in(a));
    output = [output out];
    a
end

% Generate output
for a = [1:length(output)]
   full_output.x = [full_output.x; output(1,a).x];
   full_output.phi = [full_output.phi; output(1,a).phi];
   full_output.u = [full_output.u; output(1,a).u];
   full_output.x_dot = [full_output.x_dot; output(1,a).x_dot];
   full_output.phi_dot = [full_output.phi_dot; output(1,a).phi_dot];
   full_output.u_dot = [full_output.u_dot; output(1,a).u_dot];
end

save("performance_data_conjugate_20_retrain_5.mat","full_output"); % Save output to file
    
