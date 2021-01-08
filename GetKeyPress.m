function character = GetKeyPress

% Collects key presses from users for grey-matching experiments (e.g.
% RunTrial). Utilises the getkey function by Jos van der Geest, 2019.
% 6/1/2021 Emiko Bell

character = getkey('non-ascii'); % getkey function takes one input from the keyboard automatically and stores character in a character array

accepted = ['h' 'b' 'j' 'n' 'm' 'q'];

    while isempty(character) | ~ismember(character, accepted) | length(character) > 1 % The last argument avoids modifier keys (e.g. enter, space). No guarantee if the array is scalar, so the | argument is used.
          beep; % Play error noise when the input is invalid
          character = getkey('non-ascii'); % Reassigns character with new input
    end
    
end