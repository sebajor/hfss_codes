import sys
sys.path.append("../lib_vbs")
from model import *
from surfaces import *
from actions import *
from volumes import *
from astropy import constants as cte
from astropy import units as apu


###
### Simple microstrip simulation at 5GHz.
### Just want to generate a 50ohm 90 deg microstrip.
###

freq = 5*apu.GHz
wavel = (cte.c/freq)

output_filename = "vbs_files/simple_microstrip.vbs"

### values for hyperparameters
## we took the values from an online calculator... but the pozar has the eq
## we will use FR4 that has e_r = 4.4
dielectric_height_value = 1.6   ##mm

line_width_value = 3.05     ##mm
line_length_value = 8.22*5    ##mm. this is 5 lambda
line_height_value = 0.035   ##mm

dielectric_size_value = line_length_value/2  ##mm

dielectric_material = "FR4_epoxy"

### 
model = hfss_vbs_model("test")

dielectric_height =  Add_model_parameter("dielectric_height", value=dielectric_height_value, unit='mm')
dielectric_size =  Add_model_parameter("dielectric_size", value=dielectric_size_value, unit='mm')
line_width=  Add_model_parameter("line_width", value=line_width_value, unit='mm')
line_length = Add_model_parameter("line_length", value=line_length_value, unit='mm')
line_height = Add_model_parameter("line_height", value=line_height_value, unit='mm')

model.add_action(dielectric_height)
model.add_action(dielectric_size)
model.add_action(line_width)
model.add_action(line_length)
model.add_action(line_height)



###create ground plane
gnd = Box('ground_plane', "dielectric_size", "line_length", "line_height", 
          position=["-dielectric_size/2","-line_length/2","-line_height"],
          material='pec', solve_inside=False, color='orange')

model.add_action(gnd)

###create dielectric
dielec = Box("diel", "dielectric_size", "line_length", "dielectric_height",
             position=["-dielectric_size/2", "-line_length/2",0],
             material=dielectric_material, color='blue')

model.add_action(dielec)

##create microstrip on top
micro = Box('microstrip', "line_width", "line_length", "line_height", 
          position=["-line_width/2","-line_length/2","dielectric_height"],
          material='pec', solve_inside=False, color='orange')

model.add_action(micro)


##put the lumped ports
rect1 = Rectangle(name='rect1', height="line_width", 
                  width="2*line_height+dielectric_height",
                  axis="Y", transparency=0)

rect1.set_position(offset_x="-line_width/2",
                   offset_y="line_length/2",
                   offset_z="-line_height")
model.add_action(rect1)


field_dir = [[0,line_length_value/2, -line_height_value],
             [0,line_length_value/2, line_height_value+dielectric_height_value]]


lump_port1 = Set_lumped_port("1",rect1, field_dir)
model.add_action(lump_port1)




rect2 = Rectangle(name='rect2', height="line_width", 
                  width="2*line_height+dielectric_height",
                  axis="Y")
rect2.set_position(offset_x="-line_width/2",
                   offset_y="-line_length/2",
                   offset_z="-line_height")
model.add_action(rect2)


field_dir2 = [[0,-line_length_value/2, -line_height_value],
             [0,-line_length_value/2, line_height_value+dielectric_height_value]]

lump_port2 = Set_lumped_port("2", rect2, field_dir2)
model.add_action(lump_port2)

##create radiation box
thumb_rule = wavel.to_value(apu.mm)/4
rad_width =  "dielectric_size+3*("+str(thumb_rule)+"mm)"
rad_length = "line_length+3*("+str(thumb_rule)+"mm)"
rad_height = "2*line_height+dielectric_height+2*("+str(thumb_rule)+"mm)"

rad_box = Box("rad_box", rad_width, rad_length, rad_height, transparency=90,
            position=[
                    "-("+rad_width+")/2",
                    "-("+rad_length+")/2",
                    "-("+rad_height+")/2"
                ]
              )

model.add_action(rad_box)

rad = Set_radiation_boundary(rad_box)
model.add_action(rad)


###generate analysis and fsweep

sol = Create_analysis("sol", freq.to_value(apu.GHz), units="GHz")
fsweep = Add_fsweep(sol.name, 4, 6, 0.1, units="GHz")

model.add_action(sol)
model.add_action(fsweep)




###
### Generate output file
###


text = model.hfss_implementation()

f = open(output_filename, "w")
f.write(text)
f.close()

