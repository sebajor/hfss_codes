from abc import ABC, abstractmethod
from parameters import Expression
from PIL import ImageColor
import copy

class Surface(ABC):

    def __init__(self, name, material="vacuum", color='orange', units='mm', 
                 axis='Z', transparency=0, solve_inside=True):

        self.name = name
        self.material = material
        self.axis = axis
        self.color = color
        self.units = units
        
        self.position = [0]*3
        self.transparency = transparency
        self.solve_inside = solve_inside

    def set_position(self, offset_x=0, offset_y=0, offset_z=0):
        self.position[0]= offset_x
        self.position[1]= offset_y
        self.position[2]= offset_z

    @abstractmethod
    def hfss_implementation(self, model_params):
        raise NotImplementedError

    @abstractmethod
    def plot(self, model_params):
        raise NotImplementedError

    def _hfss_value(self, value, units=None):
        """
        """
        if isinstance(value, Expression):
            return value.name

        if units is None:
            units = self.units

        return f"{value}{units}"
    
###
### Children
###

class Rectangle(Surface):
    """
    The axis is orthogonal to where the rectangle lives!
    """


    def __init__(self, name, width, height, position=[0,0,0], 
                 units="mm",rotation=[0,0,0], axis="Z",
                 material="vacuum", color="orange", transparency=0):
        super().__init__(name, material, color, units, axis, 
                         transparency=transparency) 
        self.set_position(offset_x=position[0], offset_y=position[1], offset_z=position[2])
        self.width = width
        self.height = height

    
    def hfss_implementation(self):
        text = '\nOEditor.CreateRectangle Array("NAME:RectangleParameters", "IsCovered:=", true,'

        text += '"XStart:=",  _\n\
"%s",'%self._hfss_value(self.position[0])
        text+=' "YStart:=", "%s",'%self._hfss_value(self.position[1])
        text+=' "ZStart:=", "%s",'%self._hfss_value(self.position[2])
        text += '"Width:=", "%s",'%self._hfss_value(self.width)
        text += '"Height:=",  _\n\
"%s",'%self._hfss_value(self.height)
        text += '"WhichAxis:=", "%s"), Array("NAME:Attributes", "Name:=", "%s", "Flags:=",  _\n\
"",'%(self.axis, self.name)
        color = ImageColor.getrgb(self.color)
        text+='"Color:=", "(%i %i %i)",'%(color[0], color[1], color[2])
        text+= '"Transparency:=", %i,'%self.transparency
        text += '"PartCoordinateSystem:=",  _\n\
"Global", "UDMId:=", "", "MaterialValue:=", "" & Chr(34) & "%s" & Chr(34) & "",'%self.material
        text += '"SolveInside:=",  _\n\
%s)\n'%(str(self.solve_inside).lower())
        
        return text

    def plot(self):
        return 

