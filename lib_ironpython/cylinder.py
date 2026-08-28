from volume import Volumen
from PIL import ImageColor
import numpy as np


class Cylinder(Volumen):
    """
    By default use the z axis. You can rotate though
    """

    def __init__(self, name, radius, height, material='vacuum', color='steelblue'):
        super().__init__(name, material, color)
        self.parameters['radius'] = radius
        self.parameters['height'] = height

    def check_aux(string):
        """
        Check if the string has some special characters, like * + - / or if its
        composed by two parameters.
        After separate the sub strings check if there are numbers in there
        """
        math_chars = ["*","/","+","-"]



    def _check_variables(self, model_parameters):
        for key, items in self.parameters.items():
            if(key=="units"):
                continue
            if((type(items) is int) or (type(items) is float)):
                continue
            elif(type(items) is str):
                if (items not in model_parameters.keys()):
                    raise ValueError("Cylinder %s variable %s not in model parameters"%(self.name, key))
            elif((type(items) is list) or (type(items) is np.array)):
                for it in items:
                    if((type(it) is int) or (type(it) is float)):
                        continue
                    elif(type(it) is str):
                        if (it not in model_parameters.keys()):
                            raise ValueError("Cylinder %s variable %s not in model parameters"%(self.name, key))
            else:
                raise ValueError("Cylinder %s variable %s type not supported"%(self.name, key))


    def hfss_implementation(self, model_parameters):
        #self._check_variables(model_parameters)

        text = 'oEditor.CreateCylinder(\n\
    [\n"NAME:CylinderParameters",\n'
        s = str(self.parameters['position'][0])
        if(type(self.parameters['position'][0]) is not str):
            s+= self.parameters['units']
        text += '"XCenter:="		, "%s",\n'%s

        s = str(self.parameters['position'][1])
        if(type(self.parameters['position'][1]) is not str):
            s+= self.parameters['units']
        text += '"YCenter:="		, "%s",\n'%s

        s = str(self.parameters['position'][2])
        if(type(self.parameters['position'][2]) is not str):
            s+= self.parameters['units']
        text +='"ZCenter:="		, "%s",\n'%s

        s = str(self.parameters['radius'])
        if(type(self.parameters['radius']) is not str):
            s+= self.parameters['units']
        text += '"Radius:="		, "%s",\n'%s

        s = str(self.parameters['height'])
        if(type(self.parameters['height']) is not str):
            s+= self.parameters['units']
        text += '"Height:="		, "%s",\n'%s

        text += '"WhichAxis:="		, "Z",\n\
"NumSides:="		, "0"\n\
    ],\n\
    [\n"NAME:Attributes",\n'
        text += '"Name:="		, "%s",\n'%self.name

        text += '"Flags:="		, "",\n'
        color = ImageColor.getrgb(self.color)
        text+= '"Color:="		, "(%i %i %i)",\n'%(color[0], color[1], color[2])
        text += '"Transparency:="	, 0,\n\
"PartCoordinateSystem:=", "Global",\n\
"UDMId:="		, "",\n'
        text += '"MaterialValue:="	, "\"%s\"",\n'%(self.material)
        text+= '"SolveInside:="		, True\n\
    ])\n'
        
        return text

    def _geometry_patches(self, resolution=60, params=None):
        #TODO
        return 

