function [brightnessMatch] = RunTrial(numWhite)

GreyLevel = randi([0 256]); % Radomly generate a grey-level
GreyLevel = GreyLevel / 256; % Convert grey-level to 0 to 1 scale

[windowPointer, wPattern, hPattern] = SetupInitialStimulus(numWhite, GreyLevel);
window = Screen('Windows');
window = window(1);
[width, height] = Screen(window, 'WindowSize');

fontSize = 0.01 * width;
fontSize = round(fontSize); %Since Psychtoolbox does not accept decimal points for font size, round the number to the nearest integer
textTop = height *.06;
textBottom = height - (height * .06);
white = WhiteIndex(window);
Screen(window, 'TextFont', 'Avenir');
Screen(window, 'TextSize', fontSize); %Font is 10% the size of the screen width
DrawFormattedText(window, 'Please adjust the disc grey-level. \n H: Significantly lighter \n B: Significantly darker \n J: Slightly lighter \n N: Slightly darker \n M: The disk matches the background \n \n Q: Quit', 'center', textTop, white, [], [], [], [2]);
Screen(window, 'Flip', [], [1]);
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
        UpdateStimulus(windowPointer, wPattern, hPattern, GreyLevel); %This function will test for limits also
        character = GetKeyPress;
    end
    
    if character == 'm'
       brightnessMatch = GreyLevel;
       disp('It''s a match!')
    
       white = WhiteIndex(window);
       Screen(window, 'TextStyle', [1]); %Bolding the text
       DrawFormattedText(window, 'It''s a match!', 'center', textBottom, white);
       Screen(window, 'Flip', [], [1]);
    end
    
    if character == 'q'
       sca
       error('Trial terminated.')
    end

pause(0.5); 
end