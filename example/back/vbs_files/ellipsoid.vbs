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
 "LocalVariables"), Array("NAME:NewProps", Array("NAME:a", "PropType:=", "VariableProp", "UserDef:=",  _
 true, "Value:=", "1.000000"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers",  _
 "LocalVariables"), Array("NAME:NewProps", Array("NAME:b", "PropType:=", "VariableProp", "UserDef:=",  _
 true, "Value:=", "0.500000"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers",  _
 "LocalVariables"), Array("NAME:NewProps", Array("NAME:curve_points", "PropType:=", "VariableProp", "UserDef:=",  _
 true, "Value:=", "10.000000"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers",  _
 "LocalVariables"), Array("NAME:NewProps", Array("NAME:ellipsoid_thick", "PropType:=", "VariableProp", "UserDef:=",  _
 true, "Value:=", "0.005000"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers",  _
 "LocalVariables"), Array("NAME:NewProps", Array("NAME:rotation_segments", "PropType:=", "VariableProp", "UserDef:=",  _
 true, "Value:=", "12.000000"))))

oEditor.CreateEquationCurve Array("NAME:EquationBasedCurveParameters","XtFunction:=",  _
"(a*sin(_t))*1mm","YtFunction:=", "(0)*1mm","ZtFunction:=", "(-b*cos(_t))*1mm","tStart:=",  _
"0","tEnd:=", "pi/4","NumOfPointsOnCurve:=", "curve_points","Version:=", 1, Array("NAME:PolylineXSection", "XSectionType:=",  _
"None", "XSectionOrient:=", "Auto", "XSectionWidth:=", "0", "XSectionTopWidth:=",  _
"0", "XSectionHeight:=", "0", "XSectionNumSegments:=", "0", "XSectionBendType:=",  _
"Corner")), Array("NAME:Attributes", "Name:=", "line1", "Flags:=", "", "Color:=",  _
"(132 132 193)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
"", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "", "SolveInside:=",  _
true)

oEditor.CreateEquationCurve Array("NAME:EquationBasedCurveParameters","XtFunction:=",  _
"(a*sin(_t)+ellipsoid_thick)*1mm","YtFunction:=", "(0)*1mm","ZtFunction:=", "(-b*cos(_t)-ellipsoid_thick)*1mm","tStart:=",  _
"0","tEnd:=", "pi/4","NumOfPointsOnCurve:=", "curve_points","Version:=", 1, Array("NAME:PolylineXSection", "XSectionType:=",  _
"None", "XSectionOrient:=", "Auto", "XSectionWidth:=", "0", "XSectionTopWidth:=",  _
"0", "XSectionHeight:=", "0", "XSectionNumSegments:=", "0", "XSectionBendType:=",  _
"Corner")), Array("NAME:Attributes", "Name:=", "line2", "Flags:=", "", "Color:=",  _
"(132 132 193)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
"", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "", "SolveInside:=",  _
true)

oEditor.Connect Array("NAME:Selections", "Selections:=",  _
"line1,line2")
oEditor.SweepAroundAxis Array("NAME:Selections","Selections:=", "line1","NewPartsModelFlag:=",  _
"Model"), Array("NAME:AxisSweepParameters", "DraftAngle:=", "0deg", "DraftType:=",  _
"Round","CheckFaceFaceIntersection:=", false,"SweepAxis:=", "Z","SweepAngle:=",  _
"360deg","NumOfSegments:=", "rotation_segments")

oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:Geometry3DAttributeTab", Array("NAME:PropServers",  _
"line1"), Array("NAME:ChangedProps", Array("NAME:Color", "R:=", 238, "G:=", 130, "B:=",  _
238))))

oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:Geometry3DAttributeTab", Array("NAME:PropServers",  _
"line1"),Array("NAME:ChangedProps", Array("NAME:Material", "Value:=", "" & Chr(34) & "pec" & Chr(34) & ""))))
