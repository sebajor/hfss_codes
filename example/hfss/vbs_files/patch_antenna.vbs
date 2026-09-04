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

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:dielectric_height", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "1.6mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:dielectric_size", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "60mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:copper_height", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "0.035mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:patch_width", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "30mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:patch_length", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "29.4mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:feedline_width", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "3mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:feed_cut_y", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "5mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:feed_cut_x", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "9.5mm"))))

oEditor.CreateBox Array("NAME:BoxParameters","XPosition:=", "((-dielectric_size)/2)", "YPosition:=",  _
  "((-dielectric_size)/2)", "ZPosition:=", "(-copper_height)", "XSize:=", "dielectric_size", "YSize:=", "dielectric_size", "ZSize:=",  _ 
"copper_height"),Array("NAME:Attributes", "Name:=", "ground_plane","Flags:=", "", "Color:=",  _
  "(255 165 0)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
  "","MaterialValue:=", "" & Chr(34) & "pec" & Chr(34) & "", "SolveInside:=",  _
  false)

oEditor.CreateBox Array("NAME:BoxParameters","XPosition:=", "((-dielectric_size)/2)", "YPosition:=",  _
  "((-dielectric_size)/2)", "ZPosition:=", "0mm", "XSize:=", "dielectric_size", "YSize:=", "dielectric_size", "ZSize:=",  _ 
"dielectric_height"),Array("NAME:Attributes", "Name:=", "diel","Flags:=", "", "Color:=",  _
  "(70 130 180)", "Transparency:=", 1, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
  "","MaterialValue:=", "" & Chr(34) & "FR4_epoxy" & Chr(34) & "", "SolveInside:=",  _
  true)

oEditor.CreateBox Array("NAME:BoxParameters","XPosition:=", "((-patch_width)/2)", "YPosition:=",  _
  "((-patch_length)/2)", "ZPosition:=", "dielectric_height", "XSize:=", "patch_width", "YSize:=", "patch_length", "ZSize:=",  _ 
"copper_height"),Array("NAME:Attributes", "Name:=", "patch","Flags:=", "", "Color:=",  _
  "(255 165 0)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
  "","MaterialValue:=", "" & Chr(34) & "pec" & Chr(34) & "", "SolveInside:=",  _
  false)

oEditor.CreateBox Array("NAME:BoxParameters","XPosition:=", "(dielectric_size/2)", "YPosition:=",  _
  "((-feedline_width)/2)", "ZPosition:=", "dielectric_height", "XSize:=", "((-dielectric_size)/2)", "YSize:=", "feedline_width", "ZSize:=",  _ 
"copper_height"),Array("NAME:Attributes", "Name:=", "feedline","Flags:=", "", "Color:=",  _
  "(255 165 0)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
  "","MaterialValue:=", "" & Chr(34) & "pec" & Chr(34) & "", "SolveInside:=",  _
  false)

oEditor.CreateBox Array("NAME:BoxParameters","XPosition:=", "(patch_width/2)", "YPosition:=",  _
  "((-feed_cut_y)/2)", "ZPosition:=", "dielectric_height", "XSize:=", "(-feed_cut_x)", "YSize:=", "feed_cut_y", "ZSize:=",  _ 
"copper_height"),Array("NAME:Attributes", "Name:=", "feed_cut","Flags:=", "", "Color:=",  _
  "(255 0 0)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
  "","MaterialValue:=", "" & Chr(34) & "pec" & Chr(34) & "", "SolveInside:=",  _
  false)

oEditor.Subtract Array("NAME:Selections", "Blank Parts:=", "patch", "Tool Parts:=",  _
"feed_cut"), Array("NAME:SubtractParameters", "KeepOriginals:=", false)

oEditor.Unite Array("NAME:Selections", "Selections:=", "patch,feedline"),Array("NAME:UniteParameters", "KeepOriginals:=",  _
false)

OEditor.CreateRectangle Array("NAME:RectangleParameters", "IsCovered:=", true,"XStart:=",  _
"(dielectric_size/2)", "YStart:=", "((-feedline_width)/2)", "ZStart:=", "(-copper_height)","Width:=", "feedline_width","Height:=",  _
"((2*copper_height)+dielectric_height)","WhichAxis:=", "X"), Array("NAME:Attributes", "Name:=", "rect1", "Flags:=",  _
"","Color:=", "(255 165 0)","Transparency:=", 0,"PartCoordinateSystem:=",  _
"Global", "UDMId:=", "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "","SolveInside:=",  _
true)

