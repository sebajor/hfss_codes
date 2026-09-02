Dim oAnsoftApp
Dim oDesktop
Dim oProject
Dim oDesign
Dim oEditor
Dim oModule
Set oAnsoftApp = CreateObject("AnsoftHfss.HfssScriptInterface")
Set oDesktop = oAnsoftApp.GetAppDesktop()
oDesktop.RestoreWindow
Set oProject = oDesktop.SetActiveProject("test")
Set oDesign = oProject.SetActiveDesign("HFSSDesign1")
Set oEditor = oDesign.SetActiveEditor("3D Modeler")

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:srr_len", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "40mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:srr_width", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "48mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:line_width", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "4mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:c_line_width", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "4mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:c_plate_len", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "18mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:c_plate_width", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "4mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:c_gap", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "2mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:copper_height", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "0.035mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:dielectric_size", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "64mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:dielectric_height", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "1.6mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:rad_thumbs_rule", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "74.9481145mm"))))

oEditor.CreatePolyline Array("NAME:PolylineParameters", "IsPolylineCovered:=", true,"IsPolylineClosed:=",  _
  true, Array("NAME:PolylinePoints", _
 Array("NAME:PLPoint", "X:=", "(((-srr_width)/2)+line_width)", "Y:=", "(((-srr_len)/2)+line_width)", "Z:=","copper_height"), _
 Array("NAME:PLPoint", "X:=", "(((-srr_width)/2)+line_width)", "Y:=", "((srr_len/2)-line_width)", "Z:=","copper_height"), _
 Array("NAME:PLPoint", "X:=", "((-c_line_width)/2)", "Y:=", "((srr_len/2)-line_width)", "Z:=","copper_height"), _
 Array("NAME:PLPoint", "X:=", "((-c_line_width)/2)", "Y:=", "((c_gap/2)+c_plate_width)", "Z:=","copper_height"), _
 Array("NAME:PLPoint", "X:=", "((-c_plate_len)/2)", "Y:=", "((c_gap/2)+c_plate_width)", "Z:=","copper_height"), _
 Array("NAME:PLPoint", "X:=", "((-c_plate_len)/2)", "Y:=", "(c_gap/2)", "Z:=","copper_height"), _
 Array("NAME:PLPoint", "X:=", "(c_plate_len/2)", "Y:=", "(c_gap/2)", "Z:=","copper_height"), _
 Array("NAME:PLPoint", "X:=", "(c_plate_len/2)", "Y:=", "((c_gap/2)+c_plate_width)", "Z:=","copper_height"), _
 Array("NAME:PLPoint", "X:=", "(c_plate_width/2)", "Y:=", "((c_gap/2)+c_plate_width)", "Z:=","copper_height"), _
 Array("NAME:PLPoint", "X:=", "(c_plate_width/2)", "Y:=", "((srr_len/2)-line_width)", "Z:=","copper_height"), _
 Array("NAME:PLPoint", "X:=", "((srr_width/2)-line_width)", "Y:=", "((srr_len/2)-line_width)", "Z:=","copper_height"), _
 Array("NAME:PLPoint", "X:=", "((srr_width/2)-line_width)", "Y:=", "(((-srr_len)/2)+line_width)", "Z:=","copper_height"), _
 Array("NAME:PLPoint", "X:=", "(c_line_width/2)", "Y:=", "(((-srr_len)/2)+line_width)", "Z:=","copper_height"), _
 Array("NAME:PLPoint", "X:=", "(c_line_width/2)", "Y:=", "(((-c_gap)/2)-c_plate_width)", "Z:=","copper_height"), _
 Array("NAME:PLPoint", "X:=", "(c_plate_len/2)", "Y:=", "(((-c_gap)/2)-c_plate_width)", "Z:=","copper_height"), _
 Array("NAME:PLPoint", "X:=", "(c_plate_len/2)", "Y:=", "((-c_gap)/2)", "Z:=","copper_height"), _
 Array("NAME:PLPoint", "X:=", "((-c_plate_len)/2)", "Y:=", "((-c_gap)/2)", "Z:=","copper_height"), _
 Array("NAME:PLPoint", "X:=", "((-c_plate_len)/2)", "Y:=", "(((-c_gap)/2)-c_plate_width)", "Z:=","copper_height"), _
 Array("NAME:PLPoint", "X:=", "((-c_line_width)/2)", "Y:=", "(((-c_gap)/2)-c_plate_width)", "Z:=","copper_height"), _
 Array("NAME:PLPoint", "X:=", "((-c_line_width)/2)", "Y:=", "(((-srr_len)/2)+line_width)", "Z:=","copper_height"), _
 Array("NAME:PLPoint", "X:=", "(((-srr_width)/2)+line_width)", "Y:=", "(((-srr_len)/2)+line_width)", "Z:=","copper_height")), Array("NAME:PolylineSegments", _
Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 0, "NoOfPoints:=", 2), _
Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 1, "NoOfPoints:=", 2), _
Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 2, "NoOfPoints:=", 2), _
Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 3, "NoOfPoints:=", 2), _
Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 4, "NoOfPoints:=", 2), _
Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 5, "NoOfPoints:=", 2), _
Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 6, "NoOfPoints:=", 2), _
Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 7, "NoOfPoints:=", 2), _
Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 8, "NoOfPoints:=", 2), _
Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 9, "NoOfPoints:=", 2), _
Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 10, "NoOfPoints:=", 2), _
Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 11, "NoOfPoints:=", 2), _
Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 12, "NoOfPoints:=", 2), _
Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 13, "NoOfPoints:=", 2), _
Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 14, "NoOfPoints:=", 2), _
Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 15, "NoOfPoints:=", 2), _
Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 16, "NoOfPoints:=", 2), _
Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 17, "NoOfPoints:=", 2), _
Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 18, "NoOfPoints:=", 2), _
Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 19, "NoOfPoints:=", 2)), Array("NAME:PolylineXSection", "XSectionType:=", "None", "XSectionOrient:=", "Auto", "XSectionWidth:=", "0mm", _
  "XSectionTopWidth:=","0mm", "XSectionHeight:=", "0mm", "XSectionNumSegments:=", "0",  _
  "XSectionBendType:=", "Corner")),Array("NAME:Attributes", "Name:=", "srr_interior","Flags:=", "", "Color:=",  _
  "(132 132 193)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
  "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "", "SolveInside:=", true)
oEditor.CreatePolyline Array("NAME:PolylineParameters", "IsPolylineCovered:=", true,"IsPolylineClosed:=",  _
  true, Array("NAME:PolylinePoints", _
 Array("NAME:PLPoint", "X:=", "((-srr_width)/2)", "Y:=", "((-srr_len)/2)", "Z:=","copper_height"), _
 Array("NAME:PLPoint", "X:=", "((-srr_width)/2)", "Y:=", "(srr_len/2)", "Z:=","copper_height"), _
 Array("NAME:PLPoint", "X:=", "(srr_width/2)", "Y:=", "(srr_len/2)", "Z:=","copper_height"), _
 Array("NAME:PLPoint", "X:=", "(srr_width/2)", "Y:=", "((-srr_len)/2)", "Z:=","copper_height"), _
 Array("NAME:PLPoint", "X:=", "((-srr_width)/2)", "Y:=", "((-srr_len)/2)", "Z:=","copper_height")), Array("NAME:PolylineSegments", _
Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 0, "NoOfPoints:=", 2), _
Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 1, "NoOfPoints:=", 2), _
Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 2, "NoOfPoints:=", 2), _
Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 3, "NoOfPoints:=", 2)), Array("NAME:PolylineXSection", "XSectionType:=", "None", "XSectionOrient:=", "Auto", "XSectionWidth:=", "0mm", _
  "XSectionTopWidth:=","0mm", "XSectionHeight:=", "0mm", "XSectionNumSegments:=", "0",  _
  "XSectionBendType:=", "Corner")),Array("NAME:Attributes", "Name:=", "srr_closed","Flags:=", "", "Color:=",  _
  "(132 132 193)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
  "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "", "SolveInside:=", true)
oEditor.Subtract Array("NAME:Selections", "Blank Parts:=", "srr_closed", "Tool Parts:=",  _
"srr_interior"), Array("NAME:SubtractParameters", "KeepOriginals:=", false)

oEditor.ThickenSheet Array("NAME:Selections", "Selections:=", "srr_closed","NewPartsModelFlag:=",  _
"Model"), Array("NAME:SheetThickenParameters", "Thickness:=", "copper_height", "BothSides:=",  _
false)

oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:Geometry3DAttributeTab", Array("NAME:PropServers",  _
"srr_closed"), Array("NAME:ChangedProps", Array("NAME:Color", "R:=", 255, "G:=", 165, "B:=",  _
0))))

oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:Geometry3DAttributeTab", Array("NAME:PropServers",  _
"srr_closed"),Array("NAME:ChangedProps", Array("NAME:Material", "Value:=", "" & Chr(34) & "pec" & Chr(34) & ""))))

oEditor.CreateBox Array("NAME:BoxParameters","XPosition:=", "((-dielectric_size)/2)", "YPosition:=",  _
  "((-dielectric_size)/2)", "ZPosition:=", "(-dielectric_height)", "XSize:=", "dielectric_size", "YSize:=", "dielectric_size", "ZSize:=",  _ 
"dielectric_height"),Array("NAME:Attributes", "Name:=", "substrate","Flags:=", "", "Color:=",  _
  "(0 128 0)", "Transparency:=", 1, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
  "","MaterialValue:=", "" & Chr(34) & "FR4_epoxy" & Chr(34) & "", "SolveInside:=",  _
  true)

oEditor.CreateBox Array("NAME:BoxParameters","XPosition:=", "((-dielectric_size)/2)", "YPosition:=",  _
  "((-dielectric_size)/2)", "ZPosition:=", "((-rad_thumbs_rule)-(dielectric_height/2))", "XSize:=", "dielectric_size", "YSize:=", "dielectric_size", "ZSize:=",  _ 
"((2*rad_thumbs_rule)+dielectric_height)"),Array("NAME:Attributes", "Name:=", "rad_box","Flags:=", "", "Color:=",  _
  "(70 130 180)", "Transparency:=", 1, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
  "","MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "", "SolveInside:=",  _
  true)

