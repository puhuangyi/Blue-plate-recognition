digitDatasetPath=fullfile('D:','matlab','cnn_2');
imds=imageDatastore(digitDatasetPath,'IncludeSubfolders',true,'LabelSource','foldernames');

%{
figure;
perm=randperm(15000,20);
for i=1:20
    subplot(4,5,i);
    imshow(imds.Files{perm(i)});
end


labelcount=countEachLabel(imds);
%}

%16151

%{
num=[];
for p=1:16151
    [t1,t2]=read(imds);
    [y_size,x_size,z_size]=size(t1);
    if z_size~=1
        num=[num t2.Filename];
        pathname=t2.Filename;
        pic=imread(pathname);
        pic1=rgb2gray(pic);
        pic2=imbinarize(pic1);
        imwrite(pic2,pathname);
    end
end

x=0;
reset(imds);
num1=[];
for p=1:16151
    [t3,t4]=read(imds);
    [y1_size,x1_size,z1_size]=size(t3);
    if z1_size~=1
        num1=[num1 t4.Filename];
        x=x+1;
    end
end
%}

try
    nnet.internal.cnngpu.reluForward(1);
catch ME
end


[imdsTrain,imdsValidation] = splitEachLabel(imds,0.7,'randomize');

layers = [
    imageInputLayer([20 20 1])
    
    convolution2dLayer(3,8,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,16,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,32,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    fullyConnectedLayer(65)
    softmaxLayer
    classificationLayer];

options = trainingOptions('sgdm', ...
    'InitialLearnRate',0.01, ...
    'MaxEpochs',4, ...
    'Shuffle','every-epoch', ...
    'ValidationData',imdsValidation, ...
    'ValidationFrequency',30, ...
    'Verbose',false, ...
    'Plots','training-progress');

net = trainNetwork(imdsTrain,layers,options);