Set oModule = oDesign.GetModule("BoundarySetup")

oModule.AssignLumpedPort Array("NAME:1", "Objects:=", Array("rect1"),"RenormalizeAllTerminals:=",  _
  true, "DoDeembed:=", false, Array("NAME:Modes", Array("NAME:Mode1", "ModeNum:=", 1, "UseIntLine:=",  _
  true,Array("NAME:IntLine", "Start:=", Array("30.0mm", "0mm","-0.035mm"),"End:=", Array("30.0mm", "0mm","1.635mm")),"CharImp:=", "Zpi", "AlignmentGroup:=", 0, "RenormImp:=", "50ohm")), "ShowReporterFilter:=",  _
  false, "ReporterFilter:=", Array(true),"FullResistance:=", "50.000000ohm", "FullReactance:=", "0.000000ohm")

oEditor.CreateBox Array("NAME:BoxParameters","XPosition:=", "((-(dielectric_size+0.09368514312500001))/2)", "YPosition:=",  _
  "((-(dielectric_size+0.09368514312500001))/2)", "ZPosition:=", "((-(((2*copper_height)+dielectric_height)+0.06245676208333334))/2)", "XSize:=", "(dielectric_size+0.09368514312500001)", "YSize:=", "(dielectric_size+0.09368514312500001)", "ZSize:=",  _ 
"(((2*copper_height)+dielectric_height)+0.06245676208333334)"),Array("NAME:Attributes", "Name:=", "rad_box","Flags:=", "", "Color:=",  _
  "(70 130 180)", "Transparency:=", 1, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
  "","MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "", "SolveInside:=",  _
  true)

Set oModule = oDesign.GetModule("BoundarySetup")
oModule.AssignRadiation Array("NAME:Rad1", "Objects:=", Array("rad_box"), "IsIncidentField:=",  _
false, "IsEnforcedField:=", false, "IsFssReference:=", false, "IsForPML:=",  _
false, "UseAdaptiveIE:=", false, "IncludeInPostproc:=", true)

Set oModule = oDesign.GetModule("AnalysisSetup")
oModule.InsertSetup "HfssDriven", Array("NAME:sol", "Frequency:=", "2.4GHz", "PortsOnly:=",  _
false, "MaxDeltaS:=", 0.02, "UseMatrixConv:=", false, "MaximumPasses:=", 6, "MinimumPasses:=",  _
1, "MinimumConvergedPasses:=", 1, "PercentRefinement:=", 30, "IsEnabled:=",  _
true, "BasisOrder:=", 1, "UseIterativeSolver:=", false, "DoLambdaRefine:=",  _
true, "DoMaterialLambda:=", true, "SetLambdaTarget:=", false, "Target:=",  _
0.3333, "UseMaxTetIncrease:=", false, "PortAccuracy:=", 2, "UseABCOnPort:=",  _
false, "SetPortMinMaxTri:=", false, "EnableSolverDomains:=", false, "SaveRadFieldsOnly:=",  _
false, "SaveAnyFields:=", true, "NoAdditionalRefinementOnImport:=", false)

Set oModule = oDesign.GetModule("AnalysisSetup")

oModule.InsertFrequencySweep "sol",Array("NAME:Sweep", "IsEnabled:=", true, "SetupType:=",  _
"LinearStep", "StartValue:=", "2GHz", "StopValue:=", "4GHz", "StepSize:=",  _
"0.1GHz","Type:=", "Interpolating", "SaveFields:=", false, "SaveRadFields:=",  _
false, "InterpTolerance:=", 0.5, "InterpMaxSolns:=", 250, "InterpMinSolns:=",  _
0, "InterpMinSubranges:=", 1, "ExtrapToDC:=", false, "InterpUseS:=", true, "InterpUsePortImped:=",  _
false, "InterpUsePropConst:=", true, "UseDerivativeConvergence:=", false, "InterpDerivTolerance:=",  _
0.2, "UseFullBasis:=", true, "EnforcePassivity:=", false)
