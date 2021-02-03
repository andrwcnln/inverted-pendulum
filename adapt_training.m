clear all,clc;

x_init = [-5:5:5];
x_dot_init = 0;
phi_init = [-0.3:0.3:0.3];
phi_dot_init = 0;
i = 1;
M = [1:1:2]; % mass of the cart
m = [0.2:0.2:0.4]; % mass of the pendulum
coeff = [0.1:0.1:0.2]; % coefficient of friction for the cart
I = [0.001:0.001:0.002]; % mass moment of inertia of pendulum
g = 9.81; % acceleration due to gravity
l = [0.1:0.1:0.2]; % length to pendulum center of mass

full_output = [];
j = 1;

 for a = [1:length(x_init)]
    for b = [1:length(phi_init)]
       for c = [1:length(M)]
          for d = [1:length(m)]
             for e = [1:length(coeff)]
                for f = [1:length(I)]
                   for g = [1:length(l)]
                      [A,B,C,D] = state_space(M(c),m(d),coeff(e),I(f),g,l(g));
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
             end
          end
       end
    end
 end

out = parsim(in);

%  for a = [1:length(x_init)]
%     for b = [1:length(phi_init)]
%        for c = [1:length(M)]
%           for d = [1:length(m)]
%              for e = [1:length(coeff)]
%                 for f = [1:length(I)]
%                    for g = [1:length(l)]
%                       full_output(j,a) = out(a,1).x;
%                       full_output(j,b) = out(b,1).phi;
%                       full_output(j,c) = M(c);
%                       full_output(j,d) = m(d);
%                       full_output(j,e) = coeff(e);
%                       full_output(j,f) = I(f);
%                       full_output(j,g) = l(g);
%                       j = j+1;
%                    end
%                 end
%              end
%           end
%        end
%     end
%end