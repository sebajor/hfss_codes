from abc import ABC, abstractmethod



class Lines(ABC):

    def __init__(self,name, units="mm",
                 material=None, color=None,):
        self.name = name
        self.units = units

    @abstractmethod
    def hfss_implementation(self, model_params):
        raise NotImplementedError

    def plot(self, model_params):
        raise NotImplementedError

###
### Childrens
###

class Equation_curve(Lines):
    """
    Sadly you need to give the equation as string
    the parameter has to be _t
    """

    def __init__(self, name, units='mm',
            x_function="0",
            y_function="0",
            z_function="0",
            start_t=0,
            stop_t=0,
            points=0
                ):
        super().__init__(name, units)
        self.x_function = x_function
        self.y_function = y_function
        self.z_function = z_function
        self.start_t = str(start_t)
        self.stop_t = str(stop_t)
        self.pts = str(points)


    def hfss_implementation(self, model_params):
        text = '\noEditor.CreateEquationCurve Array("NAME:EquationBasedCurveParameters",'
        text += '"XtFunction:=",  _\n\
"(%s)*1%s",'%(self.x_function, self.units)
        text += '"YtFunction:=", "(%s)*1%s",'%(self.y_function, self.units)
        text += '"ZtFunction:=", "(%s)*1%s",'%(self.z_function, self.units)
        text += '"tStart:=",  _\n\
"%s",'%(self.start_t)
        text += '"tEnd:=", "%s",'%self.stop_t
        text += '"NumOfPointsOnCurve:=", "%s",'%self.pts
        text += '"Version:=", 1, Array("NAME:PolylineXSection", "XSectionType:=",  _\n\
"None", "XSectionOrient:=", "Auto", "XSectionWidth:=", "0", "XSectionTopWidth:=",  _\n\
"0", "XSectionHeight:=", "0", "XSectionNumSegments:=", "0", "XSectionBendType:=",  _\n\
"Corner")), Array("NAME:Attributes", "Name:=", "%s", "Flags:=", "", "Color:=",  _\n\
"(132 132 193)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", "UDMId:=",  _\n\
"", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "", "SolveInside:=",  _\n\
true)\n'%(self.name)
        return text

    def plot(self,model_params):
        return 


class Polycurve(Lines):
    ##TOOD!! I think this one is the most interesting for my application so I
    ### should take the time to implement correctly the plotting functionality
    ##
    def __init__(self, name, units=''):
        super().__init__(self)

    def hfss_implementation(self, model_params):
        return 

    def plot(self, model_params):
        return 
