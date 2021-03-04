%%%% choose POI and show feature sequence [Feature 1] %%%%
% Input: Info (centerline, curvature, torsion, area, diameter, solidity)
% Output: Show Feature 1 sequence and location

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
close all

%% Set location
load Info
Area_diff1 = diff(OldArea); % first order diff
Area_diff2 = diff(OldArea,2); % second order diff

N = length(OldArea);
[pk_A,loc_A] = max(OldArea); 
% diff: oldercenterline first order diff, by row (size 261 x 3)
% take element wise square of diff, sum each row, then take sqaure root
delta_x = sqrt(sum(diff(OldCenterline,1,1).^2,2)); 
Dist_relative = zeros(N,1);

% entries in dis_relative shows relative distance by delta_x according to
% max(old area)
for i = loc_A+1:N
    Dist_relative(i) = sum(delta_x(loc_A:i-1));
end
for i = 1:loc_A-1 
    Dist_relative(i) = -sum(delta_x(i:loc_A-1));
end

%%%%%%%%%% choose location based on derivative of area %%%%%%
% aneu_start = find(Area_diff1(1:loc_A-1)<0,1,'last')-1;     %<0.1
% aneu_end = find(Area_diff1(loc_A:end)>0,1,'first')+loc_A;  %>-0.1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

aneu_start = a;
aneu_end = b;
AL = sqrt(sum((OldCenterline(aneu_end,:)-OldCenterline(aneu_start,:)).^2));

%% by Tau, Kappa, Cross Sectional Area
% Tau: use cumulative difference
% Area: use value difference every step points
% Kappa: use value

% Tau
% maybe Tau should use value too
% function cumdiff defined at the bottom
% cumdiff(a,b,feature,N,step) returns relative matrix accumulated difference by step
stept = 6;
[Tau_relative,indexa,indexb] = cumdiff(a,b,OldTau,N,6);
T_thres = std(Tau_relative)*1.96;
Distal_1_T = find(abs(Tau_relative(indexb+1:end))>=T_thres,1,'first')*stept+b;
Proximal_1_T = a-find(abs(Tau_relative(indexa:-1:1))>=T_thres,1,'first')*stept;

% Cross Sectional Area
stepa = 6;
A_thres = std(OldArea([1:a,b:end]));
Proximal_1_A = a-stepa-find(abs(OldArea(a-2*stepa:-stepa:1)-OldArea(a-stepa))>=A_thres,1,'first')*stepa;
Distal_1_A = find(abs(OldArea(b+stepa)-OldArea(b+2*stepa:stepa:end))>=A_thres,1,'first')*stepa+b+stepa;

% Kappa
stepk = 6;
K_thres = std(OldKappa([1:a,b:end]))*1.96;
Proximal_1_K = a-find(abs(OldKappa(a-stepk:-stepk:1))>=K_thres,1,'first')*stepk;
Distal_1_K = find(abs(OldKappa(b+stepk:stepk:end))>=K_thres,1,'first')*stepk+b;

%% 5 segments based on cross sectional area
diffpA = a - Proximal_1_A;
diffdA = Distal_1_A - b;
seg = findf(diffpA,diffdA,'seg',min(fix((N-b)/2),fix((a-1)/2)));
if seg > min(fix((N-b)/2),fix((a-1)/2))
    seg = min(fix((N-b)/2),fix((a-1)/2));
end

Proximal_1 = a - seg;
Proximal_2 = a-2*seg;
Distal_1 = b+seg;
Distal_2 = seg*2+b;
p1L = sqrt(sum((OldCenterline(a,:)-OldCenterline(Proximal_1,:)).^2));
p2L = sqrt(sum((OldCenterline(Proximal_1,:)-OldCenterline(Proximal_2,:)).^2));
d1L = sqrt(sum((OldCenterline(Distal_1,:)-OldCenterline(b,:)).^2));
d2L = sqrt(sum((OldCenterline(Distal_2,:)-OldCenterline(Distal_1,:)).^2));

%% 3 segments (one proximal, one distal)
diffpT = a - Proximal_1_T;
diffdT = Distal_1_T-b;
diffpK = a - Proximal_1_K;
diffdK = Distal_1_K-b;
segp = findf(diffpT,diffpK,'seg',a-1);
segd = findf(diffdT,diffdK,'seg',N-b);
if segp-segd > 80
    segd = fix((N-b)/2);
