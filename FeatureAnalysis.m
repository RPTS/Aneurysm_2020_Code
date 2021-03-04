%%%% This file analyzes features %%%%

clear
close all

load('SequenceFeatureA.mat')
load('SequenceFeatureD1.mat')
load('SequenceFeatureP1.mat')
load('SequenceFeatureD2.mat')
load('SequenceFeatureP2.mat')

% figure;
% scatter(SequenceFeatureA.Curvature_integration(1:4),SequenceFeatureA.Torsion_integration(1:4),'x','MarkerEdgeColor','r');
% hold on
% scatter(SequenceFeatureA.Curvature_integration(5:8),SequenceFeatureA.Torsion_integration(5:8),'o','MarkerEdgeColor','r');
% scatter(SequenceFeatureD1.Curvature_integration(1:4),SequenceFeatureD1.Torsion_integration(1:4),'x','MarkerEdgeColor','g');
% scatter(SequenceFeatureD1.Curvature_integration(5:8),SequenceFeatureD1.Torsion_integration(5:8),'o','MarkerEdgeColor','g');
% scatter(SequenceFeatureP1.Curvature_integration(1:4),SequenceFeatureP1.Torsion_integration(1:4),'x','MarkerEdgeColor','b');
% scatter(SequenceFeatureP1.Curvature_integration(5:8),SequenceFeatureP1.Torsion_integration(5:8),'o','MarkerEdgeColor','b');
% scatter(SequenceFeatureD2.Curvature_integration(1:4),SequenceFeatureD2.Torsion_integration(1:4),'x','MarkerEdgeColor','y');
% scatter(SequenceFeatureD2.Curvature_integration(5:8),SequenceFeatureD2.Torsion_integration(5:8),'o','MarkerEdgeColor','y');
% scatter(SequenceFeatureP2.Curvature_integration(1:4),SequenceFeatureP2.Torsion_integration(1:4),'x','MarkerEdgeColor','c');
% scatter(SequenceFeatureP2.Curvature_integration(5:8),SequenceFeatureP2.Torsion_integration(5:8),'o','MarkerEdgeColor','c');
% xlabel('curvature')
% ylabel('torsion')
% title('Accumulated Curvature and Torsion')

%%%%%%%%%%% Curvature and Torsion %%%%%%%%%%%%
%% KT_integration
figure;
scatter(SequenceFeatureA.Curvature_integration,SequenceFeatureA.Torsion_integration,'MarkerEdgeColor','r');
hold on
scatter(SequenceFeatureD1.Curvature_integration,SequenceFeatureD1.Torsion_integration,'MarkerEdgeColor','g');
scatter(SequenceFeatureP1.Curvature_integration,SequenceFeatureP1.Torsion_integration,'MarkerEdgeColor','b');
scatter(SequenceFeatureD2.Curvature_integration,SequenceFeatureD2.Torsion_integration,'MarkerEdgeColor','y');
scatter(SequenceFeatureP2.Curvature_integration,SequenceFeatureP2.Torsion_integration,'MarkerEdgeColor','c');
xlabel('curvature')
ylabel('torsion')
legend('aneurysm','distal 1','proximal 1','distal 2','proximal 2')
title('Accumulated Curvature and Torsion')

%% KT_max
figure;
scatter(SequenceFeatureA.Curvature_max,SequenceFeatureA.Torsion_max,'MarkerEdgeColor','r');
hold on
scatter(SequenceFeatureD1.Curvature_max,SequenceFeatureD1.Torsion_max,'MarkerEdgeColor','g');
scatter(SequenceFeatureP1.Curvature_max,SequenceFeatureP1.Torsion_max,'MarkerEdgeColor','b');
scatter(SequenceFeatureD2.Curvature_max,SequenceFeatureD2.Torsion_max,'MarkerEdgeColor','y');
scatter(SequenceFeatureP2.Curvature_max,SequenceFeatureP2.Torsion_max,'MarkerEdgeColor','c');
xlabel('curvature')
ylabel('torsion')
legend('aneurysm','distal 1','proximal 1','distal 2','proximal 2')
title('Maximum Curvature and Torsion')

