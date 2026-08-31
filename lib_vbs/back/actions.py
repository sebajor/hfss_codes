from abc import ABC, abstractmethod
from PIL import ImageColor


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


class Rotate_object(Action):
    ##TODO: There is no track on the new positions at all after this!
    ##at this stage only hfss will know where the obj is
    ##Be carefull bcs here the order of the operations matters
    def __init__(self, obj, angle, axis="X"):
        """
        angle in deg
        """
        self.obj_name = obj.name
        self.axis = axis.upper()
        if(type(angle) is str):
            self.angle = angle
        else:
            self.angle = str(angle)+"deg"

    def hfss_implementation(self, model_params):
        text = '\noEditor.Rotate Array("NAME:Selections", "Selections:=", "%s", "NewPartsModelFlag:=",  _\n\
"Model"), Array("NAME:RotateParameters", "RotateAxis:=", "%s", "RotateAngle:=",  _\n\
"%s")\n'%(self.obj_name, self.axis, self.angle)
        return text

    def plot(self, model_params):
        return None

class Move_object(Action):
    ##TODO: how to keep track of this outside hfss!
    def __init__(self, obj, x=0, y=0, z=0, units='mm'):
        self.obj_name = obj.name
        self.offsets = [x,y,z]
        self.units = units

    def hfss_implementation(self, model_params):
        text = '\noEditor.Move Array("NAME:Selections", "Selections:=", "%s", "NewPartsModelFlag:=",  _\n\
"Model"),'%self.obj_name
        s = self.offsets[0]
        if(type(s) is not str):
            s = str(s)+self.units
        text += 'Array("NAME:TranslateParameters", "TranslateVectorX:=", "%s",'%s
        s = self.offsets[1]
        if(type(s) is not str):
            s = str(s)+self.units
        text += '"TranslateVectorY:=",  _\n\
"%s",'%s
        s = self.offsets[2]
        if(type(s) is not str):
            s = str(s)+self.units
        text += '"TranslateVectorZ:=", "%s")\n'%s
        return text

    def plot(self, model_params):
        return None

class Unite_objects(Action):
    """
    Note that the unified object will have as name the name of the first obj
    """
    def __init__(self, obj1, obj2):
        self.obj1_name = obj1.name
        self.obj2_name = obj2.name 

    def hfss_implementation(self, model_params):
        text = '\noEditor.Unite Array("NAME:Selections", "Selections:=", "%s,%s"),\
Array("NAME:UniteParameters", "KeepOriginals:=",  _\n\
false)\n'%(self.obj1_name, self.obj2_name)
        return text

    def plot(self, model_params):
        return 


class Substract_objects(Action):
    """
    Obj2 is substracted from obj1, and the ouptut name is the one of obj1
    """
    def __init__(self, obj1, obj2, keep_obj2=False):
        self.obj1_name = obj1.name 
        self.obj2_name = obj2.name
        self.keep_obj2 = keep_obj2

    def hfss_implementation(self, model_params):
        text = '\noEditor.Subtract Array("NAME:Selections", "Blank Parts:=", "%s", "Tool Parts:=",  _\n\
"%s"), Array("NAME:SubtractParameters", "KeepOriginals:=", %s)\n'%(self.obj1_name, self.obj2_name, str(self.keep_obj2).lower())
        return text

    def plot(self, model_params):
        return 


class Connect_objects(Action):
    """
    Note: the resulting objname is the one of obj1
    """
    def __init__(self, obj1, obj2):
        self.obj1_name = obj1.name
        self.obj2_name = obj2.name

    def hfss_implementation(self, model_params):
        text = '\noEditor.Connect Array("NAME:Selections", "Selections:=",  _\n\
"%s,%s")'%(self.obj1_name, self.obj2_name)
        return text
    
    def plot(self, model_params):
        return


class Generate_revolution_solid(Action):
    """
    Angle in deg!
    """
    def __init__(self, obj ,segments=0, axis="Z", angle=360):
        self.obj_name = obj.name
        self.segments = str(segments)
        self.axis = axis.upper()
        self.angle = str(angle)

    def hfss_implementation(self, model_params):
        text = '\noEditor.SweepAroundAxis Array("NAME:Selections",'
        text += '"Selections:=", "%s",'%self.obj_name
        text += '"NewPartsModelFlag:=",  _\n\
"Model"), Array("NAME:AxisSweepParameters", "DraftAngle:=", "0deg", "DraftType:=",  _\n\
"Round","CheckFaceFaceIntersection:=", false,'
        text += '"SweepAxis:=", "%s",'%self.axis
        text += '"SweepAngle:=",  _\n\
"%sdeg",'%self.angle
        text += '"NumOfSegments:=", "%s")\n'%self.segments
        return text

    def plot(self, model_params):
        return 


class Extrude_surface(Action):
    def __init__(self, obj, thickness, unit='mm'):
        self.obj_name = obj.name
        self.thick = thickness
        self.unit = unit

    def hfss_implementation(self, model_params):
        text = '\noEditor.ThickenSheet Array("NAME:Selections", "Selections:=", "%s",'%self.obj_name
        s = self.thick
        if(type(s) is not str):
            s = str(s)+self.unit
        text += '"NewPartsModelFlag:=",  _\n\
"Model"), Array("NAME:SheetThickenParameters", "Thickness:=", "%s", "BothSides:=",  _\n\
false)\n'%s
        return text

    def plot(self, model_params):
        return
  




##Change objects parameters

