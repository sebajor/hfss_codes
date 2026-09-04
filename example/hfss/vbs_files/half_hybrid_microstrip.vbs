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

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:dielectric_gap", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "3mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:copper_height", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "0.035mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:port_line_width", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "3mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:port_line_len", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "8mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:circle_width", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "1.62mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:circle_radius", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "16.71126902464901mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:radiation_size", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "100mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:radiation_height", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "20mm"))))

oEditor.CreateCircle Array("NAME:CircleParameters", "IsCovered:=", true,"XCenter:=",  _
"0mm","YCenter:=", "0mm","ZCenter:=", "0mm","Radius:=",  _
"(circle_radius+(circle_width/2))","WhichAxis:=", "Z","NumSegments:=", "0"), Array("NAME:Attributes", "Name:=",  _
"circ","Flags:=", "", "Color:=", "(173 216 230)","Transparency:=", 0,"PartCoordinateSystem:=",  _
"Global", "UDMId:=", "","MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "","SolveInside:=",true)
oEditor.CreateCircle Array("NAME:CircleParameters", "IsCovered:=", true,"XCenter:=",  _
"0mm","YCenter:=", "0mm","ZCenter:=", "0mm","Radius:=",  _
"(circle_radius-(circle_width/2))","WhichAxis:=", "Z","NumSegments:=", "0"), Array("NAME:Attributes", "Name:=",  _
"inner_circ","Flags:=", "", "Color:=", "(173 216 230)","Transparency:=", 0,"PartCoordinateSystem:=",  _
"Global", "UDMId:=", "","MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "","SolveInside:=",true)
oEditor.Subtract Array("NAME:Selections", "Blank Parts:=", "circ", "Tool Parts:=",  _
"inner_circ"), Array("NAME:SubtractParameters", "KeepOriginals:=", false)

OEditor.CreateRectangle Array("NAME:RectangleParameters", "IsCovered:=", true,"XStart:=",  _
"circle_radius", "YStart:=", "((-port_line_width)/2)", "ZStart:=", "0mm","Width:=", "port_line_len","Height:=",  _
"port_line_width","WhichAxis:=", "Z"), Array("NAME:Attributes", "Name:=", "port1", "Flags:=",  _
"","Color:=", "(255 165 0)","Transparency:=", 0,"PartCoordinateSystem:=",  _
"Global", "UDMId:=", "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "","SolveInside:=",  _
true)

oEditor.DuplicateAroundAxis Array("NAME:Selections", "Selections:=", "port1","NewPartsModelFlag:=",  _
"Model"), Array("NAME:DuplicateAroundAxisParameters", "CreateNewObjects:=", true,"WhichAxis:=",  _
"Z","AngleStr:=", "60deg","NumClones:=", "2"), Array("NAME:Options", "DuplicateAssignments:=",  false)
oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:Geometry3DAttributeTab",Array("NAME:PropServers",  _
"port1_1"),Array("NAME:ChangedProps", Array("NAME:Name", "Value:=", "port2"))))
oEditor.DuplicateAroundAxis Array("NAME:Selections", "Selections:=", "port1","NewPartsModelFlag:=",  _
"Model"), Array("NAME:DuplicateAroundAxisParameters", "CreateNewObjects:=", true,"WhichAxis:=",  _
"Z","AngleStr:=", "120deg","NumClones:=", "2"), Array("NAME:Options", "DuplicateAssignments:=",  false)
oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:Geometry3DAttributeTab",Array("NAME:PropServers",  _
"port1_1"),Array("NAME:ChangedProps", Array("NAME:Name", "Value:=", "port3"))))
oEditor.DuplicateAroundAxis Array("NAME:Selections", "Selections:=", "port1","NewPartsModelFlag:=",  _
"Model"), Array("NAME:DuplicateAroundAxisParameters", "CreateNewObjects:=", true,"WhichAxis:=",  _
"Z","AngleStr:=", "180deg","NumClones:=", "2"), Array("NAME:Options", "DuplicateAssignments:=",  false)
oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:Geometry3DAttributeTab",Array("NAME:PropServers",  _
"port1_1"),Array("NAME:ChangedProps", Array("NAME:Name", "Value:=", "port4"))))
OEditor.CreateRectangle Array("NAME:RectangleParameters", "IsCovered:=", true,"XStart:=",  _
"(((circle_radius+port_line_len)*0.5000000000000001)+(port_line_width*-0.5669872981077806))", "YStart:=", "(((circle_radius+port_line_len)*0.8660254037844386)-((port_line_width/2)*0.49999999999999994))", "ZStart:=", "0mm","Width:=", "port_line_width","Height:=",  _
"(2*port_line_len)","WhichAxis:=", "Z"), Array("NAME:Attributes", "Name:=", "outp2", "Flags:=",  _
"","Color:=", "(255 165 0)","Transparency:=", 0,"PartCoordinateSystem:=",  _
"Global", "UDMId:=", "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "","SolveInside:=",  _
true)