%% KT_mean
figure;
scatter(SequenceFeatureA.Curvature_mean,SequenceFeatureA.Torsion_mean,'MarkerEdgeColor','r');
hold on
scatter(SequenceFeatureD1.Curvature_mean,SequenceFeatureD1.Torsion_mean,'MarkerEdgeColor','g');
scatter(SequenceFeatureP1.Curvature_mean,SequenceFeatureP1.Torsion_mean,'MarkerEdgeColor','b');
scatter(SequenceFeatureD2.Curvature_mean,SequenceFeatureD2.Torsion_mean,'MarkerEdgeColor','y');
scatter(SequenceFeatureP2.Curvature_mean,SequenceFeatureP2.Torsion_mean,'MarkerEdgeColor','c');
xlabel('curvature')
ylabel('torsion')
legend('aneurysm','distal 1','proximal 1','distal 2','proximal 2')
title('Average Curvature and Torsion')

%% KT_std
figure;
scatter(SequenceFeatureA.Curvature_std,SequenceFeatureA.Torsion_std,'MarkerEdgeColor','r');
hold on
scatter(SequenceFeatureD1.Curvature_std,SequenceFeatureD1.Torsion_std,'MarkerEdgeColor','g');
scatter(SequenceFeatureP1.Curvature_std,SequenceFeatureP1.Torsion_std,'MarkerEdgeColor','b');
scatter(SequenceFeatureD2.Curvature_std,SequenceFeatureD2.Torsion_std,'MarkerEdgeColor','y');
scatter(SequenceFeatureP2.Curvature_std,SequenceFeatureP2.Torsion_std,'MarkerEdgeColor','c');
xlabel('curvature')
ylabel('torsion')
legend('aneurysm','distal 1','proximal 1','distal 2','proximal 2')
title('Standard Deviation of Curvature and Torsion')

%% KT_variation
figure;
scatter(SequenceFeatureA.Curvature_variation,SequenceFeatureA.Torsion_variation,'MarkerEdgeColor','r');
hold on
scatter(SequenceFeatureD1.Curvature_variation,SequenceFeatureD1.Torsion_variation,'MarkerEdgeColor','g');
scatter(SequenceFeatureP1.Curvature_variation,SequenceFeatureP1.Torsion_variation,'MarkerEdgeColor','b');
scatter(SequenceFeatureD2.Curvature_variation,SequenceFeatureD2.Torsion_variation,'MarkerEdgeColor','y');
scatter(SequenceFeatureP2.Curvature_variation,SequenceFeatureP2.Torsion_variation,'MarkerEdgeColor','c');
xlabel('curvature')
ylabel('torsion')
legend('aneurysm','distal 1','proximal 1','distal 2','proximal 2')
title('Variation of Curvature and Torsion')


%%%%%%%% CrossArea & EquivDiameter %%%%%%
%% AE_integration
figure;
scatter(SequenceFeatureA.CrossArea_integration,SequenceFeatureA.EquivDiameter_integration,'MarkerEdgeColor','r');
hold on
scatter(SequenceFeatureD1.CrossArea_integration,SequenceFeatureD1.EquivDiameter_integration,'MarkerEdgeColor','g');
scatter(SequenceFeatureP1.CrossArea_integration,SequenceFeatureP1.EquivDiameter_integration,'MarkerEdgeColor','b');
scatter(SequenceFeatureD2.CrossArea_integration,SequenceFeatureD2.EquivDiameter_integration,'MarkerEdgeColor','y');
scatter(SequenceFeatureP2.CrossArea_integration,SequenceFeatureP2.EquivDiameter_integration,'MarkerEdgeColor','c');
xlabel('area')
ylabel('equivdiameter')
legend('aneurysm','distal 1','proximal 1','distal 2','proximal 2')
title('Accumulated Cross Sectional Area and EquivDiameter')

%% AE_max
figure;
scatter(SequenceFeatureA.CrossArea_max,SequenceFeatureA.EquivDiameter_max,'MarkerEdgeColor','r');
hold on
scatter(SequenceFeatureD1.CrossArea_max,SequenceFeatureD1.EquivDiameter_max,'MarkerEdgeColor','g');
scatter(SequenceFeatureP1.CrossArea_max,SequenceFeatureP1.EquivDiameter_max,'MarkerEdgeColor','b');
scatter(SequenceFeatureD2.CrossArea_max,SequenceFeatureD2.EquivDiameter_max,'MarkerEdgeColor','y');
scatter(SequenceFeatureP2.CrossArea_max,SequenceFeatureP2.EquivDiameter_max,'MarkerEdgeColor','c');
xlabel('area')
ylabel('equivdiameter')
legend('aneurysm','distal 1','proximal 1','distal 2','proximal 2')
title('Maximum Cross Sectional Area and EquivDiameter')