elseif segd-segp > 80
    segp = fix(a/2);
end
Proximal_1 = a - segp;
Distal_1 = b + segd;
p1L = sqrt(sum((OldCenterline(a,:)-OldCenterline(Proximal_1,:)).^2));
d1L = sqrt(sum((OldCenterline(Distal_1,:)-OldCenterline(b,:)).^2));

%% 7 segments (3 proximal/distal)

diffpA = a - Proximal_1_A;
diffdA = Distal_1_A - b;
seg = findf(diffpA,diffdA,'seg',min(fix((N-b)/3),fix((a-1)/3)));
if seg > min(fix((N-b)/3),fix((a-1)/3))
    disp(name);
    disp('default');
    seg = min(fix((N-b)/3),fix((a-1)/3));
end

Proximal_1 = a - seg;
Proximal_2 = a-2*seg;
Proximal_3 = a-3*seg;
Distal_1 = b+seg;
Distal_2 = seg*2+b;
Distal_3 = seg*3+b;
p1L = sqrt(sum((OldCenterline(a,:)-OldCenterline(Proximal_1,:)).^2));
p2L = sqrt(sum((OldCenterline(Proximal_1,:)-OldCenterline(Proximal_2,:)).^2));
p3L = sqrt(sum((OldCenterline(Proximal_2,:)-OldCenterline(Proximal_3,:)).^2));
d1L = sqrt(sum((OldCenterline(Distal_1,:)-OldCenterline(b,:)).^2));
d2L = sqrt(sum((OldCenterline(Distal_2,:)-OldCenterline(Distal_1,:)).^2));
d3L = sqrt(sum((OldCenterline(Distal_3,:)-OldCenterline(Distal_2,:)).^2));



%% Plot location and derivative of area
figure
subplot(3,1,1)
plot(Dist_relative,OldArea(1:end))
hold on
line([Dist_relative(Distal_3) Dist_relative(Distal_3)],[min(OldArea) max(OldArea)],'Color','g');
line([Dist_relative(Distal_2) Dist_relative(Distal_2)],[min(OldArea) max(OldArea)],'Color','g');
line([Dist_relative(Distal_1) Dist_relative(Distal_1)],[min(OldArea) max(OldArea)],'Color','g');
line([Dist_relative(aneu_start) Dist_relative(aneu_start)],[min(OldArea) max(OldArea)],'Color','r');
line([Dist_relative(aneu_end) Dist_relative(aneu_end)],[min(OldArea) max(OldArea)],'Color','r');
line([Dist_relative(Proximal_1) Dist_relative(Proximal_1)],[min(OldArea) max(OldArea)],'Color','g');
line([Dist_relative(Proximal_2) Dist_relative(Proximal_2)],[min(OldArea) max(OldArea)],'Color','g');
line([Dist_relative(Proximal_3) Dist_relative(Proximal_3)],[min(OldArea) max(OldArea)],'Color','g');
xlabel('centerline (mm)')
ylabel('cross sectional area')
% suptitle(['Section Area (Case',name,')'])
subplot(3,1,2)
plot(Dist_relative,[0;Area_diff1(1:end)])
ylabel('area differentiation')
subplot(3,1,3)
plot(Dist_relative,[0;0;Area_diff2(1:end)])
ylabel('second derivative of area')

%% Locate Range 
radius = MaxD/2;
radius_min = MinD/2;
Line = OldCenterline;

%%%%%%%%%% range %%%%%%%%%%%%

% 7 segments
% if isempty(Proximal_3)
%     part0 = 1:Proximal_2;
% else
%     part0 = Proximal_3:Proximal_2;
% end
% part1 = Proximal_2:Proximal_1;

%3 segments
% part1 = 1:Proximal_1;

% 5 segments
if isempty(Proximal_2)
    part1 = 1:Proximal_1;
else
    part1 = Proximal_2:Proximal_1;
end

part2 = Proximal_1:aneu_start;
part3 = aneu_start:aneu_end;
part4 = aneu_end:Distal_1;
if isempty(Distal_2)
    part5 = Distal_1:N;
else
    part5 = Distal_1:Distal_2;
end

