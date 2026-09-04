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

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:copper_height", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "0.035mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:width50", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "3.05mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:length50", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "17.1mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:width35", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "5.3mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:length35", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "16.7mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:feedline_length", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "10mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:substrate_gap", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "3mm"))))

oEditor.CreateBox Array("NAME:BoxParameters","XPosition:=", "((-(length35+(2*(feedline_length-width50))))/2)", "YPosition:=",  _
  "((-((length50+(2*width35))+(2*substrate_gap)))/2)", "ZPosition:=", "(-copper_height)", "XSize:=", "(length35+(2*(feedline_length-width50)))", "YSize:=", "((length50+(2*width35))+(2*substrate_gap))", "ZSize:=",  _ 
"copper_height"),Array("NAME:Attributes", "Name:=", "ground_plane","Flags:=", "", "Color:=",  _
  "(255 165 0)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
  "","MaterialValue:=", "" & Chr(34) & "pec" & Chr(34) & "", "SolveInside:=",  _
  false)

oEditor.CreateBox Array("NAME:BoxParameters","XPosition:=", "((-(length35+(2*(feedline_length-width50))))/2)", "YPosition:=",  _
  "((-((length50+(2*width35))+(2*substrate_gap)))/2)", "ZPosition:=", "0mm", "XSize:=", "(length35+(2*(feedline_length-width50)))", "YSize:=", "((length50+(2*width35))+(2*substrate_gap))", "ZSize:=",  _ 
"dielectric_height"),Array("NAME:Attributes", "Name:=", "diel","Flags:=", "", "Color:=",  _
  "(70 130 180)", "Transparency:=", 1, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
  "","MaterialValue:=", "" & Chr(34) & "FR4_epoxy" & Chr(34) & "", "SolveInside:=",  _
  true)

oEditor.CreateBox Array("NAME:BoxParameters","XPosition:=", "((-length35)/2)", "YPosition:=",  _
  "((length50/2)-width50)", "ZPosition:=", "dielectric_height", "XSize:=", "length35", "YSize:=", "width35", "ZSize:=",  _ 
"copper_height"),Array("NAME:Attributes", "Name:=", "line1","Flags:=", "", "Color:=",  _
  "(255 165 0)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
  "","MaterialValue:=", "" & Chr(34) & "pec" & Chr(34) & "", "SolveInside:=",  _
  false)

oEditor.CreateBox Array("NAME:BoxParameters","XPosition:=", "((-length35)/2)", "YPosition:=",  _
  "(((-length50)/2)+width50)", "ZPosition:=", "dielectric_height", "XSize:=", "length35", "YSize:=", "(-width35)", "ZSize:=",  _ 
"copper_height"),Array("NAME:Attributes", "Name:=", "line2","Flags:=", "", "Color:=",  _
  "(255 165 0)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
  "","MaterialValue:=", "" & Chr(34) & "pec" & Chr(34) & "", "SolveInside:=",  _
  false)

oEditor.CreateBox Array("NAME:BoxParameters","XPosition:=", "((-length35)/2)", "YPosition:=",  _
  "((-length50)/2)", "ZPosition:=", "dielectric_height", "XSize:=", "width50", "YSize:=", "length50", "ZSize:=",  _ 
"copper_height"),Array("NAME:Attributes", "Name:=", "line3","Flags:=", "", "Color:=",  _
  "(255 165 0)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
  "","MaterialValue:=", "" & Chr(34) & "pec" & Chr(34) & "", "SolveInside:=",  _
  false)

oEditor.CreateBox Array("NAME:BoxParameters","XPosition:=", "(length35/2)", "YPosition:=",  _
  "((-length50)/2)", "ZPosition:=", "dielectric_height", "XSize:=", "(-width50)", "YSize:=", "length50", "ZSize:=",  _ 
"copper_height"),Array("NAME:Attributes", "Name:=", "line4","Flags:=", "", "Color:=",  _
  "(255 165 0)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
  "","MaterialValue:=", "" & Chr(34) & "pec" & Chr(34) & "", "SolveInside:=",  _
  false)

oEditor.CreateBox Array("NAME:BoxParameters","XPosition:=", "(((-length35)/2)+width50)", "YPosition:=",  _
  "(length50/2)", "ZPosition:=", "dielectric_height", "XSize:=", "(-feedline_length)", "YSize:=", "(-width50)", "ZSize:=",  _ 
"copper_height"),Array("NAME:Attributes", "Name:=", "feed1","Flags:=", "", "Color:=",  _
  "(255 165 0)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
  "","MaterialValue:=", "" & Chr(34) & "pec" & Chr(34) & "", "SolveInside:=",  _
  false)

