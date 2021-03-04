% clear
% close all
%% Central Differentiation
name = num2str(i);
load(['Case',name,'.mat'])
% Approximate arclens by accumulating point to point geometric distance 
P2arclens = zeros(Proximal_1-Proximal_2,1);
inc = 0;
for i = 1: Proximal_1-Proximal_2
    step = sqrt(sum((OldCenterline(Proximal_2+i,:)-OldCenterline(Proximal_2+i-1,:)).^2));
    P2arclens(i) = inc + step;
    inc = P2arclens(i);
end

P1arclens = zeros(aneu_start-Proximal_1,1);
inc = 0;
for i = 1: aneu_start-Proximal_1
    step = sqrt(sum((OldCenterline(Proximal_1+i,:)-OldCenterline(Proximal_1+i-1,:)).^2));
    P1arclens(i) = inc + step;
    inc = P1arclens(i);
end

D1arclens = zeros(Distal_1-aneu_end,1);
inc = 0;
for i = 1: Distal_1-aneu_end
    step = sqrt(sum((OldCenterline(aneu_end+i,:)-OldCenterline(aneu_end+i-1,:)).^2));
    D1arclens(i) = inc + step;
    inc = D1arclens(i);
end

D2arclens = zeros(Distal_2-Distal_1,1);
inc = 0;
for i = 1: Distal_2-Distal_1
    step = sqrt(sum((OldCenterline(Distal_1+i,:)-OldCenterline(Distal_1+i-1,:)).^2));
    D2arclens(i) = inc + step;
    inc = D2arclens(i);
end

ecc_diff1 = diff(Eccentricity(Proximal_2:Proximal_1));
P2arclen_diff1 = [P2arclens(1);diff(P2arclens)];
ecc_rup_dXds = ecc_diff1./P2arclen_diff1;
ecc_terms = (ecc_rup_dXds.^2).*(P2arclen_diff1./2);
ecc_variation = sum(ecc_terms)/P2arclens(end); %% eccentricity P2

P1_curv_diff1 = diff(OldKappa(Proximal_1:aneu_start));
P1arclen_diff1 = [P1arclens(1);diff(P1arclens)];
P1_curv_rup_dXds = P1_curv_diff1./P1arclen_diff1;
P1_curv_terms = abs(P1_curv_rup_dXds).*(P1arclen_diff1./2);
P1_curv_variation = sum(P1_curv_terms)/P1arclens(end); %% curve P1

D1_curv_diff1 = diff(OldKappa(aneu_end:Distal_1));
D1arclen_diff1 = [D1arclens(1);diff(D1arclens)];
D1_curv_rup_dXds = D1_curv_diff1./D1arclen_diff1;
D1_curv_terms = abs(D1_curv_rup_dXds).*(D1arclen_diff1./2);
D1_curv_variation = sum(D1_curv_terms)/D1arclens(end);

PD_curv_variation = P1_curv_variation/D1_curv_variation; %% curve PD

P2_csa_diff1 = diff(OldArea(Proximal_2:Proximal_1));
P2arclen_diff1 = [P2arclens(1);diff(P2arclens)];
P2_csa_rup_dXds = P2_csa_diff1./P2arclen_diff1;
P2_csa_terms = abs(P2_csa_rup_dXds).*(P2arclen_diff1./2);
P2_csa_variation = sum(P2_csa_terms)/P2arclens(end);
 
D2_csa_diff1 = diff(OldArea(Distal_1:Distal_2));
D2arclen_diff1 = [D2arclens(1);diff(D2arclens)];
D2_csa_rup_dXds = D2_csa_diff1./D2arclen_diff1;
D2_csa_terms = abs(D2_csa_rup_dXds).*(D2arclen_diff1./2);
D2_csa_variation = sum(D2_csa_terms)/D2arclens(end);

PD2_csa_variation = P2_csa_variation/D2_csa_variation; %% curve PD2



caseT = {str2num(name) 0 ecc_variation P1_curv_variation D1_curv_variation ...
         PD_curv_variation P2_csa_variation D2_csa_variation PD2_csa_variation };
caseT = cell2table(caseT,'VariableNames',{'Case' 'Group' 'Eccentricity_Variation_P2' ...
        'Curvature_Variation_P1' 'Curvature_Variation_D1' 'Curvature_Variation_PD'...
        'CrossArea_Variation_P2' 'CrossArea_Variation_D2' 'CrossArea_Variation_PD2'});
if strcmp(name,'1')
    writetable(caseT,'Variations1.xlsx');
