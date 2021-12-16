function AltDrawDisc(w, h, greyLevel)
 
hold on
 
centre = [w/2 h/2]; % Define centre
radius = h / 4; % Define radius
 
c = viscircles(centre, radius, 'LineStyle', 'none');

% Specify coordinates of the circle; remove NaN values at end
xd = c.Children(1).XData(1:end-1);
yd = c.Children(1).YData(1:end-1);
 
fill(xd, yd, repmat(greyLevel, 1, 3), 'LineStyle', 'none');

