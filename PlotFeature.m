% Plot Features

% clear 
close all 
% load AllFeatureTable1

new = [4.244110854
3.581021485
4.145168429
4.91618969
4.204473171
2.980433841
4.529504645
3.617991376
4.346143822
4.215993286
3.965044857
3.07183614
4.303894762
6.433830157
4.341426393
4.864501526
4.274267035
5.381985025
2.404191695
4.007323194
3.633893636
2.852688165
4.164578424
3.767281189
5.14394321
3.285016646
5.072526913
3.950439609
6.820489855
4.550022133
3.462562532
4.326972688
3.182038859
5.584708628
3.257513399
2.755385017
4.933463843];


Case = AllFeatureTable1.Case;
%Feature = table2array(AllFeatureTable1(:,ind(19)));
Feature = table2array(FeatureGroupSet(:,28));
%Feature = table2array(AllFeatureTable1(:,391));%+table2array(AllFeatureTable1(:,451));  %385+445,391+451

figure
scatter(Case(1:12), Feature(1:12), 'r')
hold on
scatter(Case(13:end), Feature(13:end), 'b')
legend('rup','unrup')

figure
scatter(Case(1:12), Feature(1:12)./AllFeatureTable1.Length_aneu(1:12), 'r')
hold on
scatter(Case(13:end), Feature(13:end)./AllFeatureTable1.Length_aneu(13:end), 'b')
legend('rup','unrup')

figure
h1 = histogram(Feature(1:12));
hold on
h2 = histogram(Feature(13:end));
h1.Normalization = 'probability';
h1.BinWidth = 0.25;
h1.FaceColor = 'r';
h2.Normalization = 'probability';
h2.BinWidth = 0.25;
h2.FaceColor = 'b';

% sign = [-1
% -1
% -1
% -1
% -1
% -1
% 1
% -1
% 1
% 1
% -1
% -1
% -1
% -1
% -1
% -1
% -1
% 1
% 1
% -1
% 1
% 1
% 1
% -1
% -1
% 1
% -1
% 1
% -1
% 1
% 1
% 1
% 1
% 1
% -1
% 1
% 1];
% 
% figure
% scatter(Case(1:12), sign(1:12), 'r')
% hold on
% scatter(Case(13:end), sign(13:end), 'b')
% legend('rup','unrup')
% 
% 
[h1,p1] = ttest2(Feature(1:12),Feature(13:end))