rad_box_Xmin = oEditor.GetFaceByPosition(Array( _
    "NAME:FaceParameters", _
    "BodyName:=", "rad_box", _
    "XPosition:=", "((-dielectric_size)/2)", _
    "YPosition:=", "(((-dielectric_size)/2)+(dielectric_size/2))", _
    "ZPosition:=", "(((-rad_thumbs_rule)-(dielectric_height/2))+(((2*rad_thumbs_rule)+dielectric_height)/2))"))
rad_box_Xmax = oEditor.GetFaceByPosition(Array( _
    "NAME:FaceParameters", _
    "BodyName:=", "rad_box", _
    "XPosition:=", "(((-dielectric_size)/2)+dielectric_size)", _
    "YPosition:=", "(((-dielectric_size)/2)+(dielectric_size/2))", _
    "ZPosition:=", "(((-rad_thumbs_rule)-(dielectric_height/2))+(((2*rad_thumbs_rule)+dielectric_height)/2))"))

rad_box_Ymin = oEditor.GetFaceByPosition(Array( _
    "NAME:FaceParameters", _
    "BodyName:=", "rad_box", _
    "XPosition:=", "(((-dielectric_size)/2)+(dielectric_size/2))", _
    "YPosition:=", "((-dielectric_size)/2)", _
    "ZPosition:=", "(((-rad_thumbs_rule)-(dielectric_height/2))+(((2*rad_thumbs_rule)+dielectric_height)/2))"))
rad_box_Ymax = oEditor.GetFaceByPosition(Array( _
    "NAME:FaceParameters", _
    "BodyName:=", "rad_box", _
    "XPosition:=", "(((-dielectric_size)/2)+(dielectric_size/2))", _
    "YPosition:=", "(((-dielectric_size)/2)+dielectric_size)", _
    "ZPosition:=", "(((-rad_thumbs_rule)-(dielectric_height/2))+(((2*rad_thumbs_rule)+dielectric_height)/2))"))