% 7 segments
% part5 = Distal_1:Distal_2;
% if isempty(Distal_3)
%     part6 = Distal_2:N;
% else
%     part6 = Distal_2:Distal_3;
% end

[stlcoords] = READ_stl(['/Users/Rikki/Desktop/AneurysmSummerProject/Image/',name,'_1.stl']);  
xco = squeeze(stlcoords(:,1,:))';
yco = squeeze(stlcoords(:,2,:))';
zco = squeeze(stlcoords(:,3,:))';

figure;
[hpat] = patch(xco,yco,zco,'b','EdgeColor','none');
alpha(0.2);
camlight('headlight');
material('dull');
hold on   
plot3(Line(:,1),Line(:,2),Line(:,3),'square','Markersize',1,'MarkerFaceColor','k','Color','k'); 
% scatter3(Line(part0(1),1),Line(part0(1),2),Line(part0(1),3),'MarkerEdgeColor','g','MarkerFaceColor','g'); 
scatter3(Line(part1(1),1),Line(part1(1),2),Line(part1(1),3),'MarkerEdgeColor','g','MarkerFaceColor','g'); 
scatter3(Line(part2(1),1),Line(part2(1),2),Line(part2(1),3),'MarkerEdgeColor','g','MarkerFaceColor','g'); 
scatter3(Line(part3(1),1),Line(part3(1),2),Line(part3(1),3),'MarkerEdgeColor','r','MarkerFaceColor','r'); 
scatter3(Line(part3(end),1),Line(part3(end),2),Line(part3(end),3),'MarkerEdgeColor','r','MarkerFaceColor','r'); 

%for 3 segments
% scatter3(Line(part4(end),1),Line(part4(end),2),Line(part4(end),3),'MarkerEdgeColor','g','MarkerFaceColor','g'); 

scatter3(Line(part5(1),1),Line(part5(1),2),Line(part5(1),3),'MarkerEdgeColor','g','MarkerFaceColor','g'); 
scatter3(Line(part5(end),1),Line(part5(end),2),Line(part5(end),3),'MarkerEdgeColor','g','MarkerFaceColor','g'); 
% scatter3(Line(part6(end),1),Line(part6(end),2),Line(part6(end),3),'MarkerEdgeColor','g','MarkerFaceColor','g'); 
set(gcf,'Color','white');
title(['Segment Location (Case',name,')'])
view(75,10)
% xlim([-5 15])
% ylim([-5 15])
% zlim([-30 0])
%saveas(gcf,['Location-Case',name,'.png'])

%% Show Feature 1
figure;% KT
subplot(3,1,1)
%plot(Dist_relative,kappa(1:end))
hold on
plot(Dist_relative,OldKappa(1:end))
% line([Dist_relative(part0(1)) Dist_relative(part0(1))],[min(OldKappa) max(OldKappa)],'Color','g');
line([Dist_relative(part1(1)) Dist_relative(part1(1))],[min(OldKappa) max(OldKappa)],'Color','g');
line([Dist_relative(part2(1)) Dist_relative(part2(1))],[min(OldKappa) max(OldKappa)],'Color','g');
line([Dist_relative(part3(1)) Dist_relative(part3(1))],[min(OldKappa) max(OldKappa)],'Color','r');
line([Dist_relative(part4(1)) Dist_relative(part4(1))],[min(OldKappa) max(OldKappa)],'Color','r');
% for 3 segments
% line([Dist_relative(part4(end)) Dist_relative(part4(end))],[min(OldKappa) max(OldKappa)],'Color','g');

line([Dist_relative(part5(1)) Dist_relative(part5(1))],[min(OldKappa) max(OldKappa)],'Color','g');
line([Dist_relative(part5(end)) Dist_relative(part5(end))],[min(OldKappa) max(OldKappa)],'Color','g');
% line([Dist_relative(part6(end)) Dist_relative(part6(end))],[min(OldKappa) max(OldKappa)],'Color','g');

