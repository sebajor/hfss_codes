# ----------------------------------------------
# Script Recorded by Ansoft HFSS Version 15.0.2
# 10:23:08 PM  Aug 26, 2026
# ----------------------------------------------
oDesktop.RestoreWindow()
oProject = oDesktop.SetActiveProject("code_debug")
oDesign = oProject.SetActiveDesign("HFSSDesign1")
oEditor = oDesign.SetActiveEditor("3D Modeler")
oEditor.CreateCylinder(
	[
		"NAME:CylinderParameters",
		"XCenter:="		, "0mm",
		"YCenter:="		, "0mm",
		"ZCenter:="		, "0mm",
		"Radius:="		, "0.4mm",
		"Height:="		, "1.2mm",
		"WhichAxis:="		, "Z",
		"NumSides:="		, "0"
	], 
	[
		"NAME:Attributes",
		"Name:="		, "Cylinder1",
		"Flags:="		, "",
		"Color:="		, "(132 132 193)",
		"Transparency:="	, 0,
		"PartCoordinateSystem:=", "Global",
		"UDMId:="		, "",
		"MaterialValue:="	, "\"vacuum\"",
		"SolveInside:="		, True
	])
oDesign.ChangeProperty(
	[
		"NAME:AllTabs",
		[
			"NAME:LocalVariableTab",
			[
				"NAME:PropServers", 
				"LocalVariables"
			],
			[
				"NAME:NewProps",
				[
					"NAME:x_pos",
					"PropType:="		, "VariableProp",
					"UserDef:="		, True,
					"Value:="		, "12mm"
				]
			]
		]
	])
oDesign.ChangeProperty(
	[
		"NAME:AllTabs",
		[
			"NAME:LocalVariableTab",
			[
				"NAME:PropServers", 
				"LocalVariables"
			],
			[
				"NAME:NewProps",
				[
					"NAME:radius",
					"PropType:="		, "VariableProp",
					"UserDef:="		, True,
					"Value:="		, "0.4mm"
				]
			]
		]
	])
oDesign.ChangeProperty(
	[
		"NAME:AllTabs",
		[
			"NAME:LocalVariableTab",
			[
				"NAME:PropServers", 
				"LocalVariables"
			],
			[
				"NAME:NewProps",
				[
					"NAME:height",
					"PropType:="		, "VariableProp",
					"UserDef:="		, True,
					"Value:="		, "1.2mm"
				]
			]
		]
	])
oEditor.ChangeProperty(
	[
		"NAME:AllTabs",
		[
			"NAME:Geometry3DCmdTab",
			[
				"NAME:PropServers", 
				"Cylinder1:CreateCylinder:1"
			],
			[
				"NAME:ChangedProps",
				[
					"NAME:Center Position",
					"X:="			, "x_pos",
					"Y:="			, "0mm",
					"Z:="			, "0mm"
				],
				[
					"NAME:Radius",
					"Value:="		, "radius"
				],
				[
					"NAME:Height",
					"Value:="		, "height"
				]
			]
		]
	])
