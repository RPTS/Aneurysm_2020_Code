%%%% This file summerize features [Feature 1, Feature 2, and Feature 3] %%%%
% Input: Info, location, and supposedcurve
% Output: Feature tables
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

%% Feature 2: supposed curve
CurveDist = Dist_curves;
Feature2 = table(CurveDist);

%% Feature 3
Angle = angle;
PointDist = distance_point;
LineDist = distance_line;
Feature3 = table(AsymmetryFactor,Angle,PointDist,LineDist);

%% Summarize Feature 1 (max, accumulated,...) 
clearvars -except name Feature1 Feature2 Feature3 Apart1
load('location.mat');

% corrplot(Feature1); 

% %%%%%%%%%%%%%%% old accumulated %%%%%%%%%%%%%
% [FT1_aneu] = FTcalculation(Feature1,aneu_start,aneu_end); % Feature 1 (aneurysm)
% [FT1_distal1] = FTcalculation(Feature1,aneu_end,Distal_1); % Feature 1 (Distal 1)
% [FT1_distal2] = FTcalculation(Feature1,Distal_1,Distal_2); % Feature 1 (Distal 2)
% [FT1_proximal1] = FTcalculation(Feature1,Proximal_1,aneu_start); % Feature 1 (Proximal 1)
% [FT1_proximal2] = FTcalculation(Feature1,Proximal_2,Proximal_1); % Feature 1 (Proximal 2)
% %%%%%%%%%%%%%%% old accumulated %%%%%%%%%%%%%

[FT1_aneu] = FTcalculation1(Feature1,aneu_start,aneu_end,Dist_relative); % Feature 1 (aneurysm)
[FT1_distal1] = FTcalculation1(Feature1,aneu_end,Distal_1,Dist_relative); % Feature 1 (Distal 1)
[FT1_distal2] = FTcalculation1(Feature1,Distal_1,Distal_2,Dist_relative); % Feature 1 (Distal 2)
% [FT1_distal3] = FTcalculation1(Feature1,Distal_2,Distal_3,Dist_relative); % Feature 1 (Distal 3)
[FT1_proximal1] = FTcalculation1(Feature1,Proximal_1,aneu_start,Dist_relative); % Feature 1 (Proximal 1)
[FT1_proximal2] = FTcalculation1(Feature1,Proximal_2,Proximal_1,Dist_relative); % Feature 1 (Proximal 2)
% [FT1_proximal3] = FTcalculation1(Feature1,Proximal_3,Proximal_2,Dist_relative); % Feature 1 (Proximal 3)

%% Ratio of Sequence Feature (P1/D1, P1/A, D1/A) 
FT1_PD = table2array(FT1_proximal1(1,:))./table2array(FT1_distal1(1,:));
FT1_PD2 = table2array(FT1_proximal2(1,:))./table2array(FT1_distal2(1,:));
% FT1_PD3 = table2array(FT1_proximal3(1,:))./table2array(FT1_distal3(1,:));
% FT1_PA = table2array(FT1_proximal1(1,:))./table2array(FT1_aneu(1,:));
% FT1_DA = table2array(FT1_distal1(1,:))./table2array(FT1_aneu(1,:));
FT_PD = [];
FT_PD2 = [];
% FT_PD3 = [];
% FT_PA = [];
% FT_DA = [];
for i = 1:length(FT1_PD)
    FT_PD = [FT_PD, table(FT1_PD(i),'VariableNames',FT1_aneu.Properties.VariableNames(i))];
    FT_PD2 = [FT_PD2, table(FT1_PD2(i),'VariableNames',FT1_aneu.Properties.VariableNames(i))];
%     FT_PD3 = [FT_PD3, table(FT1_PD3(i),'VariableNames',FT1_aneu.Properties.VariableNames(i))];
%     FT_PA = [FT_PA, table(FT1_PA(i),'VariableNames',FT1_aneu.Properties.VariableNames(i))];
%     FT_DA = [FT_DA, table(FT1_DA(i),'VariableNames',FT1_aneu.Properties.VariableNames(i))];
end


