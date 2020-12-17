function UpdateStimulus(windowPointer, wPattern, hPattern, GreyLevel)

    if GreyLevel < 0 || GreyLevel > 1 %Checking if GreyLevel is out of bounds
       sca %Closing psychtoolbox screen and returning to Matlab command window
       warning('GreyLevel is out of range. Accepted values are between 0 to 1.') %Warning appears to enable continuation of script but informs user of issues.
       tryAgain = input('Would you like to continue from the last step? y/n: ', 's') %Takes y or n and goes to the if statement
    
        if tryAgain == 'y'
            
            if GreyLevel > 1
               GreyLevel = 0.9945; %Restarts at 255/256 grey-level
            
            elseif GreyLevel < 0
                   GreyLevel = 0.0039; %Restarts at 1/256 grey-level
            end
            
        elseif tryAgain == 'n'
               error('Trial terminated.') % Stops the trial completely by bringing up the error message
        else % Accounts for any other input
            input('Please input y or n: ', 's')
        end
    end

window = Screen('Windows');
window = window(1);
    
set(0, 'CurrentFigure', windowPointer); %Setting as active figure without a figure popup in Matlab
DrawDisc(wPattern, hPattern, GreyLevel);
diskImg = getframe(windowPointer);
diskImg = frame2im(diskImg);

textureIndex = Screen(window, 'MakeTexture', diskImg);
Screen(window, 'DrawTexture', textureIndex);

Screen(window, 'Flip', [], [1]); %Brings the drawn texture to the psychtoolbox screen
end