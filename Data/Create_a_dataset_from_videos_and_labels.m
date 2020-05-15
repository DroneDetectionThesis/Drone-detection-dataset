%% Introduction
% This is an example showing how to create a dataset for training from 
% videos and label-files.


%% Preparations:
% 1. Create a folder called Data under C:
% 2. Copy the folders Video_IR and Video_V to the folder C:\Data
% 3. Add the folder C:\Data to the Matlab path using "Set Path"
% This has to be done so that the DataSource-value of the groundTruth-
% object in the label-file points at the correct video file.


%% Load ground truth from four label-files
gt1=load('IR_AIRPLANE_001_LABELS.mat');
gt2=load('IR_BIRD_001_LABELS.mat');
gt3=load('IR_DRONE_001_LABELS.mat');
gt4=load('IR_HELICOPTER_001_LABELS.mat');


%% Put the ground truth together
gTruth = [gt1.gTruth;gt2.gTruth;gt3.gTruth;gt4.gTruth];
gTruth = selectLabels(gTruth,{'AIRPLANE','BIRD','DRONE','HELICOPTER'});


%% Create a folder for all the images that will be extracted from the videos
if isfolder(fullfile('Training_data_IR'))
    cd Training_data_IR
else
    mkdir Training_data_IR
end 
addpath('Training_data_IR');


%% Produce the training dataset
trainingData = objectDetectorTrainingData(gTruth,...
    'SamplingFactor', [1,1,1,1], ...
    'WriteLocation','Training_data_IR');
% Using a sampling factor of 1 means that all images from the video will be
% included in the dataset.
% If more or less than four label-files is to be included, the length of the
% SamplingFactor-array must also be changed so that the number of files and
% the length are the same.


%% Save the training dataset
save('Training_data_IR.mat',"trainingData")


%% Results
% You should now have the following:
% 1. A folder contaning the images extracted from the videos
% 2. A .mat-file with as many rows as images and five columns, one with
% the paths to the images and four with bounding boxes for the respective classes


%% Example of how to use the results:
% To load the dataset, use the following commands:
% addpath('Training_data_IR');
% data = load('Training_data_IR.mat');
% trainingData = data.trainingData;

% To train a detector, use the following commands:
% [detector,info] = trainYOLOv2ObjectDetector(trainingData,lgraph,options);
% Note that lgraph and options has to be defined first.


