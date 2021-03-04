clear
close all
%%
load Case3
% Approximate arclens by accumulating point to point geometric distance 
rupturedP2arclens = zeros(Proximal_1-Proximal_2,1);
inc = 0;
for i = 1: Proximal_1-Proximal_2
    step = sqrt(sum((OldCenterline(Proximal_2+i,:)-OldCenterline(Proximal_2+i-1,:)).^2));
    rupturedP2arclens(i) = inc + step;
    inc = rupturedP2arclens(i);
end

rupturedP1arclens = zeros(aneu_start-Proximal_1,1);
inc = 0;
for i = 1: aneu_start-Proximal_1
    step = sqrt(sum((OldCenterline(Proximal_1+i,:)-OldCenterline(Proximal_1+i-1,:)).^2));
    rupturedP1arclens(i) = inc + step;
    inc = rupturedP1arclens(i);
end

rupturedD1arclens = zeros(Distal_1-aneu_end,1);
inc = 0;
for i = 1: Distal_1-aneu_end
    step = sqrt(sum((OldCenterline(aneu_end+i,:)-OldCenterline(aneu_end+i-1,:)).^2));
    rupturedD1arclens(i) = inc + step;
    inc = rupturedD1arclens(i);
end

rupturedD2arclens = zeros(Distal_2-Distal_1,1);
inc = 0;
for i = 1: Distal_2-Distal_1
    step = sqrt(sum((OldCenterline(Distal_1+i,:)-OldCenterline(Distal_1+i-1,:)).^2));
    rupturedD2arclens(i) = inc + step;
    inc = rupturedD2arclens(i);
end

rupturedD1D2arclens = zeros(Distal_2-aneu_end,1);
inc = 0;
for i = 1: Distal_2-aneu_end
    step = sqrt(sum((OldCenterline(aneu_end+i,:)-OldCenterline(aneu_end+i-1,:)).^2));
    rupturedD1D2arclens(i) = inc + step;
    inc = rupturedD1D2arclens(i);
end


rupturedEcc = Eccentricity(:);
rupturedCur = OldKappa(:);
rupturedCsa = OldArea(:);
rupturedP1 = Proximal_1;
rupturedP2 = Proximal_2;
rupturedStart = aneu_start;
rupturedEnd = aneu_end;
rupturedD1 = Distal_1;
rupturedD2 = Distal_2;
rupturedDR = Dist_relative;
rupturedName = name;
rupturedDia = MajorAxisLength;

filename = strcat(['Case',name,'Features']);
save(filename,'rupturedP2arclens','rupturedP1arclens','rupturedD1arclens','rupturedD2arclens','rupturedD1D2arclens',...
     'rupturedEcc', 'rupturedCur','rupturedCsa','rupturedName', 'rupturedDia',...
     'rupturedP1','rupturedP2', 'rupturedStart','rupturedEnd','rupturedD1','rupturedD2','rupturedDR')
%%
load Case13
% Approximate arclens by accumulating point to point geometric distance 
unrupturedP2arclens = zeros(Proximal_1-Proximal_2,1);
inc = 0;
for i = 1: Proximal_1-Proximal_2
    step = sqrt(sum((OldCenterline(Proximal_2+i,:)-OldCenterline(Proximal_2+i-1,:)).^2));
    unrupturedP2arclens(i) = inc + step;
    inc = unrupturedP2arclens(i);
end

unrupturedP1arclens = zeros(aneu_start-Proximal_1,1);
inc = 0;
for i = 1: aneu_start-Proximal_1
    step = sqrt(sum((OldCenterline(Proximal_1+i,:)-OldCenterline(Proximal_1+i-1,:)).^2));
    unrupturedP1arclens(i) = inc + step;
    inc = unrupturedP1arclens(i);
end

unrupturedD1arclens = zeros(Distal_1-aneu_end,1);
inc = 0;
for i = 1: Distal_1-aneu_end
    step = sqrt(sum((OldCenterline(aneu_end+i,:)-OldCenterline(aneu_end+i-1,:)).^2));
    unrupturedD1arclens(i) = inc + step;
    inc = unrupturedD1arclens(i);
end

