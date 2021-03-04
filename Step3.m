%%%% This file modifies centerline and calculates some feature sequence
%%%% based on slicing and thinning algorithm %%%%
% Input: list (connected centerline)
% Output: Info includes modified centerline and some geometric properties: 
%         curvature, torsion, diameter, perimeter, cross sectional area, 
%         eccentricity, orientation, solidity (Area/hull), extent (Area/BB)
% Image: [modified] 1_1 (mainD,curveFit: 1:end, Apart = 194:218 (196:218)), 
% 2_1 (mainD,curveFit: 1:end, Apart = 89:119 (90:116)),
% 3_1 (mainD,curveFit: 1:end, Apart = 143:169 (143:167)),
% 4_1 (mainD,curveFit: 1:end, Apart = 188:210 (188:212)),
% 5_1 (mainD,curveFit: 1:end, Apart = 172:204 (172:202)),
% 6_1 (mainD,curveFit: 1:end, Apart = 142:166 (142:182)),
% 7_1 (mainD,curveFit: 1:end, Apart = 156:188 (156:190)),
% 8_1 (mainD,curveFit: 1:end, Apart = 142:166 (140:173)),
% 9_1 (mainD,curveFit: 1:end, Apart = 280:312 (280:311)),
% 10_1 (mainD,curveFit: 1:end, Apart = 176:202 (178:202), idx = 10),
% 12_1 (mainD,curveFit: 1:end, Apart = 146:174; 71:90; 136:166),
% 13_1 (mainD,curveFit: 1:end, Apart = 104:124; 198:236 (196:240)),
% 14_1 (mainD,curveFit: 1:end, Apart = 135:180 (137:170)),
% 16_1 (mainD,curveFit: 1:end, Apart = 231:252, idx = 3),
% 17_1 (mainD,curveFit: 1:end, Apart = 287:310 (284:312)),
% 19_1 (mainD,curveFit: 1:end, Apart = 115:133; 247:283 (247:290), idx = 50),
% 21_1 (mainD,curveFit: 1:end, Apart = 60:95 (60:94)),
% 22_1 (mainD,curveFit: 1:end, Apart = 326:346 (314:356)),
% 26_1 (mainD,curveFit: 1:end, Apart = 98:126 (96:128)),
% 27_1 (mainD,curveFit: 1:end, Apart = 126:150 (125:150)),
% 28_1 (mainD,curveFit: 1:end, Apart = 222:240),
% 29_1 (mainD,curveFit: 1:end, Apart = 150:182, idx = 50),
% 30_1 (mainD,curveFit: 1:end, Apart = 133:161),
% 31_1 (mainD,curveFit: 1:end, Apart = 202:236 (196:238)),
% 32_1 (mainD,curveFit: 1:end, Apart = 170:202 (170:208)),
% 33_1 (mainD,curveFit: 1:end, Apart = 194:230 (195:226)),
% 36_1 (mainD,curveFit: 1:end, Apart = 260:274),
% 39_1 (mainD,curveFit: 1:end, Apart = 160:192),
% 40_1 (mainD,curveFit: 1:end, Apart = 144:169),
% 41_1 (mainD,curveFit: 1:end, Apart = 142:184),
% 42_1 (mainD,curveFit: 1:end, Apart = 196:238),
% 43_1 (mainD,curveFit: 1:end, Apart = 145:162),
% 44_1 (mainD,curveFit: 1:end, Apart = 150:186),
% 45_1 (mainD,curveFit: 1:end, Apart = 38:68),
% 47_1 (mainD,curveFit: 1:end, Apart = 154:198),
% 48_1 (mainD,curveFit: 1:end, Apart = 156:178),
% 49_1 (mainD,curveFit: 1:end, Apart = 151:176),
% 50_1 (mainD,curveFit: 1:end, Apart = 162:180)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
close all

load('list.mat');   
load VolumePixel 

%% Changed parameters
a_list = [196,90,143,188,172,142,156,140,280,178,0,136,196,137,0,231,0,0,247,0,60,314,...  % 22_1
    0,0,0,96,125,222,150,133,196,170,195,0,0,260,0,0,160,144,142,196,145,150,38,0,154,156,151,162]; 
b_list = [218,116,167,212,202,182,190,173,311,202,0,166,240,170,0,252,0,0,290,0,94,356,...
    0,0,0,128,150,240,182,161,238,208,226,0,0,274,0,0,192,169,184,238,162,186,68,0,198,178,176,180];
idx_list = [80,80,80,80,80,80,80,80,80,10,0,80,80,80,0,3,0,0,50,0,80,80,...
    0,0,0,80,80,80,50,80,80,80,80,0,0,80,0,0,80,80,80,80,80,80,80,0,50,50,80,80];
list_ind = str2double(name);

