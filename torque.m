% Initialise variables
tau = [];
radius = 0.025;

% Calulate all torques
for k = [1:length(full_output.u)]
   force = full_output.u(k)/4;
   tau = [tau;force*radius];
end

% Find max torque and location
[a,b] = max(tau)
