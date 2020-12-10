function eightTest

element = zeros(600, 600); %Creating array with zeros

    for i = 1:8 %Repeating for loop 8 times
    unit = GenerateThreeByThreeElement(i); %Calling GenerateThreeByThreeElement function to create an element for each iteration from 1-8
    element = repmat(unit, 200, 200); %Repeating the 3x3 element by 200 rows and columns to produce a 600x600 image
    imwrite(element, strcat('Pattern', num2str(i), '.png')); %Outputs a .png for each iteration, creating filename
    imshow(['Pattern' num2str(i) '.png'], 'InitialMagnification', 100) %Shows a figure for each iteration
    pause %Pauses the loop until a keystroke
    end

end