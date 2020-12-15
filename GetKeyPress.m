function character = GetKeyPress

character = input('Please adjust the disc grey-level: ', 's');

accepted = ['h' 'b' 'j' 'n' 'm'];

    while isempty(character) | ~ismember(character, accepted) | length(character) > 1
    character = input('Invalid input. Please enter the correct key: ', 's');
    end
    
end