oEditor.CreateBox Array("NAME:BoxParameters","XPosition:=", "(((-length35)/2)+width50)", "YPosition:=",  _
  "((-length50)/2)", "ZPosition:=", "dielectric_height", "XSize:=", "(-feedline_length)", "YSize:=", "width50", "ZSize:=",  _ 
"copper_height"),Array("NAME:Attributes", "Name:=", "feed2","Flags:=", "", "Color:=",  _
  "(255 165 0)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
  "","MaterialValue:=", "" & Chr(34) & "pec" & Chr(34) & "", "SolveInside:=",  _
  false)

oEditor.CreateBox Array("NAME:BoxParameters","XPosition:=", "((length35/2)-width50)", "YPosition:=",  _
  "(length50/2)", "ZPosition:=", "dielectric_height", "XSize:=", "feedline_length", "YSize:=", "(-width50)", "ZSize:=",  _ 
"copper_height"),Array("NAME:Attributes", "Name:=", "feed3","Flags:=", "", "Color:=",  _
  "(255 165 0)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
  "","MaterialValue:=", "" & Chr(34) & "pec" & Chr(34) & "", "SolveInside:=",  _
  false)

oEditor.CreateBox Array("NAME:BoxParameters","XPosition:=", "((length35/2)-width50)", "YPosition:=",  _
  "((-length50)/2)", "ZPosition:=", "dielectric_height", "XSize:=", "feedline_length", "YSize:=", "width50", "ZSize:=",  _ 
"copper_height"),Array("NAME:Attributes", "Name:=", "feed4","Flags:=", "", "Color:=",  _
  "(255 165 0)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
  "","MaterialValue:=", "" & Chr(34) & "pec" & Chr(34) & "", "SolveInside:=",  _
  false)

oEditor.Unite Array("NAME:Selections", "Selections:=", "line1,line2"),Array("NAME:UniteParameters", "KeepOriginals:=",  _
false)

oEditor.Unite Array("NAME:Selections", "Selections:=", "line1,line3"),Array("NAME:UniteParameters", "KeepOriginals:=",  _
false)

oEditor.Unite Array("NAME:Selections", "Selections:=", "line1,line4"),Array("NAME:UniteParameters", "KeepOriginals:=",  _
false)

oEditor.Unite Array("NAME:Selections", "Selections:=", "line1,feed1"),Array("NAME:UniteParameters", "KeepOriginals:=",  _
false)

oEditor.Unite Array("NAME:Selections", "Selections:=", "line1,feed2"),Array("NAME:UniteParameters", "KeepOriginals:=",  _
false)

oEditor.Unite Array("NAME:Selections", "Selections:=", "line1,feed3"),Array("NAME:UniteParameters", "KeepOriginals:=",  _
false)

oEditor.Unite Array("NAME:Selections", "Selections:=", "line1,feed4"),Array("NAME:UniteParameters", "KeepOriginals:=",  _
false)

OEditor.CreateRectangle Array("NAME:RectangleParameters", "IsCovered:=", true,"XStart:=",  _
"((length35+(2*(feedline_length-width50)))/2)", "YStart:=", "((-length35)/2)", "ZStart:=", "(-copper_height)","Width:=", "width50","Height:=",  _
"((2*copper_height)+dielectric_height)","WhichAxis:=", "X"), Array("NAME:Attributes", "Name:=", "rect1", "Flags:=",  _
"","Color:=", "(255 165 0)","Transparency:=", 0,"PartCoordinateSystem:=",  _
"Global", "UDMId:=", "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "","SolveInside:=",  _
true)

Set oModule = oDesign.GetModule("BoundarySetup")

oModule.AssignLumpedPort Array("NAME:1", "Objects:=", Array("rect1"),"RenormalizeAllTerminals:=",  _
  true, "DoDeembed:=", false, Array("NAME:Modes", Array("NAME:Mode1", "ModeNum:=", 1, "UseIntLine:=",  _
  true,Array("NAME:IntLine", "Start:=", Array("15.3mm", "-8.35mm","-0.035mm"),"End:=", Array("15.3mm", "-8.35mm","1.635mm")),"CharImp:=", "Zpi", "AlignmentGroup:=", 0, "RenormImp:=", "50ohm")), "ShowReporterFilter:=",  _
  false, "ReporterFilter:=", Array(true),"FullResistance:=", "50.000000ohm", "FullReactance:=", "0.000000ohm")

OEditor.CreateRectangle Array("NAME:RectangleParameters", "IsCovered:=", true,"XStart:=",  _
"((length35+(2*(feedline_length-width50)))/2)", "YStart:=", "(length35/2)", "ZStart:=", "(-copper_height)","Width:=", "(-width50)","Height:=",  _
"((2*copper_height)+dielectric_height)","WhichAxis:=", "X"), Array("NAME:Attributes", "Name:=", "rect2", "Flags:=",  _
"","Color:=", "(255 165 0)","Transparency:=", 0,"PartCoordinateSystem:=",  _
"Global", "UDMId:=", "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "","SolveInside:=",  _
true)

