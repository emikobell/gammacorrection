function [windowPointer, wPattern, hPattern] = SetupInitialStimulus(numWhite, GreyLevel)

% Sets up a grey-matching pattern and initial disc by calling DrawDisc.
% Outputs the figure window and the size of the figure.
% When not using this function in a loop, please use the CloseandTidy function immediately after.
% 2/1/2021 Emiko Bell


    if ~ismember(numWhite, 1:8) % Check whether the chosen white pattern is in range
        error('numWhite is out of range. Input values must be integers 1-8.')
    end
    
    if GreyLevel < 0.0 || GreyLevel > 1.0 % Check whether the chosen grey-level is in range
       error('GreyLevel is out of range. Input values must be between 0 to 1.')
    end

window = Screen('Windows'); % Return current open windows in PTB
    
    if isempty(window) % If no psychtoolbox windows are open, open one. This if loop is placed in case this function is run standalone.
       window = OpenPTBWindow;
    end

window = window(1); % In case there are multiple windows open, choose the main (first) one. If there is only one, this line will choose that. 
    
img = imread(['Pattern' int2str(numWhite) '.png']); % Read in pattern image according to the specified white-ratio

[hPattern, wPattern] = size(img); % Output the size of the image in pixels

set(0,'DefaultFigureVisible','off'); % Turn off figure popups to eliminate redundant figure screens from appearing

windowPointer = figure; % Specify figure window
imshow(img, 'InitialMagnification', 100, 'border', 'tight') % Display the image in a figure window with 100% magnification and no border space
AltDrawDisc(hPattern, wPattern, GreyLevel); % Call DrawDisc according to the height, width, and grey-level specified
diskImg = getframe(windowPointer); % Capture the figure window as a frame
diskImg = frame2im(diskImg); % Convert the figure window frame to image

set(0,'DefaultFigureVisible','on'); % Turn the default figure visibility back on

textureIndex = Screen(window, 'MakeTexture', diskImg); % Make the pattern with the disc a texture
Screen(window, 'DrawTexture', textureIndex); % Draw the texture
Screen(window, 'Flip', [], [1]); % Flip the drawn texture to the window without resetting past drawings
end