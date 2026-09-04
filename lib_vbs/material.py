


class Define_material():
    """
    Dont know if the version is to outdated, but for each material in the library 
    that I use I need to call it before using it
    """

    def __init__(self, name):
        self.name = name

    def hfss_implementation(self):
        return

    def cst_implementation(self):
        if((self.name == "FR-4 (lossy)") or (self.name=='FR4_epoxy')):
            text = 'With Material\n\
\t.Reset\n\
\t.Name "FR-4 (lossy)"\n\
\t.Folder ""\n\
\t.FrqType "all"\n\
\t.Type "Normal"\n\
\t.SetMaterialUnit "GHz", "mm"\n\
\t.Epsilon "4.3"\n\
\t.Mu "1.0"\n\
\t.Kappa "0.0"\n\
\t.TanD "0.025"\n\
\t.TanDFreq "10.0"\n\
\t.TanDGiven "True"\n\
\t.TanDModel "ConstTanD"\n\
\t.KappaM "0.0"\n\
\t.TanDM "0.0"\n\
\t.TanDMFreq "0.0"\n\
\t.TanDMGiven "False"\n\
\t.TanDMModel "ConstKappa"\n\
\t.DispModelEps "None"\n\
\t.DispModelMu "None"\n\
\t.DispersiveFittingSchemeEps "General 1st"\n\
\t.DispersiveFittingSchemeMu "General 1st"\n\
\t.UseGeneralDispersionEps "False"\n\
\t.UseGeneralDispersionMu "False"\n\
\t.Rho "0.0"\n\
\t.ThermalType "Normal"\n\
\t.ThermalConductivity "0.3"\n\
\t.SetActiveMaterial "all"\n\
\t.Colour "0.94", "0.82", "0.76"\n\
\t.Wireframe "False"\n\
\t.Transparency "0"\n\
\t.Create\n\
End With\n'
        else:
            text = ""
        return text
            







