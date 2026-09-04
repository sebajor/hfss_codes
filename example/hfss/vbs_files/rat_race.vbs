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

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:dielectric_height", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "1.6mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:dielectric_size", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "60mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:copper_height", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "0.035mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:port_line_width", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "3mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:circle_width", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "1.62mm"))))

oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers", "LocalVariables"), Array("NAME:NewProps", Array("NAME:circle_radius", "PropType:=", "VariableProp", "UserDef:=", true, "Value:=", "16.71126902464901mm"))))

oEditor.CreateCircle Array("NAME:CircleParameters", "IsCovered:=", true,"XCenter:=",  _
"0mm","YCenter:=", "0mm","ZCenter:=", "0mm","Radius:=",  _
"(circle_radius+(circle_width/2))","WhichAxis:=", "Z","NumSegments:=", "0"), Array("NAME:Attributes", "Name:=",  _
"circ","Flags:=", "", "Color:=", "(173 216 230)","Transparency:=", 0,"PartCoordinateSystem:=",  _
"Global", "UDMId:=", "","MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "","SolveInside:=",true)
oEditor.CreateCircle Array("NAME:CircleParameters", "IsCovered:=", true,"XCenter:=",  _
"0mm","YCenter:=", "0mm","ZCenter:=", "0mm","Radius:=",  _
"(circle_radius-(circle_width/2))","WhichAxis:=", "Z","NumSegments:=", "0"), Array("NAME:Attributes", "Name:=",  _
"inner_circ","Flags:=", "", "Color:=", "(173 216 230)","Transparency:=", 0,"PartCoordinateSystem:=",  _
"Global", "UDMId:=", "","MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "","SolveInside:=",true)
oEditor.Subtract Array("NAME:Selections", "Blank Parts:=", "circ", "Tool Parts:=",  _
"inner_circ"), Array("NAME:SubtractParameters", "KeepOriginals:=", false)

OEditor.CreateRectangle Array("NAME:RectangleParameters", "IsCovered:=", true,"XStart:=",  _
"((-circle_radius)+port_line_width)", "YStart:=", "0mm", "ZStart:=", "0mm","Width:=", "port_line_width","Height:=",  _
"port_line_len","WhichAxis:=", "Z"), Array("NAME:Attributes", "Name:=", "port1", "Flags:=",  _
"","Color:=", "(255 165 0)","Transparency:=", 0,"PartCoordinateSystem:=",  _
"Global", "UDMId:=", "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "","SolveInside:=",  _
true)