class Change_object_color(Action):
    def __init__(self, obj, new_color):
        self.obj_name = obj.name
        if(type(new_color) is str):
            self.new_color = ImageColor.getrgb(new_color)
        else:
            self.new_color = new_color

    def hfss_implementation(self, model_params):
        text = '\noEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:Geometry3DAttributeTab", Array("NAME:PropServers",  _\n\
"%s"), Array("NAME:ChangedProps", Array("NAME:Color", "R:=", %i, "G:=", %i, "B:=",  _\n\
%i))))\n'%(self.obj_name, self.new_color[0], self.new_color[1], self.new_color[2])
        return text

    def plot(self, model_params):
        return 


class Change_object_material(Action):
    def __init__(self, obj, material):
        self.obj_name = obj.name
        self.material = material

    def hfss_implementation(self, model_params):
        text = '\noEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:Geometry3DAttributeTab", Array("NAME:PropServers",  _\n\
"%s"),'%self.obj_name
        text += 'Array("NAME:ChangedProps", Array("NAME:Material", "Value:=", "" & Chr(34) & "%s" & Chr(34) & ""))))\n'%self.material
        return text

    def plot(self, model_params):
        return 






###
### Boundaries
###



class Set_radiation_boundary(Action):

    def __init__(self, obj):
        self.obj_name = obj.name

    def hfss_implementation(self, model_params):

        text = '\nSet oModule = oDesign.GetModule("BoundarySetup")\n'
        text += 'oModule.AssignRadiation Array("NAME:Rad1", "Objects:=", Array("%s"), "IsIncidentField:=",  _\n\
false, "IsEnforcedField:=", false, "IsFssReference:=", false, "IsForPML:=",  _\n\
false, "UseAdaptiveIE:=", false, "IncludeInPostproc:=", true)\n'%self.obj_name
        return text

    def plot(self, model_params):
        return None



class Set_lumped_port(Action):

    def __init__(self, name, surface, field_mode, units='mm', mode_num=1, resistance=50, reactance=0):
        """
        
        The field mode should is a list with two 3D points, creating a line that
        should be inside the surface..
        TODO: Check that the input parameters gives a valid object!!!
        
        """
        self.name = name
        self.surface_name = surface.name
        self.field_mode = field_mode
        self.mode_num = mode_num
        self.units = units
        self.R = resistance
        self.X = reactance

    def hfss_implementation(self, model_params):
        text = '\nSet oModule = oDesign.GetModule("BoundarySetup")\n'
        text +='\noModule.AssignLumpedPort Array("NAME:%s", "Objects:=", Array("%s"),'%(self.name, self.surface_name)
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


###
### simulation setup
###


class Create_analysis(Action):

    def __init__(self, name, freq, units="GHz" ):
        self.name = name
        self.freq = str(freq)+units

    def hfss_implementation(self, model_params):
        text = '\nSet oModule = oDesign.GetModule("AnalysisSetup")'
        text += '\noModule.InsertSetup "HfssDriven", Array("NAME:%s", "Frequency:=", "%s", "PortsOnly:=",  _\n\
false, "MaxDeltaS:=", 0.02, "UseMatrixConv:=", false, "MaximumPasses:=", 6, "MinimumPasses:=",  _\n\
1, "MinimumConvergedPasses:=", 1, "PercentRefinement:=", 30, "IsEnabled:=",  _\n\
true, "BasisOrder:=", 1, "UseIterativeSolver:=", false, "DoLambdaRefine:=",  _\n\
true, "DoMaterialLambda:=", true, "SetLambdaTarget:=", false, "Target:=",  _\n\
0.3333, "UseMaxTetIncrease:=", false, "PortAccuracy:=", 2, "UseABCOnPort:=",  _\n\
false, "SetPortMinMaxTri:=", false, "EnableSolverDomains:=", false, "SaveRadFieldsOnly:=",  _\n\
false, "SaveAnyFields:=", true, "NoAdditionalRefinementOnImport:=", false)\n'%(self.name,self.freq)
        return text

    def plot(self, model_params):
        return 


class Add_fsweep(Action):
    def __init__(self, analysis_name, start_freq, stop_freq, step_freq=0.1, units="GHz"):
        self.analysis_name = analysis_name
        self.fstart = str(start_freq)+units
        self.fstop = str(stop_freq)+units
        self.fstep = str(step_freq)+units

    def hfss_implementation(self, model_params):
        text = '\nSet oModule = oDesign.GetModule("AnalysisSetup")\n'
        text += '\noModule.InsertFrequencySweep "%s",'%self.analysis_name
        text += 'Array("NAME:Sweep", "IsEnabled:=", true, "SetupType:=",  _\n\
"LinearStep", "StartValue:=", "%s", "StopValue:=", "%s", "StepSize:=",  _\n\
"%s",'%(self.fstart, self.fstop, self.fstep)
        text += '"Type:=", "Interpolating", "SaveFields:=", false, "SaveRadFields:=",  _\n\
false, "InterpTolerance:=", 0.5, "InterpMaxSolns:=", 250, "InterpMinSolns:=",  _\n\
0, "InterpMinSubranges:=", 1, "ExtrapToDC:=", false, "InterpUseS:=", true, "InterpUsePortImped:=",  _\n\
false, "InterpUsePropConst:=", true, "UseDerivativeConvergence:=", false, "InterpDerivTolerance:=",  _\n\
0.2, "UseFullBasis:=", true, "EnforcePassivity:=", false)\n'
        return text

    def plot(self, model_params):
        return 


class Parametric_sweep(Action):
    ##TODO (?)
    def __init__(self):
        print("dont exist yet..")

    def hfss_implementation(self, model_params):
        return
    
    def plot(self, model_params):
        return


class Generate_report(Action):
    ##TODO (?)
    def __init__(self):
        print("dont exist yet..")

    def hfss_implementation(self, model_params):
        return

    def plot(self, model_params):
        return 