ylabel('curvature (\kappa)')
suptitle(['Main Blood Vessel Information - Torsion and Curvature (Case',name,')'])
grid on
subplot(3,1,2)
%plot(Dist_relative,tau(1:end))
hold on 
plot(Dist_relative,OldTau(1:end))
% line([Dist_relative(part0(1)) Dist_relative(part0(1))],[min(OldTau) max(OldTau)],'Color','g');
line([Dist_relative(part1(1)) Dist_relative(part1(1))],[min(OldTau) max(OldTau)],'Color','g');
line([Dist_relative(part2(1)) Dist_relative(part2(1))],[min(OldTau) max(OldTau)],'Color','g');
line([Dist_relative(part3(1)) Dist_relative(part3(1))],[min(OldTau) max(OldTau)],'Color','r');
line([Dist_relative(part4(1)) Dist_relative(part4(1))],[min(OldTau) max(OldTau)],'Color','r');
% for 3 segments
% line([Dist_relative(part4(end)) Dist_relative(part4(end))],[min(OldTau) max(OldTau)],'Color','g');

line([Dist_relative(part5(1)) Dist_relative(part5(1))],[min(OldTau) max(OldTau)],'Color','g');
line([Dist_relative(part5(end)) Dist_relative(part5(end))],[min(OldTau) max(OldTau)],'Color','g');
% line([Dist_relative(part6(end)) Dist_relative(part6(end))],[min(OldTau) max(OldTau)],'Color','g');
ylabel('torsion (\tau)')
grid on
subplot(3,1,3)
plot(Dist_relative,OldArea(1:end))
% line([Dist_relative(part0(1)) Dist_relative(part0(1))],[min(OldArea) max(OldArea)],'Color','g');
line([Dist_relative(part1(1)) Dist_relative(part1(1))],[min(OldArea) max(OldArea)],'Color','g');
line([Dist_relative(part2(1)) Dist_relative(part2(1))],[min(OldArea) max(OldArea)],'Color','g');
line([Dist_relative(part3(1)) Dist_relative(part3(1))],[min(OldArea) max(OldArea)],'Color','r');
line([Dist_relative(part4(1)) Dist_relative(part4(1))],[min(OldArea) max(OldArea)],'Color','r');
% for 3 segments
% line([Dist_relative(part4(end)) Dist_relative(part4(end))],[min(OldArea) max(OldArea)],'Color','g');

line([Dist_relative(part5(1)) Dist_relative(part5(1))],[min(OldArea) max(OldArea)],'Color','g');
line([Dist_relative(part5(end)) Dist_relative(part5(end))],[min(OldArea) max(OldArea)],'Color','g');
% line([Dist_relative(part6(end)) Dist_relative(part6(end))],[min(OldArea) max(OldArea)],'Color','g');
ylabel('cross sectional area')
xlabel('centerline (mm)')
grid on
%saveas(gcf,['FeatureTorsion-Case',name,'.png'])

figure;  % Diameter
subplot(4,1,1)
hold on
plot(Dist_relative,Perimeter(1:end))
% line([Dist_relative(part0(1)) Dist_relative(part0(1))],[min(Perimeter) max(Perimeter)],'Color','g');
line([Dist_relative(part1(1)) Dist_relative(part1(1))],[min(Perimeter) max(Perimeter)],'Color','g');
line([Dist_relative(part2(1)) Dist_relative(part2(1))],[min(Perimeter) max(Perimeter)],'Color','g');
line([Dist_relative(part3(1)) Dist_relative(part3(1))],[min(Perimeter) max(Perimeter)],'Color','r');
line([Dist_relative(part4(1)) Dist_relative(part4(1))],[min(Perimeter) max(Perimeter)],'Color','r');
% for 3 segments
% line([Dist_relative(part4(end)) Dist_relative(part4(end))],[min(Perimeter) max(Perimeter)],'Color','g');

line([Dist_relative(part5(1)) Dist_relative(part5(1))],[min(Perimeter) max(Perimeter)],'Color','g');
line([Dist_relative(part5(end)) Dist_relative(part5(end))],[min(Perimeter) max(Perimeter)],'Color','g');
% line([Dist_relative(part6(end)) Dist_relative(part6(end))],[min(Perimeter) max(Perimeter)],'Color','g');
ylabel('perimeter')
suptitle(['Main Blood Vessel Information - Perimeter and Diameter (Case',name,')'])
grid on
subplot(4,1,2)
hold on
plot(Dist_relative,EquivDiameter(1:end))
plot(Dist_relative,MajorAxisLength(1:end),'m')
plot(Dist_relative,MinorAxisLength(1:end),'y')
legend('EquivDiameter', 'MajorAxisLength','MinorAxisLength','Location','best')
% line([Dist_relative(part0(1)) Dist_relative(part0(1))],[min(EquivDiameter) max(EquivDiameter)],'Color','g');
line([Dist_relative(part1(1)) Dist_relative(part1(1))],[min(EquivDiameter) max(EquivDiameter)],'Color','g');
line([Dist_relative(part2(1)) Dist_relative(part2(1))],[min(EquivDiameter) max(EquivDiameter)],'Color','g');
line([Dist_relative(part3(1)) Dist_relative(part3(1))],[min(EquivDiameter) max(EquivDiameter)],'Color','r');
line([Dist_relative(part4(1)) Dist_relative(part4(1))],[min(EquivDiameter) max(EquivDiameter)],'Color','r');
% for 3 segments
% line([Dist_relative(part4(end)) Dist_relative(part4(end))],[min(EquivDiameter) max(EquivDiameter)],'Color','g');

