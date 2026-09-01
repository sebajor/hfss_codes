from abc import ABC, abstractmethod
from PIL import ImageColor
from parameters import Expression


class Action(ABC):
    """
    Parent class
    """
    def __init__(self, units='mm'):
        self.units = units

    @abstractmethod
    def hfss_implementation(self):
        raise NotImplementedError

    @abstractmethod
    def plot(self):
        raise NotImplementedError

    def _hfss_value(self, value, units=None):
        """
        """
        if isinstance(value, Expression):
            return value.name

        if units is None:
            units = self.units

        return f"{value}{units}"


class Rotate_object(Action):

    def __init__(self, obj, angle, axis="Z", units='deg'):
        super.__init__()
        self.obj_name = obj.aname
        self.axis = axis.upper()
        self.angle = angle
        self.units = units

    def hfss_implementation(self):
        text = '\noEditor.Rotate Array("NAME:Selections", "Selections:=", "%s", "NewPartsModelFlag:=",  _\n\
"Model"), Array("NAME:RotateParameters", "RotateAxis:=", "%s", "RotateAngle:=",  _\n\
"%s")\n'%(self.obj_name, self.axis, self._hfss_value(self.angle))
        return text

    def plot(self):
        return None


class Move_object(Action):
    def __init__(self, obj, x=0, y=0, z=0, units='mm'):
        super.__init__()
        self.obj_name = obj.name
        self.offsets = [x,y,z]
        self.units = units

    def hfss_implementation(self):
        text = '\noEditor.Move Array("NAME:Selections", "Selections:=", "%s", "NewPartsModelFlag:=",  _\n\
"Model"),'%self.obj_name
        text += 'Array("NAME:TranslateParameters", "TranslateVectorX:=", "%s",'%self._hfss_value(self.ofssets[0])
        text += '"TranslateVectorY:=",  _\n\
"%s",'%self._hfss_value(self.offsets[1])
        text += '"TranslateVectorZ:=", "%s")\n'%self._hfss_value(self.ofssets[2])
        return text

    def plot(self):
        return 

class Unite_objects(Action):
    """
    Note that the unified object will have as name the name of the first obj
    """
    def __init__(self, obj1, obj2):
        self.obj1_name = obj1.name
        self.obj2_name = obj2.name 

    def hfss_implementation(self):
        text = '\noEditor.Unite Array("NAME:Selections", "Selections:=", "%s,%s"),\
Array("NAME:UniteParameters", "KeepOriginals:=",  _\n\
false)\n'%(self.obj1_name, self.obj2_name)
        return text

    def plot(self):
        return 


class Substract_objects(Action):
    """
    Obj2 is substracted from obj1, and the ouptut name is the one of obj1
    """
    def __init__(self, obj1, obj2, keep_obj2=False):
        self.obj1_name = obj1.name 
        self.obj2_name = obj2.name
        self.keep_obj2 = keep_obj2

    def hfss_implementation(self):
        text = '\noEditor.Subtract Array("NAME:Selections", "Blank Parts:=", "%s", "Tool Parts:=",  _\n\
"%s"), Array("NAME:SubtractParameters", "KeepOriginals:=", %s)\n'%(self.obj1_name, self.obj2_name, str(self.keep_obj2).lower())
        return text

    def plot(self):
        return 


class Connect_objects(Action):
    """
    Note: the resulting objname is the one of obj1
    """
    def __init__(self, obj1, obj2):
        self.obj1_name = obj1.name
        self.obj2_name = obj2.name

    def hfss_implementation(self):
        text = '\noEditor.Connect Array("NAME:Selections", "Selections:=",  _\n\
"%s,%s")'%(self.obj1_name, self.obj2_name)
        return text
    
    def plot(self):
        return



class Generate_revolution_solid(Action):
    """
    Angle in deg!
    """
    def __init__(self, obj ,segments=0, axis="Z", angle=360, units='deg'):
        super().__init__()
        self.obj_name = obj.name
        self.segments = segments
        self.axis = axis.upper()
        self.angle = angle
        self.units = units

    def hfss_implementation(self):
        text = '\noEditor.SweepAroundAxis Array("NAME:Selections",'
        text += '"Selections:=", "%s",'%self.obj_name
        text += '"NewPartsModelFlag:=",  _\n\
"Model"), Array("NAME:AxisSweepParameters", "DraftAngle:=", "0deg", "DraftType:=",  _\n\
"Round","CheckFaceFaceIntersection:=", false,'
        text += '"SweepAxis:=", "%s",'%self.axis
        text += '"SweepAngle:=",  _\n\
"%s",'%self._hfss_value(self.angle)
        text += '"NumOfSegments:=", "%s")\n'%self._hfss_value(self.segments)
        return text

    def plot(self):
        return


