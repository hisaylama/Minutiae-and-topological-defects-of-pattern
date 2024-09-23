clear all
close all

%%% START OF USER DEFINED VARIABLES %%%

%Input file information
Root = 'C:\Users\hlama\Desktop\Zain_Analysis\Topological_Defect+Detector\Defector-master\'; %Root directory containing your raw images and 'Orientations' subdirectory.
startFrame = 0; %First timepoint to be included in analysis
endFrame = 0; %Final timepoint to be included in analysis

%Defect detection parameters
procSettings.minimumDist = 3; %Minimum radius for defects not to be considered annihilated. In physical units. 
procSettings.tensorSize = 0.7; %Spatial scale of the Gaussian filter used to define the orientation tensor. In physical units
procSettings.pixSize = 0.39; %The size of an individual pixel (on its side) in physical units

plotting = true; %Whether you wish to export overlays of defects on your original grayscale images.
plotSubDir = 'defOverlays'; %Name of the subdirectory (inside Root) you want to save the overlay images inside of


%%% END OF USER DEFINED VARIABLES %%%
noFrames = endFrame - startFrame;
inDir = 'Images';
imgName = 'Sample_%04d.tiff';
outName = 'Defects.mat';

%Construct input file list
imgList = cell(endFrame-startFrame+1,1);
for i = startFrame:endFrame
    imgList{i-startFrame+1} = fullfile(Root,inDir,sprintf(imgName,i));
end
outFile = fullfile(Root,outName);


[negDefCents,negDefOris,posDefCents,posDefOris] = DefectorFind(imgList,procSettings,plotting,fullfile(Root,plotSubDir));
save(outFile,'posDefCents','posDefOris','negDefCents','negDefOris','procSettings');


% [procDefTracks] = DefectorTrack(posDefCents,negDefCents,posDefOris,negDefOris,trackSettings,plotting,imgList,fullfile(Root,plotSubDir));
% save(outFile,'procDefTracks','trackSettings','-append')