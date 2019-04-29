function y = mdfmap_plot(Data_mdf,min,max)

% Plot the 2D map
%map figure
Data_mdf_maps=Data_mdf;
temp = Data_mdf_maps(49:59);
Data_mdf_maps(49)= NaN;
Data_mdf_maps(50:60)= temp;
% one z matrix for each epoch
z = [Data_mdf_maps(49:1:60);  Data_mdf_maps(37:1:48) ;  Data_mdf_maps(25:1:36)...
    ; Data_mdf_maps(13:1:24) ; Data_mdf_maps(1:1:12) ];

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
plot(7,3,'ko','LineWidth',3);
plot(8,3,'ko','LineWidth',3);

view(0,90)
shading interp %interpolate the points in the map
hold on

%build the title
title('Heat Map - Frequency');
hcb=colorbar();
y=Data_mdf;


end

