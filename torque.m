tau = [];
radius = 0.025;

for k = [1:length(full_output.u)]
   force = full_output.u(k)/4;
   tau = [tau;force*radius];
end

[a,b] = max(tau)