class Extrude_surface(Action):
    def __init__(self, obj, thickness, units='mm'):
        super().__init__()
        self.obj_name = obj.name
        self.thick = thickness
        self.units = units

    def hfss_implementation(self):
        text = '\noEditor.ThickenSheet Array("NAME:Selections", "Selections:=", "%s",'%self.obj_name
        text += '"NewPartsModelFlag:=",  _\n\
"Model"), Array("NAME:SheetThickenParameters", "Thickness:=", "%s", "BothSides:=",  _\n\
false)\n'%self._hfss_value(self.thick)
        return text

    def plot(self):
        return

##Change objects parameters

class Change_object_color(Action):
    def __init__(self, obj, new_color):
        self.obj_name = obj.name
        if(type(new_color) is str):
            self.new_color = ImageColor.getrgb(new_color)
        else:
            self.new_color = new_color

    def hfss_implementation(self):
        text = '\noEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:Geometry3DAttributeTab", Array("NAME:PropServers",  _\n\
"%s"), Array("NAME:ChangedProps", Array("NAME:Color", "R:=", %i, "G:=", %i, "B:=",  _\n\
%i))))\n'%(self.obj_name, self.new_color[0], self.new_color[1], self.new_color[2])
        return text

    def plot(self):
        return 


class Change_object_material(Action):
    def __init__(self, obj, material):
        self.obj_name = obj.name
        self.material = material

    def hfss_implementation(self):
        text = '\noEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:Geometry3DAttributeTab", Array("NAME:PropServers",  _\n\
"%s"),'%self.obj_name
        text += 'Array("NAME:ChangedProps", Array("NAME:Material", "Value:=", "" & Chr(34) & "%s" & Chr(34) & ""))))\n'%self.material
        return text

    def plot(self):
        return 


###
### boundaries and exitations
###

class Set_radiation_boundary(Action):

    def __init__(self, obj):
        self.obj_name = obj.name

    def hfss_implementation(self):

        text = '\nSet oModule = oDesign.GetModule("BoundarySetup")\n'
        text += 'oModule.AssignRadiation Array("NAME:Rad1", "Objects:=", Array("%s"), "IsIncidentField:=",  _\n\
false, "IsEnforcedField:=", false, "IsFssReference:=", false, "IsForPML:=",  _\n\
false, "UseAdaptiveIE:=", false, "IncludeInPostproc:=", true)\n'%self.obj_name
        return text

    def plot(self):
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

    def hfss_implementation(self):
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

    def plot(self):
        return None


class Set_floquet_port(Action):
    """
    Im lazy... just going to support 2 modes
    mode_vector is a 2 element list with the orig, dest vector
    """

    def __init__(self, name, face, 
                 mode_x_vector, mode_y_vector,
                 units = 'mm',
                 scan_phi=0, scan_theta=0,
                 scan_units='deg'
                 ):
        super().__init__()
        self.name = name
        self.face = face
        self.modes = 2
        self.scan_phi = scan_phi
        self.scan_theta = scan_theta
        self.mode_x_vector = mode_x_vector
        self.mode_y_vector = mode_y_vector
        self.scan_units = "deg"

    def hfss_implementation(self):
        modex_orig = self.mode_x_vector[0]
        modex_dest = self.mode_x_vector[1]
        modey_orig = self.mode_y_vector[0]
        modey_dest = self.mode_y_vector[1]

        text = '\nSet oModule = oDesign.GetModule("BoundarySetup")\n'
        text += 'oModule.AssignFloquetPort Array("NAME:%s",'%self.name
        text += '"Faces:=", Array(%s),'%self.face
        text += '"NumModes:=",  _\n\
  %i,'%self.modes
        text += '"RenormalizeAllTerminals:=", true, "DoDeembed:=", false, Array("NAME:Modes", Array("NAME:Mode1", "ModeNum:=",  _\n\
  1, "UseIntLine:=", false), Array("NAME:Mode2", "ModeNum:=", 2, "UseIntLine:=",  _\n\
  false)), "ShowReporterFilter:=", false, "ReporterFilter:=", Array(false, false), "UseScanAngles:=",  _\n\
  true,'
        text += '"Phi:=", "%s", "Theta:=", "%s",'%(self._hfss_value(self.scan_phi, units=self.scan_units),
                                                   self._hfss_value(self.scan_theta, units=self.scan_units))
        text += 'Array("NAME:LatticeAVector", "Start:=", Array( _\n\
  "%f%s", "%f%s", "%f%s"), "End:=", Array("%f%s", "%f%s", "%f%s")),'%(modex_orig[0], self.units,
                                                                      modex_orig[1], self.units,
                                                                      modex_orig[2], self.units,
                                                                      modex_dest[0], self.units,
                                                                      modex_dest[1], self.units, 
                                                                      modex_dest[2], self.units)
        text += 'Array("NAME:LatticeBVector", "Start:=", Array( _\n\
  "%f%s", "%f%s", "%f%s"), "End:=", Array("%f%s", "%f%s", "%f%s")),'%(modey_orig[0], self.units,
                                                                      modey_orig[1], self.units,
                                                                      modey_orig[2], self.units,
                                                                      modey_dest[0], self.units,
                                                                      modey_dest[1], self.units, 
                                                                      modey_dest[2], self.units)
        
        text +=  'Array("NAME:ModesList", Array("NAME:Mode", "ModeNumber:=",  _\n\
  1, "IndexM:=", 0, "IndexN:=", 0, "KC2:=", 0, "PropagationState:=", "Propagating", "Attenuation:=",  _\n\
  0, "PolarizationState:=", "TE", "AffectsRefinement:=", false), Array("NAME:Mode", "ModeNumber:=",  _\n\
  2, "IndexM:=", 0, "IndexN:=", 0, "KC2:=", 0, "PropagationState:=", "Propagating", "Attenuation:=",  _\n\
  0, "PolarizationState:=", "TM", "AffectsRefinement:=", false)))\n'
        return text

    def plot(self):
        return 




