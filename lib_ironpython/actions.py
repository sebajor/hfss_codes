from abc import ABC, abstractmethod


class Action(ABC):
    @abstractmethod
    def hfss_implementation(self, model_paramters):
        raise NotImplementedError
    
    @abstractmethod
    def plot(self):
        raise NotImplementedError


class AddModelParameter(Action):
    def __init__(self, name, value, unit='mm'):
        self.name = name
        self.value = value
        self.unit = unit

    def hfss_implementation(self, model_parameters):
        text = 'oDesign.ChangeProperty(\n\
	[\n\
		"NAME:AllTabs",\n\
		[\n\
			"NAME:LocalVariableTab",\n\
			[\n\
				"NAME:PropServers",\n\
				"LocalVariables"\n\
			],\n\
			[\n\
				"NAME:NewProps",\n\
				[\n\
					"NAME:%s",\n\
					"PropType:="		, "VariableProp",\n\
					"UserDef:="		, True,\n\
					"Value:="		, "%f%s"\n\
				]\n\
			]\n\
		]\n\
	])\n'%(self.name, self.value, self.unit)
        return text
    
    def plot(self):
        return None


class Rotate_Volumen(Action):
    def __init__(self, Volume, ang_x=0, ang_y=0, ang_z=0):
        self.volumen = Volumen
        self.parameters = {"rotation": [ang_x, ang_y, ang_z]}

    def hfss_implementation(self, model_parameters):
        ##TODO
        return

    def plot(self):
        return None







