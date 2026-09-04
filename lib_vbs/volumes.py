from abc import ABC, abstractmethod
from PIL import ImageColor
import copy
import ipdb
from parameters import Expression



class Volume(ABC):

    def __init__(self, name, material='vacuum', color='steelblue', units='mm',
                 axis='Z', solve_inside=True, transparency=0):
        self.name = name
        self.material = material
        self.axis = axis
        self.color = color
        self.units = units
        self.solve_inside = solve_inside
        self.position = [0,0,0]
        self.transparency = transparency

    def set_position(self, offset_x=0, offset_y=0, offset_z=0):
        self.position[0] = offset_x
        self.position[1] = offset_y
        self.position[2] = offset_z

    def change_axis(self, new_axis):
        if(not(new_axis.upper() in ["X", "Y", "Z"])):
            raise ValueError("Set axis on Valume %s dont make sense %s"%(self.name, new_axis))
        self.axis = new_axis.upper()

    def _hfss_value(self, value, units=None):
        """
        """
        if isinstance(value, Expression):
            return value.name

        if units is None:
            units = self.units

        return f"{value}{units}"
    
    def _cst_value(sefl, value):
        if isinstance(value, Expression):
            return value.name
        return f"{value}"


    @abstractmethod
    def hfss_implementation(self):
        raise NotImplementedError

    @abstractmethod
    def plot(self):
        raise NotImplementedError

###
### Childrens
###

class Cylinder(Volume):

    def __init__(self, name, radius, height, position=[0,0,0],
                 units="mm",rotation=[0,0,0], axis="Z",
                 material="vacuum", color="steelblue",
                 transparency=0,solve_inside = True):
        super().__init__(name, material, color, units, 
                         axis=axis, solve_inside=solve_inside, 
                         transparency=transparency)
        self.set_position(offset_x=position[0], offset_y=position[1], offset_z=position[2])
        self.radius = radius
        self.height = height

    def hfss_implementation(self):
        text = '\noEditor.CreateCylinder Array("NAME:CylinderParameters",'
        text += '"XCenter:=", "%s", '%self._hfss_value(self.position[0])
        text += '"YCenter:=",  _\n\
  "%s", '%self._hfss_value(self.position[1])
        text += '"ZCenter:=", "%s", '%self._hfss_value(self.position[2])
        text += ' "Radius:=", "%s",'%self._hfss_value(self.radius)
        text += '"Height:=",  _\n\
  "%s",'%self._hfss_value(self.height)
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

    def plot(self):
        return 

    def cst_implementation(self):
        text = '\nWith Cylinder\n\
\t.Reset\n\
\t.Name "%s"\n'%self.name
        text +='\t.Component "component1"\n'     ##no idea.. just let it
        text +='\t.Material "%s"\n'%self.material   ##be carefull here..
        text +='\t.OuterRadius "%s"\n'%self._cst_value(self.radius)
        text +='\t.InnerRadius "0.0"\n'
        text +='\t.Axis "%s"\n'%(str(self.axis).lower())
        ###Here I really believe that the names here will change depending on the 
        ##axis..
        text += '\t.Zrange "%s", "%s"\n'%(self._cst_value(self.position[2]), 
                                      self._cst_value(self.position[2]+self.height))
        text += '\t.Xcenter "%s"\n'%self._cst_value(self.position[0])
        text += '\t.Ycenter "%s"\n'%self._cst_value(self.position[1])
        text += '\t.Segments "0"\n'
        text += '\t.Create\n\
End With\n'
        ##set the color
        color = ImageColor.getrgb(self.color)
        text += 'Solid.SetUseIndividualColor "component1:%s", 1\n'%self.name
        text += 'Solid.ChangeIndividualColor "component1:%s", "%i", "%i", "%i"\n'%(self.name,
                                                                                  color[0],
                                                                                  color[1],
                                                                                  color[2])
        return text




class Box(Volume):

    def __init__(self, name, x_size, y_size, z_size, position=[0,0,0], 
                 units="mm",rotation=[0,0,0], axis="Z",
                 material="vacuum", color="steelblue", solve_inside=True, transparency=0):
        super().__init__(name, material, color, units, axis, 
                         solve_inside=solve_inside,transparency=transparency) 
        self.set_position(offset_x=position[0], offset_y=position[1], offset_z=position[2])
        self.sizes = [x_size, y_size, z_size]

    def hfss_implementation(self):
        text = '\noEditor.CreateBox Array("NAME:BoxParameters",'
        text += '"XPosition:=", "%s", '%self._hfss_value(self.position[0])
        text += '"YPosition:=",  _\n\
  "%s", '%self._hfss_value(self.position[1])
        text += '"ZPosition:=", "%s", '%self._hfss_value(self.position[2])
        text += '"XSize:=", "%s",'%self._hfss_value(self.sizes[0])
        text += ' "YSize:=", "%s", '%self._hfss_value(self.sizes[1])
        text += '"ZSize:=",  _ \n\"%s"),'%self._hfss_value(self.sizes[2])
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
    
    def plot(self):
        return 

    def cst_implementation(self):
        text ='\nWith Brick\n\
\t.Reset\n'
        text += '\t.Name "%s"\n'%self.name
        text += '\t.Component "component1"\n'
        text += '\t.Material "%s"\n'%self.material
        text += '\t.Xrange "%s", "%s"\n'%(self._cst_value(self.position[0]),
                    self._cst_value(self.position[0]+self.sizes[0]))
        text += '\t.Yrange "%s", "%s"\n'%(self._cst_value(self.position[1]),
                    self._cst_value(self.position[1]+self.sizes[1]))
        text += '\t.Zrange "%s", "%s"\n'%(self._cst_value(self.position[2]),
                    self._cst_value(self.position[2]+self.sizes[2]))
        text +='\t.Create\n\
End With\n'
        ##set the color
        color = ImageColor.getrgb(self.color)
        text += 'Solid.SetUseIndividualColor "component1:%s", 1\n'%self.name
        text += 'Solid.ChangeIndividualColor "component1:%s", "%i", "%i", "%i"\n'%(self.name,
                                                                                  color[0],
                                                                                  color[1],
                                                                                  color[2])
        return text








class Sphere(Volume):

    def __init__(self, name, position, radius, material='vaccum',
                 units='mm', color='steelblue', transparency=0,
                 solve_inside=True):

        super().__init__(name, material, color, units,
                         solve_inside=solve_inside,transparency=transparency)
        self.set_position(offset_x=position[0], offset_y=position[1], offset_z=position[2])
        self.radius = radius

    def hfss_implementation(self):
        text = 'oEditor.CreateSphere Array("NAME:SphereParameters",'
        text += '"XCenter:=", "%s",'%self._hfss_value(self.position[0])
        text += '"YCenter:=", "%s",\n' %self._hfss_value(self.position[1])
        text += '"ZCenter:=", "%s",'%self._hfss_value(self.position[2])
        text += '"Radius:=", "%s"),'%self._hfss_value(self.radius)
        text += 'Array("NAME:Attributes", "Name:=",  _\n\
"%s",'%self.name
        text += '"Flags:=", "", '
        color = ImageColor.getrgb(self.color)
        text += ' "Color:=", "(%i %i %i)",'%(color[0], color[1], color[2])

        text +=  '"Transparency:=", %i, "PartCoordinateSystem:=",  _\n\
"Global", "UDMId:=", "",'%transparency
        text += '"MaterialValue:=", "" & Chr(34) & "%s" & Chr(34) & "",'%self.amterial
        text += '"SolveInside:=",  %s)'%(str(self.solve_inside).lower())
        return text


