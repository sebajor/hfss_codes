import sys
sys.path.append("../lib_vbs")
from parameters import *
from model import *
from surfaces import *
from actions import *
from volumes import *
from lines import *
from astropy import constants as cte
from astropy import units as apu


###
### ellipsoid geometry.. 
### just to show how to use the function line+ the revolution around axis
###

output_filename = "vbs_files/ellipsoid.vbs"

###
###
a_value = 1
b_value = 0.5
curve_points_value = 10
ellipsoid_thick_value = 0.005
rotation_segments_value = 12

x_funct = "a*sin(_t)"
z_funct = "-b*cos(_t)"



#
model = hfss_vbs_model("test")

a = Add_model_parameter("a", value=a_value, unit="")
b = Add_model_parameter("b", value=b_value, unit="")
curve_points = Add_model_parameter("curve_points", value=curve_points_value, unit="")
ellipsoid_thick = Add_model_parameter("ellipsoid_thick", value=ellipsoid_thick_value, unit="")
rotation_segments= Add_model_parameter("rotation_segments", value=rotation_segments_value, unit="")


model.add_action(a)
model.add_action(b)
model.add_action(curve_points)
model.add_action(ellipsoid_thick)
model.add_action(rotation_segments)

##functions, Ill do the function up to pi/4 and then rotate it around z

line1 = Equation_curve("line1",
                       x_function=x_funct,
                       z_function=z_funct,
                       start_t=0,
                       stop_t= "pi/4",
                       points=curve_points
                       )

model.add_action(line1)


##add a second line shiftted to generate a solid when rotating

line2 = Equation_curve("line2",
                       x_function=x_funct+"+ellipsoid_thick",
                       z_function=z_funct+"-ellipsoid_thick",
                       start_t=0,
                       stop_t= "pi/4",
                       points=curve_points
                       )

model.add_action(line2)

###connect objs
conn = Connect_objects(line1, line2)
model.add_action(conn)

##here line1 its a sheet

##create the revolution solid
revolve = Generate_revolution_solid(line1, 
                                    segments=rotation_segments,
                                    angle=360,
                                    axis="Z")

model.add_action(revolve)
##here line1 starts to ve volume... Ill do the 
color_change = Change_object_color(line1, "violet")
material_change = Change_object_material(line1, "pec")

model.add_action(color_change)
model.add_action(material_change)






###
### Generate output file
###


text = model.hfss_implementation()

f = open(output_filename, "w")
f.write(text)
f.close()