OEditor.CreateRectangle Array("NAME:RectangleParameters", "IsCovered:=", true,"XStart:=",  _
"(((circle_radius+port_line_len)*-0.4999999999999998)-((port_line_width/2)*0.8660254037844387))", "YStart:=", "(((circle_radius+port_line_len)*0.8660254037844387)-((port_line_width/2)*0.49999999999999994))", "ZStart:=", "0mm","Width:=", "port_line_width","Height:=",  _
"(2*port_line_len)","WhichAxis:=", "Z"), Array("NAME:Attributes", "Name:=", "outp3", "Flags:=",  _
"","Color:=", "(255 165 0)","Transparency:=", 0,"PartCoordinateSystem:=",  _
"Global", "UDMId:=", "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "","SolveInside:=",  _
true)

oEditor.Unite Array("NAME:Selections", "Selections:=", "circ,port1"),Array("NAME:UniteParameters", "KeepOriginals:=",  _
false)

oEditor.Unite Array("NAME:Selections", "Selections:=", "circ,port2"),Array("NAME:UniteParameters", "KeepOriginals:=",  _
false)

oEditor.Unite Array("NAME:Selections", "Selections:=", "circ,port3"),Array("NAME:UniteParameters", "KeepOriginals:=",  _
false)

oEditor.Unite Array("NAME:Selections", "Selections:=", "circ,port4"),Array("NAME:UniteParameters", "KeepOriginals:=",  _
false)

oEditor.Unite Array("NAME:Selections", "Selections:=", "circ,outp2"),Array("NAME:UniteParameters", "KeepOriginals:=",  _
false)

oEditor.Unite Array("NAME:Selections", "Selections:=", "circ,outp3"),Array("NAME:UniteParameters", "KeepOriginals:=",  _
false)

oEditor.CreateBox Array("NAME:BoxParameters","XPosition:=", "((-((2*circle_radius)+(2*port_line_len)))/2)", "YPosition:=",  _
  "(((-circle_radius)-(circle_width/2))-dielectric_gap)", "ZPosition:=", "(-dielectric_height)", "XSize:=", "((2*circle_radius)+(2*port_line_len))", "YSize:=", "((((((circle_radius+port_line_len)*0.8660254037844387)-((port_line_width/2)*0.49999999999999994))+(2*port_line_len))+(circle_radius+(circle_width/2)))+dielectric_gap)", "ZSize:=",  _ 
"dielectric_height"),Array("NAME:Attributes", "Name:=", "diel","Flags:=", "", "Color:=",  _
  "(70 130 180)", "Transparency:=", 1, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
  "","MaterialValue:=", "" & Chr(34) & "FR4_epoxy" & Chr(34) & "", "SolveInside:=",  _
  true)

