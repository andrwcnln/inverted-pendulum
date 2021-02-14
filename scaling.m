load('adapt_training_data')
input = [full_output.x full_output.phi full_output.x_dot full_output.phi_dot full_output.u];

x = max(input(:,1));
phi = max(input(:,2));
x_dot = max(input(:,3));
phi_dot = max(input(:,4));
u = max(input(:,5));

input(:,1) = input(:,1)/x;
input(:,2) = input(:,2)/phi;
input(:,3) = input(:,3)/x_dot;
input(:,4) = input(:,4)/phi_dot;
input(:,5) = input(:,5)/u;

save('adapt_training_data_scaled.mat','input');
save('adapt_scaling_factors','x','phi','x_dot','phi_dot','u');

