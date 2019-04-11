function plt(el)
    clc
    close all

    x = load('nodes.inp');
x = x(:,2:3);
conn = load('elements.inp');
conn = conn(:,2:5);

    hold on;
    plot(x(:,1),x(:,2),'ro')
    plot(x(conn(el,:),1),x(conn(el,:),2),'bx')
    axis equal
end