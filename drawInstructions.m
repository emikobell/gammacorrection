function drawInstructions(width, height, window)

fontSize = 0.01 * width; % Define font size as 1% of the width
fontSize = round(fontSize); % Since PTB does not accept decimal points for font size, round the number to the nearest integer
textTop = height *.06; % Define top text placement as at the top 6% of the height
white = WhiteIndex(window); % Define white for the text colour
Screen(window, 'TextFont', 'Avenir'); % Specify font
Screen(window, 'TextSize', fontSize); % Specify font size as defined above
DrawFormattedText(window, 'Please adjust the disc grey-level. \n H: Significantly lighter \n B: Significantly darker \n J: Slightly lighter \n N: Slightly darker \n M: The disk matches the background \n \n Q: Quit', 'center', textTop, white, [], [], [], [2]); % Draw instructions in the center top of the window with more space between lines
Screen(window, 'Flip', [], [1]); % Flip the drawn text to the window

end