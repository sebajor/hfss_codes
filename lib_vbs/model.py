from abc import ABC, abstractmethod
import numpy as np


"""
    This is the top layer of the HFSS design. The end goal of this class is to 
    collect the actions to make to generate the final system. 
    The Action, Volume, Layer classes are all saved as actions in this incarnation.

    The final idea is to also have a python plotting translation layer, and why not
    having another translation layers to other types of software (CST, altium, kicad, 
    fusion360, etc)

"""

class hfss_vbs_model():
    def __init__(self, name):
        self.name = name 
        self.model_params = {}
        self.actions = []

    def add_model_parameter(self, name, value, unit='mm'):
        self.model_params[name] = {"value":value, "unit":unit}
        self.actions.append(action.Add_model_parameter(name, value, unit))

    def add_action(self, action):
        """
        Here the creation of 3D volumes and 2D surface are also an action that should
        be added
        """
        self.actions.append(action)

    def plot(self):
        return

    def hfss_implementation(self):
        text = 'Dim oAnsoftApp\n\
Dim oDesktop\n\
Dim oProject\n\
Dim oDesign\n\
Dim oEditor\n\
Dim oModule\n\
Set oAnsoftApp = CreateObject("AnsoftHfss.HfssScriptInterface")\n\
Set oDesktop = oAnsoftApp.GetAppDesktop()\n\
oDesktop.RestoreWindow\n\
Set oProject = oDesktop.SetActiveProject("%s")\n\
Set oDesign = oProject.SetActiveDesign("HFSSDesign1")\n\
Set oEditor = oDesign.SetActiveEditor("3D Modeler")\n'%self.name
        for action in self.actions:
            text += action.hfss_implementation(self.model_params)
        return text