line([Dist_relative(part5(1)) Dist_relative(part5(1))],[min(EquivDiameter) max(EquivDiameter)],'Color','g');
line([Dist_relative(part5(end)) Dist_relative(part5(end))],[min(EquivDiameter) max(EquivDiameter)],'Color','g');
% line([Dist_relative(part6(end)) Dist_relative(part6(end))],[min(EquivDiameter) max(EquivDiameter)],'Color','g');
ylabel('diameter')
grid on
subplot(4,1,3)
hold on
plot(Dist_relative,EquivDiameter(1:end)/2)
plot(Dist_relative,radius(1:end),'m')
plot(Dist_relative,radius_min(1:end),'y')
legend('EquivRadius', 'maximum radius', 'minimum radius','Location','best')
% line([Dist_relative(part0(1)) Dist_relative(part0(1))],[min(radius) max(radius)],'Color','g');
line([Dist_relative(part1(1)) Dist_relative(part1(1))],[min(radius) max(radius)],'Color','g');
line([Dist_relative(part2(1)) Dist_relative(part2(1))],[min(radius) max(radius)],'Color','g');
line([Dist_relative(part3(1)) Dist_relative(part3(1))],[min(radius) max(radius)],'Color','r');
line([Dist_relative(part4(1)) Dist_relative(part4(1))],[min(radius) max(radius)],'Color','r');
% for 3 segments
% line([Dist_relative(part4(end)) Dist_relative(part4(end))],[min(radius) max(radius)],'Color','g');

line([Dist_relative(part5(1)) Dist_relative(part5(1))],[min(radius) max(radius)],'Color','g');
line([Dist_relative(part5(end)) Dist_relative(part5(end))],[min(radius) max(radius)],'Color','g');
% line([Dist_relative(part6(end)) Dist_relative(part6(end))],[min(radius) max(radius)],'Color','g');
ylabel('diameter')
grid on
subplot(4,1,4)
plot(Dist_relative,OldArea(1:end))
% line([Dist_relative(part0(1)) Dist_relative(part0(1))],[min(OldArea) max(OldArea)],'Color','g');
line([Dist_relative(part1(1)) Dist_relative(part1(1))],[min(OldArea) max(OldArea)],'Color','g');
line([Dist_relative(part2(1)) Dist_relative(part2(1))],[min(OldArea) max(OldArea)],'Color','g');
line([Dist_relative(part3(1)) Dist_relative(part3(1))],[min(OldArea) max(OldArea)],'Color','r');
line([Dist_relative(part4(1)) Dist_relative(part4(1))],[min(OldArea) max(OldArea)],'Color','r');
% for 3 segments
% line([Dist_relative(part4(end)) Dist_relative(part4(end))],[min(OldArea) max(OldArea)],'Color','g');

line([Dist_relative(part5(1)) Dist_relative(part5(1))],[min(OldArea) max(OldArea)],'Color','g');
line([Dist_relative(part5(end)) Dist_relative(part5(end))],[min(OldArea) max(OldArea)],'Color','g');
% line([Dist_relative(part6(end)) Dist_relative(part6(end))],[min(OldArea) max(OldArea)],'Color','g');
ylabel('cross sectional area')
xlabel('centerline (mm)')
grid on
%saveas(gcf,['FeatureDiameter-Case',name,'.png'])

figure;% Ratio
subplot(4,1,1)
hold on
plot(Dist_relative,Eccentricity(1:end))

