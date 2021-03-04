% Edit Plots

clear 
close all 
load AllFeatureTable1

ind = [518,528,516,381,383,525,522,499,540,88,201,469,493,58,52,63,100,244,530,526]; % 20 meaningful 
ind5 = [518,88,52,63,244]; % 5 meaningful 
ind3 = [364,363,367];  % Length_aneu, Width, Ratio_DmaxL
T = AllFeatureTable1(:,[2,ind]);  
T5 = AllFeatureTable1(:,[2,ind5]); 
T3 = AllFeatureTable1(:,[2,ind3]);   
T7 = AllFeatureTable1(:,[2,ind3,ind5]); 

Feature = table2array(T5(:,2));
F1 = table2array(T5(:,2));   % Area_pd
Extent_ad = table2array(T5(:,4));
F3 = Extent_ad;
E_range = Extent_ad./AllFeatureTable1.Length_aneu;
%F3 = (Extent_ad - min(Extent_ad))/(max(Extent_ad) - min(Extent_ad))*(max(E_range)-min(E_range)) + min(E_range);  % NorExtent_ad
%F3 = ((Extent_ad - min(Extent_ad))/(max(Extent_ad) - min(Extent_ad))*(max(E_range)-min(E_range)) + min(E_range))/max(E_range);
MaxD_d = table2array(T5(:,3));
%F2 = MaxD_d./AllFeatureTable1.Length_aneu;    % NorMaxD_D
F2 = MaxD_d;
F4 = table2array(T5(:,5));    % Curmax_D
F5 = table2array(T5(:,6));    % Cur_PA

F6 = AllFeatureTable1.Length_aneu;
F7 = AllFeatureTable1.Ratio_DmaxL;
F8 = AllFeatureTable1.Diameter_aneu;

figure
h1 = histogram(F1(1:12));
hold on
h2 = histogram(F1(13:end));
h1.Normalization = 'probability';
h1.BinWidth = 0.25;
h1.FaceColor = 'r';
h2.Normalization = 'probability';
h2.BinWidth = 0.25;
h2.FaceColor = 'b';

figure
subplot(1,2,1)
boxplot(F1(1:12))
%ylim([0,3])
subplot(1,2,2)
boxplot(F1(13:end))
%ylim([0,3])

F = F8;
[h,p,ci,stat] = ttest2(F(13:end),F(1:12),'Vartype','unequal')
MSD = [mean(F(1:12)),std(F(1:12));mean(F(13:end)),std(F(13:end))];