###
### coupled boundaries
###

class Set_master_boundary(Action):
    """
    You need to call Get_box_faces before using this one..
    direction is a len 2 list  (with numerical values!)
    """
    def __init__(self, name, face, direction, units='mm', reverse_v=False):
        self.name = name
        self.face = face
        self.direction = direction
        self.units = units
        self.reverse_v = reverse_v

    def hfss_implementation(self):
        origin = self.direction[0]
        dest = self.direction[1]
        text = '\nSet oModule = oDesign.GetModule("BoundarySetup")\n'
        text += 'oModule.AssignMaster Array("NAME:%s",'%self.name
        text += '"Faces:=", Array(%s),'%self.face
        text += 'Array("NAME:CoordSysVector", "Origin:=", Array( _\n\
"%f%s", "%f%s", "%f%s"),'%(origin[0], self.units, origin[1], self.units, 
                           origin[2], self.units)
        text += '"UPos:=", Array("%f%s", "%f%s", "%f%s")),'%(dest[0], self.units,
                                                             dest[1], self.units, 
                                                             dest[2], self.units)
        text +='"ReverseV:=",  _\n\
%s)'%(str(self.reverse_v).lower())
        return text

    def plot(self):
        return 


class Set_slave_boundary(Action):

    def __init__(self, name, master_name, face, direction, units='mm', reverse_v=False,
                 phi=0, theta=0, ang_units='deg'):
        super().__init__()
        self.name = name
        self.master_name = master_name
        self.face = face
        self.direction = direction
        self.units = units
        self.reverse_v = reverse_v  ##I think if the master is true, this should be false..
        self.phi = phi      #
        self.theta = theta
        self.ang_units = ang_units
        

    def hfss_implementation(self):
        origin = self.direction[0]
        dest = self.direction[1]
        text = '\nSet oModule = oDesign.GetModule("BoundarySetup")\n'
        text += 'oModule.AssignSlave Array("NAME:%s",'%self.name
        text += '"Faces:=", Array(%s),'%self.face
        text += 'Array("NAME:CoordSysVector", "Origin:=", Array( _\n\
  "%f%s", "%f%s", "%f%s"),'%(origin[0], self.units, origin[1], self.units,
                             origin[2], self.units)
        text += '"UPos:=", Array("%f%s", "%f%s", "%f%s")),'%(dest[0], self.units,
                                                               dest[1], self.units,
                                                               dest[2], self.units)
        text += '"ReverseV:=",  _\n\
  %s,'%(str(self.reverse_v).lower())
        text += '"Master:=", "%s",'%self.master_name
        text += '"UseScanAngles:=", true, "Phi:=", "%s",'%(self._hfss_value(self.phi, units=self.ang_units))
        text += '"Theta:=", "%s")'%self._hfss_value(self.theta, self.ang_units)
        return text

    def plot(self):
        return 





###
### simulation setup
###


class Create_analysis(Action):

    def __init__(self, name, freq, units="GHz" ):
        self.name = name
        self.freq = str(freq)+units

    def hfss_implementation(self):
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

    def plot(self):
        return 


class Add_fsweep(Action):
    def __init__(self, analysis_name, start_freq, stop_freq, step_freq=0.1, units="GHz"):
        self.analysis_name = analysis_name
        self.fstart = str(start_freq)+units
        self.fstop = str(stop_freq)+units
        self.fstep = str(step_freq)+units

    def hfss_implementation(self):
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

    def plot(self):
        return 


