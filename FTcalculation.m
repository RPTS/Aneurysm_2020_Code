function [FT1] = FTcalculation(x,a,b)

[CrossArea_max,CrossArea_integration,CrossArea_mean,CrossArea_std,CrossArea_variation] ...
    = Fstatistics(x.CrossArea(a:b));
[MajorAxis_max,MajorAxis_integration,MajorAxis_mean,MajorAxis_std,MajorAxis_variation] ...
    = Fstatistics(x.MajorAxis(a:b));
[MinorAxis_max,MinorAxis_integration,MinorAxis_mean,MinorAxis_std,MinorAxis_variation] ...
    = Fstatistics(x.MinorAxis(a:b));
[EquivDiameter_max,EquivDiameter_integration,EquivDiameter_mean,EquivDiameter_std,EquivDiameter_variation] ...
    = Fstatistics(x.EquivDiameter(a:b));
[Eccentricity_max,Eccentricity_integration,Eccentricity_mean,Eccentricity_std,Eccentricity_variation] ...
    = Fstatistics(x.Eccentricity(a:b));
[Solidity_max,Solidity_integration,Solidity_mean,Solidity_std,Solidity_variation] ...
    = Fstatistics(x.Solidity(a:b));
[Extent_max,Extent_integration,Extent_mean,Extent_std,Extent_variation] ...
    = Fstatistics(x.Extent(a:b));
[Curvature_max,Curvature_integration,Curvature_mean,Curvature_std,Curvature_variation] ...
    = Fstatistics(x.Curvature(a:b));
[Torsion_max,Torsion_integration,Torsion_mean,Torsion_std,Torsion_variation] ...
    = Fstatistics(x.Torsion(a:b));
FT1 = table(Curvature_max,Curvature_integration,Curvature_mean,Curvature_std,Curvature_variation,...
    Torsion_max,Torsion_integration,Torsion_mean,Torsion_std,Torsion_variation,...
    CrossArea_max,CrossArea_integration,CrossArea_mean,CrossArea_std,CrossArea_variation,...
    MajorAxis_max,MajorAxis_integration,MajorAxis_mean,MajorAxis_std,MajorAxis_variation,...
    MinorAxis_max,MinorAxis_integration,MinorAxis_mean,MinorAxis_std,MinorAxis_variation,...
    EquivDiameter_max,EquivDiameter_integration,EquivDiameter_mean,EquivDiameter_std,EquivDiameter_variation,...
    Eccentricity_max,Eccentricity_integration,Eccentricity_mean,Eccentricity_std,Eccentricity_variation,...
    Solidity_max,Solidity_integration,Solidity_mean,Solidity_std,Solidity_variation,...
    Extent_max,Extent_integration,Extent_mean,Extent_std,Extent_variation);
