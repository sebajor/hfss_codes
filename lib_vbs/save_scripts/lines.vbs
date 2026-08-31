' ----------------------------------------------
' Script Recorded by Ansoft HFSS Version 15.0.2
' 7:37:57 PM  Aug 30, 2026
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
Set oEditor = oDesign.SetActiveEditor

oEditor.CreatePolyline Array("NAME:PolylineParameters", "IsPolylineCovered:=", true, "IsPolylineClosed:=",  _
  true, Array("NAME:PolylinePoints", Array("NAME:PLPoint", "X:=", "0mm", "Y:=", "0mm", "Z:=",  _
  "0mm"), Array("NAME:PLPoint", "X:=", "0mm", "Y:=", "100mm", "Z:=", "0mm"), Array("NAME:PLPoint", "X:=",  _
  "50mm", "Y:=", "100mm", "Z:=", "0mm"), Array("NAME:PLPoint", "X:=", "50mm", "Y:=",  _
  "0mm", "Z:=", "0mm"), Array("NAME:PLPoint", "X:=", "0mm", "Y:=", "0mm", "Z:=", "0mm")), Array("NAME:PolylineSegments", Array("NAME:PLSegment", "SegmentType:=",  _
  "Line", "StartIndex:=", 0, "NoOfPoints:=", 2), Array("NAME:PLSegment", "SegmentType:=",  _
  "Line", "StartIndex:=", 1, "NoOfPoints:=", 2), Array("NAME:PLSegment", "SegmentType:=",  _
  "Line", "StartIndex:=", 2, "NoOfPoints:=", 2), Array("NAME:PLSegment", "SegmentType:=",  _
  "Line", "StartIndex:=", 3, "NoOfPoints:=", 2)), Array("NAME:PolylineXSection", "XSectionType:=",  _
  "None", "XSectionOrient:=", "Auto", "XSectionWidth:=", "0mm", "XSectionTopWidth:=",  _
  "0mm", "XSectionHeight:=", "0mm", "XSectionNumSegments:=", "0", "XSectionBendType:=",  _
  "Corner")), Array("NAME:Attributes", "Name:=", "Polyline1", "Flags:=", "", "Color:=",  _
  "(132 132 193)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
  "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "", "SolveInside:=",  _
  true)

##some order...
oEditor.CreatePolyline Array("NAME:PolylineParameters", "IsPolylineCovered:=", true, "IsPolylineClosed:=",  _
  true, Array("NAME:PolylinePoints", _
  Array("NAME:PLPoint", "X:=", "0mm", "Y:=", "0mm", "Z:=","0mm"), _
  Array("NAME:PLPoint", "X:=", "0mm", "Y:=", "100mm", "Z:=", "0mm"), _
  Array("NAME:PLPoint", "X:=", "50mm", "Y:=", "100mm", "Z:=", "0mm"), _
  Array("NAME:PLPoint", "X:=", "50mm", "Y:=", "0mm", "Z:=", "0mm"), _
  Array("NAME:PLPoint", "X:=", "0mm", "Y:=", "0mm", "Z:=", "0mm")), _
  Array("NAME:PolylineSegments", _
  Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 0, "NoOfPoints:=", 2), _
  Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 1, "NoOfPoints:=", 2), _
  Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 2, "NoOfPoints:=", 2), _
  Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 3, "NoOfPoints:=", 2)), _
  Array("NAME:PolylineXSection", "XSectionType:=", "None", "XSectionOrient:=", "Auto", "XSectionWidth:=", "0mm", _
  "XSectionTopWidth:=","0mm", "XSectionHeight:=", "0mm", "XSectionNumSegments:=", "0",  _
  "XSectionBendType:=", "Corner")), Array("NAME:Attributes", "Name:=", "Polyline1", "Flags:=", "", "Color:=",  _
  "(132 132 193)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
  "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "", "SolveInside:=",  _
  true)




oEditor.ThickenSheet Array("NAME:Selections", "Selections:=", "Polyline1", "NewPartsModelFlag:=",  _
  "Model"), Array("NAME:SheetThickenParameters", "Thickness:=", "50mm", "BothSides:=",  _
  false)


oEditor.CreateEquationCurve Array("NAME:EquationBasedCurveParameters", "XtFunction:=",  _
  "0.5*sin(_t)", "YtFunction:=", "cos(_t)", "ZtFunction:=", "0", "tStart:=", "0", "tEnd:=",  _
  "180", "NumOfPointsOnCurve:=", "0", "Version:=", 1, Array("NAME:PolylineXSection", "XSectionType:=",  _
  "None", "XSectionOrient:=", "Auto", "XSectionWidth:=", "0", "XSectionTopWidth:=",  _
  "0", "XSectionHeight:=", "0", "XSectionNumSegments:=", "0", "XSectionBendType:=",  _
  "Corner")), Array("NAME:Attributes", "Name:=", "EquationCurve1", "Flags:=", "", "Color:=",  _
  "(132 132 193)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
  "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "", "SolveInside:=",  _
  true)


oEditor.Delete Array("NAME:Selections", "Selections:=", "Polyline1")
oEditor.CoverLines Array("NAME:Selections", "Selections:=", "EquationCurve1", "NewPartsModelFlag:=",  _
  "Model")
oEditor.CoverLines Array("NAME:Selections", "Selections:=", "EquationCurve1", "NewPartsModelFlag:=",  _
  "Model")
oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:Geometry3DCmdTab", Array("NAME:PropServers",  _
  "EquationCurve1:CreateEquationCurve:1"), Array("NAME:ChangedProps", Array("NAME:End _t", "Value:=",  _
  "360"))))
oEditor.DeleteOperation Array("NAME:Parameters", Array("NAME:PartOperations", Array("NAME:EquationCurve1", "OperationIndices:=", Array( _
  1))))
oEditor.DeleteLastOperation Array("NAME:Selections", "Selections:=", "EquationCurve1", "NewPartsModelFlag:=",  _
  "Model")
oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:Geometry3DCmdTab", Array("NAME:PropServers",  _
  "EquationCurve1:CreateEquationCurve:1"), Array("NAME:ChangedProps", Array("NAME:End _t", "Value:=",  _
  "2*pi"))))
oEditor.CoverLines Array("NAME:Selections", "Selections:=", "EquationCurve1", "NewPartsModelFlag:=",  _
  "Model")
oEditor.ThickenSheet Array("NAME:Selections", "Selections:=", "EquationCurve1", "NewPartsModelFlag:=",  _
  "Model"), Array("NAME:SheetThickenParameters", "Thickness:=", "50mm", "BothSides:=",  _
  false)