class Parametric_sweep(Action):
    ##TODO (?)
    def __init__(self):
        print("dont exist yet..")

    def hfss_implementation(self):
        return
    
    def plot(self):
        return


class Generate_report(Action):
    ##TODO (?)
    def __init__(self):
        print("dont exist yet..")

    def hfss_implementation(self):
        return

    def plot(self):
        return 



###
### Get parameters...
###



class Get_box_faces(Action):
    """
    The faces of the box have have a generated ID.. so we need to get the parameters
    somehow
    """
    def __init__(self, obj):
        self.obj= obj
        self.xmin = obj.position[0]
        self.xmax = obj.position[0]+obj.sizes[0]
        self.xcenter = obj.position[0]+obj.sizes[0]/2

        self.ymin = obj.position[1]
        self.ymax = obj.position[1]+obj.sizes[1]
        self.ycenter = obj.position[1]+obj.sizes[1]/2

        self.zmin = obj.position[2]
        self.zmax = obj.position[2]+obj.sizes[2]
        self.zcenter= obj.position[2]+obj.sizes[2]/2

        self.face_xmin = "%s_Xmin"%obj.name
        self.face_xmax = "%s_Xmax"%obj.name
        self.face_ymin = "%s_Ymin"%obj.name
        self.face_ymax = "%s_Ymax"%obj.name
        self.face_zmin = "%s_Zmin"%obj.name
        self.face_zmax = "%s_Zmax"%obj.name

    def hfss_implementation(self):
        prefix = self.obj.name
        text = '\n%s_Xmin = oEditor.GetFaceByPosition(Array( _\n\
    "NAME:FaceParameters", _\n\
    "BodyName:=", "%s", _\n\
    "XPosition:=", "%s", _\n\
    "YPosition:=", "%s", _\n\
    "ZPosition:=", "%s"))\n'%(self.obj.name, self.obj.name, 
                              self.obj._hfss_value(self.xmin),
                              self.obj._hfss_value(self.ycenter),
                              self.obj._hfss_value(self.zcenter))
        text += '%s_Xmax = oEditor.GetFaceByPosition(Array( _\n\
    "NAME:FaceParameters", _\n\
    "BodyName:=", "%s", _\n\
    "XPosition:=", "%s", _\n\
    "YPosition:=", "%s", _\n\
    "ZPosition:=", "%s"))\n'%(self.obj.name, self.obj.name, 
                              self.obj._hfss_value(self.xmax),
                              self.obj._hfss_value(self.ycenter),
                              self.obj._hfss_value(self.zcenter))

        text += '\n%s_Ymin = oEditor.GetFaceByPosition(Array( _\n\
    "NAME:FaceParameters", _\n\
    "BodyName:=", "%s", _\n\
    "XPosition:=", "%s", _\n\
    "YPosition:=", "%s", _\n\
    "ZPosition:=", "%s"))\n'%(self.obj.name, self.obj.name, 
                              self.obj._hfss_value(self.xcenter),
                              self.obj._hfss_value(self.ymin),
                              self.obj._hfss_value(self.zcenter))
        text += '%s_Ymax = oEditor.GetFaceByPosition(Array( _\n\
    "NAME:FaceParameters", _\n\
    "BodyName:=", "%s", _\n\
    "XPosition:=", "%s", _\n\
    "YPosition:=", "%s", _\n\
    "ZPosition:=", "%s"))\n'%(self.obj.name, self.obj.name,
                              self.obj._hfss_value(self.xcenter),
                              self.obj._hfss_value(self.ymax),
                              self.obj._hfss_value(self.zcenter))

        text += '\n%s_Zmin = oEditor.GetFaceByPosition(Array( _\n\
    "NAME:FaceParameters", _\n\
    "BodyName:=", "%s", _\n\
    "XPosition:=", "%s", _\n\
    "YPosition:=", "%s", _\n\
    "ZPosition:=", "%s"))\n'%(self.obj.name, self.obj.name,
                              self.obj._hfss_value(self.xcenter),
                              self.obj._hfss_value(self.ycenter),
                              self.obj._hfss_value(self.zmin))
        text += '%s_Zmax = oEditor.GetFaceByPosition(Array( _\n\
    "NAME:FaceParameters", _\n\
    "BodyName:=", "%s", _\n\
    "XPosition:=", "%s", _\n\
    "YPosition:=", "%s", _\n\
    "ZPosition:=", "%s"))\n'%(self.obj.name, self.obj.name,
                              self.obj._hfss_value(self.xcenter),
                              self.obj._hfss_value(self.ycenter),
                              self.obj._hfss_value(self.zmax))

        return text

    def plot(self):
        return 



