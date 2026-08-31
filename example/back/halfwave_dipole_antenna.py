import sys
sys.path.append("../lib_vbs")
from model import *
from surfaces import *
from actions import *
from volumes import *
from astropy import constants as cte
from astropy import units as apu

###
###
###

freq = 2.4*apu.GHz
wavel = cte.c/freq

output_filename = "vbs_files/halfwave_dipole.vbs"

##values used for the hyperparameters
dipole_height_value = (wavel).to_value(apu.mm)/2
dipole_gap_value = (wavel).to_value(apu.mm)/100
wire_radius_value = (wavel).to_value(apu.mm)/100


###create objects
model = hfss_vbs_model("test")

dipole_height = Add_model_parameter("dipole_height", value=dipole_height_value, unit="mm")
wire_radius = Add_model_parameter("wire_radius", value=wire_radius_value, unit="mm")
dipole_gap = Add_model_parameter("dipole_gap", value=dipole_gap_value, unit="mm")

model.add_action(dipole_height)
model.add_action(dipole_gap)
model.add_action(wire_radius)

###create cylinders
upper_wire = Cylinder(name='upper_wire', radius='wire_radius', height='dipole_height/2-dipole_gap/2', 
                      material='pec', solve_inside=False)
upper_wire.set_position(offset_z="dipole_gap/2")


bottom_wire = Cylinder(name='bottom_wire', radius='wire_radius', height='-dipole_height/2+dipole_gap/2', 
                       material='pec', solve_inside=False)
bottom_wire.set_position(offset_z="-dipole_gap/2")

model.add_action(upper_wire)
model.add_action(bottom_wire)

###create lumped port
##It seems that the width is the next one in the right hand rule and the height the other one...
##so if I take Y as axis, width=Z and height=X

rect_port = Rectangle(name="rect1", width='dipole_gap', height="2*wire_radius", axis="Y") 
rect_port.set_position(offset_x="-wire_radius", offset_z="-dipole_gap/2")

###with this the rectangle should be at (-wire_radius, 0, -dipole_gap/2), (-wire_radius,0,dipole_gap/2),
###(wire_radius, 0, dipole_gap/2), (wire_radius, 0, -dipole_gap/2)
model.add_action(rect_port)

field_dir = [[0,0,-dipole_gap.value/2], [0,0,dipole_gap.value/2]]
lump_port = Set_lumped_port("1",rect_port, field_dir)

model.add_action(lump_port)

## create radiation box
rad_rule = wavel.to_value(apu.mm)/4     ##rule of thumbs

rad_width = str(2*rad_rule)+"mm"+"+2*wire_radius"
rad_height = str(2*rad_rule)+"mm"+"+dipole_height"

rad_box = Box("rad_box", rad_width, rad_width, rad_height, transparency=90,
            position=[
                    "-("+rad_width+")/2",
                    "-("+rad_width+")/2",
                    "-("+rad_height+")/2"
                ]

              )
model.add_action(rad_box)

rad = Set_radiation_boundary(rad_box)
model.add_action(rad)


###generate analysis and fsweep

sol = Create_analysis("sol", freq.to_value(apu.GHz), units="GHz")
fsweep = Add_fsweep(sol.name, 1.5, 3.5, 0.1, units="GHz")

model.add_action(sol)
model.add_action(fsweep)


###
### Generate the output file
###

text = model.hfss_implementation()

f = open(output_filename, "w")
f.write(text)
f.close()





