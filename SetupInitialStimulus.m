function [windowPointer, wPattern, hPattern] = SetupInitialStimulus(numWhite, startingGreyLevel);
if ~ismember(numWhite, 1:8)
    error('Input argument numWhite is out of range - allowable values are integers 1-8')
end
if startingGreyLevel < 0.0 || startingGreyLevel > 1.0
    error('Input argument startingGreyLevel is out of range - 0 to 1')
end

Screen('Preference', 'SkipSyncTests', 1);
Screen('Preference', 'VisualDebugLevel', 0);
whichScreen = 0;
window = Screen(whichScreen, 'OpenWindow');

black = BlackIndex(window); % pixel value for white

Screen(window, 'FillRect', black); %Making the background white

img = imread(['Pattern' int2str(numWhite) '.png']);

[hPattern, wPattern] = size(img);

set(0,'DefaultFigureVisible','off'); %turning off figure popups

windowPointer = figure;
imshow(img, 'InitialMagnification', 100, 'border', 'tight')
DrawDisc(hPattern, wPattern, startingGreyLevel);
diskImg = getframe(windowPointer);
diskImg = frame2im(diskImg);


set(0,'DefaultFigureVisible','on'); %turning the default back on

textureIndex = Screen(window, 'MakeTexture', diskImg);
Screen(window, 'DrawTexture', textureIndex);

Screen(window, 'Flip');
KbWait;
Screen('CloseAll');
end