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
 "LocalVariables"), Array("NAME:NewProps", Array("NAME:dipole_height", "PropType:=", "VariableProp", "UserDef:=",  _
 true, "Value:=", "62.456762mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers",  _
 "LocalVariables"), Array("NAME:NewProps", Array("NAME:dipole_gap", "PropType:=", "VariableProp", "UserDef:=",  _
 true, "Value:=", "1.249135mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers",  _
 "LocalVariables"), Array("NAME:NewProps", Array("NAME:wire_radius", "PropType:=", "VariableProp", "UserDef:=",  _
 true, "Value:=", "1.249135mm"))))

oEditor.CreateCylinder Array("NAME:CylinderParameters","XCenter:=", "0mm", "YCenter:=",  _
  "0mm", "ZCenter:=", "dipole_gap/2",  "Radius:=", "wire_radius","Height:=",  _
  "dipole_height/2-dipole_gap/2","WhichAxis:=", "Z", "NumSides:=", "0"), Array("NAME:Attributes","Name:=",  _
  "upper_wire","Flags:=", "","Color:=", "(70 130 180)","Transparency:=", 0, "PartCoordinateSystem:=",  _
  "Global", "UDMId:=", "","MaterialValue:=", "" & Chr(34) & "pec" & Chr(34) & "","SolveInside:=",  _
  false)

oEditor.CreateCylinder Array("NAME:CylinderParameters","XCenter:=", "0mm", "YCenter:=",  _
  "0mm", "ZCenter:=", "-dipole_gap/2",  "Radius:=", "wire_radius","Height:=",  _
  "-dipole_height/2+dipole_gap/2","WhichAxis:=", "Z", "NumSides:=", "0"), Array("NAME:Attributes","Name:=",  _
  "bottom_wire","Flags:=", "","Color:=", "(70 130 180)","Transparency:=", 0, "PartCoordinateSystem:=",  _
  "Global", "UDMId:=", "","MaterialValue:=", "" & Chr(34) & "pec" & Chr(34) & "","SolveInside:=",  _
  false)

OEditor.CreateRectangle Array("NAME:RectangleParameters", "IsCovered:=", true,"XStart:=",  _
"-wire_radius", "YStart:=", "0mm", "ZStart:=", "-dipole_gap/2","Width:=", "dipole_gap","Height:=",  _
"2*wire_radius","WhichAxis:=", "Y"), Array("NAME:Attributes", "Name:=", "rect1", "Flags:=",  _
"","Color:=", "(255 165 0)","Transparency:=", 0,"PartCoordinateSystem:=",  _
"Global", "UDMId:=", "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "","SolveInside:=",  _
true)

Set oModule = oDesign.GetModule("BoundarySetup")

oModule.AssignLumpedPort Array("NAME:1", "Objects:=", Array("rect1"),"RenormalizeAllTerminals:=",  _
  true, "DoDeembed:=", false, Array("NAME:Modes", Array("NAME:Mode1", "ModeNum:=", 1, "UseIntLine:=",  _
  true,Array("NAME:IntLine", "Start:=", Array("0mm", "0mm","-0.6245676208333333mm"),"End:=", Array("0mm", "0mm","0.6245676208333333mm")),"CharImp:=", "Zpi", "AlignmentGroup:=", 0, "RenormImp:=", "50ohm")), "ShowReporterFilter:=",  _
  false, "ReporterFilter:=", Array(true),"FullResistance:=", "50.000000ohm", "FullReactance:=", "0.000000ohm")

oEditor.CreateBox Array("NAME:BoxParameters","XPosition:=", "-(62.45676208333333mm+2*wire_radius)/2", "YPosition:=",  _
  "-(62.45676208333333mm+2*wire_radius)/2", "ZPosition:=", "-(62.45676208333333mm+dipole_height)/2", "XSize:=", "62.45676208333333mm+2*wire_radius", "YSize:=", "62.45676208333333mm+2*wire_radius", "ZSize:=",  _ 
"62.45676208333333mm+dipole_height"),Array("NAME:Attributes", "Name:=", "rad_box","Flags:=", "", "Color:=",  _
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
"LinearStep", "StartValue:=", "1.5GHz", "StopValue:=", "3.5GHz", "StepSize:=",  _
"0.1GHz","Type:=", "Interpolating", "SaveFields:=", false, "SaveRadFields:=",  _
false, "InterpTolerance:=", 0.5, "InterpMaxSolns:=", 250, "InterpMinSolns:=",  _
0, "InterpMinSubranges:=", 1, "ExtrapToDC:=", false, "InterpUseS:=", true, "InterpUsePortImped:=",  _
false, "InterpUsePropConst:=", true, "UseDerivativeConvergence:=", false, "InterpDerivTolerance:=",  _
0.2, "UseFullBasis:=", true, "EnforcePassivity:=", false)
