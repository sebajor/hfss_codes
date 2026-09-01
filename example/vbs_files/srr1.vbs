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

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:srr_len", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "40mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:srr_width", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "48mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:line_width", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "4mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:c_line_width", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "4mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:c_plate_len", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "18mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:c_plate_width", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "4mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:c_gap", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "2mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:copper_height", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "0.035mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:dielectric_size", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "64mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:dielectric_height", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "1.6mm"))))

oEditor.CreatePolyline Array("NAME:PolylineParameters", "IsPolylineCovered:=", true,"IsPolylineClosed:=",  _
  true, Array("NAME:PolylinePoints", _
 Array("NAME:PLPoint", "X:=", "(((-srr_width)/2)+line_width)", "Y:=", "(((-srr_len)/2)+line_width)", "Z:=","copper_height"), _
 Array("NAME:PLPoint", "X:=", "(((-srr_width)/2)+line_width)", "Y:=", "((srr_len/2)-line_width)", "Z:=","copper_height"), _
 Array("NAME:PLPoint", "X:=", "((-c_line_width)/2)", "Y:=", "((srr_len/2)-line_width)", "Z:=","copper_height"), _
 Array("NAME:PLPoint", "X:=", "((-c_line_width)/2)", "Y:=", "((c_gap/2)+c_plate_width)", "Z:=","copper_height"), _
 Array("NAME:PLPoint", "X:=", "((-c_plate_len)/2)", "Y:=", "((c_gap/2)+c_plate_width)", "Z:=","copper_height"), _
 Array("NAME:PLPoint", "X:=", "((-c_plate_len)/2)", "Y:=", "(c_gap/2)", "Z:=","copper_height"), _
 Array("NAME:PLPoint", "X:=", "(c_plate_len/2)", "Y:=", "(c_gap/2)", "Z:=","copper_height"), _
 Array("NAME:PLPoint", "X:=", "(c_plate_len/2)", "Y:=", "((c_gap/2)+c_plate_width)", "Z:=","copper_height"), _
 Array("NAME:PLPoint", "X:=", "(c_plate_width/2)", "Y:=", "((c_gap/2)+c_plate_width)", "Z:=","copper_height"), _
 Array("NAME:PLPoint", "X:=", "(c_plate_width/2)", "Y:=", "((srr_len/2)-line_width)", "Z:=","copper_height"), _
 Array("NAME:PLPoint", "X:=", "((srr_width/2)-line_width)", "Y:=", "((srr_len/2)-line_width)", "Z:=","copper_height"), _
 Array("NAME:PLPoint", "X:=", "((srr_width/2)-line_width)", "Y:=", "(((-srr_len)/2)+line_width)", "Z:=","copper_height"), _
 Array("NAME:PLPoint", "X:=", "(c_line_width/2)", "Y:=", "(((-srr_len)/2)+line_width)", "Z:=","copper_height"), _
 Array("NAME:PLPoint", "X:=", "(c_line_width/2)", "Y:=", "(((-c_gap)/2)-c_plate_width)", "Z:=","copper_height"), _
 Array("NAME:PLPoint", "X:=", "(c_plate_len/2)", "Y:=", "(((-c_gap)/2)-c_plate_width)", "Z:=","copper_height"), _
 Array("NAME:PLPoint", "X:=", "(c_plate_len/2)", "Y:=", "((-c_gap)/2)", "Z:=","copper_height"), _
 Array("NAME:PLPoint", "X:=", "((-c_plate_len)/2)", "Y:=", "((-c_gap)/2)", "Z:=","copper_height"), _
 Array("NAME:PLPoint", "X:=", "((-c_plate_len)/2)", "Y:=", "(((-c_gap)/2)-c_plate_width)", "Z:=","copper_height"), _
 Array("NAME:PLPoint", "X:=", "((-c_line_width)/2)", "Y:=", "(((-c_gap)/2)-c_plate_width)", "Z:=","copper_height"), _
 Array("NAME:PLPoint", "X:=", "((-c_line_width)/2)", "Y:=", "(((-srr_len)/2)+line_width)", "Z:=","copper_height"), _
 Array("NAME:PLPoint", "X:=", "(((-srr_width)/2)+line_width)", "Y:=", "(((-srr_len)/2)+line_width)", "Z:=","copper_height")), Array("NAME:PolylineSegments", _
Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 0, "NoOfPoints:=", 2), _
Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 1, "NoOfPoints:=", 2), _
Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 2, "NoOfPoints:=", 2), _
Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 3, "NoOfPoints:=", 2), _
Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 4, "NoOfPoints:=", 2), _
Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 5, "NoOfPoints:=", 2), _
Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 6, "NoOfPoints:=", 2), _
Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 7, "NoOfPoints:=", 2), _
Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 8, "NoOfPoints:=", 2), _
Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 9, "NoOfPoints:=", 2), _
Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 10, "NoOfPoints:=", 2), _
Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 11, "NoOfPoints:=", 2), _
Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 12, "NoOfPoints:=", 2), _
Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 13, "NoOfPoints:=", 2), _
Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 14, "NoOfPoints:=", 2), _
Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 15, "NoOfPoints:=", 2), _
Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 16, "NoOfPoints:=", 2), _
Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 17, "NoOfPoints:=", 2), _
Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 18, "NoOfPoints:=", 2), _
Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 19, "NoOfPoints:=", 2)), Array("NAME:PolylineXSection", "XSectionType:=", "None", "XSectionOrient:=", "Auto", "XSectionWidth:=", "0mm", _
  "XSectionTopWidth:=","0mm", "XSectionHeight:=", "0mm", "XSectionNumSegments:=", "0",  _
  "XSectionBendType:=", "Corner")),Array("NAME:Attributes", "Name:=", "srr_interior","Flags:=", "", "Color:=",  _
  "(132 132 193)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
  "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "", "SolveInside:=", true)
oEditor.CreatePolyline Array("NAME:PolylineParameters", "IsPolylineCovered:=", true,"IsPolylineClosed:=",  _
  true, Array("NAME:PolylinePoints", _
 Array("NAME:PLPoint", "X:=", "((-srr_width)/2)", "Y:=", "((-srr_len)/2)", "Z:=","copper_height"), _
 Array("NAME:PLPoint", "X:=", "((-srr_width)/2)", "Y:=", "(srr_len/2)", "Z:=","copper_height"), _
 Array("NAME:PLPoint", "X:=", "(srr_width/2)", "Y:=", "(srr_len/2)", "Z:=","copper_height"), _
 Array("NAME:PLPoint", "X:=", "(srr_width/2)", "Y:=", "((-srr_len)/2)", "Z:=","copper_height"), _
 Array("NAME:PLPoint", "X:=", "((-srr_width)/2)", "Y:=", "((-srr_len)/2)", "Z:=","copper_height")), Array("NAME:PolylineSegments", _
Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 0, "NoOfPoints:=", 2), _
Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 1, "NoOfPoints:=", 2), _
Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 2, "NoOfPoints:=", 2), _
Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", 3, "NoOfPoints:=", 2)), Array("NAME:PolylineXSection", "XSectionType:=", "None", "XSectionOrient:=", "Auto", "XSectionWidth:=", "0mm", _
  "XSectionTopWidth:=","0mm", "XSectionHeight:=", "0mm", "XSectionNumSegments:=", "0",  _
  "XSectionBendType:=", "Corner")),Array("NAME:Attributes", "Name:=", "srr_closed","Flags:=", "", "Color:=",  _
  "(132 132 193)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
  "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "", "SolveInside:=", true)
oEditor.Subtract Array("NAME:Selections", "Blank Parts:=", "srr_closed", "Tool Parts:=",  _
"srr_interior"), Array("NAME:SubtractParameters", "KeepOriginals:=", false)

oEditor.ThickenSheet Array("NAME:Selections", "Selections:=", "srr_closed","NewPartsModelFlag:=",  _
"Model"), Array("NAME:SheetThickenParameters", "Thickness:=", "copper_height", "BothSides:=",  _
false)

oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:Geometry3DAttributeTab", Array("NAME:PropServers",  _
"srr_closed"), Array("NAME:ChangedProps", Array("NAME:Color", "R:=", 255, "G:=", 165, "B:=",  _
0))))

oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:Geometry3DAttributeTab", Array("NAME:PropServers",  _
"srr_closed"),Array("NAME:ChangedProps", Array("NAME:Material", "Value:=", "" & Chr(34) & "pec" & Chr(34) & ""))))

oEditor.CreateBox Array("NAME:BoxParameters","XPosition:=", "((-dielectric_size)/2)", "YPosition:=",  _
  "((-dielectric_size)/2)", "ZPosition:=", "(-dielectric_height)", "XSize:=", "dielectric_size", "YSize:=", "dielectric_size", "ZSize:=",  _ 
"dielectric_height"),Array("NAME:Attributes", "Name:=", "substrate","Flags:=", "", "Color:=",  _
  "(0 128 0)", "Transparency:=", 1, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
  "","MaterialValue:=", "" & Chr(34) & "FR4_epoxy" & Chr(34) & "", "SolveInside:=",  _
  true)
