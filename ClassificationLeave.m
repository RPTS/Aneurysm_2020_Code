% Classification - Leave-one-out process
% (subspace discriminant, SVM, KNN, random forest)

clc
clear
close all

load('AllFeatureTable1.mat')
%load Model  % 0:SD 1:SVM 2:KNN 3:RF
%Group = table2cell(AllFeatureTable1(:,2));
ind = [518,528,516,381,383,525,522,499,540,88,201,469,493,58,52,63,100,244,530,526]; % 20 meaningful 
T = AllFeatureTable1(:,[2,ind]);
ind5 = [518,88,52,63,244];
T5 = AllFeatureTable1(:,[2,ind5]);
%T(33,:) = [];
num = 37;
% for i = 1:num
% Group{i} = num2str(Group{i});
% end

accuracy = zeros(num,1);
i = 1;
for i = 1:num
    TestData = T(i,:);
    TrainData = T;
    TrainData(i,:) = [];
    y = TestData(1,1);
    TestData(:,1) = [];
    [trainedClassifier, validationAccuracy] = trainClassifierSVM8(TrainData);
    %[trainedClassifier, validationAccuracy] = trainClassifierKNN8(TrainData);
    %[trainedClassifier, validationAccuracy] = trainClassifierRF8(TrainData);
    %[trainedClassifier, validationAccuracy] = trainClassifierLD6(TrainData);
    %[trainedClassifier, validationAccuracy] = trainClassifierSD8(TrainData);
    %[trainedClassifier, validationAccuracy] = trainClassifierLR6(TrainData);
    yfit = trainedClassifier.predictFcn(TestData);   
    accuracy(i) = sum(yfit==table2array(y));
end

mean(accuracy)
oldy = [ones(12,1);zeros(25,1)];