else
    writetable(caseT,'Variations1.xlsx','WriteMode','Append',...
     'WriteVariableNames',false,'WriteRowNames',true)
end


% for i=[1,2,3,5,9,10,14,16,26,27,28,29]
%     save runName i
%     GenerateClassificationGraph
% end
%     
% for i=[4,6,7,8,12,13,19,21,22,30,31,32,33,36,39,40,41,42,43,44,45,47,48,49,50]
%      save runName i
%      GenerateClassificationGraph
%  end

%%
% load Case26
% % Approximate arclens by accumulating point to point geometric distance 
% rupturedP2arclens = zeros(Proximal_1-Proximal_2,1);
% inc = 0;
% for i = 1: Proximal_1-Proximal_2
%     step = sqrt(sum((OldCenterline(Proximal_2+i,:)-OldCenterline(Proximal_2+i-1,:)).^2));
%     rupturedP2arclens(i) = inc + step;
%     inc = rupturedP2arclens(i);
% end
% 
% rupturedP1arclens = zeros(aneu_start-Proximal_1,1);
% inc = 0;
% for i = 1: aneu_start-Proximal_1
%     step = sqrt(sum((OldCenterline(Proximal_1+i,:)-OldCenterline(Proximal_1+i-1,:)).^2));
%     rupturedP1arclens(i) = inc + step;
%     inc = rupturedP1arclens(i);
% end
% 
% rupturedEcc = Eccentricity(:);
% rupturedCur = OldKappa(:);
% rupturedP1 = Proximal_1;
% rupturedP2 = Proximal_2;
% rupturedStart = aneu_start;
% rupturedEnd = aneu_end;
% rupturedD1 = Distal_1;
% rupturedD2 = Distal_2;
% rupturedDR = Dist_relative;
% rupturedName = name;
% 
% filename = strcat(['Case',name,'Features']);
% save(filename,'rupturedP2arclens','rupturedP1arclens','rupturedEcc', 'rupturedCur','rupturedName', ...
%      'rupturedP1','rupturedP2', 'rupturedStart','rupturedEnd','rupturedD1','rupturedD2','rupturedDR')
% %%
% load Case36
% % Approximate arclens by accumulating point to point geometric distance 
% unrupturedP2arclens = zeros(Proximal_1-Proximal_2,1);
% inc = 0;
% for i = 1: Proximal_1-Proximal_2
%     step = sqrt(sum((OldCenterline(Proximal_2+i,:)-OldCenterline(Proximal_2+i-1,:)).^2));
%     unrupturedP2arclens(i) = inc + step;
%     inc = unrupturedP2arclens(i);
% end
% 
% unrupturedP1arclens = zeros(aneu_start-Proximal_1,1);
% inc = 0;
% for i = 1: aneu_start-Proximal_1
%     step = sqrt(sum((OldCenterline(Proximal_1+i,:)-OldCenterline(Proximal_1+i-1,:)).^2));
%     unrupturedP1arclens(i) = inc + step;
%     inc = unrupturedP1arclens(i);
% end
% 
% unrupturedEcc = Eccentricity(:);
% unrupturedCur = OldKappa(:);
% unrupturedP1 = Proximal_1;
% unrupturedP2 = Proximal_2;
% unrupturedStart = aneu_start;
% unrupturedEnd = aneu_end;
% unrupturedD1 = Distal_1;
% unrupturedD2 = Distal_2;
% unrupturedDR = Dist_relative;
% unrupturedName = name;
% 
% filename = strcat(['Case',name,'Features']);
% save(filename,'unrupturedP2arclens','unrupturedP1arclens','unrupturedEcc','unrupturedCur','unrupturedName',...
%      'unrupturedP1','unrupturedP2','unrupturedStart','unrupturedEnd','unrupturedD1','unrupturedD2','unrupturedDR')

