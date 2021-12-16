# Perceptual Gamma Correction Experiment

This MATLAB program is a perceptual gamma correction experiment modeled after Parraga et al. (2014)<sup>1</sup>. Each computer's (or other device's) display can show differnt intensities of light, regardless of the requested value from the computer. To tackle this issue when presenting stimuli, calibration processes can be useful. This program simulates and estimates the gamma curve of a given display using perceptual responses given by users. Gamma values vary across displays, however, can be estimated. Using the power law formula, <img src="https://render.githubusercontent.com/render/math?math=I = R^{\gamma}">, where I is the screen intensity, R is the requested signal, and <img src="https://render.githubusercontent.com/render/math?math=\gamma"> is the gamma curve of the display, the proportional relationship between the requested value and the actual light intensity can be found and adjusted.

The first part of the program simulates the gamma curve and output using inputted data. The second part of the program compares an objective "grayscale" created by black and white pixels in varying proportions to grayscale discs, which change in intensity. The user is asked to match the gray intensity of the disc to the black and white gray square in the background. This information is used to estimate the gamma curve of the display of the user.

 ![Pattern4](https://user-images.githubusercontent.com/64177820/146288105-3e385c6a-8314-4051-96da-d9070e424c91.png)
 
 
 <i>An example of a pattern that a user will see. The middle disk gray intensity is adjustable.</i>


The compatibility of the following functions has been tested on both a Retina-display Mac running OSX Catalina and Big Sur and a Windows 10 PC with various screen resolutions.

These functions require Matlab R2020a or newer for optimal functioning, as well as the Curve Fitting Toolbox and the Image Processing Toolbox. Psychtoolbox-based functions are not compatible with external monitors connected to Retina-display computers or on Windows 8 operating system or newer. Psychtoolbox does not recognise the resolution of the external monitor as an extension of a Retina-display and formats the stimulus as a default one, while Windows 10 window desktop manager prevents Psychtoolbox from identifying the window space and may display the stimulus between two screens. Psychtoolbox will have an error the first time that it is initialised on a Retina display. Please run a Psychtoolbox-inclusive function at least once prior to presenting the experiment to a participant.

Please use matlabProjectMaster.mlx to run the scripts provided below. The live script can run functions step by step. Please note that not all dependent functions are supplied, and that they need to be added to the working directory for them to function correctly. Dependent functions are noted in each step’s instructions.

## Simulating the Power Law Formula

The following script generates an array of values, stores them, and calculates the intensities of a display with a gamma value of 2.2 for each value:

```
requestedSignal = [0:0.05:1]; %Create requestedSignal object with numbers from 0 to 1 in a 0.05 interval
 
lightOutput = requestedSignal .^ 2.2; %Run power law formula for every value in requestedSignal
```
The lightOutput object contains each requestedSignal value to the power of 2.2. The object shows the output intensity when the gamma is 2.2.

The “plotLightOutput.m” function plots the gamma curve and outputs the plot as a .png file called “GammaDataPlot.png” in the working directory.
The function accepts light output and requested signal data as input arguments, but only as matrices with either a single row or column to avoid potential errors with any other data types.The requested signal is placed on the x-axis while the light output is placed on the y-axis.
The lightOutput data is then smoothed using the smooth function from the Curve Fitting Toolbox before being plotted, while requestedSignal should already have consistent intervals regardless of transformation (i.e. 1/9, 2/9…), have no noise, and be non-alterable due to their pre-specified nature. x and y axes limits are implemented since all values should remain between 0 and 1.

The “alterGamma.m” function accepts an image file and a desired gamma value as input arguments to simulate an environment with the given gamma value. The image file must be loaded by specifying the file location, or name if the image is in the current working directory (e.g. alterGamma(‘testing.png’, 1.0)). The imread function transforms the image to a data array, and if the minimum and the maximum values of the data array exceeds 0 or 1 respectively, the im2double function rescales the output from integer data to a 0 to 1 scale. The power-law formula then transforms the image data to the specified gamma value. The im2double function is particularly useful for grey-scale intensities and removes the necessity to include another line of code to convert integer-based data to a 0 to 1 scale to fit the power-law formula. The function also allows for multiple image-type inputs, such as intensity, RGB, and binary. Finally, the updated data is displayed using the imshow function. imshow displays the matrix as an image and assumes that the data are pixel intensities.

The “plotLightOutput.m” function can be used in the following manner:

```
GammaData = readmatrix('GammaData.csv');

plotLightOutput(GammaData(:, 1), GammaData(:, 2))
```

The dataset is read as a matrix as opposed to a table to omit any header text, without needing subsequent lines of code for processing. The plotLightOutput function then uses the first column as the requestedSignal argument and the second column as the lightOutput argument. The .png file of the plot is stored as “GammaDataPlot.png” in the working directory.

The “PowerLawFit.m” function accepts x value data (requested signal) and y value data (recorded output) and plots the data points in comparison to a power-law curve generated using the fit function of the Curve Fitting Toolbox. This function utilises the nonlinear least-squares model and is an exponential type fit. Since the exponential model is convex/concave and will only provide one answer as the best fit, the inputted dataset will have one answer as the best fit as opposed to other nonlinear least-squares models with multiple possibilities. Thus, the most efficient starting point will be the one closest to “the correct answer”. Since most screens will have a gamma of around 2, the starting exponent is set to 2 to make the algorithm more efficient. However, the function will run and find the correct fit speedily regardless of a starting point if omitted due to the limited nature of answers. The outputted figure will display the best-fitting gamma for the dataset, along with the curve and the data points.

## Perceptual Gamma Estimation

The “eightTest.m” function will create 8 patterns based on the white and black units created by the GenerateThreeByThreeElement function and no input argument is needed. For each pattern, the for loop will call a three-by-three element with an increasing proportion of white in each iteration. Once the element is created, it is repeated 200 times in each direction using the repmat function to create a 600 by 600-pixel pattern. The pattern is then outputted as a .png file, shown to the user in a figure window, and after a keystroke, will close and continue the next iteration of the loop. This process will allow the user to verify the patterns and continue without a build-up of multiple figure windows. The .png files will be saved as “PatternNumber.png”, with “Number” representing the white proportion of the pattern in the white-black proportion (i.e. Pattern1.png for 1/9 white proportion) in the working directory.

The functions, “SetupInitialStimulus.m”, “UpdateStimulus.m”, and “CloseandTidy.m” can be used in the following manner:
```
[windowPointer, wPattern, hPattern] = SetupInitialStimulus(1, 0.2);
KbWait;
UpdateStimulus(windowPointer, wPattern, hPattern, 0.5)
KbWait;
CloseandTidy
```
SetupInitialStimulus receives the desired halftone pattern and grey-level as input arguments. The function checks for boundaries in input arguments and displays an error if the halftone range is not within 1-8 and grey-level is not within 0-1. It then opens a black Psychtoolbox window if there are none presently open using the function “OpenPTBWindow.m”. The specified halftone pattern is read (Pattern1.png), a hidden figure window is opened, and AltDrawDisc is called to draw the initially specified grey-level (0.2) over the halftone pattern. Since capturing the figure as an image requires output from and input into Matlab, the figure is then captured as a frame and converted as an image within Matlab and made into a texture to display on the Psychtoolbox window to use less processing power. This method ensures that the image is displayed true to its original dimensions and is shown as intended. To allow for integration with other functions, the function ends by flipping the drawn contents to the window and outputs the figure window object, width, and height of the halftone pattern. KbWait allows Psychtoolbox to wait for an input by the user to continue on to the next function while the window is still visible to the user, then UpdateStimulus takes the input arguments and checks whether the updated grey-level intensity is within range. If the intensity is out of range, the function returns to the Matlab command window and shows a warning and an option to either start over from the closest extreme grey-level within range or to quit the program. This is to account for key presses that may contribute to an accidental termination of an experiment and data loss if it is used within a loop and terminates from an error. A warning is used instead of the OS sound since users may not understand what they are doing wrong, may have accidentally been pressing the same button continuously, and would allow the script to continue after input. This error should not be a frequent issue. UpdateStimulus then uses the current Psychtoolbox window and draws a new disc as a texture with AltDrawDisc over the existing pattern. Finally, KbWait waits for the user input, then CloseandTidy closes all Psychtoolbox windows and terminates the program. Separating CloseandTidy allows for continuous display of stimuli in multiple contexts without closing the Psychtoolbox window.







## References

<sup>1</sup> Parraga, C. A., Roca-Vila, J., Karatzas, D. and Wuerger, S. M. (2014) “Limitations of visual gamma corrections in LCD displays” Displays 35 (2014) 227–239. 
