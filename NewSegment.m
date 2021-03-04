%%%% This file summerize features [Feature 1, Feature 2, and Feature 3] %%%%
% Input: Info, location, and supposedcurve
% Output: Feature tables (half aneurysm + the first distal part)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
close all

load('Info.mat');    
load('supposedcurve.mat');

%% Feature 1: sequence
CenterLine = OldCenterline;
CrossArea = OldArea;
AreaChange = [0;Area_diff1];
MaxR = MaxD/2;
MinR = MinD/2;
MajorAxis = MajorAxisLength;
MinorAxis = MinorAxisLength;
Curvature = OldKappa;
Torsion = OldTau;
Feature1 = table(CrossArea,AreaChange,MaxR,MinR,MajorAxis,MinorAxis,EquivDiameter,...
           Perimeter,Eccentricity,Solidity,Extent,Curvature,Torsion);

%% Summarize Feature 1 (max, accumulated,...) 
clearvars -except name Feature1 
load('location.mat');

aneu_middle = round((aneu_start+aneu_end)/2);
p_middle = round((Proximal_1+aneu_start)/2);
d_middle = round((Distal_1+aneu_end)/2);
[FT1_ap] = FTcalculation1(Feature1,p_middle,aneu_middle,Dist_relative); % Feature 1 (aneurysm half + half Proximal 1)
[FT1_ad] = FTcalculation1(Feature1,aneu_middle,d_middle,Dist_relative); % Feature 1 (aneurysm half + half Distal 1)

%% Ratio of Sequence Feature (ap/ad) 
FT1_pd = table2array(FT1_ap(1,:))./table2array(FT1_ad(1,:));
FT_pd = [];
for i = 1:length(FT1_pd)
    FT_pd = [FT_pd, table(FT1_pd(i),'VariableNames',FT1_ap.Properties.VariableNames(i))];
end

%% Save Feature

save FeatureTable FT1_ap FT1_ad FT_pd '-append'

% writetable(FT1_ap,['Case_',name,'-4.xlsx'],'Sheet',1)      % new sequence feature
% writetable(FT1_ad,['Case_',name,'-4.xlsx'],'Sheet',2)
% writetable(FT_pd,['Case_',name,'-4.xlsx'],'Sheet',3)


