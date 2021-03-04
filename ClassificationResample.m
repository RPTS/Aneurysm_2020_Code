% Classification - Subsample 80%+20% process
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
n = 30;

accuracySVM = zeros(n,1);
accuracyKNN = zeros(n,1);
accuracyRF = zeros(n,1);
accuracyLD = zeros(n,1);
accuracySD = zeros(n,1);
accuracyLR = zeros(n,1);
i = 1;
for i = 1:n
    [RtrainInd,~,RtestInd] = dividerand(12,0.8,0,0.2);    % rup
    [UtrainInd,~,UtestInd] = dividerand(num-12,0.8,0,0.2);    % unrup
    TrainInd = [RtrainInd,UtrainInd+12];
    TrainData = T(TrainInd,:);
    TestInd = [RtestInd,UtestInd+12];
    TestData = T(TestInd,:);
    y = TestData(:,1);
    TestData(:,1) = [];
    [trainedClassifierSVM, ~] = trainClassifierSVM8(TrainData);
    [trainedClassifierKNN, ~] = trainClassifierKNN2(TrainData);
    [trainedClassifierRF, ~] = trainClassifierRF2(TrainData);
    [trainedClassifierLD, ~] = trainClassifierLD2(TrainData);
    [trainedClassifierSD, ~] = trainClassifierSD2(TrainData);
    [trainedClassifierLR, ~] = trainClassifierLR2(TrainData);
    yfitSVM = trainedClassifierSVM.predictFcn(TestData);   
    accuracySVM(i) = sum(yfitSVM==table2array(y))/length(yfitSVM);
    yfitKNN = trainedClassifierKNN.predictFcn(TestData);   
    accuracyKNN(i) = sum(yfitKNN==table2array(y))/length(yfitKNN);
    yfitRF = trainedClassifierRF.predictFcn(TestData);   
    accuracyRF(i) = sum(yfitRF==table2array(y))/length(yfitRF);
    yfitLD = trainedClassifierLD.predictFcn(TestData);   
    accuracyLD(i) = sum(yfitLD==table2array(y))/length(yfitLD);
    yfitSD = trainedClassifierSD.predictFcn(TestData);   
    accuracySD(i) = sum(yfitSD==table2array(y))/length(yfitSD);
    yfitLR = trainedClassifierLR.predictFcn(TestData);   
    accuracyLR(i) = sum(yfitLR==table2array(y))/length(yfitLR);
end

aSVM = mean(accuracySVM)
aKNN = mean(accuracyKNN)
aRF = mean(accuracyRF)
aLD = mean(accuracyLD)
aSD = mean(accuracySD)
aLR = mean(accuracyLR)


[h,p,ci,stat] = ttest2(accuracySVM,accuracyRF,'Vartype','unequal')
std(accuracyRF)

