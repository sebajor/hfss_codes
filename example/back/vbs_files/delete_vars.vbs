Set oDesktop = oAnsoftApp.GetAppDesktop()
Set oProject = oDesktop.GetActiveProject()
Set oDesign = oProject.GetActiveDesign()

' 1. FETCH & LIST ALL LOCAL VARIABLES
Dim varList, varName, msg
' GetVariables() returns an array of all local (design) variable names
varList = oDesign.GetVariables()

If UBound(varList) < 0 Then
    MsgBox "No local variables found in the active design.", 64, "HFSS Info"
    WScript.Quit
End If

' Build a list overview string 
msg = "Found Local Variables:" & vbCrLf
For Each varName In varList
    msg = msg & " - " & varName & vbCrLf
Next

' 2. DELETE ALL LOCAL VARIABLES
' HFSS manages variables through the "AllProperties" array inside ChangeProperty.
' By sending an empty "LocalVariables" tab declaration, you clear out the properties.

Dim propArgs, deleteArgs
propArgs = Array("NAME:AllTabs", _
    Array("NAME:LocalVariables", _
        Array("NAME:PropServers"), _
        Array("NAME:DeletedProps", varList) _
    ) _
)

' Execute the deletion command on the active design
oDesign.ChangeProperty propArgs

MsgBox "All local variables have been removed successfully.", 64, "Deletion Complete"
