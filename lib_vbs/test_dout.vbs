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

oEditor.CreateBox Array("NAME:BoxParameters","XPosition:=", "((-dipole_height)/2)", "YPosition:=",  _
  "((-dipole_height)/4)", "ZPosition:=", "((-dipole_gap)/2)", "XSize:=", "dipole_height", "YSize:=", "(dipole_height/2)", "ZSize:=",  _ 
"dipole_gap"),Array("NAME:Attributes", "Name:=", "box1","Flags:=", "", "Color:=",  _
  "(70 130 180)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", "UDMId:=",  _
  "","MaterialValue:=", "" & Chr(34) & "pec" & Chr(34) & "", "SolveInside:=",  _
  false)

box1_Xmin = oEditor.GetFaceByPosition(Array( _
    "NAME:FaceParameters", _
    "BodyName:=", "box1", _
    "XPosition:=", "((-dipole_height)/2)", _
    "YPosition:=", "(((-dipole_height)/4)+((dipole_height/2)/2))", _
    "ZPosition:=", "(((-dipole_gap)/2)+(dipole_gap/2))"))
box1_Xmax = oEditor.GetFaceByPosition(Array( _
    "NAME:FaceParameters", _
    "BodyName:=", "box1", _
    "XPosition:=", "(((-dipole_height)/2)+dipole_height)", _
    "YPosition:=", "(((-dipole_height)/4)+((dipole_height/2)/2))", _
    "ZPosition:=", "(((-dipole_gap)/2)+(dipole_gap/2))"))

box1_Ymin = oEditor.GetFaceByPosition(Array( _
    "NAME:FaceParameters", _
    "BodyName:=", "box1", _
    "XPosition:=", "(((-dipole_height)/2)+(dipole_height/2))", _
    "YPosition:=", "((-dipole_height)/4)", _
    "ZPosition:=", "(((-dipole_gap)/2)+(dipole_gap/2))"))
box1_Ymax = oEditor.GetFaceByPosition(Array( _
    "NAME:FaceParameters", _
    "BodyName:=", "box1", _
    "XPosition:=", "(((-dipole_height)/2)+(dipole_height/2))", _
    "YPosition:=", "(((-dipole_height)/4)+(dipole_height/2))", _
    "ZPosition:=", "(((-dipole_gap)/2)+(dipole_gap/2))"))

box1_Zmin = oEditor.GetFaceByPosition(Array( _
    "NAME:FaceParameters", _
    "BodyName:=", "box1", _
    "XPosition:=", "(((-dipole_height)/2)+(dipole_height/2))", _
    "YPosition:=", "(((-dipole_height)/4)+((dipole_height/2)/2))", _
    "ZPosition:=", "((-dipole_gap)/2)"))
box1_Zmax = oEditor.GetFaceByPosition(Array( _
    "NAME:FaceParameters", _
    "BodyName:=", "box1", _
    "XPosition:=", "(((-dipole_height)/2)+(dipole_height/2))", _
    "YPosition:=", "(((-dipole_height)/4)+((dipole_height/2)/2))", _
    "ZPosition:=", "(((-dipole_gap)/2)+dipole_gap)"))

Set oModule = oDesign.GetModule("BoundarySetup")
oModule.AssignMaster Array("NAME:mx","Faces:=", Array(box1_Xmin),Array("NAME:CoordSysVector", "Origin:=", Array( _
"-5.000000mm", "-2.500000mm", "-0.500000mm"),"UPos:=", Array("-5.000000mm", "2.500000mm", "-0.500000mm")),"ReverseV:=",  _
false)
Set oModule = oDesign.GetModule("BoundarySetup")
oModule.AssignSlave Array("NAME:sx","Faces:=", Array(box1_Xmax),Array("NAME:CoordSysVector", "Origin:=", Array( _
  "5.000000mm", "-2.500000mm", "-0.500000mm"),"UPos:=", Array("5.000000mm", "2.500000mm", "-0.500000mm")),"ReverseV:=",  _
  true,"Master:=", "mx","UseScanAngles:=", true, "Phi:=", "0deg","Theta:=", "0deg")
