Sub Main ()
Component.New "component1"
With Material
	.Reset
	.Name "FR-4 (lossy)"
	.Folder ""
	.FrqType "all"
	.Type "Normal"
	.SetMaterialUnit "GHz", "mm"
	.Epsilon "4.3"
	.Mu "1.0"
	.Kappa "0.0"
	.TanD "0.025"
	.TanDFreq "10.0"
	.TanDGiven "True"
	.TanDModel "ConstTanD"
	.KappaM "0.0"
	.TanDM "0.0"
	.TanDMFreq "0.0"
	.TanDMGiven "False"
	.TanDMModel "ConstKappa"
	.DispModelEps "None"
	.DispModelMu "None"
	.DispersiveFittingSchemeEps "General 1st"
	.DispersiveFittingSchemeMu "General 1st"
	.UseGeneralDispersionEps "False"
	.UseGeneralDispersionMu "False"
	.Rho "0.0"
	.ThermalType "Normal"
	.ThermalConductivity "0.3"
	.SetActiveMaterial "all"
	.Colour "0.94", "0.82", "0.76"
	.Wireframe "False"
	.Transparency "0"
	.Create
End With

StoreDoubleParameter("dielectric_height", 1.6)

StoreDoubleParameter("copper_height", 0.035)

StoreDoubleParameter("width50", 3.05)

StoreDoubleParameter("length50", 17.1)

StoreDoubleParameter("width35", 5.3)

StoreDoubleParameter("length35", 16.7)

StoreDoubleParameter("feedline_length", 10)

StoreDoubleParameter("substrate_gap", 3)

With Brick
	.Reset
	.Name "ground_plane"
	.Component "component1"
	.Material "PEC"
	.Xrange "((-(length35+(2*(feedline_length-width50))))/2)", "(((-(length35+(2*(feedline_length-width50))))/2)+(length35+(2*(feedline_length-width50))))"
	.Yrange "((-((length50+(2*width35))+(2*substrate_gap)))/2)", "(((-((length50+(2*width35))+(2*substrate_gap)))/2)+((length50+(2*width35))+(2*substrate_gap)))"
	.Zrange "(-copper_height)", "((-copper_height)+copper_height)"
	.Create
End With
Solid.SetUseIndividualColor "component1:ground_plane", 1
Solid.ChangeIndividualColor "component1:ground_plane", "255", "165", "0"

With Brick
	.Reset
	.Name "diel"
	.Component "component1"
	.Material "FR-4 (lossy)"
	.Xrange "((-(length35+(2*(feedline_length-width50))))/2)", "(((-(length35+(2*(feedline_length-width50))))/2)+(length35+(2*(feedline_length-width50))))"
	.Yrange "((-((length50+(2*width35))+(2*substrate_gap)))/2)", "(((-((length50+(2*width35))+(2*substrate_gap)))/2)+((length50+(2*width35))+(2*substrate_gap)))"
	.Zrange "0", "(0+dielectric_height)"
	.Create
End With
Solid.SetUseIndividualColor "component1:diel", 1
Solid.ChangeIndividualColor "component1:diel", "70", "130", "180"

With Brick
	.Reset
	.Name "line1"
	.Component "component1"
	.Material "PEC"
	.Xrange "((-length35)/2)", "(((-length35)/2)+length35)"
	.Yrange "((length50/2)-width50)", "(((length50/2)-width50)+width35)"
	.Zrange "dielectric_height", "(dielectric_height+copper_height)"
	.Create
End With
Solid.SetUseIndividualColor "component1:line1", 1
Solid.ChangeIndividualColor "component1:line1", "255", "165", "0"

With Brick
	.Reset
	.Name "line2"
	.Component "component1"
	.Material "PEC"
	.Xrange "((-length35)/2)", "(((-length35)/2)+length35)"
	.Yrange "(((-length50)/2)+width50)", "((((-length50)/2)+width50)+(-width35))"
	.Zrange "dielectric_height", "(dielectric_height+copper_height)"
	.Create
End With
Solid.SetUseIndividualColor "component1:line2", 1
Solid.ChangeIndividualColor "component1:line2", "255", "165", "0"

With Brick
	.Reset
	.Name "line3"
	.Component "component1"
	.Material "PEC"
	.Xrange "((-length35)/2)", "(((-length35)/2)+width50)"
	.Yrange "((-length50)/2)", "(((-length50)/2)+length50)"
	.Zrange "dielectric_height", "(dielectric_height+copper_height)"
	.Create
End With
Solid.SetUseIndividualColor "component1:line3", 1
Solid.ChangeIndividualColor "component1:line3", "255", "165", "0"

With Brick
	.Reset
	.Name "line4"
	.Component "component1"
	.Material "PEC"
	.Xrange "(length35/2)", "((length35/2)+(-width50))"
	.Yrange "((-length50)/2)", "(((-length50)/2)+length50)"
	.Zrange "dielectric_height", "(dielectric_height+copper_height)"
	.Create
End With
Solid.SetUseIndividualColor "component1:line4", 1
Solid.ChangeIndividualColor "component1:line4", "255", "165", "0"

With Brick
	.Reset
	.Name "feed1"
	.Component "component1"
	.Material "PEC"
	.Xrange "(((-length35)/2)+width50)", "((((-length35)/2)+width50)+(-feedline_length))"
	.Yrange "(length50/2)", "((length50/2)+(-width50))"
	.Zrange "dielectric_height", "(dielectric_height+copper_height)"
	.Create
End With
Solid.SetUseIndividualColor "component1:feed1", 1
Solid.ChangeIndividualColor "component1:feed1", "255", "165", "0"

With Brick
	.Reset
	.Name "feed2"
	.Component "component1"
	.Material "PEC"
	.Xrange "(((-length35)/2)+width50)", "((((-length35)/2)+width50)+(-feedline_length))"
	.Yrange "((-length50)/2)", "(((-length50)/2)+width50)"
	.Zrange "dielectric_height", "(dielectric_height+copper_height)"
	.Create
End With
Solid.SetUseIndividualColor "component1:feed2", 1
Solid.ChangeIndividualColor "component1:feed2", "255", "165", "0"

With Brick
	.Reset
	.Name "feed3"
	.Component "component1"
	.Material "PEC"
	.Xrange "((length35/2)-width50)", "(((length35/2)-width50)+feedline_length)"
	.Yrange "(length50/2)", "((length50/2)+(-width50))"
	.Zrange "dielectric_height", "(dielectric_height+copper_height)"
	.Create
End With
Solid.SetUseIndividualColor "component1:feed3", 1
Solid.ChangeIndividualColor "component1:feed3", "255", "165", "0"

With Brick
	.Reset
	.Name "feed4"
	.Component "component1"
	.Material "PEC"
	.Xrange "((length35/2)-width50)", "(((length35/2)-width50)+feedline_length)"
	.Yrange "((-length50)/2)", "(((-length50)/2)+width50)"
	.Zrange "dielectric_height", "(dielectric_height+copper_height)"
	.Create
End With
Solid.SetUseIndividualColor "component1:feed4", 1
Solid.ChangeIndividualColor "component1:feed4", "255", "165", "0"

Solid.Add "component1:line1", "component1:line2"

Solid.Add "component1:line1", "component1:line3"

Solid.Add "component1:line1", "component1:line4"

Solid.Add "component1:line1", "component1:feed1"

Solid.Add "component1:line1", "component1:feed2"

Solid.Add "component1:line1", "component1:feed3"

Solid.Add "component1:line1", "component1:feed4"

End Sub