unrupturedD2arclens = zeros(Distal_2-Distal_1,1);
inc = 0;
for i = 1: Distal_2-Distal_1
    step = sqrt(sum((OldCenterline(Distal_1+i,:)-OldCenterline(Distal_1+i-1,:)).^2));
    unrupturedD2arclens(i) = inc + step;
    inc = unrupturedD2arclens(i);
end

unrupturedD1D2arclens = zeros(Distal_2-aneu_end,1);
inc = 0;
for i = 1: Distal_2-aneu_end
    step = sqrt(sum((OldCenterline(aneu_end+i,:)-OldCenterline(aneu_end+i-1,:)).^2));
    unrupturedD1D2arclens(i) = inc + step;
    inc = unrupturedD1D2arclens(i);
end


unrupturedEcc = Eccentricity(:);
unrupturedCur = OldKappa(:);
unrupturedCsa = OldArea(:);
unrupturedP1 = Proximal_1;
unrupturedP2 = Proximal_2;
unrupturedStart = aneu_start;
unrupturedEnd = aneu_end;
unrupturedD1 = Distal_1;
unrupturedD2 = Distal_2;
unrupturedDR = Dist_relative;
unrupturedName = name;
unrupturedDia = MajorAxisLength;

filename = strcat(['Case',name,'Features']);
save(filename,'unrupturedP2arclens','unrupturedP1arclens','unrupturedD1arclens','unrupturedD2arclens','unrupturedD1D2arclens',...
    'unrupturedEcc','unrupturedCur','unrupturedCsa','unrupturedName','unrupturedDia',...
    'unrupturedP1','unrupturedP2','unrupturedStart','unrupturedEnd','unrupturedD1','unrupturedD2','unrupturedDR')

%%
clear
load Case3Features
load Case13Features
%% plot features over arc length
%% eccentricity P2
figure;
subplot(3,1,1)
hold on
rupturedP2segment = rupturedEcc(rupturedP2:rupturedP1-1);
err = rupturedP2segment-mean(rupturedP2segment);
errorbar(rupturedP2arclens,rupturedP2segment,err)
plot(rupturedP2arclens,mean(rupturedP2segment)*ones(1,length(rupturedP2segment)))
rup_std = num2str(std(rupturedP2segment));
ylabel('Eccentricity')
xlabel(['Arc Length of Segment Proximal2 - ','std(e)=',rup_std])
legend(strcat(['Case',rupturedName,' (ruptured)']),'mean(segment P2 eccentricity)')
suptitle('Eccentricity (ruptured vs unruptured)')
ylim([-0.2,1])
% grid on

subplot(3,1,2)
hold on 
unrupturedP2segment = unrupturedEcc(unrupturedP2:unrupturedP1-1);
err = unrupturedP2segment-mean(unrupturedP2segment);
errorbar(unrupturedP2arclens,unrupturedP2segment,err)
plot(unrupturedP2arclens,mean(unrupturedP2segment)*ones(1,length(unrupturedP2segment)))
un_std = num2str(std(unrupturedP2segment));
ylabel('Eccentricity')
xlabel(['Arc Length of Segment Proximal2 - ','std(e)=',un_std])
legend(strcat(['Case',unrupturedName,' (unruptured)']),'mean(segment P2 eccentricity)')
suptitle('Eccentricity (ruptured vs unruptured)')
ylim([-0.2,1])
% grid on

subplot(3,1,3)
hold on
plot(rupturedP2arclens,rupturedP2segment)
plot(unrupturedP2arclens,unrupturedP2segment)
ylabel('Eccentricity')
xlabel('Arc Length of Segment Proximal2')
legend(strcat(['Case',rupturedName,' (ruptured)']),strcat(['Case',unrupturedName,' (unruptured)']))
suptitle('Eccentricity (ruptured vs unruptured)')
ylim([-0.2,1])
% grid on

%% curv PD
figure;
subplot(3,1,1)
hold on
rup_cur_P1 = rupturedCur(rupturedP1:rupturedStart-1);
area(rupturedP1arclens, rup_cur_P1)
rup_int = num2str(trapz(rupturedP1arclens,rup_cur_P1));
ylabel('Curvature')
xlabel(['Arc Length of Segment Proximal1 - ','curvature integral = ',rup_int])
legend(strcat(['Case',rupturedName,' (ruptured)']))
suptitle('Curvature Integration P1(ruptured vs unruptured)')
ylim([-0.7 0.8])

