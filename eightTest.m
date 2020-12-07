function eightTest

binaryElement = zeros(600, 600);

    for i = 1:8
    unit = GenerateThreeByThreeElement(i);
    binaryElement = repmat(unit, 200, 200);
    imwrite(binaryElement, strcat('Pattern', num2str(i), '.png'))
    end
end