% line([Dist_relative(part0(1)) Dist_relative(part0(1))],[min(Eccentricity) max(Eccentricity)],'Color','g');

line([Dist_relative(part1(1)) Dist_relative(part1(1))],[min(Eccentricity) max(Eccentricity)],'Color','g');
line([Dist_relative(part2(1)) Dist_relative(part2(1))],[min(Eccentricity) max(Eccentricity)],'Color','g');
line([Dist_relative(part3(1)) Dist_relative(part3(1))],[min(Eccentricity) max(Eccentricity)],'Color','r');
line([Dist_relative(part4(1)) Dist_relative(part4(1))],[min(Eccentricity) max(Eccentricity)],'Color','r');
% for 3 segments
% line([Dist_relative(part4(end)) Dist_relative(part4(end))],[min(Eccentricity) max(Eccentricity)],'Color','g');
line([Dist_relative(part5(1)) Dist_relative(part5(1))],[min(Eccentricity) max(Eccentricity)],'Color','g');
line([Dist_relative(part5(end)) Dist_relative(part5(end))],[min(Eccentricity) max(Eccentricity)],'Color','g');
% line([Dist_relative(part6(end)) Dist_relative(part6(end))],[min(Eccentricity) max(Eccentricity)],'Color','g');
ylabel('eccentricity')
suptitle(['Main Blood Vessel Information - Ratio (Case',name,')'])
grid on
subplot(4,1,2)
hold on 

plot(Dist_relative,Extent(1:end))
% line([Dist_relative(part0(1)) Dist_relative(part0(1))],[min(Extent) max(Extent)],'Color','g');
line([Dist_relative(part1(1)) Dist_relative(part1(1))],[min(Extent) max(Extent)],'Color','g');
line([Dist_relative(part2(1)) Dist_relative(part2(1))],[min(Extent) max(Extent)],'Color','g');
line([Dist_relative(part3(1)) Dist_relative(part3(1))],[min(Extent) max(Extent)],'Color','r');
line([Dist_relative(part4(1)) Dist_relative(part4(1))],[min(Extent) max(Extent)],'Color','r');

% for 3 segments
% line([Dist_relative(part4(end)) Dist_relative(part4(end))],[min(Extent) max(Extent)],'Color','g');
line([Dist_relative(part5(1)) Dist_relative(part5(1))],[min(Extent) max(Extent)],'Color','g');
line([Dist_relative(part5(end)) Dist_relative(part5(end))],[min(Extent) max(Extent)],'Color','g');
% line([Dist_relative(part6(end)) Dist_relative(part6(end))],[min(Extent) max(Extent)],'Color','g');
ylabel('extent')
grid on
subplot(4,1,3)
hold on

plot(Dist_relative,Solidity(1:end))
% line([Dist_relative(part0(1)) Dist_relative(part0(1))],[min(Solidity) max(Solidity)],'Color','g');
line([Dist_relative(part1(1)) Dist_relative(part1(1))],[min(Solidity) max(Solidity)],'Color','g');
line([Dist_relative(part2(1)) Dist_relative(part2(1))],[min(Solidity) max(Solidity)],'Color','g');
line([Dist_relative(part3(1)) Dist_relative(part3(1))],[min(Solidity) max(Solidity)],'Color','r');
line([Dist_relative(part4(1)) Dist_relative(part4(1))],[min(Solidity) max(Solidity)],'Color','r');
% for 3 segments
% line([Dist_relative(part4(end)) Dist_relative(part4(end))],[min(Solidity) max(Solidity)],'Color','g');

line([Dist_relative(part5(1)) Dist_relative(part5(1))],[min(Solidity) max(Solidity)],'Color','g');
line([Dist_relative(part5(end)) Dist_relative(part5(end))],[min(Solidity) max(Solidity)],'Color','g');
% line([Dist_relative(part6(end)) Dist_relative(part6(end))],[min(Solidity) max(Solidity)],'Color','g');
ylabel('solidity')
grid on
subplot(4,1,4)
plot(Dist_relative,OldArea(1:end))
% line([Dist_relative(part0(1)) Dist_relative(part0(1))],[min(OldArea) max(OldArea)],'Color','g');
line([Dist_relative(part1(1)) Dist_relative(part1(1))],[min(OldArea) max(OldArea)],'Color','g');
line([Dist_relative(part2(1)) Dist_relative(part2(1))],[min(OldArea) max(OldArea)],'Color','g');
line([Dist_relative(part3(1)) Dist_relative(part3(1))],[min(OldArea) max(OldArea)],'Color','r');
line([Dist_relative(part4(1)) Dist_relative(part4(1))],[min(OldArea) max(OldArea)],'Color','r');
%
% line([Dist_relative(part4(end)) Dist_relative(part4(end))],[min(OldArea) max(OldArea)],'Color','g');