subplot(3,1,2)
hold on
un_cur_P1 = unrupturedCur(unrupturedP1:unrupturedStart-1);
area(unrupturedP1arclens,un_cur_P1)
un_int = num2str(trapz(unrupturedP1arclens,un_cur_P1));
ylabel('Curvature')
xlabel(['Arc Length of Segment Proximal1 - ','curvature integral = ',un_int])
legend(strcat(['Case',unrupturedName,' (unruptured)']))
suptitle('Curvature Integration P1(ruptured vs unruptured)')
ylim([-0.7 0.8])
% grid on

subplot(3,1,3)
hold on
plot(rupturedP1arclens,rup_cur_P1)
plot(unrupturedP1arclens,un_cur_P1)
ylabel('Curvature')
xlabel('Arc Length of Segment Proximal1')
legend(strcat(['Case',rupturedName,' (ruptured)']),strcat(['Case',unrupturedName,' (unruptured)']))
ylim([-0.7 0.8])
% grid on
% 
% subplot(3,1,3)
% hold on
% rup_cur_PD = mean(rup_cur_P1)/mean(rup_cur_D1);
% % plot(rupturedP1arclens,rup_cur_P1./rup_cur_D1)
% un_cur_PD = mean(un_cur_P1)/mean(un_cur_D1);
% % plot(unrupturedP1arclens,un_cur_PD)
% plot(rup_cur_PD*ones(1,length(rup_cur_P1)))
% plot(un_cur_PD*ones(1,length(rup_cur_P1)))
% plot(-2.655*ones(1,length(rup_cur_P1)))
% ylabel('Curvature')
% xlabel('Arc Length of Segment Proximal/Distal1')
% legend(strcat(['Case',rupturedName]),strcat(['Case',unrupturedName]),'Curvature mean PD = -2.655')
% ylim([-6 6])
% % grid on
% 
% % Cross sectional area PD2
% figure;
% subplot(2,1,1)
% hold on
% rup_csa_P2 = rupturedCur(rupturedP2:rupturedP1-1);
% un_csa_P2 = unrupturedCur(unrupturedP2:unrupturedP1-1);
% plot(rupturedP2arclens,rup_csa_P2)
% plot(unrupturedP2arclens,un_csa_P2)
% 
% ylabel('CrossSectional Area')
% xlabel('Arc Length of Segment Proximal2')
% legend(strcat(['Case',rupturedName]),strcat(['Case',unrupturedName]))
% % ylim([0.1 0.6])
% suptitle('CrossSectional Area P2 and D2 (ruptured vs unruptured)')
% % grid on
% 
% subplot(2,1,2)
% hold on
% % un_cur_PD = unrupturedCur(unrupturedP1:unrupturedStart-1)./unrupturedCur(unrupturedEnd:unrupturedD1-1);
% % plot(unrupturedP1arclens,un_cur_PD)
% rup_csa_D2 = rupturedCur(rupturedD1:rupturedD2-1);
% un_csa_D2 = unrupturedCur(unrupturedD1:unrupturedD2-1);
% plot(rupturedD2arclens,rup_csa_D2)
% plot(unrupturedD2arclens,un_csa_D2)
% 
% ylabel('CrossSectional Area')
% xlabel('Arc Length of Segment Distal2')
% legend(strcat(['Case',rupturedName]),strcat(['Case',unrupturedName]))
% grid on

