figure(1);
yyaxis left; % Select left y axis
a = plot(out.tout,out.phi,out.tout,out.x); % Plot to x axis and left y axis
grid on;
title('Deviation of alternative pendulum from upright and X position of cart (Non-optimal P.I.D)') % Title
% Labels and limits
xlabel('Time (s)');
xlim([0 30]);
ylabel('Angle and X position (rad and m)');
ylim([-0.6 0.6]);


yyaxis right; % Select right y axis
b = plot(out.tout,out.u); % Plot to x axis and right y axis
% Labels, ranges and stylings
ylabel('Force on cart');
ylim([60 -10]);
b.LineWidth = 1.3;
l = refline(0,0);
l.Color = 'k';
l.LineStyle = ':';
legend('Angle (rad)','X (m)','0 reference','Location','southeast');

