function alterGamma(img, gammaValue)

% Transforms a given image to the gamma value specified. Displays image after transformation.
% 2/1/2021 Emiko Bell

img = imread(img); % Read the image

    if  min(img, [], 'all') < 0 || max(img, [], 'all') > 1 % If the min or max of any element is out of bounds (0 and 1)
        img = im2double(img); % Convert the image to double-precision, which also converts the scale to 0 to 1
    end

updatedOutput = img .^ gammaValue; % Run the formula to convert img values according to the gamma value

imshow(updatedOutput) % Output the converted array as an image. imshow can rescale and use a dynamic range of colours
end