import numpy as np
from abc import ABC, abstractmethod

class HFSS_model():

    def __init__(self, name):
        self.name = name
        self.model_parameters = {}
        self.actions = []

    def add_parameter(self, name, value, unit='mm'):
        self.model_parameters[name] = {"value": value, "unit":unit}
        self.action.append(action.AddModelParameter(name, value, unit))

    def add_action(self, action):
        self.actions.append(action)

        

    def python_plot(self):
        return

    def generate_hfss_code(self):
        text = 'oDesktop.RestoreWindow()\n\
oProject = oDesktop.SetActiveProject("%s")\n\
oDesign = oProject.SetActiveDesign("HFSSDesign1")\n\
oEditor = oDesign.SetActiveEditor("3D Modeler")\n'%self.name
        for action in self.actions:
            text += action.hfss_implementation(self.model_parameters)
        return text



