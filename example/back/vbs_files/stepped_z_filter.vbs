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

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers",  _
 "LocalVariables"), Array("NAME:NewProps", Array("NAME:dielectric_height", "PropType:=", "VariableProp", "UserDef:=",  _
 true, "Value:=", "1.600000mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers",  _
 "LocalVariables"), Array("NAME:NewProps", Array("NAME:copper_height", "PropType:=", "VariableProp", "UserDef:=",  _
 true, "Value:=", "0.035000mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers",  _
 "LocalVariables"), Array("NAME:NewProps", Array("NAME:C_width", "PropType:=", "VariableProp", "UserDef:=",  _
 true, "Value:=", "11.100000mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers",  _
 "LocalVariables"), Array("NAME:NewProps", Array("NAME:L_width", "PropType:=", "VariableProp", "UserDef:=",  _
 true, "Value:=", "0.408000mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers",  _
 "LocalVariables"), Array("NAME:NewProps", Array("NAME:C1_len", "PropType:=", "VariableProp", "UserDef:=",  _
 true, "Value:=", "1.700000mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers",  _
 "LocalVariables"), Array("NAME:NewProps", Array("NAME:L1_len", "PropType:=", "VariableProp", "UserDef:=",  _
 true, "Value:=", "5.460000mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers",  _
 "LocalVariables"), Array("NAME:NewProps", Array("NAME:C2_len", "PropType:=", "VariableProp", "UserDef:=",  _
 true, "Value:=", "6.360000mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers",  _
 "LocalVariables"), Array("NAME:NewProps", Array("NAME:L2_len", "PropType:=", "VariableProp", "UserDef:=",  _
 true, "Value:=", "7.460000mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers",  _
 "LocalVariables"), Array("NAME:NewProps", Array("NAME:C3_len", "PropType:=", "VariableProp", "UserDef:=",  _
 true, "Value:=", "4.660000mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers",  _
 "LocalVariables"), Array("NAME:NewProps", Array("NAME:L3_len", "PropType:=", "VariableProp", "UserDef:=",  _
 true, "Value:=", "2.000000mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers",  _
 "LocalVariables"), Array("NAME:NewProps", Array("NAME:input_line_len", "PropType:=", "VariableProp", "UserDef:=",  _
 true, "Value:=", "6.180000mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers",  _
 "LocalVariables"), Array("NAME:NewProps", Array("NAME:input_line_width", "PropType:=", "VariableProp", "UserDef:=",  _
 true, "Value:=", "3.000000mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers",  _
 "LocalVariables"), Array("NAME:NewProps", Array("NAME:output_line_len", "PropType:=", "VariableProp", "UserDef:=",  _
 true, "Value:=", "6.180000mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers",  _
 "LocalVariables"), Array("NAME:NewProps", Array("NAME:output_line_width", "PropType:=", "VariableProp", "UserDef:=",  _
 true, "Value:=", "3.000000mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers",  _
 "LocalVariables"), Array("NAME:NewProps", Array("NAME:substrate_gap", "PropType:=", "VariableProp", "UserDef:=",  _
 true, "Value:=", "5.000000mm"))))

oEditor.CreateBox Array("NAME:BoxParameters","XPosition:=", "-(input_line_len+C1_len+L1_len+C2_len+L2_len+C3_len+L3_len+output_line_len)/2", "YPosition:=",  _
  "-(max(C_width, L_width)+substrate_gap)/2", "ZPosition:=", "-copper_height-dielectric_height", "XSize:=", "input_line_len+C1_len+L1_len+C2_len+L2_len+C3_len+L3_len+output_line_len", "YSize:=", "max(C_width, L_width)+substrate_gap", "ZSize:=",  _ 
"copper_height"),Array("NAME:Attributes", "Name:=", "ground_plane","Flags:=", "", "Color:=",  _
  "(255 165 0)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
  "","MaterialValue:=", "" & Chr(34) & "pec" & Chr(34) & "", "SolveInside:=",  _
  false)

oEditor.CreateBox Array("NAME:BoxParameters","XPosition:=", "-(input_line_len+C1_len+L1_len+C2_len+L2_len+C3_len+L3_len+output_line_len)/2", "YPosition:=",  _
  "-(max(C_width, L_width)+substrate_gap)/2", "ZPosition:=", "-dielectric_height", "XSize:=", "input_line_len+C1_len+L1_len+C2_len+L2_len+C3_len+L3_len+output_line_len", "YSize:=", "max(C_width, L_width)+substrate_gap", "ZSize:=",  _ 
"dielectric_height"),Array("NAME:Attributes", "Name:=", "diel","Flags:=", "", "Color:=",  _
  "(70 130 180)", "Transparency:=", 1, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
  "","MaterialValue:=", "" & Chr(34) & "FR4_epoxy" & Chr(34) & "", "SolveInside:=",  _
  true)

oEditor.CreateBox Array("NAME:BoxParameters","XPosition:=", "-(input_line_len+C1_len+L1_len+C2_len+L2_len+C3_len+L3_len+output_line_len)/2", "YPosition:=",  _
  "-(input_line_width)/2", "ZPosition:=", "0mm", "XSize:=", "input_line_len", "YSize:=", "input_line_width", "ZSize:=",  _ 
"copper_height"),Array("NAME:Attributes", "Name:=", "filter_stage0","Flags:=", "", "Color:=",  _
  "(255 165 0)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
  "","MaterialValue:=", "" & Chr(34) & "pec" & Chr(34) & "", "SolveInside:=",  _
  false)

oEditor.CreateBox Array("NAME:BoxParameters","XPosition:=", "-(input_line_len+C1_len+L1_len+C2_len+L2_len+C3_len+L3_len+output_line_len)/2+input_line_len", "YPosition:=",  _
  "-(C_width)/2", "ZPosition:=", "0mm", "XSize:=", "C1_len", "YSize:=", "C_width", "ZSize:=",  _ 
"copper_height"),Array("NAME:Attributes", "Name:=", "filter_stage1","Flags:=", "", "Color:=",  _
  "(255 165 0)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
  "","MaterialValue:=", "" & Chr(34) & "pec" & Chr(34) & "", "SolveInside:=",  _
  false)

oEditor.CreateBox Array("NAME:BoxParameters","XPosition:=", "-(input_line_len+C1_len+L1_len+C2_len+L2_len+C3_len+L3_len+output_line_len)/2+input_line_len+C1_len", "YPosition:=",  _
  "-(L_width)/2", "ZPosition:=", "0mm", "XSize:=", "L1_len", "YSize:=", "L_width", "ZSize:=",  _ 
"copper_height"),Array("NAME:Attributes", "Name:=", "filter_stage2","Flags:=", "", "Color:=",  _
  "(255 165 0)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
  "","MaterialValue:=", "" & Chr(34) & "pec" & Chr(34) & "", "SolveInside:=",  _
  false)

oEditor.CreateBox Array("NAME:BoxParameters","XPosition:=", "-(input_line_len+C1_len+L1_len+C2_len+L2_len+C3_len+L3_len+output_line_len)/2+input_line_len+C1_len+L1_len", "YPosition:=",  _
  "-(C_width)/2", "ZPosition:=", "0mm", "XSize:=", "C2_len", "YSize:=", "C_width", "ZSize:=",  _ 
"copper_height"),Array("NAME:Attributes", "Name:=", "filter_stage3","Flags:=", "", "Color:=",  _
  "(255 165 0)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
  "","MaterialValue:=", "" & Chr(34) & "pec" & Chr(34) & "", "SolveInside:=",  _
  false)

oEditor.CreateBox Array("NAME:BoxParameters","XPosition:=", "-(input_line_len+C1_len+L1_len+C2_len+L2_len+C3_len+L3_len+output_line_len)/2+input_line_len+C1_len+L1_len+C2_len", "YPosition:=",  _
  "-(L_width)/2", "ZPosition:=", "0mm", "XSize:=", "L2_len", "YSize:=", "L_width", "ZSize:=",  _ 
"copper_height"),Array("NAME:Attributes", "Name:=", "filter_stage4","Flags:=", "", "Color:=",  _
  "(255 165 0)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
  "","MaterialValue:=", "" & Chr(34) & "pec" & Chr(34) & "", "SolveInside:=",  _
  false)

oEditor.CreateBox Array("NAME:BoxParameters","XPosition:=", "-(input_line_len+C1_len+L1_len+C2_len+L2_len+C3_len+L3_len+output_line_len)/2+input_line_len+C1_len+L1_len+C2_len+L2_len", "YPosition:=",  _
  "-(C_width)/2", "ZPosition:=", "0mm", "XSize:=", "C3_len", "YSize:=", "C_width", "ZSize:=",  _ 
"copper_height"),Array("NAME:Attributes", "Name:=", "filter_stage5","Flags:=", "", "Color:=",  _
  "(255 165 0)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
  "","MaterialValue:=", "" & Chr(34) & "pec" & Chr(34) & "", "SolveInside:=",  _
  false)

oEditor.CreateBox Array("NAME:BoxParameters","XPosition:=", "-(input_line_len+C1_len+L1_len+C2_len+L2_len+C3_len+L3_len+output_line_len)/2+input_line_len+C1_len+L1_len+C2_len+L2_len+C3_len", "YPosition:=",  _
  "-(L_width)/2", "ZPosition:=", "0mm", "XSize:=", "L3_len", "YSize:=", "L_width", "ZSize:=",  _ 
"copper_height"),Array("NAME:Attributes", "Name:=", "filter_stage6","Flags:=", "", "Color:=",  _
  "(255 165 0)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
  "","MaterialValue:=", "" & Chr(34) & "pec" & Chr(34) & "", "SolveInside:=",  _
  false)

oEditor.CreateBox Array("NAME:BoxParameters","XPosition:=", "-(input_line_len+C1_len+L1_len+C2_len+L2_len+C3_len+L3_len+output_line_len)/2+input_line_len+C1_len+L1_len+C2_len+L2_len+C3_len+L3_len", "YPosition:=",  _
  "-(output_line_width)/2", "ZPosition:=", "0mm", "XSize:=", "output_line_len", "YSize:=", "output_line_width", "ZSize:=",  _ 
"copper_height"),Array("NAME:Attributes", "Name:=", "filter_stage7","Flags:=", "", "Color:=",  _
  "(255 165 0)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
  "","MaterialValue:=", "" & Chr(34) & "pec" & Chr(34) & "", "SolveInside:=",  _
  false)

oEditor.Unite Array("NAME:Selections", "Selections:=", "filter_stage0,filter_stage1"),Array("NAME:UniteParameters", "KeepOriginals:=",  _
false)

oEditor.Unite Array("NAME:Selections", "Selections:=", "filter_stage0,filter_stage2"),Array("NAME:UniteParameters", "KeepOriginals:=",  _
false)

oEditor.Unite Array("NAME:Selections", "Selections:=", "filter_stage0,filter_stage3"),Array("NAME:UniteParameters", "KeepOriginals:=",  _
false)

oEditor.Unite Array("NAME:Selections", "Selections:=", "filter_stage0,filter_stage4"),Array("NAME:UniteParameters", "KeepOriginals:=",  _
false)

oEditor.Unite Array("NAME:Selections", "Selections:=", "filter_stage0,filter_stage5"),Array("NAME:UniteParameters", "KeepOriginals:=",  _
false)

oEditor.Unite Array("NAME:Selections", "Selections:=", "filter_stage0,filter_stage6"),Array("NAME:UniteParameters", "KeepOriginals:=",  _
false)

oEditor.Unite Array("NAME:Selections", "Selections:=", "filter_stage0,filter_stage7"),Array("NAME:UniteParameters", "KeepOriginals:=",  _
false)

OEditor.CreateRectangle Array("NAME:RectangleParameters", "IsCovered:=", true,"XStart:=",  _
"-(input_line_len+C1_len+L1_len+C2_len+L2_len+C3_len+L3_len+output_line_len)/2", "YStart:=", "-input_line_width/2", "ZStart:=", "-copper_height-dielectric_height","Width:=", "input_line_width","Height:=",  _
"2*copper_height+dielectric_height","WhichAxis:=", "X"), Array("NAME:Attributes", "Name:=", "rect1", "Flags:=",  _
"","Color:=", "(255 165 0)","Transparency:=", 0,"PartCoordinateSystem:=",  _
"Global", "UDMId:=", "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "","SolveInside:=",  _
true)

Set oModule = oDesign.GetModule("BoundarySetup")

oModule.AssignLumpedPort Array("NAME:1", "Objects:=", Array("rect1"),"RenormalizeAllTerminals:=",  _
  true, "DoDeembed:=", false, Array("NAME:Modes", Array("NAME:Mode1", "ModeNum:=", 1, "UseIntLine:=",  _
  true,Array("NAME:IntLine", "Start:=", Array("-20.0mm", "-1.5mm","-1.635mm"),"End:=", Array("-20.0mm", "-1.5mm","0.035mm")),"CharImp:=", "Zpi", "AlignmentGroup:=", 0, "RenormImp:=", "50ohm")), "ShowReporterFilter:=",  _
  false, "ReporterFilter:=", Array(true),"FullResistance:=", "50.000000ohm", "FullReactance:=", "0.000000ohm")

OEditor.CreateRectangle Array("NAME:RectangleParameters", "IsCovered:=", true,"XStart:=",  _
"(input_line_len+C1_len+L1_len+C2_len+L2_len+C3_len+L3_len+output_line_len)/2", "YStart:=", "-input_line_width/2", "ZStart:=", "-copper_height-dielectric_height","Width:=", "input_line_width","Height:=",  _
"2*copper_height+dielectric_height","WhichAxis:=", "X"), Array("NAME:Attributes", "Name:=", "rect2", "Flags:=",  _
"","Color:=", "(255 165 0)","Transparency:=", 0,"PartCoordinateSystem:=",  _
"Global", "UDMId:=", "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "","SolveInside:=",  _
true)

Set oModule = oDesign.GetModule("BoundarySetup")

oModule.AssignLumpedPort Array("NAME:2", "Objects:=", Array("rect2"),"RenormalizeAllTerminals:=",  _
  true, "DoDeembed:=", false, Array("NAME:Modes", Array("NAME:Mode1", "ModeNum:=", 1, "UseIntLine:=",  _
  true,Array("NAME:IntLine", "Start:=", Array("20.0mm", "-1.5mm","-1.635mm"),"End:=", Array("20.0mm", "-1.5mm","0.035mm")),"CharImp:=", "Zpi", "AlignmentGroup:=", 0, "RenormImp:=", "50ohm")), "ShowReporterFilter:=",  _
  false, "ReporterFilter:=", Array(true),"FullResistance:=", "50.000000ohm", "FullReactance:=", "0.000000ohm")

oEditor.CreateBox Array("NAME:BoxParameters","XPosition:=", "-(input_line_len+C1_len+L1_len+C2_len+L2_len+C3_len+L3_len+output_line_len+3*(24.98270483333333mm))/2", "YPosition:=",  _
  "-(max(C_width, L_width)+substrate_gap+3*(24.98270483333333mm))/2", "ZPosition:=", "-(2*copper_height+dielectric_height+2*(24.98270483333333mm))/2", "XSize:=", "input_line_len+C1_len+L1_len+C2_len+L2_len+C3_len+L3_len+output_line_len+3*(24.98270483333333mm)", "YSize:=", "max(C_width, L_width)+substrate_gap+3*(24.98270483333333mm)", "ZSize:=",  _ 
"2*copper_height+dielectric_height+2*(24.98270483333333mm)"),Array("NAME:Attributes", "Name:=", "rad_box","Flags:=", "", "Color:=",  _
  "(70 130 180)", "Transparency:=", 1, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
  "","MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "", "SolveInside:=",  _
  true)

Set oModule = oDesign.GetModule("BoundarySetup")
oModule.AssignRadiation Array("NAME:Rad1", "Objects:=", Array("rad_box"), "IsIncidentField:=",  _
false, "IsEnforcedField:=", false, "IsFssReference:=", false, "IsForPML:=",  _
false, "UseAdaptiveIE:=", false, "IncludeInPostproc:=", true)

Set oModule = oDesign.GetModule("AnalysisSetup")
oModule.InsertSetup "HfssDriven", Array("NAME:sol", "Frequency:=", "3.0GHz", "PortsOnly:=",  _
false, "MaxDeltaS:=", 0.02, "UseMatrixConv:=", false, "MaximumPasses:=", 6, "MinimumPasses:=",  _
1, "MinimumConvergedPasses:=", 1, "PercentRefinement:=", 30, "IsEnabled:=",  _
true, "BasisOrder:=", 1, "UseIterativeSolver:=", false, "DoLambdaRefine:=",  _
true, "DoMaterialLambda:=", true, "SetLambdaTarget:=", false, "Target:=",  _
0.3333, "UseMaxTetIncrease:=", false, "PortAccuracy:=", 2, "UseABCOnPort:=",  _
false, "SetPortMinMaxTri:=", false, "EnableSolverDomains:=", false, "SaveRadFieldsOnly:=",  _
false, "SaveAnyFields:=", true, "NoAdditionalRefinementOnImport:=", false)

Set oModule = oDesign.GetModule("AnalysisSetup")

oModule.InsertFrequencySweep "sol",Array("NAME:Sweep", "IsEnabled:=", true, "SetupType:=",  _
"LinearStep", "StartValue:=", "1GHz", "StopValue:=", "10GHz", "StepSize:=",  _
"0.1GHz","Type:=", "Interpolating", "SaveFields:=", false, "SaveRadFields:=",  _
false, "InterpTolerance:=", 0.5, "InterpMaxSolns:=", 250, "InterpMinSolns:=",  _
0, "InterpMinSubranges:=", 1, "ExtrapToDC:=", false, "InterpUseS:=", true, "InterpUsePortImped:=",  _
false, "InterpUsePropConst:=", true, "UseDerivativeConvergence:=", false, "InterpDerivTolerance:=",  _
0.2, "UseFullBasis:=", true, "EnforcePassivity:=", false)
