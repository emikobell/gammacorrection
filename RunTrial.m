function brightnessMatch = RunTrial(numWhite)

GreyLevel = randi([0 256]); % Radomly generate a grey-level
GreyLevel = GreyLevel / 256; % Convert grey-level to 0 to 1 scale

[window, windowPointer, wPattern, hPattern] = SetupInitialStimulus(numWhite, GreyLevel);
character = GetKeyPress;
    
    while ismember(character, 'hbjn')
    
    small = .0039; % Represents 1/256 of the grey level between 0 to 1; cannot go in between grey-levels
    large = .097; % Represents  25/256 of the grey levels (about .1 when 0 to 1)
    
        if character == 'h'
           GreyLevel = GreyLevel + large;
        
        elseif character == 'b'
               GreyLevel = GreyLevel - large;
    
        elseif character == 'j'
               GreyLevel = GreyLevel + small;
    
        elseif character == 'n'
               GreyLevel = GreyLevel - small;
        end
    
        pause(0.1)
        UpdateStimulus(window, windowPointer, wPattern, hPattern, GreyLevel); %This function will test for limits also
        character = GetKeyPress;
    end
    
    if character == 'm'
       brightnessMatch = GreyLevel;
       disp('It''s a match!')
    
       white = WhiteIndex(window);
       Screen(window, 'TextStyle', [1]); %Bolding the text
       DrawFormattedText(window, 'It''s a match!', 'center', 'center', white);
       Screen(window, 'Flip', [], [1]);
    end
    
    if character == 'q'
       sca
       error('Trial terminated.')
    end

pause(0.1);
Screen('CloseAll');
sca
end