rad_box_Zmin = oEditor.GetFaceByPosition(Array( _
    "NAME:FaceParameters", _
    "BodyName:=", "rad_box", _
    "XPosition:=", "(((-dielectric_size)/2)+(dielectric_size/2))", _
    "YPosition:=", "(((-dielectric_size)/2)+(dielectric_size/2))", _
    "ZPosition:=", "((-rad_thumbs_rule)-(dielectric_height/2))"))
rad_box_Zmax = oEditor.GetFaceByPosition(Array( _
    "NAME:FaceParameters", _
    "BodyName:=", "rad_box", _
    "XPosition:=", "(((-dielectric_size)/2)+(dielectric_size/2))", _
    "YPosition:=", "(((-dielectric_size)/2)+(dielectric_size/2))", _
    "ZPosition:=", "(((-rad_thumbs_rule)-(dielectric_height/2))+((2*rad_thumbs_rule)+dielectric_height))"))

Set oModule = oDesign.GetModule("BoundarySetup")
oModule.AssignMaster Array("NAME:mx","Faces:=", Array(rad_box_Xmin),Array("NAME:CoordSysVector", "Origin:=", Array( _
"-32.000000mm", "-32.000000mm", "-75.748114mm"),"UPos:=", Array("-32.000000mm", "32.000000mm", "-75.748114mm")),"ReverseV:=",  _
false)
Set oModule = oDesign.GetModule("BoundarySetup")
oModule.AssignSlave Array("NAME:sx","Faces:=", Array(rad_box_Xmax),Array("NAME:CoordSysVector", "Origin:=", Array( _
  "32.000000mm", "-32.000000mm", "-75.748114mm"),"UPos:=", Array("32.000000mm", "32.000000mm", "-75.748114mm")),"ReverseV:=",  _
  true,"Master:=", "mx","UseScanAngles:=", true, "Phi:=", "0deg","Theta:=", "0deg")
Set oModule = oDesign.GetModule("BoundarySetup")
oModule.AssignMaster Array("NAME:my","Faces:=", Array(rad_box_Ymin),Array("NAME:CoordSysVector", "Origin:=", Array( _
"-32.000000mm", "-32.000000mm", "-75.748114mm"),"UPos:=", Array("32.000000mm", "-32.000000mm", "-75.748114mm")),"ReverseV:=",  _
true)
Set oModule = oDesign.GetModule("BoundarySetup")
oModule.AssignSlave Array("NAME:sy","Faces:=", Array(rad_box_Ymax),Array("NAME:CoordSysVector", "Origin:=", Array( _
  "-32.000000mm", "32.000000mm", "-75.748114mm"),"UPos:=", Array("32.000000mm", "32.000000mm", "-75.748114mm")),"ReverseV:=",  _
  false,"Master:=", "my","UseScanAngles:=", true, "Phi:=", "0deg","Theta:=", "0deg")
Set oModule = oDesign.GetModule("BoundarySetup")
oModule.AssignFloquetPort Array("NAME:floq1","Faces:=", Array(rad_box_Zmin),"NumModes:=",  _
  2,"RenormalizeAllTerminals:=", true, "DoDeembed:=", false, Array("NAME:Modes", Array("NAME:Mode1", "ModeNum:=",  _
  1, "UseIntLine:=", false), Array("NAME:Mode2", "ModeNum:=", 2, "UseIntLine:=",  _
  false)), "ShowReporterFilter:=", false, "ReporterFilter:=", Array(false, false), "UseScanAngles:=",  _
  true,"Phi:=", "0deg", "Theta:=", "0deg",Array("NAME:LatticeAVector", "Start:=", Array( _
  "-32.000000mm", "-32.000000mm", "-75.748114mm"), "End:=", Array("32.000000mm", "-32.000000mm", "-75.748114mm")),Array("NAME:LatticeBVector", "Start:=", Array( _
  "-32.000000mm", "-32.000000mm", "-75.748114mm"), "End:=", Array("-32.000000mm", "32.000000mm", "-75.748114mm")),Array("NAME:ModesList", Array("NAME:Mode", "ModeNumber:=",  _
  1, "IndexM:=", 0, "IndexN:=", 0, "KC2:=", 0, "PropagationState:=", "Propagating", "Attenuation:=",  _
  0, "PolarizationState:=", "TE", "AffectsRefinement:=", true), Array("NAME:Mode", "ModeNumber:=",  _
  2, "IndexM:=", 0, "IndexN:=", 0, "KC2:=", 0, "PropagationState:=", "Propagating", "Attenuation:=",  _
  0, "PolarizationState:=", "TM", "AffectsRefinement:=", true)))

