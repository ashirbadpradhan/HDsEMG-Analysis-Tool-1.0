function [y1,y2] = map_print(Data_rms,min,max)

%map figure
Data_rms_maps=Data_rms;
temp = Data_rms_maps(49:59);
Data_rms_maps(49)= NaN;
Data_rms_maps(50:60)= temp;
% one z matrix for each epoch
z = [Data_rms_maps(49:1:60);  Data_rms_maps(37:1:48) ;  Data_rms_maps(25:1:36)...
    ; Data_rms_maps(13:1:24) ; Data_rms_maps(1:1:12) ]; 

xcg = (1*(nansum(z(:,1))) + 2*(sum(z(:,2))) + 3*(sum(z(:,3))) + 4*(sum(z(:,4)))...
    + 5*(sum(z(:,5))) + 6*(sum(z(:,6))) + 7*(sum(z(:,7))) + 8*(sum(z(:,8))) ...
    + 9*(sum(z(:,9))) + 10*(sum(z(:,10))) + 11*(sum(z(:,11))) + 12*(sum(z(:,12))))...
    / nansum(nansum(z(:,:)));
ycg = (1*(nansum(z(1,:))) + 2*(sum(z(2,:))) + 3*(sum(z(3,:))) + 4*(sum(z(4,:)))...
    + 5*(sum(z(5,:))))/ (nansum(nansum(z(:,:))));

%handles
% Plot the 2D map
hold on
[x,y]=meshgrid(1:12,1:5);
%ax=gca; % gca get handle to current axix
pcolor(x,y,z) % a pseudocolor or "checkerboard" plot of matrix z on the grid defined by x and y.
% The values of the elements of c specify the color in each cell of the plot.
colormap(jet)
caxis([min max])
axis equal tight
%axis off
hold on
plot(x,y,'ko','LineWidth',1);
%highlight the channels used to compute the diff feature (20 and 21 now)
plot(6,3,'ko','LineWidth',3);
plot(7,3,'ko','LineWidth',3);

view(0,90)
shading interp %interpolate the points in the map
hold on

%build the title
title('Heat Map - Amplitude');

plot(xcg,ycg,'x','LineWidth',2,'MarkerSize',10,'MarkerEdgeColor','k')
plot(x(1),y(1),'kx','LineWidth',3,'MarkerSize',20)

hcb=colorbar();
y1 = xcg;
y2 = ycg;
end

