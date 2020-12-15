function currentGreyLevel = RunTrial(numWhite, startingGreyLevel)

[windowPointer, wPattern, hPattern] = SetupInitialStimulus(numWhite, startingGreyLevel);
character = GetKeyPress;
    
    if character == 'm'
    currentGreyLevel = startingGreyLevel; %Accounting for match on the first try
    disp("It's a match!")
    end
    
    while ismember(character, 'hbjn')
    
    small = .0039
    large = .1
    
        if character == 'h'
        updatedGreyLevel = startingGreyLevel + large
        
        elseif character == 'b'
        updatedGreyLevel = startingGreyLevel - large
    
        elseif character == 'j'
        updatedGreyLevel = startingGreyLevel + small
    
        elseif character == 'n'
        updatedGreyLevel = startingGreyLevel - small
        end
    
    UpdateStimulus(windowPointer, wPattern, hPattern, updatedGreyLevel);
    character = GetKeyPress;
    end
    
    if character == 'm' && currentGreyLevel ~= startingGreyLevel
    currentGreyLevel = updatedGreyLevel;
    disp("It's a match!")
    end
end