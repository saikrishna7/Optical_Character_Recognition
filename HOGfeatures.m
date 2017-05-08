%% Digit classification is a multiclass classification problem, where you have to classify an 
% image into one out of the ten possible digit classes. In this example, the fitcecoc function 
% from the Statistics and Machine Learning Toolbox™ is used to create a multiclass classifier 
% using binary SVMs.

% Start by extracting HOG features from the training set. These features will be used to train the classifier.

%% Loop over the trainingSet and extract HOG features from each image. A
% similar procedure will be used to extract features from the testSet.

f=dir('*.png');
    files={f.name};
    
%     for k=1:numel(files)
%         Im{k}=imread(files{k});
%     end
% 
%     Imv=mat2vec(Im); % convert image matrices into datapoint vectors
%     X=double(Imv{1}');
    
numImages = numel(files);
trainingFeatures = zeros(numImages, hogFeatureSize, 'single');

for i = 1:numImages
    img = readimage(trainingSet, i);

    img = rgb2gray(img);

    % Apply pre-processing steps
    img = imbinarize(img);

    trainingFeatures(i, :) = extractHOGFeatures(img, 'CellSize', cellSize);
end

% Get labels for each image.
trainingLabels = trainingSet.Labels;

