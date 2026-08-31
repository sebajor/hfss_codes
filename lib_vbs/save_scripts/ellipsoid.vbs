' ----------------------------------------------
' Script Recorded by Ansoft HFSS Version 15.0.2
' 9:44:45 PM  Aug 30, 2026
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

oEditor.CreateEquationCurve Array("NAME:EquationBasedCurveParameters", "XtFunction:=",  _
  "0.5*sin(_t)*1mm", "YtFunction:=", "0", "ZtFunction:=", "-cos(_t)*1mm", "tStart:=",  _
  "0", "tEnd:=", "pi/2", "NumOfPointsOnCurve:=", "10", "Version:=", 1, Array("NAME:PolylineXSection", "XSectionType:=",  _
  "None", "XSectionOrient:=", "Auto", "XSectionWidth:=", "0", "XSectionTopWidth:=",  _
  "0", "XSectionHeight:=", "0", "XSectionNumSegments:=", "0", "XSectionBendType:=",  _
  "Corner")), Array("NAME:Attributes", "Name:=", "EquationCurve1", "Flags:=", "", "Color:=",  _
  "(132 132 193)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
  "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "", "SolveInside:=",  _
  true)




oEditor.SweepAroundAxis Array("NAME:Selections", "Selections:=", "EquationCurve1", "NewPartsModelFlag:=",  _
  "Model"), Array("NAME:AxisSweepParameters", "DraftAngle:=", "0deg", "DraftType:=",  _
  "Round", "CheckFaceFaceIntersection:=", false, "SweepAxis:=", "Z", "SweepAngle:=",  _
  "360deg", "NumOfSegments:=", "40")




oEditor.Connect Array("NAME:Selections", "Selections:=",  _
  "EquationCurve1,EquationCurve2")
oEditor.SweepAroundAxis Array("NAME:Selections", "Selections:=", "EquationCurve1", "NewPartsModelFlag:=",  _
  "Model"), Array("NAME:AxisSweepParameters", "DraftAngle:=", "0deg", "DraftType:=",  _
  "Round", "CheckFaceFaceIntersection:=", false, "SweepAxis:=", "Z", "SweepAngle:=",  _
  "360deg", "NumOfSegments:=", "0")
