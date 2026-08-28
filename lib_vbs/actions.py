from abc import ABC, abstractmethod


class Action(ABC):
    """
    Parent class
    """

    @abstractmethod
    def hfss_implementation(self, model_params):
        raise NotImplementedError

    @abstractmethod
    def plot(self, model_params):
        raise NotImplementedError




class Add_model_parameter(Action):

    def __init__(self, name, value, unit='mm'):
        self.name = name
        self.value = value
        self.unit = unit

    def hfss_implementation(self, model_params):
        text = '\noDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers",  _\n\
 "LocalVariables"), Array("NAME:NewProps", Array("NAME:%s", "PropType:=", "VariableProp", "UserDef:=",  _\n\
 true, "Value:=", "%f%s"))))\n'%(self.name, self.value, self.unit)
        return text

    def plot(self, model_params):
        return


class Rotate_obj(Action):
    ##TODO
    def __init__(self, obj, ang_x=0, ang_y=0, ang_z=0):
        self.rotations = [ang_x, ang_y, ang_z]

    def hfss_implementation(self, model_params):
        return

    def plot(self, model_params):
        return None

class Move_obj(Action):
    ##TODO
    def __init__(self, obj, x=0, y=0, z=0):
        self.rotations = [x, y, z]

    def hfss_implementation(self, model_params):
        return

    def plot(self, model_params):
        return None


class Set_radiation_boundary(Action):

    def __init__(self, obj):
        self.obj_name = obj.name

    def hfss_implementation(self, model_params):
        text = '\noModule.AssignRadiation Array("NAME:Rad1", "Objects:=", Array("%s"), "IsIncidentField:=",  _\n\
false, "IsEnforcedField:=", false, "IsFssReference:=", false, "IsForPML:=",  _\n\
false, "UseAdaptiveIE:=", false, "IncludeInPostproc:=", true)\n'%self.obj_name
        return text

    def plot(self, model_params):
        return None



class Set_lumped_port(Action):

    def __init__(self, surface, field_mode, units='mm', mode_num=1, resistance=50, reactance=0):
        """
        
        The field mode should is a list with two 3D points, creating a line that
        should be inside the surface..
        TODO: Check that the input parameters gives a valid object!!!
        
        """
        self.surface_name = surface.name
        self.field_mode = field_mode
        self.mode_num = mode_num
        self.units = units
        self.R = resistance
        self.X = reactance

    def hfss_implementation(self, model_params):
        text ='\noModule.AssignLumpedPort Array("NAME:1", "Objects:=", Array("%s"),'%self.surface_name
        text += '"RenormalizeAllTerminals:=",  _\n\
  true, "DoDeembed:=", false,'
        text += ' Array("NAME:Modes", Array("NAME:Mode1", "ModeNum:=", %i, "UseIntLine:=",  _\n\
  true,'%self.mode_num
        
        start_field = [str(x)+self.units for x in self.field_mode[0]]
        text+= 'Array("NAME:IntLine", "Start:=", Array("%s", "%s","%s"),'%(start_field[0], start_field[1], start_field[2])
        stop_field = [str(x)+self.units for x in self.field_mode[1]]
        text+= '"End:=", Array("%s", "%s","%s")),'%(stop_field[0], stop_field[1], stop_field[2])

        text += '"CharImp:=", "Zpi", "AlignmentGroup:=", 0, "RenormImp:=", "50ohm")), "ShowReporterFilter:=",  _\n\
  false, "ReporterFilter:=", Array(true),'
        text += '"FullResistance:=", "%fohm", "FullReactance:=", "%fohm")\n'%(self.R, self.X)
        return text

    def plot(self, model_params):
        return None








