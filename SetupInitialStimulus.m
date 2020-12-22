function [windowPointer, wPattern, hPattern] = SetupInitialStimulus(numWhite, GreyLevel)

    if ~ismember(numWhite, 1:8)
        error('numWhite is out of range. Input values must be integers 1-8.')
    end
    
    if GreyLevel < 0.0 || GreyLevel > 1.0
       error('GreyLevel is out of range. Input values must be between 0 to 1.')
    end

window = Screen('Windows'); %Returns the current open windows in psychtoolbox
    
    if isempty(window) %If no psychtoolbox windows are open, open one
       Screen('Preference', 'SkipSyncTests', 2);
       Screen('Preference', 'VisualDebugLevel', 0);
       whichScreen = 0;
       window = Screen(whichScreen, 'OpenWindow', [0 0 0]);
       HideCursor(window)
    end

window = window(1); %In case there are multiple windows open, choose the main (first) one. If there is only one, this function will choose that. 
    
img = imread(['Pattern' int2str(numWhite) '.png']);

[hPattern, wPattern] = size(img);

set(0,'DefaultFigureVisible','off'); %turning off figure popups

windowPointer = figure;
imshow(img, 'InitialMagnification', 100, 'border', 'tight')
DrawDisc(hPattern, wPattern, GreyLevel);
diskImg = getframe(windowPointer);
diskImg = frame2im(diskImg);

set(0,'DefaultFigureVisible','on'); %turning the default back on

textureIndex = Screen(window, 'MakeTexture', diskImg);
Screen(window, 'DrawTexture', textureIndex);
Screen(window, 'Flip', [], [1]);
return