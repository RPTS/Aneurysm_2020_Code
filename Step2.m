%%%% This file finds a main connected centerline %%%%
% Input: skeleton of object (skeleton.mat) and the original image (*.stl)
% Output: mainskel.mat including mainskel_xyz (a list to show the x,y,z 
%         coordinate of the main vessel), mainskel (a list to show the x,y,z 
%         location in the binary matrix of main vessel);
%         list.mat includes list, mainD (maximal radius), and curveFit (smoothing centerline)
% Image: [modified] 1_1 (quantile: 0.01, distance: 10), 2_1 (0.2), 3_1 (0.2,cut), 
%                   4_1 (0.1,cut), 5_1 (0.1,cut), 6_1 (0.2,cut), 7_1 (0.1), 8_1 (0.1), 
%        [selected] 9_1 (0.1,cut), 10_1 (0.01), 12_1 (0.2,cut;0.01;0.25,cut), 13_1 (0.01,cut; 0.05,cut),
%                   14_1 (0.2), 16_1 (0.01,cut), 17_1 (0.1,cut), 19_1 (0.1;0.05,cut), 
%        [new modified] 21_1 (0.1), 22_1 (0.1,cut,distances 3), 
%        [new] 26_1 (0.1,cut), 27_1 (0.1,cut) 28_1 (0.1,cut), 29_1 (0.05),
%              30_1 (0.05), 31_1 (0.1), 32_1 (0.1), 33_1 (0.1,cut), 36_1 (0.1,cut),
%              39_1 (0.1), 40_1 (0.05,cut), 41_1 (0.05), 42_1 (0.2,cut),
%              43_1 (0.05,cut), 44_1 (0.1,cut), 45_1 (0.1), 47_1 (0.05,cut),
%              48_1 (0.01,cut), 49_1 (0.01), 50_1 (0.1,cut)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear 
close all

%% Get skeleton and surface of object
load('skeleton.mat');   
[vertices,faces,normals,~] = stlRead(['/Users/Rikki/Desktop/AneurysmSummerProject/Image/',name,'_1c.stl']);   % vertices

%% Changed parameters
quantile_list = [0.01,0.2,0.2,0.1,0.1,0.2,0.1,0.1,0.1,0.01,0,0.25,0.05,0.2,0,0.01,0,0,0.05,0,0.1,0.1,...  % 22_1
    0,0,0,0.1,0.1,0.1,0.05,0.05,0.1,0.1,0.1,0,0,0.1,0,0,0.1,0.05,0.05,0.2,0.05,0.1,0.1,0,0.05,0.01,0.01,0.1,0.1];
distance_list = [10,10,10,10,10,10,10,10,10,10,0,10,10,10,0,10,0,0,10,0,10,3,...
    0,0,0,10,10,10,10,10,10,10,10,0,0,10,0,0,10,10,10,10,10,10,10,0,10,10,10,10,0];% added random number for 51 case
list_ind = str2double(name);

%% Calculate minimum distance between centerline and surface
skel_N = length(skel_xyz);
vertices_mark = zeros(skel_N,1);
distances = zeros(skel_N,1);
for i = 1:skel_N
    [vertex_mark, distance] = findclosestvertex(vertices, skel_xyz(i,:));
    vertices_mark(i) = vertex_mark;
    distances(i) = distance;
end
D = distances;

%% Plot all vessels
[stlcoords] = READ_stl(['/Users/Rikki/Desktop/AneurysmSummerProject/Image/',name,'_1c.stl']);  
xco = squeeze(stlcoords(:,1,:))';
yco = squeeze(stlcoords(:,2,:))';
zco = squeeze(stlcoords(:,3,:))';

figure;
[hpat] = patch(xco,yco,zco,'b','EdgeColor','none');
alpha(0.2);
camlight('headlight');
material('dull');
hold on
S = distances*30;
C = distances;
scatter3(skel_xyz(:,1),skel_xyz(:,2),skel_xyz(:,3),S,C,'filled');
view(75,10)
title(['All Blood Vessels (Case ',name,')'])
colorbar;
xlabel x
ylabel y
zlabel z

%% Set a threshold of distance to choose main vessel 
%%%%%%%%%% quantile %%%%%%%%%%%%%%%%
threshold = quantile(distances,quantile_list(list_ind));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mainskel_xyz = skel_xyz(distances > threshold,:);
mainskel = [x(distances > threshold),y(distances > threshold),z(distances > threshold)];

%% Plot main vessel 
S = distances(distances > threshold)*30;
C = distances(distances > threshold);
maindist = C;

figure;
scatter3(mainskel_xyz(:,1),mainskel_xyz(:,2),mainskel_xyz(:,3),S,C,'filled');
title(['Main Blood Vessels (Case ',name,')'])
axis equal
colorbar;
view(75,10)

