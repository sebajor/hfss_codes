oDesktop.RestoreWindow()
oProject = oDesktop.SetActiveProject("test")
oDesign = oProject.SetActiveDesign("HFSSDesign1")
oEditor = oDesign.SetActiveEditor("3D Modeler")
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
					"NAME:dipole_height",
					"PropType:="		, "VariableProp",
					"UserDef:="		, True,
					"Value:="		, "10.000000mm"
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
					"NAME:wire_radius",
					"PropType:="		, "VariableProp",
					"UserDef:="		, True,
					"Value:="		, "1.000000mm"
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
					"NAME:dipole_gap",
					"PropType:="		, "VariableProp",
					"UserDef:="		, True,
					"Value:="		, "1.000000mm"
				]
			]
		]
	])
oEditor.CreateCylinder(
    [
"NAME:CylinderParameters",
"XCenter:="		, "0mm",
"YCenter:="		, "0mm",
"ZCenter:="		, "-dipole_gap/2",
"Radius:="		, "wire_radius",
"Height:="		, "dipole_height/2-dipole_gap/2",
"WhichAxis:="		, "Z",
"NumSides:="		, "0"
    ],
    [
"NAME:Attributes",
"Name:="		, "upper_wire",
"Flags:="		, "",
"Color:="		, "(70 130 180)",
"Transparency:="	, 0,
"PartCoordinateSystem:=", "Global",
"UDMId:="		, "",
"MaterialValue:="	, ""vacuum"",
"SolveInside:="		, True
    ])
oEditor.CreateCylinder(
    [
"NAME:CylinderParameters",
"XCenter:="		, "0mm",
"YCenter:="		, "0mm",
"ZCenter:="		, "0mm",
"Radius:="		, "wire_radius",
"Height:="		, "-(dipole_height/2-dipole_gap/2)",
"WhichAxis:="		, "Z",
"NumSides:="		, "0"
    ],
    [
"NAME:Attributes",
"Name:="		, "upper_wire",
"Flags:="		, "",
"Color:="		, "(70 130 180)",
"Transparency:="	, 0,
"PartCoordinateSystem:=", "Global",
"UDMId:="		, "",
"MaterialValue:="	, ""vacuum"",
"SolveInside:="		, True
    ])