%% Discrete Feature: Diameter and Length
Diameter_aneu = FT1_aneu.MajorAxis_max;
% Length_aneu = AL;
Diameter_proximal = Feature1.MajorAxis(aneu_start);
Diameter_distal = Feature1.MajorAxis(aneu_end);
Diameter_normalP1 = Feature1.MajorAxis(Proximal_1);
Diameter_normalD1 = Feature1.MajorAxis(Distal_1);
Diameter_normalP2 = Feature1.MajorAxis(Proximal_2);
Diameter_normalD2 = Feature1.MajorAxis(Distal_2);
% Diameter_normalP3 = Feature1.MajorAxis(Proximal_3);
% Diameter_normalD3 = Feature1.MajorAxis(Distal_3);

% Ratio_DmaxL = Diameter_aneu/Length_aneu;
% Ratio_DpL = Diameter_proximal/Length_aneu;
% Ratio_DdL = Diameter_distal/Length_aneu;
% Ratio_Dpmax = Diameter_proximal/Diameter_aneu;
% Ratio_Ddmax = Diameter_distal/Diameter_aneu;

Ratio_Ddp = Diameter_distal/Diameter_proximal;

Ratio_Ddnor1 = Diameter_distal/Diameter_normalD1;
Ratio_Dpnor1 = Diameter_proximal/Diameter_normalP1;
Ratio_Ddnor2 = Diameter_distal/Diameter_normalD2;
Ratio_Dpnor2 = Diameter_proximal/Diameter_normalP2;
% Ratio_Ddnor3 = Diameter_distal/Diameter_normalD3;
% Ratio_Dpnor3 = Diameter_proximal/Diameter_normalP3;

Ratio_Dpnor12 = Diameter_normalP1/Diameter_normalP2;
Ratio_Ddnor12 = Diameter_normalD1/Diameter_normalD2;

% Ratio_Dpnor13 = Diameter_normalP1/Diameter_normalP3;
% Ratio_Ddnor13 = Diameter_normalD1/Diameter_normalD3;

% Ratio_Dpnor23 = Diameter_normalP2/Diameter_normalP3;
% Ratio_Ddnor23 = Diameter_normalD2/Diameter_normalD3;

Ratio_Dpnordnor1 = Diameter_normalP1/Diameter_normalD1;
Ratio_Dpnordnor2 = Diameter_normalP2/Diameter_normalD2;
% Ratio_Dpnordnor3 = Diameter_normalP3/Diameter_normalD3;

% FT1 = table(Diameter_aneu,Length_aneu,Diameter_proximal,Diameter_distal,Ratio_DmaxL,Ratio_DpL,Ratio_DdL,Ratio_Dpmax,Ratio_Ddmax,Ratio_Ddp,...
%     Ratio_Ddnor,Ratio_Dpnor);

% 5 segments
FT1 = table(Diameter_proximal,Diameter_distal,Diameter_normalP1,Diameter_normalD1,Diameter_normalP2, Diameter_normalD2,...
    Ratio_Ddp,Ratio_Ddnor1,Ratio_Dpnor1,Ratio_Ddnor2,Ratio_Dpnor2,...
    Ratio_Dpnor12,Ratio_Ddnor12,Ratio_Dpnordnor1,Ratio_Dpnordnor2);

% 3 segments
% FT1 = table(Diameter_aneu,Diameter_proximal,Diameter_distal,Diameter_normalP1,Diameter_normalD1,...
%     Ratio_Dpmax,Ratio_Ddmax,Ratio_Ddp,Ratio_Ddnor1,Ratio_Dpnor1,...
%     Ratio_Dpnordnor1);

% 7 segments
% FT1 = table(Diameter_proximal,Diameter_distal,Diameter_normalP1,Diameter_normalD1,...
%     Diameter_normalP2,Diameter_normalD2,Diameter_normalP3,Diameter_normalD3,...
%     Ratio_Ddp,Ratio_Ddnor1,Ratio_Dpnor1,Ratio_Ddnor2,Ratio_Dpnor2, Ratio_Ddnor3, Ratio_Dpnor3,...
%     Ratio_Dpnor12,Ratio_Ddnor12,Ratio_Dpnor13,Ratio_Ddnor13,Ratio_Dpnor23,Ratio_Ddnor23,...
%     Ratio_Dpnordnor1,Ratio_Dpnordnor2,Ratio_Dpnordnor3);