%%
% clear
% load Case26Features
% load Case36Features
% %% simply plotting eccentricity over arc length
% figure;
% subplot(2,1,1)
% hold on
% rupturedP2segment = rupturedEcc(rupturedP2:rupturedP1-1);
% plot(rupturedP2arclens,rupturedP2segment)
% plot(rupturedP2arclens,mean(rupturedP2segment)*ones(1,length(rupturedP2segment)))
% ylabel('eccentricity')
% xlabel('ruptured (Case 26) arclength P2')
% % legend('std(e)=0.0551 <= 0.072','segment proximal2 mean(e)')
% ylim([0.1 0.6])
% suptitle('Eccentricity (ruptured vs unruptured)')
% grid on
% 
% subplot(2,1,2)
% hold on
% unrupturedP2segment = unrupturedEcc(unrupturedP2:unrupturedP1-1);
% plot(unrupturedP2arclens,unrupturedEcc(unrupturedP2:unrupturedP1-1))
% plot(unrupturedP2arclens,mean(unrupturedP2segment)*ones(1,length(unrupturedP2segment)))
% ylabel('eccentricity')
% xlabel('unruptured (Case 36) arclength P2')
% % legend('std(e)=0.1182 > 0.072','segment proximal2 mean(e)')
% ylim([0.1 0.6])
% % suptitle(['Main Blood Vessel Information - Eccentricity(P2) (Case',name,')'])
% grid on

%%
% integral (dX/ds) at each point, then divide by arc length between
% corresponding two neighboring point
% ruptured
% maxpts = max(rupturedP1-rupturedP2,unrupturedP1-unrupturedP2)
% 
% rup_ecc_diff1 = diff(rupturedEcc(rupturedP2:rupturedP1));
% rup_P2arclen_diff1 = [rupturedP2arclens(1);diff(rupturedP2arclens)];
% rup_dXds = rup_ecc_diff1./rup_P2arclen_diff1;
% 
% pts = size(rup_dXds,1);
% rup_ecc_int = zeros(maxpts,1);
% rup_ecc_int(1) = trapz([0;rupturedP2arclens(1)],[0;rup_dXds(1)])/rup_P2arclen_diff1(1);
% for i = 2:pts
%     rup_ecc_int(i) = trapz(rupturedP2arclens(i-1:i),rup_dXds(i-1:i))/rup_P2arclen_diff1(i);
% end
% 
% % [maxe,maxi] = max(rup_ecc_int);
%  
% figure
% subplot(2,1,1)
% hold on
% plot(rup_ecc_int);
% plot(mean(rup_ecc_int)*ones(1,pts));
% % plot(rup_ecc_int(maxi),'r*')
% legend('Variation of Eccentricity for ruptured case','Mean of Eccentricity Variation')
% ylim([-0.5 0.5])
% yticks(linspace(-0.5,0.5,5))
% ylabel('Eccentricity')
% xlabel([strcat(['Case',rupturedName]) '(ruptured) curve-fitting points along centerline at segment proximal2'])
% suptitle('Variation of Eccentricity per Arc Length (ruptured vs unruptured)')
% 
% 
% %unruptured
% un_ecc_diff1 = diff(unrupturedEcc(unrupturedP2:unrupturedP1));
% un_P2arclen_diff1 = [unrupturedP2arclens(1);diff(unrupturedP2arclens)];
% un_dXds = un_ecc_diff1./un_P2arclen_diff1;
% 
% pts = size(un_dXds,1);
% un_ecc_int = ones(maxpts,1);
% un_ecc_int(1) = trapz([0;unrupturedP2arclens(1)],[0;un_dXds(1)])/un_P2arclen_diff1(1);
% for i = 2:pts
%     un_ecc_int(i) = trapz(unrupturedP2arclens(i-1:i),un_dXds(i-1:i))/un_P2arclen_diff1(i);
% end
% 
% % [maxe,maxi] = max(un_ecc_int);
% 
% subplot(2,1,2)
% hold on
% plot(un_ecc_int);
% plot(mean(un_ecc_int)*ones(1,pts));
% % plot(un_ecc_int(maxi),'r*')
% ylim([-0.5 0.5])
% yticks(linspace(-0.5,0.5,5))
% ylabel('Eccentricity')
% xlabel([strcat(['Case',unrupturedName]) '(unruptured) curve-fitting points along centerline at segment proximal2'])
% legend('Variation of Eccentricity for unruptured case','Mean of Eccentricity Variation')

%%
% figure;
% hold on 
% plot(unrupturedP1arclens,rupturedCur(Proximal_1:aneu_start-1))
% ylabel('curvature (\kappa)')
% xlabel('arclength P1')
% suptitle(['Main Blood Vessel Information - Curvature(P1) (Case',name,')'])
% grid on
% 
% figure;
% hold on
% PD = rupturedCur(Proximal_1:aneu_start-1)./rupturedCur(aneu_end+1:Distal_1);
% plot(unrupturedP1arclens,log(PD))
% suptitle(['Main Blood Vessel Information - curvature(P1/D1) (Case',name,')'])
% ylabel('curvature (\kappa)')
% xlabel('arclength P1')