OEditor.CreateRectangle Array("NAME:RectangleParameters", "IsCovered:=", true,"XStart:=",  _
"((-((2*circle_radius)+(2*port_line_len)))/2)", "YStart:=", "(((-circle_radius)-(circle_width/2))-dielectric_gap)", "ZStart:=", "(-dielectric_height)","Width:=", "((2*circle_radius)+(2*port_line_len))","Height:=",  _
"((((((circle_radius+port_line_len)*0.8660254037844387)-((port_line_width/2)*0.49999999999999994))+(2*port_line_len))+(circle_radius+(circle_width/2)))+dielectric_gap)","WhichAxis:=", "Z"), Array("NAME:Attributes", "Name:=", "gnd", "Flags:=",  _
"","Color:=", "(255 165 0)","Transparency:=", 0,"PartCoordinateSystem:=",  _
"Global", "UDMId:=", "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "","SolveInside:=",  _
true)

Set oModule = oDesign.GetModule("BoundarySetup")
oModule.AssignPerfectE Array("NAME:gnd_pec", "Objects:=", Array("gnd"), "InfGroundPlane:=",  _
false)

Set oModule = oDesign.GetModule("BoundarySetup")
oModule.AssignPerfectE Array("NAME:rat_race_pec", "Objects:=", Array("circ"), "InfGroundPlane:=",  _
false)

OEditor.CreateRectangle Array("NAME:RectangleParameters", "IsCovered:=", true,"XStart:=",  _
"(circle_radius+port_line_len)", "YStart:=", "((-port_line_width)/2)", "ZStart:=", "(-dielectric_height)","Width:=", "port_line_width","Height:=",  _
"dielectric_height","WhichAxis:=", "X"), Array("NAME:Attributes", "Name:=", "p1", "Flags:=",  _
"","Color:=", "(255 0 0)","Transparency:=", 0,"PartCoordinateSystem:=",  _
"Global", "UDMId:=", "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "","SolveInside:=",  _
true)

Set oModule = oDesign.GetModule("BoundarySetup")

oModule.AssignLumpedPort Array("NAME:1", "Objects:=", Array("p1"),"RenormalizeAllTerminals:=",  _
  true, "DoDeembed:=", false, Array("NAME:Modes", Array("NAME:Mode1", "ModeNum:=", 1, "UseIntLine:=",  _
  true,Array("NAME:IntLine", "Start:=", Array("24.71126902464901mm", "0mm","-1.6mm"),"End:=", Array("24.71126902464901mm", "0mm","0mm")),"CharImp:=", "Zpi", "AlignmentGroup:=", 0, "RenormImp:=", "50ohm")), "ShowReporterFilter:=",  _
  false, "ReporterFilter:=", Array(true),"FullResistance:=", "50.000000ohm", "FullReactance:=", "0.000000ohm")

OEditor.CreateRectangle Array("NAME:RectangleParameters", "IsCovered:=", true,"XStart:=",  _
"(-(circle_radius+port_line_len))", "YStart:=", "((-port_line_width)/2)", "ZStart:=", "(-dielectric_height)","Width:=", "port_line_width","Height:=",  _
"dielectric_height","WhichAxis:=", "X"), Array("NAME:Attributes", "Name:=", "p4", "Flags:=",  _
"","Color:=", "(255 0 0)","Transparency:=", 0,"PartCoordinateSystem:=",  _
"Global", "UDMId:=", "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "","SolveInside:=",  _
true)

Set oModule = oDesign.GetModule("BoundarySetup")

oModule.AssignLumpedPort Array("NAME:4", "Objects:=", Array("p4"),"RenormalizeAllTerminals:=",  _
  true, "DoDeembed:=", false, Array("NAME:Modes", Array("NAME:Mode1", "ModeNum:=", 1, "UseIntLine:=",  _
  true,Array("NAME:IntLine", "Start:=", Array("-24.71126902464901mm", "0mm","-1.6mm"),"End:=", Array("-24.71126902464901mm", "0mm","0mm")),"CharImp:=", "Zpi", "AlignmentGroup:=", 0, "RenormImp:=", "50ohm")), "ShowReporterFilter:=",  _
  false, "ReporterFilter:=", Array(true),"FullResistance:=", "50.000000ohm", "FullReactance:=", "0.000000ohm")