%% AE_mean
figure;
scatter(SequenceFeatureA.CrossArea_mean,SequenceFeatureA.EquivDiameter_mean,'MarkerEdgeColor','r');
hold on
scatter(SequenceFeatureD1.CrossArea_mean,SequenceFeatureD1.EquivDiameter_mean,'MarkerEdgeColor','g');
scatter(SequenceFeatureP1.CrossArea_mean,SequenceFeatureP1.EquivDiameter_mean,'MarkerEdgeColor','b');
scatter(SequenceFeatureD2.CrossArea_mean,SequenceFeatureD2.EquivDiameter_mean,'MarkerEdgeColor','y');
scatter(SequenceFeatureP2.CrossArea_mean,SequenceFeatureP2.EquivDiameter_mean,'MarkerEdgeColor','c');
xlabel('area')
ylabel('equivdiameter')
legend('aneurysm','distal 1','proximal 1','distal 2','proximal 2')
title('Average Cross Sectional Area and EquivDiameter')

%% AE_std
figure;
scatter(SequenceFeatureA.CrossArea_std,SequenceFeatureA.EquivDiameter_std,'MarkerEdgeColor','r');
hold on
scatter(SequenceFeatureD1.CrossArea_std,SequenceFeatureD1.EquivDiameter_std,'MarkerEdgeColor','g');
scatter(SequenceFeatureP1.CrossArea_std,SequenceFeatureP1.EquivDiameter_std,'MarkerEdgeColor','b');
scatter(SequenceFeatureD2.CrossArea_std,SequenceFeatureD2.EquivDiameter_std,'MarkerEdgeColor','y');
scatter(SequenceFeatureP2.CrossArea_std,SequenceFeatureP2.EquivDiameter_std,'MarkerEdgeColor','c');
xlabel('area')
ylabel('equivdiameter')
legend('aneurysm','distal 1','proximal 1','distal 2','proximal 2')
title('Standard Deviation of Cross Sectional Area and EquivDiameter')

%% AE_variation
figure;
scatter(SequenceFeatureA.CrossArea_variation,SequenceFeatureA.EquivDiameter_variation,'MarkerEdgeColor','r');
hold on
scatter(SequenceFeatureD1.CrossArea_variation,SequenceFeatureD1.EquivDiameter_variation,'MarkerEdgeColor','g');
scatter(SequenceFeatureP1.CrossArea_variation,SequenceFeatureP1.EquivDiameter_variation,'MarkerEdgeColor','b');
scatter(SequenceFeatureD2.CrossArea_variation,SequenceFeatureD2.EquivDiameter_variation,'MarkerEdgeColor','y');
scatter(SequenceFeatureP2.CrossArea_variation,SequenceFeatureP2.EquivDiameter_variation,'MarkerEdgeColor','c');
xlabel('area')
ylabel('equivdiameter')
legend('aneurysm','distal 1','proximal 1','distal 2','proximal 2')
title('Variation of Cross Sectional Area and EquivDiameter')

%%%%%%%% MajorAxis & MinorAxis %%%%%%
%% MM_integration
figure;
scatter(SequenceFeatureA.MajorAxis_integration,SequenceFeatureA.MinorAxis_integration,'MarkerEdgeColor','r');
hold on
scatter(SequenceFeatureD1.MajorAxis_integration,SequenceFeatureD1.MinorAxis_integration,'MarkerEdgeColor','g');
scatter(SequenceFeatureP1.MajorAxis_integration,SequenceFeatureP1.MinorAxis_integration,'MarkerEdgeColor','b');
scatter(SequenceFeatureD2.MajorAxis_integration,SequenceFeatureD2.MinorAxis_integration,'MarkerEdgeColor','y');
scatter(SequenceFeatureP2.MajorAxis_integration,SequenceFeatureP2.MinorAxis_integration,'MarkerEdgeColor','c');
xlabel('major')
ylabel('minor')
legend('aneurysm','distal 1','proximal 1','distal 2','proximal 2')
title('Accumulated Major and Minor Axis Length')

