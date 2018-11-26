%{
% Gif definition
h = figure('units','normalized','outerposition',[0 0 1 1]);
axis tight manual % this ensures that getframe() returns a consistent size
filename = 'Animation.gif';

% Avi definition
v = VideoWriter('Video');
open(v);
%}

%{
    % Avi writer
    plot(x(:,1) + un(1:2:2*nnod),x(:,2) + un(2:2:2*nnod),'rx');
    figure('units','normalized','outerposition',[0 0 1 1])
    title(['Time = ',num2str(t)]);
    xlim([-1 14])
    ylim([-0.1 15.1])
    grid on;
    drawnow
    
    ax = gca;
    ax.Units = 'pixels';
    pos = ax.Position;
    ti = ax.TightInset;
    rect = [-ti(1), -ti(2), pos(3)+ti(1)+ti(3), pos(4)+ti(2)+ti(4)];
    f = getframe(ax,rect);
    writeVideo(v,f);

    
    % Gif writer

    plot(x(:,1) + un(1:2:2*nnod),x(:,2) + un(2:2:2*nnod),'rx');
    title(['Time = ',num2str(t)]);

    title(['Time = ',num2str(t)]);
    xlim([-1 14])
    ylim([-0.1 15.1])
    axis equal
    grid on;
    drawnow 
    % Capture the plot as an image 
    frame = getframe(h); 
    im = frame2im(frame); 
    [imind,cm] = rgb2ind(im,256); 
    % Write to the GIF File 
    if t == 0 
      imwrite(imind,cm,filename,'gif','DelayTime',0.075, 'Loopcount',inf); 
    else 
      imwrite(imind,cm,filename,'gif','DelayTime',0.075, 'WriteMode','append'); 
    end

    % Line plotter
    
    time = [0,5,10,30];
	for ti = 1:length(time)
        tt = time(ti);
		if t == tt
			top = find(x(:,2) == 1);
            xx = x(top,1);
            [temp, sortindex] = sort(xx,'ascend');
            top = top(sortindex);
			y = zeros(size(top));
			for i = 1:length(top)
				node_bc = top(i);
				idof = node_bc*2-1;
				y(i) = un1(idof);
			end
			plot((1:length(top))./(nnod/20),y);
            hold on;    grid on;
            xlabel('Undeformed x-coordinate');  ylabel('Property');
            title('Displacement line plot');
		end
	end

    % Position plotter
   
    time = 1:tmax;
    for ti = 1:length(time)
        tt = time(ti);
        if t == tt
            subplot(ceil(length(time)/4),4,ti);
            plot(x(:,1) + un(1:2:2*nnod),x(:,2) + un(2:2:2*nnod),'b.');
            xdeformed = [x(:,1) + un(1:2:2*nnod) x(:,2) + un(2:2:2*nnod) zeros(size(x(:,1)))];
            vtkwrite(['x0',num2str(t),'.vtk'],'x',xdeformed);
            title(['Time = ',num2str(t)]);
            grid on;
            axis equal;
            xlim([-1 16]);    ylim([-1 16]); 
            xlabel('x');    ylabel('y');
        end
    end
%}

% close(v)  % Avi writer