%% Diameter (major axis)
% figure;
% subplot(3,1,1)
% hold on
% rupturedD2segment = rupturedDia(rupturedD1+1:rupturedD2);
% err = rupturedD2segment-mean(rupturedD2segment);
% errorbar(rupturedD2arclens,rupturedD2segment,err)
% plot(rupturedD2arclens,mean(rupturedD2segment)*ones(1,length(rupturedD2segment)))
% rupD2 = rupturedD2segment(end);
% ylabel('Diameter (MajorAxisLength)')
% xlabel(['Arc Length of Segment Distal2 - ', 'Diameter normalD2=',rupD2])
% legend(strcat(['Case',rupturedName,' (ruptured)']),'mean(segment D2 Diameter)')
% suptitle('Diameter at Distal1 and Distal2 (ruptured)')
% % ylim([2.5,6.5])
% % grid on
%  
% subplot(3,1,2)
% hold on
% rupturedD1segment = rupturedDia(rupturedEnd+1:rupturedD1);
% err = rupturedD1segment-mean(rupturedD1segment);
% errorbar(rupturedD1arclens,rupturedD1segment,err)
% plot(rupturedD1arclens,mean(rupturedD1segment)*ones(1,length(rupturedD1segment)))
% rupD1 = rupturedD1segment(end);
% ylabel('Diameter (MajorAxisLength)')
% xlabel(['Arc Length of Segment Distal1 - ', 'Diameter normalD1=',rupD1])
% legend(strcat(['Case',rupturedName,' (ruptured)']),'mean(segment D1 Diameter)')
% suptitle('Diameter at Distal1 and Distal2 (ruptured)')
% % ylim([2.5,6.5])
%  
% subplot(3,1,3)
% hold on
% plot(rupturedD2arclens,rupturedD2segment)
% plot(rupturedD1arclens,rupturedD1segment)
% ylabel('Diameter (MajorAxisLength)')
% xlabel('Arc Length')
% legend(strcat(['Case',rupturedName,' Segment D2 (ruptured)']),strcat(['Case',rupturedName,' Segment D1 (ruptured)']))
% suptitle('Diameter at Distal1 and Distal2 (ruptured)')
% % ylim([2.5,6.5])
%  
%  
% figure;
% subplot(3,1,1)
% hold on
% unrupturedD2segment = unrupturedDia(unrupturedD1+1:unrupturedD2);
% err = unrupturedD2segment-mean(unrupturedD2segment);
% errorbar(unrupturedD2arclens,unrupturedD2segment,err)
% plot(unrupturedD2arclens,mean(unrupturedD2segment)*ones(1,length(unrupturedD2segment)))
% unrupD2 = unrupturedD2segment(end);
% ylabel('Diameter (MajorAxisLength)')
% xlabel(['Arc Length of Segment Distal2 - ', 'Diameter normalD2=',unrupD2])
% legend(strcat(['Case',unrupturedName,' (unruptured)']),'mean(segment D2 Diameter)')
% suptitle('Diameter at Distal1 and Distal2 (unruptured)')
% % ylim([2.5,6.5])
% 
% subplot(3,1,2)
% hold on
% unrupturedD1segment = unrupturedDia(unrupturedEnd+1:unrupturedD1);
% err = unrupturedD1segment-mean(unrupturedD1segment);
% errorbar(unrupturedD1arclens,unrupturedD1segment,err)
% plot(unrupturedD1arclens,mean(unrupturedD1segment)*ones(1,length(unrupturedD1segment)))
% unrupD1 = unrupturedD1segment(end);
% ylabel('Diameter (MajorAxisLength)')
% xlabel(['Arc Length of Segment Distal1 - ', 'Diameter normalD1=',unrupD1])
% legend(strcat(['Case',unrupturedName,' (unruptured)']),'mean(segment D1 Diameter)')
% suptitle('Diameter at Distal1 and Distal2 (unruptured)')
% % ylim([2.5,6.5])
% 
% subplot(3,1,3)
% hold on
% plot(unrupturedD2arclens,unrupturedD2segment)
% plot(unrupturedD1arclens,unrupturedD1segment)
% ylabel('Diameter (MajorAxisLength)')
% xlabel('Arc Length')
% legend(strcat(['Case',unrupturedName,' Segment D2 (unruptured)']),strcat(['Case',unrupturedName,' Segment D1 (unruptured)']))
% suptitle('Diameter at Distal1 and Distal2 (unruptured)')
% % ylim([2.5,6.5])



figure;  % Diameter
subplot(3,1,1)
hold on
%ruptured
rupturedD1D2Dia = rupturedDia(rupturedEnd+1:rupturedD2);

rupD1Dia = rupturedDia(rupturedEnd+1:rupturedD1);
rupD1Arc = rupturedD1D2arclens(1:rupturedD1-rupturedEnd);
err = rupD1Dia-mean(rupD1Dia);
errorbar(rupD1Arc,rupD1Dia,err,'Color',[0 0.4470 0.7410],'DisplayName','D1')
plot(rupD1Arc,mean(rupD1Dia)*ones(1,length(rupD1Dia)),'DisplayName','mean(D1)')

