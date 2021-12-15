# Perceptual Gamma Correction 

The compatibility of the following functions has been tested on both a Retina-display Mac running OSX Catalina and Big Sur and a Windows 10 PC with various screen resolutions.
These functions require Matlab R2020a or newer for optimal functioning, as well as the Curve Fitting Toolbox and the Image Processing Toolbox. Psychtoolbox-based functions are not compatible with external monitors connected to Retina-display computers or on Windows 8 operating system or newer. Psychtoolbox does not recognise the resolution of the external monitor as an extension of a Retina-display and formats the stimulus as a default one, while Windows 10 window desktop manager prevents Psychtoolbox from identifying the window space and may display the stimulus between two screens. Psychtoolbox will have an error the first time that it is initialised on a Retina display. Please run a Psychtoolbox-inclusive function at least once prior to presenting the experiment to a participant.

Please use matlabProjectMaster.mlx to run the scripts provided below. The live script can run functions question by question. Please note that not all dependent functions are supplied, and that they need to be added to the working directory for them to function correctly. Dependent functions are noted in each step’s instructions.

##

The following script generates an array of values, stores them, and calculates the intensities of a display with a gamma value of 2.2 for each value:

```
{
requestedSignal = [0:0.05:1]; %Create requestedSignal object with numbers from 0 to 1 in a 0.05 interval
 
lightOutput = requestedSignal .^ 2.2; %Run power law formula for every value in requestedSignal
}
```
The lightOutput object contains each requestedSignal value to the power of 2.2. The object shows the output intensity when the gamma is 2.2.
