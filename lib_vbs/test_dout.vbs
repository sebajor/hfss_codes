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
Set oModule = oDesign.GetModule("BoundarySetup")
Set oEditor = oDesign.SetActiveEditor("3D Modeler")

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers",  _
 "LocalVariables"), Array("NAME:NewProps", Array("NAME:dipole_height", "PropType:=", "VariableProp", "UserDef:=",  _
 true, "Value:=", "10.000000mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers",  _
 "LocalVariables"), Array("NAME:NewProps", Array("NAME:wire_radius", "PropType:=", "VariableProp", "UserDef:=",  _
 true, "Value:=", "1.000000mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers",  _
 "LocalVariables"), Array("NAME:NewProps", Array("NAME:dipole_gap", "PropType:=", "VariableProp", "UserDef:=",  _
 true, "Value:=", "1.000000mm"))))

oEditor.CreateCylinder Array("NAME:CylinderParameters","XCenter:=", "0mm", "YCenter:=",  _
  "0mm", "ZCenter:=", "dipole_gap/2",  "Radius:=", "wire_radius","Height:=",  _
  "dipole_height/2-dipole_gap/2","WhichAxis:=", "Z", "NumSides:=", "0"), Array("NAME:Attributes","Name:=",  _
  "upper_wire","Flags:=", "","Color:=", "(70 130 180)","Transparency:=", 0, "PartCoordinateSystem:=",  _
  "Global", "UDMId:=", "","MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "","SolveInside:=",  _
  true)

oEditor.CreateCylinder Array("NAME:CylinderParameters","XCenter:=", "0mm", "YCenter:=",  _
  "0mm", "ZCenter:=", "-dipole_gap/2",  "Radius:=", "wire_radius","Height:=",  _
  "-(dipole_height/2-dipole_gap/2)","WhichAxis:=", "Z", "NumSides:=", "0"), Array("NAME:Attributes","Name:=",  _
  "bottom_wire","Flags:=", "","Color:=", "(70 130 180)","Transparency:=", 0, "PartCoordinateSystem:=",  _
  "Global", "UDMId:=", "","MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "","SolveInside:=",  _
  true)

oEditor.CreateBox Array("NAME:BoxParameters","XCenter:=", "30mm", "YCenter:=",  _
  "20mm", "ZCenter:=", "0mm", "XSize:=", "10mm", "YSize:=", "20mm", "ZSize:=",  _ 
"30mm"),Array("NAME:Attributes", "Name:=", "Box_wn","Flags:=", "", "Color:=",  _
  "(70 130 180)", "Transparency:=", 1, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
  "","MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "", "SolveInside:=",  _
  true)

OEditor.CreateRectangle Array("NAME:RectangleParameters", "IsCovered:=", true,"XStart:=",  _
"0mm", "YStart:=", "0mm", "ZStart:=", "0mm","Width:=", "10mm","Height:=",  _
"5mm","WhichAxis:=", "X"), Array("NAME:Attributes", "Name:=", "Rect1", "Flags:=",  _
"","Color:=", "(255 165 0)","Transparency:=", 0,"PartCoordinateSystem:=",  _
"Global", "UDMId:=", "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "","SolveInside:=",  _
true)

oModule.AssignRadiation Array("NAME:Rad1", "Objects:=", Array("Box_wn"), "IsIncidentField:=",  _
false, "IsEnforcedField:=", false, "IsFssReference:=", false, "IsForPML:=",  _
false, "UseAdaptiveIE:=", false, "IncludeInPostproc:=", true)

oModule.AssignLumpedPort Array("NAME:1", "Objects:=", Array("Rect1"),"RenormalizeAllTerminals:=",  _
  true, "DoDeembed:=", false, Array("NAME:Modes", Array("NAME:Mode1", "ModeNum:=", 1, "UseIntLine:=",  _
  true,Array("NAME:IntLine", "Start:=", Array("0mm", "0mm","2.5mm"),"End:=", Array("0mm", "10mm","2.5mm")),"CharImp:=", "Zpi", "AlignmentGroup:=", 0, "RenormImp:=", "50ohm")), "ShowReporterFilter:=",  _
  false, "ReporterFilter:=", Array(true),"FullResistance:=", "50.000000ohm", "FullReactance:=", "0.000000ohm")
