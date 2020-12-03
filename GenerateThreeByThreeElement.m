function binaryElement = GenerateThreeByThreeElement(numWhite)
% Generates a binary 3-by-3 matrix to be used as a repeating element for a
% halftone pattern, where numWhite is the number of white pixels (out of a
% maximum of 9). Note that allowed values of numWhite are integers 1 to 8
% (since 0/9 and 9/9 are not needed for the perceptual gamma experiment).
% e.g. binaryElement = GenerateThreeByThreeElement(2)
% HES 26/11/2020

if ~ismember(numWhite, 1:8)
    error('Input argument numWhite is out of range - allowable values are integers 1-8')
end

switch numWhite
    case 1
        binaryElement = zeros(3,3);
        binaryElement(2, 2) = 1;
    case 2
        binaryElement = zeros(3,3);
        binaryElement(2, 1) = 1;        
        binaryElement(2, 3) = 1;
    case 3
        binaryElement = zeros(3,3);
        binaryElement(2, :) = 1;
    case 4
        binaryElement = zeros(3,3);
        binaryElement(1, 2) = 1;
        binaryElement(2, 1) = 1;
        binaryElement(2, 3) = 1;
        binaryElement(3, 2) = 1;
    case 5
        binaryElement = ones(3,3);
        binaryElement(1, 2) = 0;
        binaryElement(2, :) = 0;
        binaryElement(3, 2) = 0;
    case 6
        binaryElement = ones(3,3);
        binaryElement(2, :) = 0;
    case 7
        binaryElement = ones(3,3);
        binaryElement(2, 1) = 0;        
        binaryElement(2, 3) = 0;
    case 8
        binaryElement = ones(3,3);
        binaryElement(2, 2) = 0;
end