%% MM_max
figure;
scatter(SequenceFeatureA.MajorAxis_max,SequenceFeatureA.MinorAxis_max,'MarkerEdgeColor','r');
hold on
scatter(SequenceFeatureD1.MajorAxis_max,SequenceFeatureD1.MinorAxis_max,'MarkerEdgeColor','g');
scatter(SequenceFeatureP1.MajorAxis_max,SequenceFeatureP1.MinorAxis_max,'MarkerEdgeColor','b');
scatter(SequenceFeatureD2.MajorAxis_max,SequenceFeatureD2.MinorAxis_max,'MarkerEdgeColor','y');
scatter(SequenceFeatureP2.MajorAxis_max,SequenceFeatureP2.MinorAxis_max,'MarkerEdgeColor','c');
xlabel('major')
ylabel('minor')
legend('aneurysm','distal 1','proximal 1','distal 2','proximal 2')
title('Maximum Major and Minor Axis Length')

%% MM_mean
figure;
scatter(SequenceFeatureA.MajorAxis_mean,SequenceFeatureA.MinorAxis_mean,'MarkerEdgeColor','r');
hold on
scatter(SequenceFeatureD1.MajorAxis_mean,SequenceFeatureD1.MinorAxis_mean,'MarkerEdgeColor','g');
scatter(SequenceFeatureP1.MajorAxis_mean,SequenceFeatureP1.MinorAxis_mean,'MarkerEdgeColor','b');
scatter(SequenceFeatureD2.MajorAxis_mean,SequenceFeatureD2.MinorAxis_mean,'MarkerEdgeColor','y');
scatter(SequenceFeatureP2.MajorAxis_mean,SequenceFeatureP2.MinorAxis_mean,'MarkerEdgeColor','c');
xlabel('major')
ylabel('minor')
legend('aneurysm','distal 1','proximal 1','distal 2','proximal 2')
title('Average Major and Minor Axis Length')

%% MM_std
figure;
scatter(SequenceFeatureA.MajorAxis_std,SequenceFeatureA.MinorAxis_std,'MarkerEdgeColor','r');
hold on
scatter(SequenceFeatureD1.MajorAxis_std,SequenceFeatureD1.MinorAxis_std,'MarkerEdgeColor','g');
scatter(SequenceFeatureP1.MajorAxis_std,SequenceFeatureP1.MinorAxis_std,'MarkerEdgeColor','b');
scatter(SequenceFeatureD2.MajorAxis_std,SequenceFeatureD2.MinorAxis_std,'MarkerEdgeColor','y');
scatter(SequenceFeatureP2.MajorAxis_std,SequenceFeatureP2.MinorAxis_std,'MarkerEdgeColor','c');
xlabel('major')
ylabel('minor')
legend('aneurysm','distal 1','proximal 1','distal 2','proximal 2')
title('Standard Deviation of Major and Minor Axis Length')

%% MM_variation
figure;
scatter(SequenceFeatureA.MajorAxis_variation,SequenceFeatureA.MinorAxis_variation,'MarkerEdgeColor','r');
hold on
scatter(SequenceFeatureD1.MajorAxis_variation,SequenceFeatureD1.MinorAxis_variation,'MarkerEdgeColor','g');
scatter(SequenceFeatureP1.MajorAxis_variation,SequenceFeatureP1.MinorAxis_variation,'MarkerEdgeColor','b');
scatter(SequenceFeatureD2.MajorAxis_variation,SequenceFeatureD2.MinorAxis_variation,'MarkerEdgeColor','y');
scatter(SequenceFeatureP2.MajorAxis_variation,SequenceFeatureP2.MinorAxis_variation,'MarkerEdgeColor','c');
xlabel('major')
ylabel('minor')
legend('aneurysm','distal 1','proximal 1','distal 2','proximal 2')
title('Variation of Major and Minor Axis Length')

