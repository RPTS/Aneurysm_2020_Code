load FeatureTable

% Append suffix to each features
for i=1:size(FT1_aneu,2)
%     FT1_aneu.Properties.VariableNames{i} = [FT1_aneu.Properties.VariableNames{i},'_A'];
    FT1_distal1.Properties.VariableNames{i} = [FT1_distal1.Properties.VariableNames{i},'_D'];
    FT1_proximal1.Properties.VariableNames{i} = [FT1_proximal1.Properties.VariableNames{i},'_P'];
    FT1_distal2.Properties.VariableNames{i} = [FT1_distal2.Properties.VariableNames{i},'_D2'];
    FT1_proximal2.Properties.VariableNames{i} = [FT1_proximal2.Properties.VariableNames{i},'_P2'];
%     FT1_distal3.Properties.VariableNames{i} = [FT1_distal3.Properties.VariableNames{i},'_D3'];
%     FT1_proximal3.Properties.VariableNames{i} = [FT1_proximal3.Properties.VariableNames{i},'_P3'];
    FT_PD.Properties.VariableNames{i} = [FT_PD.Properties.VariableNames{i},'_PD'];
    FT_PD2.Properties.VariableNames{i} = [FT_PD2.Properties.VariableNames{i},'_PD2'];
%     FT_PD3.Properties.VariableNames{i} = [FT_PD3.Properties.VariableNames{i},'_PD3'];
%     FT_PA.Properties.VariableNames{i} = [FT_PA.Properties.VariableNames{i},'_PA'];
%     FT_DA.Properties.VariableNames{i} = [FT_DA.Properties.VariableNames{i},'_DA'];
%     FT1_ap.Properties.VariableNames{i} = [FT1_ap.Properties.VariableNames{i},'_ap'];
%     FT1_ad.Properties.VariableNames{i} = [FT1_ad.Properties.VariableNames{i},'_ad'];
%     FT_pd.Properties.VariableNames{i} = [FT_pd.Properties.VariableNames{i},'_pd'];
end

% Append each case
% need to revise when group changes from 1 to 0 after 12 cases
% 5 segments
caseT = {str2num(name) 1 seg d1L d2L p1L p2L};
caseT = cell2table(caseT,'VariableNames',{'Case' 'Group' 'segmentP' 'd1L' 'd2L' 'p1L' 'p2L'});
% 3 segments
% caseT = {str2num(name) 0 segd segp d1L p1L};
% caseT = cell2table(caseT,'VariableNames',{'Case' 'Group' 'segmentD' 'segmentP' 'd1L' 'p1L'});
% 7 segments
% caseT = {str2num(name) 0 seg d1L d2L d3L p1L p2L p3L};
% caseT = cell2table(caseT,'VariableNames',{'Case' 'Group' 'segmentPoint' 'd1L' 'd2L' 'd3L' 'p1L' 'p2L' 'p3L'});

writetable([caseT,FT1_distal1,FT1_distal2,FT1_proximal1,FT1_proximal2,FT_PD,FT_PD2,FT],'AllNewFeaturesnew.xlsx');

% if strcmp(name,'1')
    % 5 segments
%     writetable([caseT,FT1_distal1,FT1_distal2,FT1_proximal1,FT1_proximal2,FT_PD,FT_PD2,FT],'AllNewFeaturesnew.xlsx');
    % 3 segments
%     writetable([caseT,FT1_distal1,FT1_proximal1,FT_PD,FT],'AllNewFeatures2.xlsx');
    % 7 segments
%     writetable([caseT,FT1_distal1,FT1_distal2,FT1_distal3,FT1_proximal1,FT1_proximal2,FT1_proximal3,...
%         FT_PD,FT_PD2,FT_PD3,FT],'AllNewFeatures4.xlsx');
% else
    % 5 segments
%     writetable([caseT,FT1_distal1,FT1_distal2,FT1_proximal1,FT1_proximal2,FT_PD,FT_PD2,FT],...
%     'AllNewFeaturesnew.xlsx','WriteMode','Append',...
%     'WriteVariableNames',false,'WriteRowNames',true)
    % 3 segments
%     writetable([caseT,FT1_distal1,FT1_proximal1,FT_PD,FT],...
%     'AllNewFeatures2.xlsx','WriteMode','Append',...
%     'WriteVariableNames',false,'WriteRowNames',true)
    % 7 segments
%     writetable([caseT,FT1_distal1,FT1_distal2,FT1_distal3,FT1_proximal1,FT1_proximal2,FT1_proximal3,...
%         FT_PD,FT_PD2,FT_PD3,FT],'AllNewFeatures4.xlsx','WriteMode','Append',...
%         'WriteVariableNames',false,'WriteRowNames',true)
% end

% AllNewFeatures: use curvature torsion and didn't add new features
% AllNewFeatures1: use cross sectional area and added new features (still
% have cruvedist, 5 segments
% AllNewFeatures1_revised: use cross sectional area and removed leftover
% aneu-related features, 5 segments
% AllNewFeatures2: use curvature torsion and kappa and 3 segments
% AllNewFeautre3:use curvature torsion and kappa, 3 segments, removed
% curvedist features
% AllNewFeature4: use cross sectional area, 7 segments

% command-line commands
% for i=[1,2,3,5,9,10,14,16,26,27,28,29]
%     save runName i
%     Step1
%     Step2
%     Step3
%     Step4
%     Step5
%     Step6
%     generateAllFeature
% end
%     
% for i=[4,6,7,8,12,13,19,21,22,30,31,32,33,36,39,40,41,42,43,44,45,47,48,49,50]
%      save runName i
%      Step1
%      Step2
%      Step3
%      Step4
%      Step5
%      Step6
%      generateAllFeature
%  end