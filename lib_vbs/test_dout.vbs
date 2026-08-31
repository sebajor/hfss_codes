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

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:dipole_height", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "10mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:wire_radius", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "1mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:dipole_gap", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "1mm"))))

oEditor.CreateCylinder Array("NAME:CylinderParameters","XCenter:=", "0mm", "YCenter:=",  _
  "0mm", "ZCenter:=", "0mm",  "Radius:=", "(2*wire_radius)","Height:=",  _
  "10mm","WhichAxis:=", "Z", "NumSides:=", "0"), Array("NAME:Attributes","Name:=",  _
  "cyl","Flags:=", "","Color:=", "(70 130 180)","Transparency:=", 0, "PartCoordinateSystem:=",  _
  "Global", "UDMId:=", "","MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "","SolveInside:=",  _
  true)

oEditor.CreateBox Array("NAME:BoxParameters","XPosition:=", "5mm", "YPosition:=",  _
  "1mm", "ZPosition:=", "-10mm", "XSize:=", "dipole_height", "YSize:=", "(dipole_height/2)", "ZSize:=",  _ 
"dipole_gap"),Array("NAME:Attributes", "Name:=", "box1","Flags:=", "", "Color:=",  _
  "(70 130 180)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
  "","MaterialValue:=", "" & Chr(34) & "pec" & Chr(34) & "", "SolveInside:=",  _
  false)
