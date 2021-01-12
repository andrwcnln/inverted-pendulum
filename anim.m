l = 0.3;
bottomx = out.x;
bottomy = ones(length(out.x),1)/10;
topx = [];
topy = [];
[cart,map,transparency] = imread('cart.png');
playback_speed = 2;

for j = [1:length(out.phi)]
    if out.phi(j) >= 0
        topx = [topx; bottomx(j) - l*sin(abs(out.phi(j)))];
        topy = [topy; bottomy(j) + l*cos(out.phi(j))];
    else
        topx = [topx; bottomx(j) + l*sin(abs(out.phi(j)))];
        topy = [topy; bottomy(j) + l*cos(out.phi(j))];
    end
    if j == 1
        figure();
        hold on;
        set(gcf, 'InvertHardCopy', 'off');
        set(gcf,'WindowState','normal');
        set(gcf,'position',[30 30 1500 550]);
        set(gcf,'color','k');
        subplot(2,2,[1 3])
        plot_pendulum = plot([bottomx(j),topx(j)],[bottomy(j),topy(j)],'y','LineWidth',5);
        title({['Time: ' num2str(out.tout(j)) 's'];['Playback speed: ~' num2str(playback_speed) 'x']},'color','w')
        grid on;
        set(gca,'Color','k')
        set(gca,'XColor','w')
        set(gca,'YColor','w')
        set(gca,'GridColor','w')
        axis equal
        xlim([0 2]);
        ylim([0 2]);
        ax1 = gca;
        hold(gca,'on');
        plot_cart = imagesc([bottomx(j)-0.125 bottomx(j)+0.125],[0.15 0],cart);
        set(plot_cart,'AlphaData',transparency);
        hold(gca,'off');
        subplot(2,2,2)
        plot_x_phi = plot(out.tout(1:j),out.x(1:j),'r',out.tout(1:j),out.phi(1:j),'y');
        grid on;
        title('X position of cart and angle of deviation from upright position ({\it\phi})','color','w')
        legend('X','{\it\phi}','color','k','textcolor','w')
        xlabel('Time (s)')
        ylabel('X and {\it\phi} (m and rad)')
        set(gca,'Color','k')
        set(gca,'XColor','w')
        set(gca,'YColor','w')
        set(gca,'GridColor','w')
        plot_x_phi(1).LineWidth = 2;
        plot_x_phi(2).LineWidth = 2;
        xlim([0 max(out.tout)]);
        ylim([-max(abs([out.x;out.phi]))-0.1 max(abs([out.x;out.phi]))+0.1]);
        subplot(2,2,4)
        plot_x_dot_phi_dot = plot(out.tout(1:j),out.x_dot(1:j),'r',out.tout(1:j),out.phi_dot(1:j),'y');
        grid on;
        title('Rate of change of X position (dX/dt) and angle of deviation (d{\it\phi}/dt)','color','w')
        legend('dX/dt','d{\it\phi}/dt','color','k','textcolor','w')
        xlabel('Time (s)')
        ylabel('dX/dt and d{\it\phi}/dt (ms^{-1} and rads^{-1})')
        set(gca,'Color','k')
        set(gca,'XColor','w')
        set(gca,'YColor','w')
        set(gca,'GridColor','w')
        plot_x_dot_phi_dot(1).LineWidth = 2;
        plot_x_dot_phi_dot(2).LineWidth = 2;
        xlim([0 max(out.tout)]);
        ylim([-max(abs([out.x_dot;out.phi_dot]))-1 max(abs([out.x_dot;out.phi_dot]))]+1);
    else
        set(plot_pendulum,'xdata',[bottomx(j),topx(j)]);
        set(plot_pendulum,'ydata',[bottomy(j),topy(j)]);
        title(ax1,{['Time: ' num2str(out.tout(j)) 's'];['Playback speed: ~' num2str(playback_speed) 'x']},'color','w')
        set(plot_cart,'xdata',[bottomx(j)-0.125 bottomx(j)+0.125]);
        set(plot_x_phi(1),'xdata',out.tout(1:j));
        set(plot_x_phi(2),'xdata',out.tout(1:j));
        set(plot_x_phi(1),'ydata',out.x(1:j));
        set(plot_x_phi(2),'ydata',out.phi(1:j));
        set(plot_x_dot_phi_dot(1),'xdata',out.tout(1:j));
        set(plot_x_dot_phi_dot(2),'xdata',out.tout(1:j));
        set(plot_x_dot_phi_dot(1),'ydata',out.x_dot(1:j));
        set(plot_x_dot_phi_dot(2),'ydata',out.phi_dot(1:j));
    end
    print(['Frame ' num2str(j)], '-dpng', '-r100');
end

GifName = 'pendulum.gif';
ii = 1;
delay = out.tout(ii+1)-out.tout(ii)/playback_speed;
for ii = 1:length(out.x)
    [A, ~] = imread(['Frame ' num2str(ii) '.png']);
    [X, map] = rgb2ind(A, 256);
    if ii == 1
        imwrite(X, map, GifName, 'gif', 'LoopCount', inf, 'DelayTime', delay)
    else
        imwrite(X, map, GifName, 'gif', 'WriteMode', 'append', 'DelayTime', delay)
    end
end
