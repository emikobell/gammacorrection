function character = GetKeyPress

character = input('Please adjust the disc grey-level: ', 's');

accepted = ['h' 'b' 'j' 'n' 'm'];

    while isempty(character) | ~ismember(character, accepted) | length(character) > 1
    character = input('Invalid input. Please enter the correct key. If you would like to discontinue, please enter "exit": ', 's');
        if character == 'exit'
        character = NaN; %Explain rationale for this code -- idiot proofing. Also, write code in the RunTrial to account for the NaN character by stopping the program
        break
        end
    end
    
end