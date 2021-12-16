# Perceptual Gamma Correction Experiment

This MATLAB program is a perceptual gamma correction experiment modeled after Parraga et al. (2014)<sup>1</sup>. This program estimates the gamma curve of a given display using perceptual responses. Display gamma values vary across different monitors, however, can be estimated. Using the power law formula, <img src="https://render.githubusercontent.com/render/math?math=I = R^{\gamma}">, where I is the screen intensity, R is the requested signal, and <img src="https://render.githubusercontent.com/render/math?math=\gamma"> is the gamma curve of the display, the relationship between 



The compatibility of the following functions has been tested on both a Retina-display Mac running OSX Catalina and Big Sur and a Windows 10 PC with various screen resolutions.

These functions require Matlab R2020a or newer for optimal functioning, as well as the Curve Fitting Toolbox and the Image Processing Toolbox. Psychtoolbox-based functions are not compatible with external monitors connected to Retina-display computers or on Windows 8 operating system or newer. Psychtoolbox does not recognise the resolution of the external monitor as an extension of a Retina-display and formats the stimulus as a default one, while Windows 10 window desktop manager prevents Psychtoolbox from identifying the window space and may display the stimulus between two screens. Psychtoolbox will have an error the first time that it is initialised on a Retina display. Please run a Psychtoolbox-inclusive function at least once prior to presenting the experiment to a participant.

Please use matlabProjectMaster.mlx to run the scripts provided below. The live script can run functions question by question. Please note that not all dependent functions are supplied, and that they need to be added to the working directory for them to function correctly. Dependent functions are noted in each step’s instructions.

##

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



## References

<sup>1</sup> Parraga, C. A., Roca-Vila, J., Karatzas, D. and Wuerger, S. M. (2014) “Limitations of visual gamma corrections in LCD displays” Displays 35 (2014) 227–239. 