%%%%%%%% Solidity & Extent %%%%%%
%% SE_integration
figure;
scatter(SequenceFeatureA.Solidity_integration,SequenceFeatureA.Extent_integration,'MarkerEdgeColor','r');
hold on
scatter(SequenceFeatureD1.Solidity_integration,SequenceFeatureD1.Extent_integration,'MarkerEdgeColor','g');
scatter(SequenceFeatureP1.Solidity_integration,SequenceFeatureP1.Extent_integration,'MarkerEdgeColor','b');
scatter(SequenceFeatureD2.Solidity_integration,SequenceFeatureD2.Extent_integration,'MarkerEdgeColor','y');
scatter(SequenceFeatureP2.Solidity_integration,SequenceFeatureP2.Extent_integration,'MarkerEdgeColor','c');
xlabel('solidity')
ylabel('extent')
legend('aneurysm','distal 1','proximal 1','distal 2','proximal 2')
title('Accumulated Solidity and Extent')

%% SE_max
figure;
scatter(SequenceFeatureA.Solidity_max,SequenceFeatureA.Extent_max,'MarkerEdgeColor','r');
hold on
scatter(SequenceFeatureD1.Solidity_max,SequenceFeatureD1.Extent_max,'MarkerEdgeColor','g');
scatter(SequenceFeatureP1.Solidity_max,SequenceFeatureP1.Extent_max,'MarkerEdgeColor','b');
scatter(SequenceFeatureD2.Solidity_max,SequenceFeatureD2.Extent_max,'MarkerEdgeColor','y');
scatter(SequenceFeatureP2.Solidity_max,SequenceFeatureP2.Extent_max,'MarkerEdgeColor','c');
xlabel('solidity')
ylabel('extent')
legend('aneurysm','distal 1','proximal 1','distal 2','proximal 2')
title('Maximum Solidity and Extent')

%% SE_mean
figure;
scatter(SequenceFeatureA.Solidity_mean,SequenceFeatureA.Extent_mean,'MarkerEdgeColor','r');
hold on
scatter(SequenceFeatureD1.Solidity_mean,SequenceFeatureD1.Extent_mean,'MarkerEdgeColor','g');
scatter(SequenceFeatureP1.Solidity_mean,SequenceFeatureP1.Extent_mean,'MarkerEdgeColor','b');
scatter(SequenceFeatureD2.Solidity_mean,SequenceFeatureD2.Extent_mean,'MarkerEdgeColor','y');
scatter(SequenceFeatureP2.Solidity_mean,SequenceFeatureP2.Extent_mean,'MarkerEdgeColor','c');
xlabel('solidity')
ylabel('extent')
legend('aneurysm','distal 1','proximal 1','distal 2','proximal 2')
title('Average Solidity and Extent')

%% SE_std
figure;
scatter(SequenceFeatureA.Solidity_std,SequenceFeatureA.Extent_std,'MarkerEdgeColor','r');
hold on
scatter(SequenceFeatureD1.Solidity_std,SequenceFeatureD1.Extent_std,'MarkerEdgeColor','g');
scatter(SequenceFeatureP1.Solidity_std,SequenceFeatureP1.Extent_std,'MarkerEdgeColor','b');
scatter(SequenceFeatureD2.Solidity_std,SequenceFeatureD2.Extent_std,'MarkerEdgeColor','y');
scatter(SequenceFeatureP2.Solidity_std,SequenceFeatureP2.Extent_std,'MarkerEdgeColor','c');
xlabel('solidity')
ylabel('extent')
legend('aneurysm','distal 1','proximal 1','distal 2','proximal 2')
title('Standard Deviation of Solidity and Extent')

%% SE_variation
figure;
scatter(SequenceFeatureA.Solidity_variation,SequenceFeatureA.Extent_variation,'MarkerEdgeColor','r');
hold on
scatter(SequenceFeatureD1.Solidity_variation,SequenceFeatureD1.Extent_variation,'MarkerEdgeColor','g');
scatter(SequenceFeatureP1.Solidity_variation,SequenceFeatureP1.Extent_variation,'MarkerEdgeColor','b');
scatter(SequenceFeatureD2.Solidity_variation,SequenceFeatureD2.Extent_variation,'MarkerEdgeColor','y');
scatter(SequenceFeatureP2.Solidity_variation,SequenceFeatureP2.Extent_variation,'MarkerEdgeColor','c');
xlabel('solidity')
ylabel('extent')
legend('aneurysm','distal 1','proximal 1','distal 2','proximal 2')
title('Variation of Solidity and Extent')

