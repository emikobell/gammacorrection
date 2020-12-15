function UpdateStimulus(windowPointer, wPattern, hPattern, updatedGreyLevel)

% Do some error checking on the input parameters
if updatedGreyLevel < 0.0 || updatedGreyLevel > 1.0
    error('Input argument updatedGreyLevel is out of range - 0 to 1')
end
% Screen('Preference', 'SkipSyncTests', 1);
% Screen('Preference', 'VisualDebugLevel', 0);
% whichScreen = 0;
% window = Screen(whichScreen, 'OpenWindow');
% 
% black = BlackIndex(window); % pixel value for white
% 
% Screen(window, 'FillRect', black); %Making the background white

set(0, 'CurrentFigure', windowPointer); %Setting as active figure without a figure popup in Matlab
DrawDisc(wPattern, hPattern, updatedGreyLevel);
diskImg = getframe(windowPointer);
diskImg = frame2im(diskImg);

textureIndex = Screen(window, 'MakeTexture', diskImg);
Screen(window, 'DrawTexture', textureIndex);

Screen(window, 'Flip');

KbWait;
Screen('CloseAll');
end