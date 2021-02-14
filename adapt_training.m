clear all,clc;

load("pid.mat")
x_init = [-5:1:5];
x_dot_init = 0;
phi_init = [-0.3:0.025:0.3];
phi_dot_init = 0;
full_output = struct('x',[],'phi',[],'u',[],'x_dot',[],'phi_dot',[],'u_dot',[]);
M_range = [0.25 0.75];
m_range = [0.1 0.3];
coeff_range = [0.1];
I_range = [0.001 0.01];
l_range = [0.1 0.6];
pid = 1;

for M_loop = M_range
    for m_loop = m_range
        for coeff_loop = coeff_range
            for I_loop = I_range
                for l_loop = l_range
                    prop = pid_values(pid,1);
                    int = pid_values(pid,2);
                    deriv = pid_values(pid,3);
                    filt = pid_values(pid,4);
                    pid = pid + 1
                    i = 1;
                    j = 1;
                    M = M_loop;
                    m = m_loop;
                    coeff = coeff_loop;
                    I = I_loop;
                    g = 9.81;
                    l = l_loop;
                    [A,B,C,D] = state_space(M,m,coeff,I,g,l);
                    
                    for a = [1:length(x_init)]
                        for b = [1:length(phi_init)]
                            init_input = "[" + string(x_init(a)) + " " + string(x_dot_init) + " " + string(phi_init(b)) + " " + string(phi_dot_init) + "]";
                            A_input = "[" + string(A(1,1)) + " " + string(A(1,2)) + " " + string(A(1,3)) + " " + string(A(1,4)) + ";" + string(A(2,1)) + " " + string(A(2,2)) + " " + string(A(2,3)) + " " + string(A(2,4)) + ";" + string(A(3,1)) + " " + string(A(3,2)) + " " + string(A(3,3)) + " " + string(A(3,4)) + ";" + string(A(4,1)) + " " + string(A(4,2)) + " " + string(A(4,3)) + " " + string(A(4,4)) + "]";
                            B_input = "[" + string(B(1,1)) + ";" + string(B(2,1)) + ";" + string(B(3,1)) + ";" + string(B(4,1)) + "]";
                            C_input = "[" + string(C(1,1)) + " " + string(C(1,2)) + " " + string(C(1,3)) + " " + string(C(1,4)) + ";" + string(C(2,1)) + " " + string(C(2,2)) + " " + string(C(2,3)) + " " + string(C(2,4)) + "]";
                            D_input = "[" + string(D(1,1)) + ";" + string(D(2,1)) + "]";
                            in(i) = Simulink.SimulationInput("pid_ss");
                            in(i) = in(i).setBlockParameter("pid_ss/State-Space","InitialCondition",init_input,"pid_ss/State-Space","A",A_input,"pid_ss/State-Space","B",B_input,"pid_ss/State-Space","C",C_input,"pid_ss/State-Space","D",D_input,"pid_ss/PID Controller","P",string(prop),"pid_ss/PID Controller","I",string(int),"pid_ss/PID Controller","D",string(deriv),"pid_ss/PID Controller","N",string(filt));
                            i = i+1;
                            i;
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
                end
            end
        end
    end
end

save("adapt_training_data.mat","full_output");
    
