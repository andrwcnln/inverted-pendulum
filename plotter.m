figure(1);
yyaxis left; % Select left y axis
a = plot(out.tout,out.u); % Plot to x axis and left y axis
grid on;
title('Angle, X position and force on cart (Linear regression, force unrestricted)') % Title
% Labels and limits
xlabel('Time (s)');
xlim([0 30]);
ylabel('Force on cart (N)');
%ylim([-0.6 0.6]);


yyaxis right; % Select right y axis
b = plot(out.tout,out.phi,out.tout,out.x); % Plot to x axis and right y axis
% Labels, ranges and stylings
ylabel('Deviation of pendulum (rad) and X position of cart (m)');
% ylim([-70 70]);
% b.LineWidth = 1.3;
% l = refline(0,0);
% l.Color = 'k';
% l.LineStyle = ':';
legend('Angle (rad)','X (m)','Force (N)','Location','southeast');

