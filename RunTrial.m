function brightnessMatch = RunTrial(numWhite)

% Runs one grey-matching trial and returns the matched grey-level by calling SetupInitialStimulus, UpdateStimulus, and GetKeyPress.
% When not using this function in a loop, please use the CloseandTidy function immediately after.
% 2/1/2021 Emiko Bell


GreyLevel = randi([1 255]); % Radomly generate a grey-level as a random integer between 1 and 255, removing options for white or black
GreyLevel = GreyLevel / 256; % Convert grey-level to 0 to 1 scale

[windowPointer, wPattern, hPattern] = SetupInitialStimulus(numWhite, GreyLevel); % Call SetupInitialStimulus and outputting the figure and patterns
window = Screen('Windows'); % Return current open windows in PTB
window = window(1); % In case there are multiple windows open, choose the main (first) one. If there is only one, this line will choose that. 
[width, height] = Screen(window, 'WindowSize'); % Output the width and height of the window (resolution in pixels)

drawInstructions(width, height, window)
character = GetKeyPress; % Receive initial keypress in respose to the initial stimulus
    
    while ismember(character, 'hbjn') % Grey-level adjustment keys
    
    small = .0039; % Represents 1/256 of the grey level between 0 to 1; cannot go in between grey-levels
    large = .097; % Represents  25/256 of the grey levels (about .1 when 0 to 1)
    
        if character == 'h' % Large grey adjustment by addition
           GreyLevel = GreyLevel + large;
        
        elseif character == 'b' % Large grey adjustment by subtraction
               GreyLevel = GreyLevel - large;
    
        elseif character == 'j' % Small grey adjustment by addition
               GreyLevel = GreyLevel + small;
    
        elseif character == 'n' % Small grey adjustment by subtraction
               GreyLevel = GreyLevel - small;
        end
    
        pause(0.1) % Pause before the updated stimulus appears
        UpdateStimulus(windowPointer, wPattern, hPattern, GreyLevel); % Call UpdateStimulus to show the updated disc as specified in the loop above.
        drawInstructions(width, height, window)
        character = GetKeyPress; % Character is redefined by the new key press in response to UpdateStimulus
    end
    
    if character == 'm' % Grey-level matched
       brightnessMatch = GreyLevel;
       textBottom = height - (height * .1); % Define bottom text placement at the bottom 10% of height
       Screen(window, 'TextStyle', [1]); % Bold the text
       DrawFormattedText(window, 'It''s a match!', 'center', textBottom, [255 255 255]); % Draw the match message
       Screen(window, 'Flip', [], [1]); % Flip the text to the window without resetting the screen
    end
    
    if character == 'q' % Terminate the trial
       sca
       error('Trial terminated.')
    end

pause(0.5); %Pause before next trial, if this function is placed in a loop. Otherwise, please use the CloseandTidy function.
end