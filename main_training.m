clear all,clc;

x_init = [-5:0.1:5];
x_dot_init = 0;
phi_init = [-1.56:0.06:1.56];
phi_dot_init = 0;
i = 1;
full_output = struct('x',[],'phi',[],'u',[],'x_dot',[],'phi_dot',[],'u_dot',[]);
j = 1;
M = .5;
m = 0.2;
coeff = 0.1;
I = 0.006;
g = 9.81;
l = 0.3;
[A,B,C,D] = state_space(M,m,coeff,I,g,l);

for a = [1:length(x_init)]
    for b = [1:length(phi_init)]
        init_input = "[" + string(x_init(a)) + " " + string(x_dot_init) + " " + string(phi_init(b)) + " " + string(phi_dot_init) + "]";
        A_input = "[" + string(A(1,1)) + " " + string(A(1,2)) + " " + string(A(1,3)) + " " + string(A(1,4)) + ";" + string(A(2,1)) + " " + string(A(2,2)) + " " + string(A(2,3)) + " " + string(A(2,4)) + ";" + string(A(3,1)) + " " + string(A(3,2)) + " " + string(A(3,3)) + " " + string(A(3,4)) + ";" + string(A(4,1)) + " " + string(A(4,2)) + " " + string(A(4,3)) + " " + string(A(4,4)) + "]";
        B_input = "[" + string(B(1,1)) + ";" + string(B(2,1)) + ";" + string(B(3,1)) + ";" + string(B(4,1)) + "]";
        C_input = "[" + string(C(1,1)) + " " + string(C(1,2)) + " " + string(C(1,3)) + " " + string(C(1,4)) + ";" + string(C(2,1)) + " " + string(C(2,2)) + " " + string(C(2,3)) + " " + string(C(2,4)) + "]";
        D_input = "[" + string(D(1,1)) + ";" + string(D(2,1)) + "]";
        in(i) = Simulink.SimulationInput("pid_ss");
        in(i) = in(i).setBlockParameter("pid_ss/State-Space","InitialCondition",init_input,"pid_ss/State-Space","A",A_input,"pid_ss/State-Space","B",B_input,"pid_ss/State-Space","C",C_input,"pid_ss/State-Space","D",D_input);
        i = i+1;
        i
    end
end

out = parsim(in);

for a = [1:length(out)]
   full_output.x = [full_output.x; out(1,a).x];
   full_output.phi = [full_output.phi; out(1,a).phi];
   full_output.u = [full_output.u; out(1,a).u];
   full_output.x_dot = [full_output.x_dot; out(1,a).x_dot];
   full_output.phi_dot = [full_output.phi_dot; out(1,a).phi_dot];
   full_output.u_dot = [full_output.u_dot; out(1,a).u_dot];
end

save("main_training_data.mat","full_output");
    