Set oModule = oDesign.GetModule("BoundarySetup")

oModule.AssignLumpedPort Array("NAME:2", "Objects:=", Array("rect2"),"RenormalizeAllTerminals:=",  _
  true, "DoDeembed:=", false, Array("NAME:Modes", Array("NAME:Mode1", "ModeNum:=", 1, "UseIntLine:=",  _
  true,Array("NAME:IntLine", "Start:=", Array("15.3mm", "8.35mm","-0.035mm"),"End:=", Array("15.3mm", "8.35mm","1.635mm")),"CharImp:=", "Zpi", "AlignmentGroup:=", 0, "RenormImp:=", "50ohm")), "ShowReporterFilter:=",  _
  false, "ReporterFilter:=", Array(true),"FullResistance:=", "50.000000ohm", "FullReactance:=", "0.000000ohm")

OEditor.CreateRectangle Array("NAME:RectangleParameters", "IsCovered:=", true,"XStart:=",  _
"((-(length35+(2*(feedline_length-width50))))/2)", "YStart:=", "((-length35)/2)", "ZStart:=", "(-copper_height)","Width:=", "width50","Height:=",  _
"((2*copper_height)+dielectric_height)","WhichAxis:=", "X"), Array("NAME:Attributes", "Name:=", "rect3", "Flags:=",  _
"","Color:=", "(255 165 0)","Transparency:=", 0,"PartCoordinateSystem:=",  _
"Global", "UDMId:=", "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "","SolveInside:=",  _
true)

Set oModule = oDesign.GetModule("BoundarySetup")

oModule.AssignLumpedPort Array("NAME:3", "Objects:=", Array("rect3"),"RenormalizeAllTerminals:=",  _
  true, "DoDeembed:=", false, Array("NAME:Modes", Array("NAME:Mode1", "ModeNum:=", 1, "UseIntLine:=",  _
  true,Array("NAME:IntLine", "Start:=", Array("-15.3mm", "-8.35mm","-0.035mm"),"End:=", Array("-15.3mm", "-8.35mm","1.635mm")),"CharImp:=", "Zpi", "AlignmentGroup:=", 0, "RenormImp:=", "50ohm")), "ShowReporterFilter:=",  _
  false, "ReporterFilter:=", Array(true),"FullResistance:=", "50.000000ohm", "FullReactance:=", "0.000000ohm")

OEditor.CreateRectangle Array("NAME:RectangleParameters", "IsCovered:=", true,"XStart:=",  _
"((-(length35+(2*(feedline_length-width50))))/2)", "YStart:=", "(length35/2)", "ZStart:=", "(-copper_height)","Width:=", "(-width50)","Height:=",  _
"((2*copper_height)+dielectric_height)","WhichAxis:=", "X"), Array("NAME:Attributes", "Name:=", "rect4", "Flags:=",  _
"","Color:=", "(255 165 0)","Transparency:=", 0,"PartCoordinateSystem:=",  _
"Global", "UDMId:=", "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "","SolveInside:=",  _
true)

Set oModule = oDesign.GetModule("BoundarySetup")

oModule.AssignLumpedPort Array("NAME:4", "Objects:=", Array("rect4"),"RenormalizeAllTerminals:=",  _
  true, "DoDeembed:=", false, Array("NAME:Modes", Array("NAME:Mode1", "ModeNum:=", 1, "UseIntLine:=",  _
  true,Array("NAME:IntLine", "Start:=", Array("-15.3mm", "8.35mm","-0.035mm"),"End:=", Array("-15.3mm", "8.35mm","1.635mm")),"CharImp:=", "Zpi", "AlignmentGroup:=", 0, "RenormImp:=", "50ohm")), "ShowReporterFilter:=",  _
  false, "ReporterFilter:=", Array(true),"FullResistance:=", "50.000000ohm", "FullReactance:=", "0.000000ohm")

oEditor.CreateBox Array("NAME:BoxParameters","XPosition:=", "((-((length35+(2*(feedline_length-width50)))+0.09368514312500001))/2)", "YPosition:=",  _
  "((-(((length50+(2*width35))+(2*substrate_gap))+0.09368514312500001))/2)", "ZPosition:=", "((-(((2*copper_height)+dielectric_height)+0.06245676208333334))/2)", "XSize:=", "((length35+(2*(feedline_length-width50)))+0.09368514312500001)", "YSize:=", "(((length50+(2*width35))+(2*substrate_gap))+0.09368514312500001)", "ZSize:=",  _ 
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
