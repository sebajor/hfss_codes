' ----------------------------------------------
' Script Recorded by Ansoft HFSS Version 15.0.2
' 11:04:21 PM  Aug 27, 2026
' ----------------------------------------------
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
oEditor.CreateCylinder Array("NAME:CylinderParameters", "XCenter:=", "0mm", "YCenter:=",  _
  "0mm", "ZCenter:=", "0mm", "Radius:=", "0.565685424949238mm", "Height:=",  _
  "1.4mm", "WhichAxis:=", "Z", "NumSides:=", "0"), Array("NAME:Attributes", "Name:=",  _
  "Cylinder1", "Flags:=", "", "Color:=", "(132 132 193)", "Transparency:=", 0, "PartCoordinateSystem:=",  _
  "Global", "UDMId:=", "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "", "SolveInside:=",  _
  true)
oEditor.CreateBox Array("NAME:BoxParameters", "XPosition:=", "2mm", "YPosition:=",  _
  "0mm", "ZPosition:=", "0mm", "XSize:=", "-0.6mm", "YSize:=", "0.2mm", "ZSize:=",  _
  "0.6mm"), Array("NAME:Attributes", "Name:=", "Box1", "Flags:=", "", "Color:=",  _
  "(132 132 193)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
  "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "", "SolveInside:=",  _
  true)
oEditor.CreateRectangle Array("NAME:RectangleParameters", "IsCovered:=", true, "XStart:=",  _
  "1mm", "YStart:=", "1.4mm", "ZStart:=", "0mm", "Width:=", "-0.6mm", "Height:=",  _
  "0.2mm", "WhichAxis:=", "Z"), Array("NAME:Attributes", "Name:=", "Rectangle1", "Flags:=",  _
  "", "Color:=", "(132 132 193)", "Transparency:=", 0, "PartCoordinateSystem:=",  _
  "Global", "UDMId:=", "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "", "SolveInside:=",  _
  true)
oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers",  _
  "LocalVariables"), Array("NAME:NewProps", Array("NAME:z_val", "PropType:=", "VariableProp", "UserDef:=",  _
  true, "Value:=", "123mm"))))
oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:Geometry3DCmdTab", Array("NAME:PropServers",  _
  "Box1:CreateBox:1"), Array("NAME:ChangedProps", Array("NAME:Position", "X:=", "2mm", "Y:=",  _
  "0mm", "Z:=", "z_val"))))

oEditor.CreateRegularPolygon Array("NAME:RegularPolygonParameters", "IsCovered:=",  _
  true, "XCenter:=", "0.6mm", "YCenter:=", "-2.2mm", "ZCenter:=", "0mm", "XStart:=",  _
  "0mm", "YStart:=", "-2mm", "ZStart:=", "0mm", "NumSides:=", "12", "WhichAxis:=",  _
  "Z"), Array("NAME:Attributes", "Name:=", "Polygon1", "Flags:=", "", "Color:=",  _
  "(132 132 193)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
  "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "", "SolveInside:=",  _
  true)
oEditor.CreateEllipse Array("NAME:EllipseParameters", "IsCovered:=", true, "XCenter:=",  _
  "-1.8mm", "YCenter:=", "2mm", "ZCenter:=", "0mm", "MajRadius:=", "1mm", "Ratio:=",  _
  "0.6", "WhichAxis:=", "Z", "NumSegments:=", "0"), Array("NAME:Attributes", "Name:=",  _
  "Ellipse1", "Flags:=", "", "Color:=", "(132 132 193)", "Transparency:=", 0, "PartCoordinateSystem:=",  _
  "Global", "UDMId:=", "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "", "SolveInside:=",  _
  true)
