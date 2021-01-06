function UpdateStimulus(windowPointer, wPattern, hPattern, GreyLevel)

% Updates an already-present grey-matching pattern and disc figure, and draws a new grey-disc by calling DrawDisc.
% Please use with SetupIntialStimulus for optimal performance. If not, a figure window must be present as an object to call.
% When not using this function in a loop, please use the CloseandTidy function immediately after.
% 2/1/2021 Emiko Bell


    if GreyLevel < 0 || GreyLevel > 1 % Check if GreyLevel is out of bounds
       sca % Close PTB window
       warning('GreyLevel is out of range. Accepted values are between 0 to 1.') % Warning appears to enable continuation of script but informs user of issues.
       tryAgain = input('Would you like to continue from the last step? y/n: ', 's'); % Take y or n and go to the if statement
    
        if tryAgain == 'y' % If yes
            
            if GreyLevel > 1 % Restart the disc at 255/256 grey-level
               GreyLevel = 0.9945;
            
            elseif GreyLevel < 0 % Restart the disc at 1/256 grey-level
                   GreyLevel = 0.0039;
            end
            
        elseif tryAgain == 'n' % If no, terminate trial
               error('Trial terminated.') % Stop the trial completely by bringing up the error message
               
        else % Account for any other input
            input('Please input y or n: ', 's')
        end
        
        OpenPTBWindow;
        
    end
        
window = Screen('Windows'); % Return current open windows in PTB
window = window(1); % In case there are multiple windows open, choose the main (first) one. If there is only one, this line will choose that. 
    
set(0, 'CurrentFigure', windowPointer); % Set as active figure without a figure popup in Matlab
AltDrawDisc(wPattern, hPattern, GreyLevel); % Call DrawDisc for a newly drawn grey-disc with the specified grey-level
diskImg = getframe(windowPointer); % Capture the figure window as a frame
diskImg = frame2im(diskImg); % Convert the figure window frame to image

textureIndex = Screen(window, 'MakeTexture', diskImg); % Make the pattern with the disc a texture
Screen(window, 'DrawTexture', textureIndex); % Draw the texture

Screen(window, 'Flip', [], [1]); % Flip the drawn texture to the window
return