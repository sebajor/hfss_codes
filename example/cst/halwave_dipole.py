import sys
sys.path.append("../../lib_vbs")
from model import *
from parameters import *
from surfaces import *
from actions import *
from volumes import *
from astropy import constants as cte
from astropy import units as apu

##
##
##

freq = 2.4*apu.GHz
wavel = cte.c/freq

output_filename = "vba_files/halfwave_dipole.cst"

##values used for the hyperparameters
dipole_height_value = (wavel).to_value(apu.mm)/2
dipole_gap_value = (wavel).to_value(apu.mm)/100
wire_radius_value = (wavel).to_value(apu.mm)/100


###create objects
model = cst_vba_model("test")

dipole_height = Add_model_parameter("dipole_height", value=dipole_height_value, unit="mm")
wire_radius = Add_model_parameter("wire_radius", value=wire_radius_value, unit="mm")
dipole_gap = Add_model_parameter("dipole_gap", value=dipole_gap_value, unit="mm")

model.add_action(dipole_height)
model.add_action(dipole_gap)
model.add_action(wire_radius)


###create cylinders
upper_wire = Cylinder(name='upper_wire', radius=wire_radius, height=dipole_height/2-dipole_gap/2, 
                      material='PEC', solve_inside=False)
upper_wire.set_position(offset_z=dipole_gap/2)


bottom_wire = Cylinder(name='bottom_wire', radius=wire_radius, height=-dipole_height/2+dipole_gap/2, 
                       material='PEC', solve_inside=False)
bottom_wire.set_position(offset_z=-dipole_gap/2)

model.add_action(upper_wire)
model.add_action(bottom_wire)





###
### Generate the output file
###

text = model.cst_implementation()

f = open(output_filename, "w")
f.write(text)
f.close()



