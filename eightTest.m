function eightTest

% Creates 8 grey-tone pattern .png files by calling the GenerateThreeByThreeElement
% function. The patterns utlises the each three by three element with
% varying degrees of white-ratios and multiplies the element by 200 each
% side to create a 600 x 600 pixel pattern.
% 2/1/2021 Emiko Bell

    for i = 1:8 % Repeat loop 8 times for each pattern
        unit = GenerateThreeByThreeElement(i); % Call GenerateThreeByThreeElement function to create an element for each iteration
        element = zeros(600, 600); % Create array with zeros
        element = repmat(unit, 200, 200); % Repeat the 3x3 element by 200 rows and columns to produce a 600x600 image
        imwrite(element, strcat('Pattern', num2str(i), '.png')); % Output a .png for each iteration, creating filename
        figure1 = figure; % Open figure window
        imshow(['Pattern' num2str(i) '.png'], 'InitialMagnification', 100, 'border', 'tight'); % Show a figure for each iteration
        pause % Pause the loop until a keystroke before next iteration
        close % Close the figure window before next iteration to avoid a build-up of figure windows
    end

end