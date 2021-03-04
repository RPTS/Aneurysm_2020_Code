clear 
close all
load('newcenters.mat')
load('list.mat') 

[stlcoords] = READ_stl(['C:/Users/100/Desktop/1Xiukun/3d_vessels/Image/1.stl']);  
xco = squeeze(stlcoords(:,1,:))';
yco = squeeze(stlcoords(:,2,:))';
zco = squeeze(stlcoords(:,3,:))';

% S = centersnew.distance*3;
% C = centersnew.distance;

figure;
[hpat] = patch(xco,yco,zco,'b','EdgeColor','none');
alpha(0.2);
camlight('headlight');
material('dull');
hold on
scatter3(centersnew.x,centersnew.y,centersnew.z,'r','filled');
plot3(curveFit(5:end-3,1),curveFit(5:end-3,2),curveFit(5:end-3,3),'square','Markersize',4,'MarkerFaceColor','k','Color','k'); 
view(75,10)