rupD2Dia = rupturedDia(rupturedD1+1:rupturedD2);
rupD2Arc = rupturedD1D2arclens(rupturedD1-rupturedEnd+1:end);
err = rupD2Dia-mean(rupD2Dia);
errorbar(rupD2Arc,rupD2Dia,err,'Color',[0 0.4470 0.7410],'DisplayName','D2')
plot(rupD2Arc,mean(rupD2Dia)*ones(1,length(rupD2Dia)),'Color',[0.9290 0.6940 0.1250],'DisplayName','mean(D2)')

line([rupturedD1D2arclens(rupturedD1-rupturedEnd) rupturedD1D2arclens(rupturedD1-rupturedEnd)],[min(rupturedD1D2Dia) max(rupturedD1D2Dia)],'Color','g','DisplayName','Diameter\_normal\_D1');
line([rupturedD1D2arclens(end) rupturedD1D2arclens(end)],[min(rupturedD1D2Dia) max(rupturedD1D2Dia)],'Color','g','DisplayName','Diameter\_normal\_D2');

rupD1 = num2str(rupD1Dia(end));
rupD2 = num2str(rupD2Dia(end));
legend(['D1 diameter=',rupD1],'mean(segment D1)',['D2 diameter=',rupD2],'mean(segment D2)')
ylabel('Diameter')
xlabel('Arc Length of Two Distal Segments (D1 & D2)')


subplot(3,1,2)
hold on
%unruptured
unrupturedD1D2Dia = unrupturedDia(unrupturedEnd+1:unrupturedD2);

unrupD1Dia = unrupturedDia(unrupturedEnd+1:unrupturedD1);
unrupD1Arc = unrupturedD1D2arclens(1:unrupturedD1-unrupturedEnd);
err = unrupD1Dia-mean(unrupD1Dia);
errorbar(unrupD1Arc,unrupD1Dia,err,'Color',[0 0.4470 0.7410],'DisplayName','D1')
plot(unrupD1Arc,mean(unrupD1Dia)*ones(1,length(unrupD1Dia)),'DisplayName','mean(D1)')
%
unrupD2Dia = unrupturedDia(unrupturedD1+1:unrupturedD2);
unrupD2Arc = unrupturedD1D2arclens(unrupturedD1-unrupturedEnd+1:end);
err = unrupD2Dia-mean(unrupD2Dia);
errorbar(unrupD2Arc,unrupD2Dia,err,'Color',[0 0.4470 0.7410],'DisplayName','D2')
plot(unrupD2Arc,mean(unrupD2Dia)*ones(1,length(unrupD2Dia)),'Color',[0.9290 0.6940 0.1250],'DisplayName','mean(D2)')

line([unrupturedD1D2arclens(unrupturedD1-unrupturedEnd) unrupturedD1D2arclens(unrupturedD1-unrupturedEnd)],[min(unrupturedD1D2Dia) max(unrupturedD1D2Dia)],'Color','g','DisplayName','Diameter\_normal\_D1');
line([unrupturedD1D2arclens(end) unrupturedD1D2arclens(end)],[min(unrupturedD1D2Dia) max(unrupturedD1D2Dia)],'Color','g','DisplayName','Diameter\_normal\_D2');
unrupD1 = num2str(unrupD1Dia(end));
unrupD2 = num2str(unrupD2Dia(end));
legend(['D1 diameter=',unrupD1],'mean(segment D1)',['D2 diameter=',unrupD2],'mean(segment D2)')
ylabel('Diameter')
xlabel('Arc Length of Two Distal Segments (D1 & D2)')


subplot(3,1,3)
hold on
plot(rupturedD1D2arclens,rupturedD1D2Dia)
plot(unrupturedD1D2arclens,unrupturedD1D2Dia)
legend(strcat(['Case',rupturedName,' (ruptured)']),strcat(['Case',unrupturedName,' (unruptured)']))
ylabel('Diameter')
xlabel('Arc Length')
suptitle('Diameter at Distal1 and Distal2 (ruptured vs unruptured)')





