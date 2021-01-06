function window = OpenPTBWindow

Screen('Preference', 'SkipSyncTests', 2); % Skip sync tests for PTB
Screen('Preference', 'VisualDebugLevel', 0); % Remove the visual debug screen on initialisation of PTB
whichScreen = 0; % Choose main window as the stimulus screen
PsychImaging('OpenWindow', whichScreen); % To configure the resolution for Retina screens, this script is needed to call the initial window before alterations
PsychImaging('PrepareConfiguration'); % Call configurations
PsychImaging('AddTask', 'General', 'UseRetinaResolution'); % Add Retina screen compatibility to configurations; if not placed, PTB will default to a basic resolution of 1440 x 900 and the stimulus will not be displayed correctly on Macs with Retina displays. This line will be ignored if the screen is not a Retina screen.
window = Screen(whichScreen, 'OpenWindow', [0 0 0]); % Open the stimulus window with a black background
HideCursor(window) % Hide the cursor on the stimulus display

end