Set oModule = oDesign.GetModule("BoundarySetup")
oModule.AssignMaster Array("NAME:my","Faces:=", Array(box1_Ymin),Array("NAME:CoordSysVector", "Origin:=", Array( _
"-5.000000mm", "-2.500000mm", "-0.500000mm"),"UPos:=", Array("5.000000mm", "-2.500000mm", "-0.500000mm")),"ReverseV:=",  _
true)
Set oModule = oDesign.GetModule("BoundarySetup")
oModule.AssignSlave Array("NAME:sy","Faces:=", Array(box1_Ymax),Array("NAME:CoordSysVector", "Origin:=", Array( _
  "-5.000000mm", "2.500000mm", "-0.500000mm"),"UPos:=", Array("5.000000mm", "2.500000mm", "-0.500000mm")),"ReverseV:=",  _
  false,"Master:=", "my","UseScanAngles:=", true, "Phi:=", "0deg","Theta:=", "0deg")
Set oModule = oDesign.GetModule("BoundarySetup")
oModule.AssignFloquetPort Array("NAME:floq1","Faces:=", Array(box1_Zmin),"NumModes:=",  _
  2,"RenormalizeAllTerminals:=", true, "DoDeembed:=", false, Array("NAME:Modes", Array("NAME:Mode1", "ModeNum:=",  _
  1, "UseIntLine:=", false), Array("NAME:Mode2", "ModeNum:=", 2, "UseIntLine:=",  _
  false)), "ShowReporterFilter:=", false, "ReporterFilter:=", Array(false, false), "UseScanAngles:=",  _
  true,"Phi:=", "0deg", "Theta:=", "0deg",Array("NAME:LatticeAVector", "Start:=", Array( _
  "-5.000000mm", "-2.500000mm", "-0.500000mm"), "End:=", Array("5.000000mm", "-2.500000mm", "-0.500000mm")),Array("NAME:LatticeBVector", "Start:=", Array( _
  "-5.000000mm", "-2.500000mm", "-0.500000mm"), "End:=", Array("-5.000000mm", "2.500000mm", "-0.500000mm")),Array("NAME:ModesList", Array("NAME:Mode", "ModeNumber:=",  _
  1, "IndexM:=", 0, "IndexN:=", 0, "KC2:=", 0, "PropagationState:=", "Propagating", "Attenuation:=",  _
  0, "PolarizationState:=", "TE", "AffectsRefinement:=", false), Array("NAME:Mode", "ModeNumber:=",  _
  2, "IndexM:=", 0, "IndexN:=", 0, "KC2:=", 0, "PropagationState:=", "Propagating", "Attenuation:=",  _
  0, "PolarizationState:=", "TM", "AffectsRefinement:=", false)))

Set oModule = oDesign.GetModule("BoundarySetup")
oModule.AssignFloquetPort Array("NAME:floq2","Faces:=", Array(box1_Zmax),"NumModes:=",  _
  2,"RenormalizeAllTerminals:=", true, "DoDeembed:=", false, Array("NAME:Modes", Array("NAME:Mode1", "ModeNum:=",  _
  1, "UseIntLine:=", false), Array("NAME:Mode2", "ModeNum:=", 2, "UseIntLine:=",  _
  false)), "ShowReporterFilter:=", false, "ReporterFilter:=", Array(false, false), "UseScanAngles:=",  _
  true,"Phi:=", "0deg", "Theta:=", "0deg",Array("NAME:LatticeAVector", "Start:=", Array( _
  "-5.000000mm", "-2.500000mm", "0.500000mm"), "End:=", Array("5.000000mm", "-2.500000mm", "0.500000mm")),Array("NAME:LatticeBVector", "Start:=", Array( _
  "-5.000000mm", "-2.500000mm", "0.500000mm"), "End:=", Array("-5.000000mm", "2.500000mm", "0.500000mm")),Array("NAME:ModesList", Array("NAME:Mode", "ModeNumber:=",  _
  1, "IndexM:=", 0, "IndexN:=", 0, "KC2:=", 0, "PropagationState:=", "Propagating", "Attenuation:=",  _
  0, "PolarizationState:=", "TE", "AffectsRefinement:=", false), Array("NAME:Mode", "ModeNumber:=",  _
  2, "IndexM:=", 0, "IndexN:=", 0, "KC2:=", 0, "PropagationState:=", "Propagating", "Attenuation:=",  _
  0, "PolarizationState:=", "TM", "AffectsRefinement:=", false)))