% clear Diameter_aneu Length_aneu Diameter_proximal Diameter_distal Ratio_DmaxL Ratio_DpL Ratio_DdL Ratio_Dpmax Ratio_Ddmax Ratio_Ddp Ratio_Ddnor Ratio_Dpnor

% 5 segments
clear Diameter_aneu Diameter_proximal Diameter_distal Diameter_normalP1 Diameter_normalD1 Diameter_normalP2  Diameter_normalD2 ...
    Ratio_Dpmax Ratio_Ddmax Ratio_Ddp Ratio_Ddnor1 Ratio_Dpnor1 Ratio_Ddnor2 Ratio_Dpnor2 ...
    Ratio_Dpnor12 Ratio_Ddnor12 Ratio_Dpnordnor1 Ratio_Dpnordnor2

% 3 segments
% clear Diameter_aneu Diameter_proximal Diameter_distal Diameter_normalP1 Diameter_normalD1 ...
%     Ratio_Dpmax Ratio_Ddmax Ratio_Ddp Ratio_Ddnor1 Ratio_Dpnor1 ...
%     Ratio_Dpnordnor1

% 7 segments
% clear Diameter_proximal Diameter_distal Diameter_normalP1 Diameter_normalD1 ...
%     Diameter_normalP2 Diameter_normalD2 Diameter_normalP3 Diameter_normalD3 ...
%     Ratio_Ddp Ratio_Ddnor1 Ratio_Dpnor1 Ratio_Ddnor2 Ratio_Dpnor2  Ratio_Ddnor3  Ratio_Dpnor3 ...
%     Ratio_Dpnor12 Ratio_Ddnor12 Ratio_Dpnor13 Ratio_Ddnor13 Ratio_Dpnor23 Ratio_Ddnor23 ...
%     Ratio_Dpnordnor1 Ratio_Dpnordnor2 Ratio_Dpnordnor3

%% Summarize Feature 2 (aneurysm-related)
% [CurveDist_max,CurveDist_integration,CurveDist_mean,CurveDist_std,CurveDist_variation] ...
%     = Fstatistics(Feature2.CurveDist);   % old accumulated  
% [CurveDist_max,CurveDist_integration,CurveDist_mean,CurveDist_absmean,CurveDist_std,CurveDist_variation] ...
%     = Fstatistics1(Feature2.CurveDist,Dist_relative(Apart1));
% FT2 = table(CurveDist_max,CurveDist_integration,CurveDist_mean,CurveDist_absmean, CurveDist_std,CurveDist_variation);
% clear CurveDist_max CurveDist_integration CurveDist_mean CurveDist_std CurveDist_variation

%% Save feature
% FT = [FT1 FT2 Feature3];
FT = [FT1 Feature3];
% 5 segments
save FeatureTable name Feature1 Feature2 Feature3...
     FT1_distal1 FT1_distal2 FT1_proximal1 FT1_proximal2 FT FT_PD FT_PD2 seg p1L p2L d1L d2L

% 3 segments
% save FeatureTable name Feature1 Feature2 Feature3 FT2 ...
%      FT1_distal1 FT1_proximal1 FT FT_PD segd segp p1L d1L

% 7 segments
% save FeatureTable name Feature1 Feature2 Feature3 ...
%      FT1_distal1 FT1_distal2 FT1_distal3 FT1_proximal1 FT1_proximal2 FT1_proximal3 ...
%      FT FT_PD FT_PD2 FT_PD3 seg p1L p2L p3L d1L d2L d3L
    
% writetable([FT1_aneu],['Case',name,'-1.xlsx'],'Sheet',1)              % original sequence feature
% writetable(FT1_distal1,['Case',name,'-1.xlsx'],'Sheet',2)
% writetable(FT1_proximal1,['Case',name,'-1.xlsx'],'Sheet',3)
% writetable(FT1_distal2,['Case',name,'-1.xlsx'],'Sheet',4)
% writetable(FT1_proximal2,['Case',name,'-1.xlsx'],'Sheet',5)
% 
% writetable(FT,['Case',name,'-2.xlsx'],'Sheet',1)                   % discrete feature
% 
% writetable(FT_PD,['Case',name,'-3.xlsx'],'Sheet',1)                % ratio of sequence feature
% writetable(FT_PA,['Case',name,'-3.xlsx'],'Sheet',2)
% writetable(FT_DA,['Case',name,'-3.xlsx'],'Sheet',3)


