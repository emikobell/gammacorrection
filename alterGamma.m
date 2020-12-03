function alterGamma(img, gammaValue)

%Reading in the image
img = imread(img);

%Changing the values to double precision: "im2double rescales the output
%from integer data types to the range [0, 1]."
img = im2double(img);

%Running the formula to convert img values according to the gamma value
lightOutput = img .^ gammaValue;

%Outputting the converted array as an image
image(lightOutput)
end