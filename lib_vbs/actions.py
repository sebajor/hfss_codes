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
        text = 'oDesign.ChangeProperty Array("NAME:AllTabs", Array("NAME:LocalVariableTab", Array("NAME:PropServers",  _\n\
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