Set oModule = oDesign.GetModule("BoundarySetup")
oModule.AssignFloquetPort Array("NAME:floq2","Faces:=", Array(rad_box_Zmax),"NumModes:=",  _
  2,"RenormalizeAllTerminals:=", true, "DoDeembed:=", false, Array("NAME:Modes", Array("NAME:Mode1", "ModeNum:=",  _
  1, "UseIntLine:=", false), Array("NAME:Mode2", "ModeNum:=", 2, "UseIntLine:=",  _
  false)), "ShowReporterFilter:=", false, "ReporterFilter:=", Array(false, false), "UseScanAngles:=",  _
  true,"Phi:=", "0deg", "Theta:=", "0deg",Array("NAME:LatticeAVector", "Start:=", Array( _
  "-32.000000mm", "-32.000000mm", "75.748114mm"), "End:=", Array("32.000000mm", "-32.000000mm", "75.748114mm")),Array("NAME:LatticeBVector", "Start:=", Array( _
  "-32.000000mm", "-32.000000mm", "75.748114mm"), "End:=", Array("-32.000000mm", "32.000000mm", "75.748114mm")),Array("NAME:ModesList", Array("NAME:Mode", "ModeNumber:=",  _
  1, "IndexM:=", 0, "IndexN:=", 0, "KC2:=", 0, "PropagationState:=", "Propagating", "Attenuation:=",  _
  0, "PolarizationState:=", "TE", "AffectsRefinement:=", true), Array("NAME:Mode", "ModeNumber:=",  _
  2, "IndexM:=", 0, "IndexN:=", 0, "KC2:=", 0, "PropagationState:=", "Propagating", "Attenuation:=",  _
  0, "PolarizationState:=", "TM", "AffectsRefinement:=", true)))

Set oModule = oDesign.GetModule("AnalysisSetup")
oModule.InsertSetup "HfssDriven", Array("NAME:sol", "Frequency:=", "1.0GHz", "PortsOnly:=",  _
false, "MaxDeltaS:=", 0.02, "UseMatrixConv:=", false, "MaximumPasses:=", 6, "MinimumPasses:=",  _
1, "MinimumConvergedPasses:=", 1, "PercentRefinement:=", 30, "IsEnabled:=",  _
true, "BasisOrder:=", 1, "UseIterativeSolver:=", false, "DoLambdaRefine:=",  _
true, "DoMaterialLambda:=", true, "SetLambdaTarget:=", false, "Target:=",  _
0.3333, "UseMaxTetIncrease:=", false, "PortAccuracy:=", 2, "UseABCOnPort:=",  _
false, "SetPortMinMaxTri:=", false, "EnableSolverDomains:=", false, "SaveRadFieldsOnly:=",  _
false, "SaveAnyFields:=", true, "NoAdditionalRefinementOnImport:=", false)

Set oModule = oDesign.GetModule("AnalysisSetup")

oModule.InsertFrequencySweep "sol",Array("NAME:Sweep", "IsEnabled:=", true, "SetupType:=",  _
"LinearStep", "StartValue:=", "0.8GHz", "StopValue:=", "4GHz", "StepSize:=",  _
"0.1GHz","Type:=", "Interpolating", "SaveFields:=", false, "SaveRadFields:=",  _
false, "InterpTolerance:=", 0.5, "InterpMaxSolns:=", 250, "InterpMinSolns:=",  _
0, "InterpMinSubranges:=", 1, "ExtrapToDC:=", false, "InterpUseS:=", true, "InterpUsePortImped:=",  _
false, "InterpUsePropConst:=", true, "UseDerivativeConvergence:=", false, "InterpDerivTolerance:=",  _
0.2, "UseFullBasis:=", true, "EnforcePassivity:=", false)
