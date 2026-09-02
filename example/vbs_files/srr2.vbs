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

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:line_width", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "1mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:srr_radius", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "5mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:c_gap", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "0.5mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:c_plate_len", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "2mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:c_plate_width", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "0.5mm"))))

oEditor.CreateCircle Array("NAME:CircleParameters", "IsCovered:=", true,"XCenter:=",  _
"0mm","YCenter:=", "0mm","ZCenter:=", "0mm","Radius:=",  _
"srr_radius","WhichAxis:=", "Z","NumSegments:=", "0"), Array("NAME:Attributes", "Name:=",  _
"srr","Flags:=", "", "Color:=", "(173 216 230)","Transparency:=", 0,"PartCoordinateSystem:=",  _
"Global", "UDMId:=", "","MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "","SolveInside:=",true)
oEditor.CreateCircle Array("NAME:CircleParameters", "IsCovered:=", true,"XCenter:=",  _
"0mm","YCenter:=", "0mm","ZCenter:=", "0mm","Radius:=",  _
"(srr_radius-line_width)","WhichAxis:=", "Z","NumSegments:=", "0"), Array("NAME:Attributes", "Name:=",  _
"circ_cut","Flags:=", "", "Color:=", "(173 216 230)","Transparency:=", 0,"PartCoordinateSystem:=",  _
"Global", "UDMId:=", "","MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "","SolveInside:=",true)
oEditor.Subtract Array("NAME:Selections", "Blank Parts:=", "srr", "Tool Parts:=",  _
"circ_cut"), Array("NAME:SubtractParameters", "KeepOriginals:=", false)

OEditor.CreateRectangle Array("NAME:RectangleParameters", "IsCovered:=", true,"XStart:=",  _
"(-srr_radius)", "YStart:=", "((-c_gap)/2)", "ZStart:=", "0mm","Width:=", "srr_radius","Height:=",  _
"c_gap","WhichAxis:=", "Z"), Array("NAME:Attributes", "Name:=", "rect_cut", "Flags:=",  _
"","Color:=", "(255 165 0)","Transparency:=", 0,"PartCoordinateSystem:=",  _
"Global", "UDMId:=", "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "","SolveInside:=",  _
true)

oEditor.Subtract Array("NAME:Selections", "Blank Parts:=", "srr", "Tool Parts:=",  _
"rect_cut"), Array("NAME:SubtractParameters", "KeepOriginals:=", false)

OEditor.CreateRectangle Array("NAME:RectangleParameters", "IsCovered:=", true,"XStart:=",  _
"(((-srr_radius)-(c_plate_len/2))+(line_width/2))", "YStart:=", "(c_gap/2)", "ZStart:=", "0mm","Width:=", "c_plate_len","Height:=",  _
"c_plate_width","WhichAxis:=", "Z"), Array("NAME:Attributes", "Name:=", "rc1", "Flags:=",  _
"","Color:=", "(255 165 0)","Transparency:=", 0,"PartCoordinateSystem:=",  _
"Global", "UDMId:=", "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "","SolveInside:=",  _
true)

OEditor.CreateRectangle Array("NAME:RectangleParameters", "IsCovered:=", true,"XStart:=",  _
"(((-srr_radius)-(c_plate_len/2))+(line_width/2))", "YStart:=", "((-c_gap)/2)", "ZStart:=", "0mm","Width:=", "c_plate_len","Height:=",  _
"(-c_plate_width)","WhichAxis:=", "Z"), Array("NAME:Attributes", "Name:=", "rc12", "Flags:=",  _
"","Color:=", "(255 165 0)","Transparency:=", 0,"PartCoordinateSystem:=",  _
"Global", "UDMId:=", "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "","SolveInside:=",  _
true)

oEditor.Unite Array("NAME:Selections", "Selections:=", "srr,rc1"),Array("NAME:UniteParameters", "KeepOriginals:=",  _
false)

oEditor.Unite Array("NAME:Selections", "Selections:=", "srr,rc12"),Array("NAME:UniteParameters", "KeepOriginals:=",  _
false)