% %% Delete noise
% %%%%%%%%%%%%%%% test delete dots %%%%%%%%%%%%%%%%%%%
% %cut = [160,161,166,167];   % 3_1
% %cut = [208,211];   % 4_1
% %cut = [215,216,217];   % 5_1
% %cut = [149,150,156,157,162,163,172,173,175,185];   % 6_1
% %cut = [210,221,283,284,313,314,315,316,317,318,320,321,322,324,325,326,328,329,331,332,333,337,338,339,340,342,347,370,371]; % 9_1
% %cut = [174,175,176,178,179,180,181,182,183,184,187,198,204,206,207,212,218,219,234,243]; %12_1(old)
% %cut = [163,169,171,175,176,184,186,191,195,206,208,221]; % 12_1
% %cut = [100,101,102,109,110,111];  % 13_1(old)
% %cut = [199,200,211,212,213,214,215,216,217,227,228,229,230,260,261,262,263,264,268,269];   % 13_1
% %cut = [253,254,255,256];  % 16_1
% %cut = [351,353,354,355];  % 17_1
% %cut = [267,268,272,279,280,281,282,283,284,287,288,289,295,296,297,298,305,306,307,308,322,328];  % 19_1
% %cut = [336,337,346,355,356,357,358,359,360,361,362,368,369,370,371,372,373,374,375,376,377,383,384,388,390,397,...
% %   411,412,413,415,416,418,419,420,424,425,426,427,428,429,431,435,440,441,444,445,446,447,448,449,454,455,458,459];   % 22_1
% %cut = [113,114,116,118,126,127,128,130,134];  % 26_1
% %cut = [135,137,140,142,145];  % 27_1
% %cut = [245,246,247];  % 28_1
% %cut = [209,212,213,214,215];  % 33_1
% %cut = [291,292,295];  % 36_1
% %cut = [169,170,171,172];  % 40_1
% %cut = [210,218,220,221,226,229,230,232,233];  % 42_1
% %cut = [156,157];  % 43_1
% %cut = [180,181,182,187,188,189,190];  % 44_1
% %cut = [183,184,240,241];  % 47_1
% %cut = [203,204,210,211,212,213,214,215,216,217];   % 48_1
% %cut = [218,219,221,222,224,225,229,231];    % 50_1
% mainskel_xyz(cut,:) = [];
% mainskel(cut,:) = [];
% maindist(cut) = [];
% 
% % figure;
% % [hpat] = patch(xco,yco,zco,'b','EdgeColor','none');
% % alpha(0.2);
% % camlight('headlight');
% % material('dull');
% % hold on
% % scatter3(mainskel_xyz(:,1),mainskel_xyz(:,2),mainskel_xyz(:,3),'k.');
% % scatter3(mainskel_xyz(cut,1),mainskel_xyz(cut,2),mainskel_xyz(cut,3),'r');
% % %scatter3(mainskel_xyz(cut1,1),mainskel_xyz(cut1,2),mainskel_xyz(cut1,3),'g');
% % title(['Modified Main Blood Vessels (Case ',name,')'])
% % view(75,10)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Connect center points
list = [];
list = [list; mainskel_xyz(1,:)];
other_xyz = mainskel_xyz(2:end,:);
N = size(other_xyz,1);
distances = [];
mainD = maindist(1);
distother = maindist(2:end);
while ~isempty(other_xyz)
    [vertex_mark, distance] = findclosestvertex(other_xyz,list(end,:));    
    list = [list; other_xyz(vertex_mark,:)];
    distances = [distances;distance];
    other_xyz(vertex_mark,:) = [];
    mainD = [mainD; distother(vertex_mark)];
    distother(vertex_mark,:) = [];
    N = size(other_xyz,1);
end
%%%%%%%%%%% distances %%%%%%%%%%%%%%%
ind = find(distances>distance_list(list_ind));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ind = [ind;ind+1];
if ~isempty(ind)
list(ind(1):end,:) = [];
mainD(ind(1):end) = [];
end

%% Smooth
x = list(:,1);
y = list(:,2);
z = list(:,3);
u = smoothn({x,y,z},'robust');  
curveFit = [u{1},u{2},u{3}];   % curveFit is the fitting curve
scatter3(u{1},u{2},u{3})

load('curve1.mat')


% plot3(x,y,z,'r.',u{1},u{2},u{3},'k','linewidth',2);
plot3(u{1},u{2},u{3},'k','linewidth',2);
view(75,10)
% title(['curve fitting (Case ',name,')'])
axis tight square

save curve1 curveFit
save mainskel mainskel_xyz mainskel skel maindist
save list list mainD curveFit name

