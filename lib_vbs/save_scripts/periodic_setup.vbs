' ----------------------------------------------
' Script Recorded by Ansoft HFSS Version 15.0.2
' 8:59:54 PM  Aug 31, 2026
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
Set oModule = oDesign.GetModule("BoundarySetup")
oModule.AssignMaster Array("NAME:my", "Faces:=", Array(25012), Array("NAME:CoordSysVector", "Origin:=", Array( _
  "-30mm", "30mm", "-50mm"), "UPos:=", Array("30mm", "30mm", "-50mm")), "ReverseV:=",  _
  false)
oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers",  _
  "LocalVariables"), Array("NAME:NewProps", Array("NAME:phi_y", "PropType:=", "VariableProp", "UserDef:=",  _
  true, "Value:=", "0deg"))))
oModule.AssignSlave Array("NAME:sy", "Faces:=", Array(25010), Array("NAME:CoordSysVector", "Origin:=", Array( _
  "-30mm", "-30mm", "-50mm"), "UPos:=", Array("30mm", "-30mm", "-50mm")), "ReverseV:=",  _
  true, "Master:=", "my", "UseScanAngles:=", true, "Phi:=", "phi_y", "Theta:=",  _
  "0deg")
oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers",  _
  "LocalVariables"), Array("NAME:NewProps", Array("NAME:theta_y", "PropType:=",  _
  "VariableProp", "UserDef:=", true, "Value:=", "0deg"))))
oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:HfssTab", Array("NAME:PropServers",  _
  "BoundarySetup:sy"), Array("NAME:ChangedProps", Array("NAME:Theta", "Value:=", "theta_y"))))
oModule.AssignMaster Array("NAME:mx", "Faces:=", Array(25013), Array("NAME:CoordSysVector", "Origin:=", Array( _
  "30mm", "-30mm", "-50mm"), "UPos:=", Array("30mm", "30mm", "-50mm")), "ReverseV:=",  _
  true)
oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers",  _
  "LocalVariables"), Array("NAME:NewProps", Array("NAME:phi_x", "PropType:=", "VariableProp", "UserDef:=",  _
  true, "Value:=", "0"))))
oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers",  _
  "LocalVariables"), Array("NAME:NewProps", Array("NAME:theta_x", "PropType:=",  _
  "VariableProp", "UserDef:=", true, "Value:=", "0"))))
oModule.AssignSlave Array("NAME:sx", "Faces:=", Array(25011), Array("NAME:CoordSysVector", "Origin:=", Array( _
  "-30mm", "-30mm", "-50mm"), "UPos:=", Array("-30mm", "30mm", "-50mm")), "ReverseV:=",  _
  false, "Master:=", "mx", "UseScanAngles:=", true, "Phi:=", "phi_x", "Theta:=",  _
  "theta_x")
oModule.AssignWavePort Array("NAME:1", "Faces:=", Array(25008), "NumModes:=", 2, "RenormalizeAllTerminals:=",  _
  true, "UseLineModeAlignment:=", false, "DoDeembed:=", false, Array("NAME:Modes", Array("NAME:Mode1", "ModeNum:=",  _
  1, "UseIntLine:=", true, Array("NAME:IntLine", "Start:=", Array("-30mm", "30mm",  _
  "50mm"), "End:=", Array("30mm", "30mm", "50mm")), "CharImp:=", "Zpi", "AlignmentGroup:=",  _
  0), Array("NAME:Mode2", "ModeNum:=", 2, "UseIntLine:=", true, Array("NAME:IntLine", "Start:=", Array( _
  "-30mm", "30mm", "50mm"), "End:=", Array("-30mm", "-30mm", "50mm")), "CharImp:=",  _
  "Zpi", "AlignmentGroup:=", 0)), "ShowReporterFilter:=", false, "ReporterFilter:=", Array( _
  true, true), "UseAnalyticAlignment:=", false)
oModule.DeleteBoundaries Array("1")
oModule.AssignFloquetPort Array("NAME:FloquetPort1", "Faces:=", Array(25008), "NumModes:=",  _
  2, "RenormalizeAllTerminals:=", true, "DoDeembed:=", false, Array("NAME:Modes", Array("NAME:Mode1", "ModeNum:=",  _
  1, "UseIntLine:=", false), Array("NAME:Mode2", "ModeNum:=", 2, "UseIntLine:=",  _
  false)), "ShowReporterFilter:=", false, "ReporterFilter:=", Array(false, false), "UseScanAngles:=",  _
  true, "Phi:=", "phi_x", "Theta:=", "theta_x", Array("NAME:LatticeAVector", "Start:=", Array( _
  "-30mm", "30mm", "50mm"), "End:=", Array("30mm", "30mm", "50mm")), Array("NAME:LatticeBVector", "Start:=", Array( _
  "-30mm", "30mm", "50mm"), "End:=", Array("-30mm", "-30mm", "50mm")), Array("NAME:ModesList", Array("NAME:Mode", "ModeNumber:=",  _
  1, "IndexM:=", 0, "IndexN:=", 0, "KC2:=", 0, "PropagationState:=", "Propagating", "Attenuation:=",  _
  0, "PolarizationState:=", "TE", "AffectsRefinement:=", false), Array("NAME:Mode", "ModeNumber:=",  _
  2, "IndexM:=", 0, "IndexN:=", 0, "KC2:=", 0, "PropagationState:=", "Propagating", "Attenuation:=",  _
  0, "PolarizationState:=", "TM", "AffectsRefinement:=", false)))
oModule.AssignFloquetPort Array("NAME:FloquetPort2", "Faces:=", Array(25009), "NumModes:=",  _
  2, "RenormalizeAllTerminals:=", true, "DoDeembed:=", false, Array("NAME:Modes", Array("NAME:Mode1", "ModeNum:=",  _
  1, "UseIntLine:=", false), Array("NAME:Mode2", "ModeNum:=", 2, "UseIntLine:=",  _
  false)), "ShowReporterFilter:=", false, "ReporterFilter:=", Array(false, false), "UseScanAngles:=",  _
  true, "Phi:=", "phi_x", "Theta:=", "theta_x", Array("NAME:LatticeAVector", "Start:=", Array( _
  "-30mm", "30mm", "-50mm"), "End:=", Array("30mm", "30mm", "-50mm")), Array("NAME:LatticeBVector", "Start:=", Array( _
  "-30mm", "30mm", "-50mm"), "End:=", Array("-30mm", "-30mm", "-50mm")), Array("NAME:ModesList", Array("NAME:Mode", "ModeNumber:=",  _
  1, "IndexM:=", 0, "IndexN:=", 0, "KC2:=", 0, "PropagationState:=", "Propagating", "Attenuation:=",  _
  0, "PolarizationState:=", "TE", "AffectsRefinement:=", false), Array("NAME:Mode", "ModeNumber:=",  _
  2, "IndexM:=", 0, "IndexN:=", 0, "KC2:=", 0, "PropagationState:=", "Propagating", "Attenuation:=",  _
  0, "PolarizationState:=", "TM", "AffectsRefinement:=", false)))
oProject.Save
