% Classification (decision tree and SVM)

clc
clear
close all

load('NewAllFeature1.mat')
ind = [52,67,89,187,201,383];
T = NewAllFeature(:,ind);
%T(:,4) = [];
Group = table2cell(NewAllFeature(:,2));
num = 24;
for i = 1:num
Group{i} = num2str(Group{i});
end

n = 30;
accuracy = zeros(n,1);
for i = 1:n
    [BtrainInd,~,BtestInd] = dividerand(12,0.6,0,0.4);    % rup
    [CtrainInd,~,CtestInd] = dividerand(num-12,0.6,0,0.4);    % unrup
    TrainInd = [BtrainInd,CtrainInd+12];
    TrainData = T(TrainInd,:);
    TrainDataSet = table2array(TrainData(:,1:end));
    TrainLabel = Group(TrainInd);
    TestInd = [BtestInd,CtestInd+12];
    TestData = T(TestInd,:);
    TestDataSet = table2array(TestData(:,1:end));
    TestLabel = Group(TestInd);
    %Mdl = fitctree(TrainDataSet, TrainLabel);
    Mdl = fitcsvm(TrainDataSet, TrainLabel);
    TrainErr = resubLoss(Mdl);
    CVMdl = crossval(Mdl);
    CVErr = kfoldLoss(CVMdl);
    y_predict = predict(Mdl,TestDataSet);
    y = TestLabel;
    accuracy(i) = 1-sum(cell2mat(y_predict)~=cell2mat(y))/length(y);
end

mean(accuracy)
