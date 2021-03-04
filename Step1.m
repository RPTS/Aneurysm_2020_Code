%%%% This file generates voxels and initial centerline from image %%%%
% Input: *.stl format image
% Output: VolumePixel 
%         (OUTPUTgrid: 3d binary matrix, where 1: object, 0: background;
%         gridCOx, gridCOy, gridCOz: x,y,z coordinate)
%         skeleton (skel: binary matrix, where 1: centreline, 0: other;
%         skel_xyz: a list to show x,y,z coordinate of skeleton)
% Image: [modified] 1_1 (level: 7), 2_1 (7), 3_1 (7), 4_1 (7), 5_1 (7), 
%                   6_1 (7), 7_1 (7), 8_1 (7), 
%        [selected] 9_1 (7), 10_1 (7), 12_1 (7), 13_1 (7), 14_1(7),
%                   16_1 (7), 19_1 (7),
%        [new modified] 21_1 (7), 22_1 (7), 
%        [new] 26_1 (7), 27_1 (7), 28_1 (7), 29_1 (7), 30_1 (7), 31_1 (7),
%              32_1 (7), 33_1 (7), 36_1 (7), 39_1 (7), 40_1 (7), 41_1 (7),
%              42_1 (7), 43_1 (7), 44_1 (7), 45_1 (7), 47_1(7), 48_1 (7),
%              49_1 (7), 50_1 (7)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear 
close all

% load the image based on variable i stored in runName.mat
load runName
%% Plot the original STL mesh:
%%%%%%%%%%% name %%%%%%%%%%%%%%
name = num2str(i);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[stlcoords] = READ_stl(['/Users/Rikki/Desktop/AneurysmSummerProject/Image/',name,'_1c.stl']);

figure
xco = squeeze(stlcoords(:,1,:))';   
yco = squeeze(stlcoords(:,2,:))';
zco = squeeze(stlcoords(:,3,:))';
[hpat] = patch(xco,yco,zco,'b');
title(['Original 3D Image (Case ',name,')'])
xlabel x
ylabel y
zlabel z
view(75,10)

%% Voxelise the STL:
%%%%%%%%%%% level %%%%%%%%%%%
level = 7;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n = 2^level;
[OUTPUTgrid,gridCOx,gridCOy,gridCOz] = VOXELISE(n,n,n,['/Users/Rikki/Desktop/AneurysmSummerProject/Image/',name,'_1c.stl'],'xyz');
% gridOUTPUT - Mandatory - PxQxR logical array - Voxelised data (1=>Inside the mesh, 0=>Outside the mesh)
% gridCOx - 1xP array - List of the grid X coordinates.

skel = Skeleton3D(OUTPUTgrid); 

%% Plot object and its skeleton
figure();
col = [.7 .7 .8];
hiso = patch(isosurface(OUTPUTgrid,0),'FaceColor',col,'EdgeColor','none');
hiso2 = patch(isocaps(OUTPUTgrid,0),'FaceColor',col,'EdgeColor','none');
xlabel x
ylabel y
zlabel z
lighting phong;
isonormals(OUTPUTgrid,hiso);
alpha(0.5);
set(gca,'DataAspectRatio',[1 1 1])
camlight;
hold on;
w = size(skel,1);
l = size(skel,2);
h = size(skel,3);
[x,y,z]=ind2sub([w,l,h],find(skel(:)));    % binary matrix location
skel_xyz = [gridCOx(x)',gridCOy(y)',gridCOz(z)'];
plot3(y,x,z,'square','Markersize',1.5,'MarkerFaceColor','r','Color','r');            
set(gcf,'Color','white');
title(['Skeleton (Case ',name,')'])
axis equal
view(15,-10)

save VolumePixel OUTPUTgrid gridCOx gridCOy gridCOz
save skeleton skel_xyz skel x y z name




