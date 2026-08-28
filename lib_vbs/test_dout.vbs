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
  "(70 130 180)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
  "","MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "", "SolveInside:=",  _
  true)
