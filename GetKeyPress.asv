function character = GetKeyPress

disp('Please adjust the disc grey-level: ') % Displays message prior to the getkey function

character = getkey('non-ascii'); % getkey function takes one input from the keyboard automatically and stores character in a character array

accepted = ['h' 'b' 'j' 'n' 'm' 'q'];

    while isempty(character) | ~ismember(character, accepted) | length(character) > 1 %The last argument avoids modifier keys (e.g. enter, space). No guarantee if scalar, so the | argument is used.
          disp('Invalid input. Please enter the correct key: ') % Displays message before second getkeyfunction
          beep; %Plays error noise when the input is invalid
          character = getkey('non-ascii'); % Reassigns character with new input
    end
    
end