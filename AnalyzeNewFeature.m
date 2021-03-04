% analyze new features (half aneurysm + distal/proximal)

clear 
close all

load FeatureTable4

Observation = table2array(FeatureTable4(1:26,3:end));
Group = table2array(FeatureTable4(1:26,2));

%% Selecting Features Using a Simple Filter Approach
dataG1 = Observation(grp2idx(Group)==1,:);
dataG2 = Observation(grp2idx(Group)==2,:);
[h,p,ci,stat] = ttest2(dataG1,dataG2,'Vartype','unequal'); % Group rup and un
ecdf(p);
xlabel('P value');
ylabel('CDF value');

[~,featureIdxSortbyP] = sort(p,2); 
ttest_ind = featureIdxSortbyP(1:15); 

ind = [147,88,151,46,135,139,106,110];
T = FeatureTable4(1:24,[2,ind]);
FeatureGroupSet = FeatureTable4(:,[2,ttest_ind+2]);
FeatureSet = table2array(FeatureGroupSet);
FeatureSet(:,1) = [];

FeatureGroupSet1 = FeatureGroupSet(1:24,[1,3,5,8,9,14,15]);
FeatureSet1 = table2array(FeatureGroupSet1);
FeatureSet1(:,1) = [];

% Cur_PD = table2array(NewAllFeature(1:26,63:68))+table2array(NewAllFeature(1:26,123:128));
% Cur_PD_max = Cur_PD(:,1);
% Cur_PD_int = Cur_PD(:,2);
% Cur_PD_mean = Cur_PD(:,3);
% Cur_PD_absmean = Cur_PD(:,4);
% Cur_PD_sd = Cur_PD(:,5);
% Cur_PD_var = Cur_PD(:,6);
% Cur = table(Group,Cur_PD_max,Cur_PD_int,Cur_PD_mean,Cur_PD_absmean,Cur_PD_sd,Cur_PD_var);

