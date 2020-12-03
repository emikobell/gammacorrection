function DrawDisc(w, h, greyLevel)
% Add a circular disc using the patch function.
% x and y coordinates are specified as rsin(theta) and rcos(theta)
% respectively, for the full range of theta from 0 to 2*pi.
% The radius of the disc is set to 1/4 the height of the pattern.
% The disc positions at the centre of the pattern.
% e.g. DrawDisc(600, 600, 0.4)
% HES 26/11/2020

theta = linspace(0, 2*pi, 100);
r = h / 4;
patchHandle = patch(r * sin(theta)+w/2, r * cos(theta)+h/2, repmat(greyLevel, 1, 3));
% the default edge colour is black, so this must be updated to the desired
% grey level
set(patchHandle, 'EdgeColor', repmat(greyLevel, 1, 3));