% analyze features

clear 
close all

%%%%%%%%%%%% 26 cases %%%%%%%%%%%%%%
% load NewAllFeature1 % (NewAllFeature(1:26))
% Observation = table2array(NewAllFeature(1:26,3:end));
% Group = table2array(NewAllFeature(1:26,2));
% 
% %% Selecting Features Using a Simple Filter Approach
% dataG1 = Observation(grp2idx(Group)==1,:);
% dataG2 = Observation(grp2idx(Group)==2,:);
% [h,p,ci,stat] = ttest2(dataG1,dataG2,'Vartype','unequal'); % Group rup and unrup
% ecdf(p);
% xlabel('P value');
% ylabel('CDF value');
% 
% [~,featureIdxSortbyP] = sort(p,2); 
% ttest_ind = featureIdxSortbyP(1:15);    % the first 8 
% 
% ind = [52,67,89,187,201,383];        % supposed important feature index
% T = NewAllFeature(:,[2,ind]);  % feature table consists of important features
% FeatureGroupSet = NewAllFeature(:,[1,2,ttest_ind+2]);
% FeatureSet = table2array(FeatureGroupSet);
% FeatureSet(:,1) = [];
%%%%%%%%%%% 26 cases %%%%%%%%%%%%%%%

%%%%%%%%%%%% 37 cases %%%%%%%%%%%%%%%%%%%%
load AllFeatureTable1 % (AllFeatureTable1(1:37))

%AllFeatureTable1(33,:) = [];
Observation = table2array(AllFeatureTable1(1:end,3:end));
Group = table2array(AllFeatureTable1(1:end,2));

%% Selecting Features Using a Simple Filter Approach
dataG1 = Observation(grp2idx(Group)==1,:);
dataG2 = Observation(grp2idx(Group)==2,:);
[h,p,ci,stat] = ttest2(dataG1,dataG2,'Vartype','unequal'); % Group rup and unrup
ecdf(p);
xlabel('P value');
ylabel('CDF value');

[~,featureIdxSortbyP] = sort(p,2); 
ttest_ind = featureIdxSortbyP(1:30);    % the first 8 (19)

% ind = [52,67,89,187,201,383];        % supposed important feature index
% ind = [46,166,381,383,88,201,58,52];    % first 8 in the ttest_ind
% ind = [46,427,166,518,519,528,516,381,383,525,522,499,540,88,201,469,493,58,52]; % first 19 in the ttest_ind
ind = [518,528,516,381,383,525,522,499,540,88,201,469,493,58,52,63,100,244,530,526]; % 20 meaningful 
ind1 = [518,528,516,525,522,499,540,88,201,469,493,58,52,63,100,244,530,526]; % 18 meaningful (0.0607)
T = AllFeatureTable1(:,[2,ind]);  % feature table consists of important features
TNN = table2array(T);
TNN_label = TNN(:,1);
TNN(:,1) = [];
T1 = AllFeatureTable1(:,[2,ind1]);  % without angle and Distline
FeatureGroupSet = AllFeatureTable1(:,[1,2,ttest_ind+2]);
FeatureSet = table2array(FeatureGroupSet);
FeatureSet(:,1) = [];
%%%%%%%%%%%% 37 cases %%%%%%%%%%%%%%%%%%

% FeatureGroupSet1 = FeatureGroupSet(1:37,[1,3,5,8,9,14,15]);
% FeatureSet1 = table2array(FeatureGroupSet1);
% FeatureSet1(:,1) = [];

% Cur_PD = table2array(NewAllFeature(1:26,63:68))+table2array(NewAllFeature(1:26,123:128));
% Cur_PD_max = Cur_PD(:,1);
% Cur_PD_int = Cur_PD(:,2);
% Cur_PD_mean = Cur_PD(:,3);
% Cur_PD_absmean = Cur_PD(:,4);
% Cur_PD_sd = Cur_PD(:,5);
% Cur_PD_var = Cur_PD(:,6);
% Cur = table(Group,Cur_PD_max,Cur_PD_int,Cur_PD_mean,Cur_PD_absmean,Cur_PD_sd,Cur_PD_var);

%% Correlation

A = table2array(T(:,2:end));
R = corrcoef(A); 

