% find optimal threshold

clear 
close all 
load AllFeatureTable1

ind5 = [518,88,52,63,244]; % 5 meaningful 
T5 = AllFeatureTable1(:,[2,ind5]); 
F1 = table2array(T5(:,2));   % Area_pd
Extent_ad = table2array(T5(:,3));
E_range = Extent_ad./AllFeatureTable1.Length_aneu;
%F2 = (Extent_ad - min(Extent_ad))/(max(Extent_ad) - min(Extent_ad))*(max(E_range)-min(E_range)) + min(E_range);  % NorExtent_ad
F2 = ((Extent_ad - min(Extent_ad))/(max(Extent_ad) - min(Extent_ad))*(max(E_range)-min(E_range)) + min(E_range))/max(E_range); % Solidity
MaxD_d = table2array(T5(:,4));
F3 = MaxD_d./AllFeatureTable1.Length_aneu;    % NorMaxD_D
F4 = table2array(T5(:,5));    % Curmax_D
F5 = table2array(T5(:,6));    % Cur_PA
F6 = AllFeatureTable1.Length_aneu;
F7 = AllFeatureTable1.Ratio_DmaxL;
F8 = AllFeatureTable1.Diameter_aneu;

F = F1;
threshold1 = min(F):0.001:max(F);
for i = 1:length(threshold1)
good1(i) =sum(F(1:12) < threshold1(i));
good2(i) = sum(F(13:end) > threshold1(i));
good(i) = sum(F(1:12) < threshold1(i))+sum(F(13:end) > threshold1(i));
end
M = max(good);
ind = find(good1==9,1,'first');
good1(ind)
good2(ind)
threshold1(ind)
