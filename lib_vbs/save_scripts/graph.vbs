' ----------------------------------------------
' Script Recorded by Ansoft HFSS Version 15.0.2
' 9:23:14 PM  Aug 28, 2026
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
Set oModule = oDesign.GetModule("ReportSetup")
oModule.CreateReport "XY Plot 1", "Modal Solution Data", "Rectangular Plot",  _
  "sol : Sweep", Array("Domain:=", "Sweep"), Array("Freq:=", Array("All"), "dipole_height:=", Array( _
  "Nominal"), "dipole_gap:=", Array("Nominal"), "wire_radius:=", Array("Nominal")), Array("X Component:=",  _
  "Freq", "Y Component:=", Array("dB(S(1,1))")), Array()
Set oModule = oDesign.GetModule("Optimetrics")
oModule.InsertSetup "OptiParametric", Array("NAME:ParametricSetup1", "IsEnabled:=",  _
  true, Array("NAME:ProdOptiSetupData", "SaveFields:=", false, "CopyMesh:=", false), Array("NAME:StartingPoint"), "Sim. Setups:=", Array( _
  "sol"), Array("NAME:Sweeps", Array("NAME:SweepDefinition", "Variable:=", "dipole_height", "Data:=",  _
  "LIN 4mm 6mm 0.2mm", "OffsetF1:=", false, "Synchronize:=", 0)), Array("NAME:Sweep Operations"), Array("NAME:Goals"))
