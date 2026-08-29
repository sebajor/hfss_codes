' ----------------------------------------------
' Script Recorded by Ansoft HFSS Version 15.0.2
' 9:30:43 PM  Aug 28, 2026
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
oEditor.Rotate Array("NAME:Selections", "Selections:=", "upper_wire", "NewPartsModelFlag:=",  _
  "Model"), Array("NAME:RotateParameters", "RotateAxis:=", "X", "RotateAngle:=",  _
  "45deg")
oEditor.Move Array("NAME:Selections", "Selections:=", "upper_wire", "NewPartsModelFlag:=",  _
  "Model"), Array("NAME:TranslateParameters", "TranslateVectorX:=", "0mm", "TranslateVectorY:=",  _
  "-20mm", "TranslateVectorZ:=", "-10mm")
oEditor.CreateBox Array("NAME:BoxParameters", "XPosition:=", "0mm", "YPosition:=",  _
  "-26mm", "ZPosition:=", "0mm", "XSize:=", "10mm", "YSize:=", "-6mm", "ZSize:=",  _
  "-4mm"), Array("NAME:Attributes", "Name:=", "Box1", "Flags:=", "", "Color:=",  _
  "(132 132 193)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
  "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "", "SolveInside:=",  _
  true)
oEditor.Unite Array("NAME:Selections", "Selections:=", "Box1,upper_wire"), Array("NAME:UniteParameters", "KeepOriginals:=",  _
  false)
oEditor.CreateSphere Array("NAME:SphereParameters", "XCenter:=", "-2mm", "YCenter:=",  _
  "-24mm", "ZCenter:=", "0mm", "Radius:=", "12.4197423483742mm"), Array("NAME:Attributes", "Name:=",  _
  "Sphere1", "Flags:=", "", "Color:=", "(132 132 193)", "Transparency:=", 0, "PartCoordinateSystem:=",  _
  "Global", "UDMId:=", "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "", "SolveInside:=",  _
  true)
oEditor.Subtract Array("NAME:Selections", "Blank Parts:=", "Box1", "Tool Parts:=",  _
  "Sphere1"), Array("NAME:SubtractParameters", "KeepOriginals:=", false)
