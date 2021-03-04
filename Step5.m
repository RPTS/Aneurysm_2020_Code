%%%% This file creats imaginative part, calculates distance between %%%%
%%%% two curves (real and supposed) [Feature 2: sequence], and %%%%
%%%% calculates angle and distance between two vectors in 3D [Feature 3] %%%%
% Input: Info and location
% Output: supposed curve, distance between two curves, angle and distance
%         between two lines

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
close all

load('Info.mat');    
load location

Line = OldCenterline;
ImaLine = Line;

%%%%%%%%%% range %%%%%%%%%%%%
a = aneu_start;
b = aneu_end;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ImaLine(a:b,:) = [];
x = ImaLine(:,1);
y = ImaLine(:,2);
z = ImaLine(:,3);
N_del = length(Line)-length(ImaLine);

%% Hobby Spline
jj = 1;
for ii = 1:a-2 
   points{jj} = {ImaLine(ii,:)};   
   jj = jj+1;
end
points{jj} = {ImaLine(a-1,:) centervector(a-1,:) 1}; 
SpaceCurve{1} = {ImaLine(a-1,:) centervector(a-1,:)};
jj = jj+1;
points{jj} = {ImaLine(a,:) centervector(b+1,:) 1}; 
SpaceCurve{2} = {ImaLine(a,:) centervector(b+1,:)};
jj = jj+1;
for ii = a+1:length(ImaLine) 
   points{jj} = {ImaLine(ii,:)};   
   jj = jj+1;
end

%% Choose Effective Part 
figure
Q = hobbysplines(points,'debug',true,'cycle',true,'color','red');
view(75,10)
[Ind,~,~] = dividerand(48,(N_del-2)/48,0,1-(N_del-2)/48);
range = Q((a-2)*50+2:(a-1)*50-1,:);
Q_chose = range(Ind,:);
SC = [Q(1:50:(a-2)*50,:);Q((a-2)*50+1,:);Q_chose;Q((a-1)*50,:);Q((a-1)*50+1:50:length(ImaLine)*50,:);Q((length(ImaLine)-1)*50+1,:)];