%% TNB
radius = mainD(1:end);
finalLine = curveFit(1:end,:);   
x = finalLine(:,1);
y = finalLine(:,2);
z = finalLine(:,3);
[k_old,t_old,T,N,B] = frenet_robust(finalLine',7,0.1);

figure;
line(x,y,z,'Color','r','LineWidth',8), hold on
quiver3(x,y,z,T(1,:)',T(2,:)',T(3,:)','color','b')
quiver3(x,y,z,N(1,:)',N(2,:)',N(3,:)','color','g')
quiver3(x,y,z,B(1,:)',B(2,:)',B(3,:)','color','y')
legend('Curve','Tangent','Normal','Binormal')
view(75,10)

%%%%%%%% range %%%%%%%%%
a = a_list(list_ind);
b = b_list(list_ind);
%%%%%%%%%%%%%%%%%%%%%%%%
Apart = a:b;
[stlcoords] = READ_stl(['/Users/Rikki/Desktop/AneurysmSummerProject/Image/',name,'_1.stl']);  
xco = squeeze(stlcoords(:,1,:))';
yco = squeeze(stlcoords(:,2,:))';
zco = squeeze(stlcoords(:,3,:))';

figure;
subplot(3,1,1)
plot(k_old(5:end-3))
hold on 
line([Apart(1) Apart(1)],[min(k_old) max(k_old)],'Color','g');
line([Apart(end) Apart(end)],[min(k_old) max(k_old)],'Color','g');
ylabel('curvature (\kappa)')
title(['Main Blood Vessel Information (Case ',name,')'])
subplot(3,1,2)
plot(t_old(5:end-3))
hold on 
line([Apart(1) Apart(1)],[min(t_old) max(t_old)],'Color','g');
line([Apart(end) Apart(end)],[min(t_old) max(t_old)],'Color','g');
ylabel('torsion (\tau)')
subplot(3,1,3)
plot(radius(5:end-3))
hold on 
line([Apart(1) Apart(1)],[min(radius) max(radius)],'Color','g');
line([Apart(end) Apart(end)],[min(radius) max(radius)],'Color','g');
ylabel('radius (r)')

%% Centervector
centercurve = curveFit(5:end-3,:);
centervector = T(:,5:end-3)';
% wn = 3;
% coeff = ones(1, wn)/wn;
% centervector1 = filter(coeff, 1, centervector);
R = radius(5:end-3);
n = length(centercurve);
V = double(OUTPUTgrid);
[X,Y,Z] = meshgrid(gridCOx,gridCOy,gridCOz);
Vnew = zeros(size(V,2),size(V,1),size(V,3));
for i = 1:size(V,3)
    Vnew(:,:,i) = V(:,:,i)';
end

CrossArea = [];
R_max = [];
R_min = [];
Area2D = [];
ConvexArea2D = [];
MajorAxisLength2D = [];
MinorAxisLength2D = [];
EquivDiameter2D = [];
Perimeter2D = [];
Centroid2D = [];
Eccentricity2D = [];
Orientation2D = [];
Solidity2D = [];
Extent2D = [];

%figure;
for i = 1:n
    v = centervector(i,:);
    x1 = centercurve(i,1);
    y1 = centercurve(i,2);
    z1 = centercurve(i,3);
    w = null(v);
    range = 2*ceil(R(i));
    delta = 0.1;
    [P,Q] = meshgrid(-range:delta:range);
    Xc = x1+w(1,1)*P+w(1,2)*Q;
    Yc = y1+w(2,1)*P+w(2,2)*Q;
    Zc = z1+w(3,1)*P+w(3,2)*Q;
    hsp = surf(Xc,Yc,Zc);
    xd = hsp.XData;
    yd = hsp.YData;
    zd = hsp.ZData;
    smallA = delta^2;
    hslicer = slice(X,Y,Z,Vnew,xd,yd,zd);
    vd = hslicer.CData;
    obj = vd;
    obj(isnan(obj)) = 0;
    obj(obj>=0.5) = 1;
    obj(obj<0.5) = 0;
    BW = imbinarize(obj);
    [B,L,N] = bwboundaries(BW,'noholes');
    for j = 1:N
        A(j) = sum(sum(double(L == j)));
    end
    [Amax,Aloc] = max(A);
    boundary = B{Aloc};
    line1 = [xd(1,end)-xd(1,1),yd(1,end)-yd(1,1),zd(1,end)-zd(1,1)];
    line2 = [xd(end,1)-xd(1,1),yd(end,1)-yd(1,1),zd(end,1)-zd(1,1)];
    CrossArea = [CrossArea; norm(cross(line1,line2))*Amax/(size(L,1)*size(L,2))];
    for k = 1:length(boundary)
        rad(k) = sqrt((xd(boundary(k,2),boundary(k,1))-xd(fix(size(L,2)/2)+1,fix(size(L,1)/2)+1))^2+...
            (yd(boundary(k,2),boundary(k,1))-yd(fix(size(L,2)/2)+1,fix(size(L,1)/2)+1))^2+...
            (zd(boundary(k,2),boundary(k,1))-zd(fix(size(L,2)/2)+1,fix(size(L,1)/2)+1))^2);
    end
    rad_max = max(rad);
    rad_min = min(rad);
    R_max = [R_max; rad_max];
    R_min = [R_min; rad_min];
    %%%% 2d geometric properties (regionprops) %%%%
    cc = bwconncomp(BW);
    statsc = regionprops(cc, 'Area','Eccentricity'); 
    
    %%%%%%%%%% idx>80 (normal), idx>10 (case 10), idx>3 (case 16), idx>50 (case 19), idx>50 (case 29) %%%%%%
    
    idx = find(max([statsc.Area]) > idx_list(list_ind));    % 80
    BW2 = ismember(labelmatrix(cc), idx);
    stats = regionprops(BW2, 'Area','BoundingBox','Centroid','ConvexArea',...
            'Eccentricity','EquivDiameter','Extent','ConvexHull','ConvexImage',...
            'MajorAxisLength','MinorAxisLength','Orientation','Perimeter','Solidity'); 
    Area2D = [Area2D; stats.Area*smallA];
    ConvexArea2D = [ConvexArea2D; stats.ConvexArea*smallA];
    MajorAxisLength2D = [MajorAxisLength2D; stats.MajorAxisLength*delta];
    MinorAxisLength2D = [MinorAxisLength2D; stats.MinorAxisLength*delta];
    EquivDiameter2D = [EquivDiameter2D; stats.EquivDiameter*delta];
    Perimeter2D = [Perimeter2D; stats.Perimeter*delta];
    Centroid2D = [Centroid2D; xd(round(stats.Centroid(1)),round(stats.Centroid(1)))...
        yd(round(stats.Centroid(1)),round(stats.Centroid(1))),zd(round(stats.Centroid(1)),round(stats.Centroid(1)))];
    Eccentricity2D = [Eccentricity2D; stats.Eccentricity];
    Orientation2D = [Orientation2D; stats.Orientation];
    Solidity2D = [Solidity2D; stats.Solidity];
    Extent2D = [Extent2D; stats.Extent];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
% %%%%%%%%% Plot %%%%%%%%%%   
%     hold on
%     plot3(curveFit(5:end-3,1),curveFit(5:end-3,2),curveFit(5:end-3,3),'square','Markersize',1,'MarkerFaceColor','k','Color','k'); 
%     [hpat] = patch(xco,yco,zco,'b','EdgeColor','none');
%     alpha(0.2);
%     camlight('headlight');
%     material('dull');
%     view(75,10)
%     hold off
%     drawnow
%     pause
% %%%%%%%%%%%%%%%%%%%%%%%%%%    
    delete(hsp);
    delete(hslicer);
    A = [];
    rad = [];
end

OldKappa = k_old(5:end-3);
OldTau = t_old(5:end-3);
OldCenterline = centercurve;
OldArea = CrossArea;
MaxD = R_max*2;
MinD = R_min*2;
[k2,t1,T,N,B] = frenet_robust(Centroid2D',7,0.1);

Centerline = Centroid2D(1:end,:);
Area = Area2D(1:end);
ConvexArea = ConvexArea2D(1:end);
MajorAxisLength = MajorAxisLength2D(1:end);
MinorAxisLength = MinorAxisLength2D(1:end);
EquivDiameter = EquivDiameter2D(1:end); 
Perimeter = Perimeter2D(1:end);  
Eccentricity = Eccentricity2D(1:end);
Orientation = Orientation2D(1:end); 
Solidity = Solidity2D(1:end); 
Extent = Extent2D(1:end);
kappa = k2(1:end);
tau = t1(1:end);
centervector_new = T(:,1:end)';

%% Locate Range

figure;
[hpat] = patch(xco,yco,zco,'b','EdgeColor','none');
alpha(0.2);
camlight('headlight');
material('dull');
hold on   
plot3(curveFit(5:end-3,1),curveFit(5:end-3,2),curveFit(5:end-3,3),'square','Markersize',1,'MarkerFaceColor','k','Color','k'); 
plot3(Centerline(:,1),Centerline(:,2),Centerline(:,3),'square','Markersize',1,'MarkerFaceColor','y','Color','y'); 
scatter3(curveFit(4+Apart(1),1),curveFit(4+Apart(1),2),curveFit(4+Apart(1),3),'MarkerEdgeColor','r','MarkerFaceColor','r'); 
scatter3(curveFit(4+Apart(end),1),curveFit(4+Apart(end),2),curveFit(4+Apart(end),3),'MarkerEdgeColor','r','MarkerFaceColor','r'); 
set(gcf,'Color','white');
title(['Skeleton (Case ',name,')'])
view(75,10)

save Info name a b OldCenterline OldArea MaxD MinD Centerline Area ConvexArea ...
          MajorAxisLength MinorAxisLength EquivDiameter Perimeter ...
          Eccentricity Orientation Solidity Extent OldKappa OldTau kappa tau centervector

% save CenterVector centercurve centervector R