line([Dist_relative(part5(1)) Dist_relative(part5(1))],[min(OldArea) max(OldArea)],'Color','g');
line([Dist_relative(part5(end)) Dist_relative(part5(end))],[min(OldArea) max(OldArea)],'Color','g');
% line([Dist_relative(part6(end)) Dist_relative(part6(end))],[min(OldArea) max(OldArea)],'Color','g');
ylabel('cross sectional area')
xlabel('centerline (mm)')
grid on
%saveas(gcf,['FeatureRatio-Case',name,'.png'])

save location Dist_relative Distal_2 Distal_1 aneu_start aneu_end Proximal_1 Proximal_2 AL Area_diff1 seg p1L p2L d1L d2L
% save location Dist_relative Distal_1 Distal_2 Distal_3 aneu_start aneu_end ...
%     Proximal_1 Proximal_2 Proximal_3 AL Area_diff1 seg p1L p2L p3L d1L d2L d3L

% max(MajorAxisLength(a:b))
% MajorAxisLength(a)
% MajorAxisLength(b)

%%
% Approximate arclens by accumulating point to point geometric distance 
% P2arclens = zeros(Proximal_1-Proximal_2,1);
% inc = 0
% for i = 1: Proximal_1-Proximal_2
%     P2arclens(i) = inc + sqrt(sum((OldCenterline(Proximal_2+i-1,:)-OldCenterline(Proximal_2,:)).^2));
%     inc = P2arclens(i)
% end
% 
% P1arclens = zeros(aneu_start-Proximal_1,1);
% inc = 0
% for i = 1: aneu_start-Proximal_1
%     P1arclens(i) = inc + sqrt(sum((OldCenterline(Proximal_1+i-1,:)-OldCenterline(Proximal_1,:)).^2));
%     inc = P1arclens(i)
% end
% 
% figure;
% hold on
% plot(P2arclens,Eccentricity(Proximal_2:Proximal_1-1))
% ylabel('eccentricity')
% xlabel('arclength P2')
% suptitle(['Main Blood Vessel Information - Eccentricity(P2) (Case',name,')'])
% grid on
% 
% figure;
% hold on 
% plot(P1arclens,OldKappa(Proximal_1:aneu_start-1))
% ylabel('curvature (\kappa)')
% xlabel('arclength P1')
% suptitle(['Main Blood Vessel Information - Curvature(P1) (Case',name,')'])
% grid on
% 
% figure;
% hold on
% PD = OldKappa(Proximal_1:aneu_start-1)./OldKappa(aneu_end+1:Distal_1)
% plot(P1arclens,log(PD))
% suptitle(['Main Blood Vessel Information - curvature(P1/D1) (Case',name,')'])
% ylabel('curvature (\kappa)')
% xlabel('arclength P1')


%% determine segment lenght (number of points)
function y = findf(x1,x2,ind,const)
    if isempty(x1) & isempty(x2) y = const;
    elseif isempty(x1) y = x2;
    elseif isempty(x2) y = x1;
    else
        if strcmp(ind,'seg') y = min(x2,x1);
%         if strcmp(ind,'seg') y = max(x2,x1);
        elseif strcmp(ind,'pro') y = max(x2,x1);
        elseif strcmp(ind,'dis') y = min(x2,x1);
        end
    end
end



%% determine cumulative difference
function [relative,indexa,indexb] = cumdiff(a,b,old,N,step)
    relative = zeros(fix(N/step)+1,1);
    indexb = fix(b/step);
    index = indexb+1;
    
    for i = b+step:step:N
        relative(index) = sum(old(i-step:i));
        index = index+1;
    end

    indexa = fix(a/step);
    index = indexa;
    for i = a-step:-step:1
        relative(index) = -sum(old(i:i+step));
        index = index-1;
    end
    
end