OEditor.CreateRectangle Array("NAME:RectangleParameters", "IsCovered:=", true,"XStart:=",  _
"(((circle_radius+port_line_len)*0.5000000000000001)+(port_line_width*-0.5669872981077806))", "YStart:=", "((((circle_radius+port_line_len)*0.8660254037844387)-((port_line_width/2)*0.49999999999999994))+(2*port_line_len))", "ZStart:=", "(-dielectric_height)","Width:=", "dielectric_height","Height:=",  _
"port_line_width","WhichAxis:=", "Y"), Array("NAME:Attributes", "Name:=", "p2", "Flags:=",  _
"","Color:=", "(255 0 0)","Transparency:=", 0,"PartCoordinateSystem:=",  _
"Global", "UDMId:=", "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "","SolveInside:=",  _
true)

Set oModule = oDesign.GetModule("BoundarySetup")

oModule.AssignLumpedPort Array("NAME:2", "Objects:=", Array("p2"),"RenormalizeAllTerminals:=",  _
  true, "DoDeembed:=", false, Array("NAME:Modes", Array("NAME:Mode1", "ModeNum:=", 1, "UseIntLine:=",  _
  true,Array("NAME:IntLine", "Start:=", Array("10.654672618001166mm", "36.65058673509755mm","-1.6mm"),"End:=", Array("10.654672618001166mm", "36.65058673509755mm","0mm")),"CharImp:=", "Zpi", "AlignmentGroup:=", 0, "RenormImp:=", "50ohm")), "ShowReporterFilter:=",  _
  false, "ReporterFilter:=", Array(true),"FullResistance:=", "50.000000ohm", "FullReactance:=", "0.000000ohm")

OEditor.CreateRectangle Array("NAME:RectangleParameters", "IsCovered:=", true,"XStart:=",  _
"(((circle_radius+port_line_len)*-0.4999999999999998)-((port_line_width/2)*0.8660254037844387))", "YStart:=", "((((circle_radius+port_line_len)*0.8660254037844387)-((port_line_width/2)*0.49999999999999994))+(2*port_line_len))", "ZStart:=", "(-dielectric_height)","Width:=", "dielectric_height","Height:=",  _
"port_line_width","WhichAxis:=", "Y"), Array("NAME:Attributes", "Name:=", "p3", "Flags:=",  _
"","Color:=", "(255 0 0)","Transparency:=", 0,"PartCoordinateSystem:=",  _
"Global", "UDMId:=", "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "","SolveInside:=",  _
true)

Set oModule = oDesign.GetModule("BoundarySetup")

oModule.AssignLumpedPort Array("NAME:3", "Objects:=", Array("p3"),"RenormalizeAllTerminals:=",  _
  true, "DoDeembed:=", false, Array("NAME:Modes", Array("NAME:Mode1", "ModeNum:=", 1, "UseIntLine:=",  _
  true,Array("NAME:IntLine", "Start:=", Array("-13.654672618001158mm", "36.65058673509755mm","-1.6mm"),"End:=", Array("-13.654672618001158mm", "36.65058673509755mm","0mm")),"CharImp:=", "Zpi", "AlignmentGroup:=", 0, "RenormImp:=", "50ohm")), "ShowReporterFilter:=",  _
  false, "ReporterFilter:=", Array(true),"FullResistance:=", "50.000000ohm", "FullReactance:=", "0.000000ohm")

oEditor.CreateBox Array("NAME:BoxParameters","XPosition:=", "((-radiation_size)/2)", "YPosition:=",  _
  "((-radiation_size)/2)", "ZPosition:=", "((-radiation_height)/2)", "XSize:=", "radiation_size", "YSize:=", "radiation_size", "ZSize:=",  _ 
"radiation_height"),Array("NAME:Attributes", "Name:=", "rad_box","Flags:=", "", "Color:=",  _
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