[k2,t1,T,N,B] = frenet_robust(SC',7,0.1);
Apart = a:a+N_del-2;

%% Show curvature and torsion
figure;
subplot(2,1,1)
plot(k2(1:end))
hold on 
line([Apart(1) Apart(1)],[min(k2) max(k2)],'Color','g');
line([Apart(end) Apart(end)],[min(k2) max(k2)],'Color','g');
ylabel('curvature (\kappa)')
title(['Supposed Main Blood Vessel Information (Case',name,')'])
subplot(2,1,2)
plot(t1(1:end))
hold on 
line([Apart(1) Apart(1)],[min(t1) max(t1)],'Color','g');
line([Apart(end) Apart(end)],[min(t1) max(t1)],'Color','g');
ylabel('torsion (\tau)')

%% Label Location
%%%%%%%%%% range %%%%%%%%%%%%
Apart = aneu_start:aneu_end;
Apart1 = aneu_start-1:aneu_end+1;

[stlcoords] = READ_stl(['/Users/Rikki/Desktop/AneurysmProject/Image/',name,'_1.stl']);  
xco = squeeze( stlcoords(:,1,:) )';
yco = squeeze( stlcoords(:,2,:) )';
zco = squeeze( stlcoords(:,3,:) )';

figure;
[hpat] = patch(xco,yco,zco,'b','EdgeColor','none');
alpha(0.2);
camlight('headlight');
material('dull');
hold on   
plot3(Line(:,1),Line(:,2),Line(:,3),'square','Markersize',1,'MarkerFaceColor','k','Color','k'); 
scatter3(Line(Apart(1),1),Line(Apart(1),2),Line(Apart(1),3),'MarkerEdgeColor','r','MarkerFaceColor','r'); 
scatter3(Line(Apart(end),1),Line(Apart(end),2),Line(Apart(end),3),'MarkerEdgeColor','r','MarkerFaceColor','r'); 
set(gcf,'Color','white');
title(['Segment Location (Case',name,')'])
view(75,10)

%% Supposed Curve
figure % 3D curve fitting 
plot3(Line(:,1),Line(:,2),Line(:,3));
hold on
plot3(SC(:,1),SC(:,2),SC(:,3));
legend('real curve', 'supposed curve')
title(['Centerline (Case',name,')'])
view(75,10)
%saveas(gcf,['Curve-Case',name,'.png'])

figure % 3D curve fitting (part)
plot3(Line(Apart1,1),Line(Apart1,2),Line(Apart1,3));
hold on
plot3(SC(Apart1,1),SC(Apart1,2),SC(Apart1,3));
legend('real curve', 'supposed curve')
view(75,10)
title(['Aneurysm Centerline (Case',name,')'])
%saveas(gcf,['CurveZoom-Case',name,'.png'])

%% Supposed Curve Info
curve = SC(Apart1,:)';
smoothcurve = fnplt(cscvn(curve(:,[1:end 1])))';

Dist_curves = [];
for i = 1:length(Apart1)
    [vertex_mark, distance] = findclosestvertex(smoothcurve,Line(Apart1(i),:));    
    Dist_curves = [Dist_curves;distance];
end
%Dist_curves = sqrt(sum((Centerline(Apart1,:)-SC(Apart1,:)).^2,2));

figure;
plot(Dist_relative(Apart1),Dist_curves)
ylabel('distance (mm)')
xlabel('centerline (mm)')
title(['Distance between Centerline and Supposed Curve (Case',name,')'])
%saveas(gcf,['Distance-Case',name,'.png'])

AsymmetryFactor = 1-max(Dist_curves)/max(MajorAxisLength);  % 1:symmetry, 0.5:asymmetry

%% Calculate angle and distance between two vectors in 3D

Start1 = SpaceCurve{1}{1};   % start point
vector_a = SpaceCurve{1}{2};   % start vector
End1 = vector_a*10+Start1;
line1 = [Start1; End1];
Start2 = SpaceCurve{2}{1};    % end point
vector_b = SpaceCurve{2}{2};    % end vector
End2 = vector_b*10+Start2;
line2 = [Start2; End2];

% angle1 = atan2(norm(cross(vector_a,vector_b)),dot(vector_a,vector_b))
% angle2 = 2*atan(norm(vector_a*norm(vector_b)-norm(vector_a)*vector_b)/norm(vector_a*norm(vector_b)+norm(vector_a)*vector_b))
angle = acos(dot(vector_a,vector_b)/(norm(vector_a)*norm(vector_b)))*180/pi;  % degree

distance_point = sqrt(sum((Start1-Start2).^2));   % distance between two points
[distance_line, ~] = DistBetween2Segment(Start1, End1, Start2, End2); % distance between two lines

save supposedcurve SC k2 t1 Apart1 Dist_curves SpaceCurve name AsymmetryFactor angle distance_point distance_line Area_diff1

filename = strcat(['Case',name]);
save(filename,'name','a','b','OldCenterline','OldArea','MaxD','MinD','Centerline',...
     'Area','ConvexArea','MajorAxisLength','MinorAxisLength','EquivDiameter','Perimeter',...
     'Eccentricity','Orientation','Solidity','Extent','OldKappa','OldTau','kappa','tau','centervector',...
     'Dist_relative','Distal_2','Distal_1','aneu_start','aneu_end','Proximal_1','Proximal_2','AL','Area_diff1',...
     'SC','k2','t1','Apart1','Dist_curves','SpaceCurve','AsymmetryFactor','angle','distance_point','distance_line');

% save(filename,'name','a','b','OldCenterline','OldArea','MaxD','MinD','Centerline',...
%      'Area','ConvexArea','MajorAxisLength','MinorAxisLength','EquivDiameter','Perimeter',...
%      'Eccentricity','Orientation','Solidity','Extent','OldKappa','OldTau','kappa','tau','centervector',...
%      'Dist_relative','Distal_1','Distal_2','Distal_3','aneu_start','aneu_end',...
%      'Proximal_1','Proximal_2','Proximal_3','AL','Area_diff1',...
%      'SC','k2','t1','Apart1','Dist_curves','SpaceCurve','AsymmetryFactor','angle','distance_point','distance_line');
