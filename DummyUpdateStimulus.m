function DummyUpdateStimulus(figWindowHandle, w, h, updatedGreyLevel)
% Updates the colour of the stimulus disc
% The new colour is specified in updatedGreyLevel (range 0-1)
% The disc is identified by the figure window handle, and the patch handle
% e.g. DummyUpdateStimulus(1, 600, 600, 0.6)
% HES 26/11/2020

% Do some error checking on the input parameters
if updatedGreyLevel < 0.0 || updatedGreyLevel > 1.0
    error('Input argument updatedGreyLevel is out of range - 0 to 1')
end

% Make the stimulus figure window "active" 
figure(figWindowHandle);

% Add a circular disc using the patch function. 
% The DrawDisc function uses the pattern height to determine the size and position of the patch.
DrawDisc(w, h, updatedGreyLevel);