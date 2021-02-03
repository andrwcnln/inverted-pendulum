tau = [];
radius = 0.025;

for k = [1:length(out.u)]
   force = out.u(k)/4;
   tau = [tau;force*radius];
end

[a,b] = max(tau)
