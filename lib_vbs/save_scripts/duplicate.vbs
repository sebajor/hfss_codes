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
oEditor.DuplicateAroundAxis Array("NAME:Selections", "Selections:=", "port1", "NewPartsModelFlag:=",  _
  "Model"), Array("NAME:DuplicateAroundAxisParameters", "CreateNewObjects:=", true, "WhichAxis:=",  _
  "Z", "AngleStr:=", "-45deg", "NumClones:=", "2"), Array("NAME:Options", "DuplicateAssignments:=",  _
  false)
oDesign.Undo
oEditor.DuplicateAroundAxis Array("NAME:Selections", "Selections:=", "port1", "NewPartsModelFlag:=",  _
  "Model"), Array("NAME:DuplicateAroundAxisParameters", "CreateNewObjects:=", true, "WhichAxis:=",  _
  "Z", "AngleStr:=", "-60deg", "NumClones:=", "2"), Array("NAME:Options", "DuplicateAssignments:=",  _
  false)
oEditor.Rotate Array("NAME:Selections", "Selections:=", "port1", "NewPartsModelFlag:=",  _
  "Model"), Array("NAME:RotateParameters", "RotateAxis:=", "Z", "RotateAngle:=",  _
  "-60deg")
oDesign.Undo
oEditor.DuplicateAroundAxis Array("NAME:Selections", "Selections:=", "port1", "NewPartsModelFlag:=",  _
  "Model"), Array("NAME:DuplicateAroundAxisParameters", "CreateNewObjects:=", true, "WhichAxis:=",  _
  "Z", "AngleStr:=", "-120deg", "NumClones:=", "2"), Array("NAME:Options", "DuplicateAssignments:=",  _
  false)

oEditor.DuplicateAroundAxis Array("NAME:Selections", "Selections:=", "port1", "NewPartsModelFlag:=",  _
  "Model"), Array("NAME:DuplicateAroundAxisParameters", "CreateNewObjects:=", true, "WhichAxis:=",  _
  "Z", "AngleStr:=", "-180deg", "NumClones:=", "2"), Array("NAME:Options", "DuplicateAssignments:=",  _
  false)



oEditor.Unite Array("NAME:Selections", "Selections:=",  _
  "circ,port1,port1_1,port1_2,port1_3"), Array("NAME:UniteParameters", "KeepOriginals:=",  _
  false)
oEditor.Rotate Array("NAME:Selections", "Selections:=", "circ", "NewPartsModelFlag:=",  _
  "Model"), Array("NAME:RotateParameters", "RotateAxis:=", "Z", "RotateAngle:=",  _
  "-60deg")
oProject.Save
