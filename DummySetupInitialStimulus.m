function [figWindowHandle, wPattern, hPattern] = DummySetupInitialStimulus(numWhite, startingGreyLevel)
% Sets up a figure window to display the starting experimental stimulus via Matlab.
% The stimulus is made of a halftone pattern (background) and a grey disc (foreground).
% The relevant halftone pattern is identified by numWhite, which is an integer from 1 to 8.
% The image files Pattern1.png, Pattern2.png etc. need to be accessible to this function.
% The grey disc is coloured with the startingGreyLevel (in the range 0-1).
% The handle to the figure window and the handle to the patch object that
% is used to specify the grey disc are returned so they can be used by the
% function that updates the stimulus.
% e.g. [figWindowHandle, wPattern, hPattern] = DummySetupInitialStimulus(1, 0.2)
% HES 26/11/2020

% Do some error checking on the input parameters
if ~ismember(numWhite, 1:8)
    error('Input argument numWhite is out of range - allowable values are integers 1-8')
end
if startingGreyLevel < 0.0 || startingGreyLevel > 1.0
    error('Input argument startingGreyLevel is out of range - 0 to 1')
end
    
% Read in the relevant halftone pattern
halftonePattern = imread(['Pattern' int2str(numWhite) '.png']);

% Find the dimensions of the pattern programmatically, to avoid magic numbers
[hPattern, wPattern, d] = size(halftonePattern);

% Open a figure window in Matlab, and store the figure handle, so this can
% be returned and used by another function
figWindowHandle = figure;

% Show the image using imshow (needs the Image Processing Toolbox).
% Set the initial magnification so that pixels are displayed at 1-to-1 scale
imshow(halftonePattern, 'InitialMagnification', 100, 'border', 'tight')

% Add a circular disc using the patch function. 
% The DrawDisc function uses the pattern height to determine the size and position of the patch.
DrawDisc(wPattern, hPattern, startingGreyLevel);