from abc import ABC, abstractmethod
from parameters import Expression
import numpy as np
import matplotlib.pyplot as plt
import ipdb

class Lines(ABC):

    def __init__(self,name, units="mm",
                 material=None, color=None,):
        self.name = name
        self.units = units
        if(material is not None):
            self.material = material

    @abstractmethod
    def hfss_implementation(self):
        raise NotImplementedError

    def plot(self):
        raise NotImplementedError

    def _hfss_value(self, value, units=None):
        """
        """
        if isinstance(value, Expression):
            return value.name

        if units is None:
            units = self.units

        return f"{value}{units}"

    def _cst_value(self, value):
        if isinstance(value, Expression):
            return value.name

        return f"{value}"


###
### Children
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


    def hfss_implementation(self):
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

    def plot(self):
        return 


class Polycurve_plane(Lines):
    """
    Points should be a list with the [x,y] points that forms the figure
    """
    def __init__(self, name, points, axis="Z", plane_offset=0, closed=False,
                 units='mm', material='vacuum'):
        super().__init__(name, units=units, material=material)
        self.points = points
        self.closed = closed
        self.plane_offset = plane_offset


    def hfss_implementation(self):
        text = '\noEditor.CreatePolyline Array("NAME:PolylineParameters", "IsPolylineCovered:=", true,'
        text += '"IsPolylineClosed:=",  _\n\
  %s, Array("NAME:PolylinePoints", _\n'%(str(self.closed).lower())
        for point in self.points:
            x,y = point
            text += ' Array("NAME:PLPoint", "X:=", "%s", "Y:=", "%s", "Z:=","%s"), _\n'%(
                self._hfss_value(x), self._hfss_value(y), self._hfss_value(self.plane_offset)
                    )
        ##need to delete the last comma..
        text = text[:-4]
        text += '), Array("NAME:PolylineSegments", _\n'
        for i in range(len(self.points)-1):
            text += 'Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", %i, "NoOfPoints:=", 2), _\n'%i
        ##need to delete the last comma..
        text = text[:-4]
        text += '), Array("NAME:PolylineXSection", "XSectionType:=", "None", "XSectionOrient:=", "Auto", "XSectionWidth:=", "0mm", _\n\
  "XSectionTopWidth:=","0mm", "XSectionHeight:=", "0mm", "XSectionNumSegments:=", "0",  _\n\
  "XSectionBendType:=", "Corner")),'
        text += 'Array("NAME:Attributes", "Name:=", "%s",'%self.name
        text += '"Flags:=", "", "Color:=",  _\n\
  "(132 132 193)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", "UDMId:=",  _\n\
  "", "MaterialValue:=", "" & Chr(34) & "vacuum" & Chr(34) & "", "SolveInside:=", true)'
        return text

    def _get_plot_values(self):
        plot_points = np.zeros((len(self.points),2))
        for i,point in enumerate(self.points):
            x,y = point
            if isinstance(x, Expression):
                x = x.value
            if isinstance(y, Expression):
                y = y.value
            plot_points[i,:] = [x,y]
        return plot_points

    def plot(self):
        plot_points = self._get_plot_values()
        plt.plot(plot_points[:,0], plot_points[:,1], '*-')

    
    def cst_implementation(self):
        curve_name = self.name
        if(self.closed):
            curve_name = "%s_curve"%self.name
        text = '\nWith Polygon\n'
        text += '\t.Reset\n'
        text += '\t.Name "%s"\n'%curve_name
        text += '\t.Curve "curve1"\n'
        text += '\t.Point "%s", "%s"\n'%(self._cst_value(self.points[0][0]),
                                         self._cst_value(self.points[0][1]))
        for i in range(1, len(self.points)):
            text += '\t.LineTo "%s", "%s"\n'%(self._cst_value(self.points[i][0]),
                                              self._cst_value(self.points[i][1]))
        text += '\t.Create\n'
        text += 'End With\n'
        if(self.closed):
            text += 'With CoverCurve\n'
            text += '\t.Reset\n'
            text += '\t.Name "%s"\n'%self.name
            text += '\t.Component "component1"\n'
            text += '\t.Material "%s"\n'%self.material
            text += '\t.Curve "curve1:%s"\n'%curve_name
            text += '\t.DeleteCurve "True"\n'
            text += '\t.Create\n'
            text += 'End With\n'
        return text



