% Analyze summerized table

clc
clear
close all

load('Feature5.mat')

corrcoef([Feature5.P1_Curvature_integration,Feature5.P1_Curvature_variation,Feature5.D1_Solidity_integration,Feature5.D1_Extent_integration,Feature5.Diameter_distal]);

figure;
hold on
scatter(Feature5.P1_Curvature_integration(1:8),Feature5.P1_Curvature_variation(1:8))
scatter(Feature5.P1_Curvature_integration(9:16),Feature5.P1_Curvature_variation(9:16))
xlabel('accumulated curvature at the first proximal part')
ylabel('curvature variation at the first proximal part')
legend('ruptured','untruptured')

figure;
hold on
scatter(Feature5.D1_Solidity_integration(1:8),Feature5.Diameter_distal(1:8))
scatter(Feature5.D1_Solidity_integration(9:16),Feature5.Diameter_distal(9:16))
xlabel('accumulated solidity at the first distal part')
ylabel('distal diameter of the aneurysm')
legend('ruptured','untruptured')
