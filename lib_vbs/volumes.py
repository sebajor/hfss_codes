from abc import ABC, abstractmethod
from PIL import ImageColor
import copy
import ipdb


"""
"""

class Volume(ABC):

    def __init__(self, name, material='vacuum', color='steelblue', units='mm', 
                 axis="Z", solve_inside=True, transparency=0):
        self.name = name
        self.material = material
        self.axis = axis
        self.color = color
        self.units = units
        self.solve_inside = solve_inside
        position = [0]*3
        rotation = [0]*3
        self.parameters = { "position": position,
                            "rotation": rotation,
                            }
        self.transparency = transparency


    def set_rotation(self,ang_x=0, ang_y=0, ang_z=0):
        rotation = [0]*3
        rotation[0] = ang_x
        rotation[1] = ang_y
        rotation[2] = ang_z
        self.parameters['rotation'] = rotation


    def set_position(self, offset_x=0, offset_y=0, offset_z=0):
        position =[0]*3
        position[0]= offset_x
        position[1]= offset_y
        position[2]= offset_z
        self.parameters['position'] = position

    def change_axis(self, new_axis):
        if(not(new_axis.upper() in ["X", "Y", "Z"])):
            raise ValueError("Set axis on Valume %s dont make sense %s"%(self.name, new_axis))
        self.axis = new_axis.upper()

    ##these are more complicated...
    @staticmethod
    def add_rotation():
        return 
    
    @staticmethod
    def add_postion_offset():
        return 

    ##these must be implemented eventually!
    @staticmethod
    def _check_variables(self, model_params):
        """
        This method should check that all the self.params are composed either by
        combinations of model parameters and numerical values expressions.
        In the meanwhile I just trust in the values that I put..
        """
        return
    
    @abstractmethod
    def hfss_implementation(self, model_params):
        raise NotImplementedError

    @abstractmethod
    def plot(self, model_params):
        raise NotImplementedError


###
### Childrens
###


class Cylinder(Volume):

    def __init__(self, name, radius, height, position=[0,0,0], 
                 units="mm",rotation=[0,0,0], axis="Z",
                 material="vacuum", color="steelblue"):

        super().__init__(name, material, color, units, axis) 
        self.set_position(offset_x=position[0], offset_y=position[1], offset_z=position[2])
        self.parameters['radius'] = radius
        self.parameters['height'] = height

    def hfss_implementation(self, model_params):
        self._check_variables(self, model_params)
        text = '\noEditor.CreateCylinder Array("NAME:CylinderParameters",'
        s = self.parameters['position'][0]
        if(type(s) is not str):
            s = str(s)+self.units
        text += '"XCenter:=", "%s", '%s
        s = self.parameters['position'][1]
        if(type(s) is not str):
            s = str(s)+self.units
        text += '"YCenter:=",  _\n\
  "%s", '%s
        s = self.parameters['position'][2]
        if(type(s) is not str):
            s = str(s)+self.units
        text += '"ZCenter:=", "%s", '%s
        s = self.parameters['radius']
        if(type(s) is not str):
            s = str(s)+self.units
        text += ' "Radius:=", "%s",'%s
        s = self.parameters['height']
        if(type(s) is not str):
            s = str(s)+self.units
        text += '"Height:=",  _\n\
  "%s",'%s
        text += '"WhichAxis:=", "%s"'%self.axis
        text += ', "NumSides:=", "0"), Array("NAME:Attributes",'
        text += '"Name:=",  _\n\
  "%s",'%self.name

        text+= '"Flags:=", "",'
        color = ImageColor.getrgb(self.color)
        text+='"Color:=", "(%i %i %i)",'%(color[0], color[1], color[2])
        text+= '"Transparency:=", %i, "PartCoordinateSystem:=",  _\n\
  "Global", "UDMId:=", "",'%self.transparency
        text+= '"MaterialValue:=", "" & Chr(34) & "%s" & Chr(34) & "",'%self.material
        text += '"SolveInside:=",  _\n\
  %s)\n'%(str(self.solve_inside).lower())
        return text


    def plot(self, model_params):
        return 






class Box(Volume):

    def __init__(self, name, x_size, y_size, z_size, position=[0,0,0], 
                 units="mm",rotation=[0,0,0], axis="Z",
                 material="vacuum", color="steelblue", solve_inside=True, transparency=0):
        super().__init__(name, material, color, units, axis, 
                         solve_inside=solve_inside,transparency=transparency) 
        self.set_position(offset_x=position[0], offset_y=position[1], offset_z=position[2])
        self.parameters['size'] = [x_size, y_size, z_size]
        
    def hfss_implementation(self, model_params):
        self._check_variables(self, model_params)
        text = '\noEditor.CreateBox Array("NAME:BoxParameters",'
        s = self.parameters['position'][0]
        if(type(s) is not str):
            s = str(s)+self.units
        text += '"XPosition:=", "%s", '%s
        s = self.parameters['position'][1]
        if(type(s) is not str):
            s = str(s)+self.units
        text += '"YPosition:=",  _\n\
  "%s", '%s
        s = self.parameters['position'][2]
        if(type(s) is not str):
            s = str(s)+self.units
        text += '"ZPosition:=", "%s", '%s

        s = self.parameters['size'][0]
        if(type(s) is not str):
            s = str(s)+self.units
        text += '"XSize:=", "%s",'%s
        s = self.parameters['size'][1]
        if(type(s) is not str):
            s = str(s)+self.units
        text += ' "YSize:=", "%s", '%s
        s = self.parameters['size'][2]
        if(type(s) is not str):
            s = str(s)+self.units
        text += '"ZSize:=",  _ \n\"%s"),'%s
        
        text += 'Array("NAME:Attributes", "Name:=", "%s",'%self.name
        text += '"Flags:=", "",' 

        color = ImageColor.getrgb(self.color)
        text += ' "Color:=",  _\n\
  "(%i %i %i)",'%(color[0], color[1], color[2])
        text += ' "Transparency:=", %i, "PartCoordinateSystem:=", "Global", "UDMId:=",  _\n\
  "",'%self.solve_inside
        text += '"MaterialValue:=", "" & Chr(34) & "%s" & Chr(34) & "",'%self.material
        text += ' "SolveInside:=",  _\n\
  %s)\n'%(str(self.solve_inside).lower())
        return text

    def plot(self, model_params):
        return 


