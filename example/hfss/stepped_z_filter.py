import sys
sys.path.append("../lib_vbs")
from model import *
from parameters import *
from surfaces import *
from actions import *
from volumes import *
from astropy import constants as cte
from astropy import units as apu

### 
### Stepped impedance filter
### TODO: this should be a class to allow a any number for the multistage filter
### I took the values from here: https://www.youtube.com/watch?v=p_P6muNgUtc
###

freq = 3*apu.GHz
wavel = (cte.c/freq)


output_filename = "vbs_files/stepped_z_filter.vbs"


##
##As typical dont have the equations.. just the values..
##

dielectric_material = "FR4_epoxy"   ##e_r = 4.4
dielectric_height_value = 1.6   ##mm

copper_height_value = 0.035

C_width_value = 11.1   #z=20 --> common for all the C
L_width_value = 0.408  #z=120 --> common for all L

C1_len_value= 1.7       #z=20
L1_len_value= 5.46      #z=120

C2_len_value= 6.36      #z=20
L2_len_value= 7.46      #z=120

C3_len_value= 4.66      #z=20
L3_len_value= 2         #z=120

input_line_len_value = 6.18
input_line_width_value = 3      #50ohm

output_line_len_value = 6.18
output_line_width_value = 3

substrate_gap_value = 5

###
###
###

model = hfss_vbs_model("test")

dielectric_height =  Add_model_parameter("dielectric_height", value=dielectric_height_value, unit='mm')
copper_height = Add_model_parameter("copper_height", value=copper_height_value, unit='mm')

C_width= Add_model_parameter("C_width", value=C_width_value, unit='mm')
L_width= Add_model_parameter("L_width", value=L_width_value, unit='mm')


C1_len = Add_model_parameter("C1_len", value=C1_len_value, unit='mm')
L1_len = Add_model_parameter("L1_len", value=L1_len_value, unit='mm')

C2_len = Add_model_parameter("C2_len", value=C2_len_value, unit='mm')
L2_len = Add_model_parameter("L2_len", value=L2_len_value, unit='mm')

C3_len = Add_model_parameter("C3_len", value=C3_len_value, unit='mm')
L3_len = Add_model_parameter("L3_len", value=L3_len_value, unit='mm')

input_line_len = Add_model_parameter("input_line_len", value=input_line_len_value, unit='mm')
input_line_width = Add_model_parameter("input_line_width", value=input_line_width_value, unit='mm')

output_line_len = Add_model_parameter("output_line_len", value=output_line_len_value, unit='mm')
output_line_width = Add_model_parameter("output_line_width", value=output_line_width_value, unit='mm')

substrate_gap = Add_model_parameter("substrate_gap", value=substrate_gap_value, unit='mm')


model.add_action(dielectric_height)
model.add_action(copper_height)
model.add_action(C_width)
model.add_action(L_width)

model.add_action(C1_len)
model.add_action(L1_len)
model.add_action(C2_len)
model.add_action(L2_len)
model.add_action(C3_len)
model.add_action(L3_len)

model.add_action(input_line_len)
model.add_action(input_line_width)
model.add_action(output_line_len)
model.add_action(output_line_width)

model.add_action(substrate_gap)


###
###

##Ill place the gnd and the dielectric under the z=0 plane
dielectric_width = input_line_len+C1_len+L1_len+C2_len+L2_len+C3_len+L3_len+output_line_len
dielectric_len = L_width+substrate_gap


gnd = Box('ground_plane',dielectric_width, dielectric_len, copper_height, 
          position=[-dielectric_width/2,-(dielectric_len)/2,-copper_height-dielectric_height],
          material='pec', solve_inside=False, color='orange')

model.add_action(gnd)


##substrate
diel = Box('diel',dielectric_width, dielectric_len, dielectric_height, 
          position=[-(dielectric_width)/2,-(dielectric_len)/2,-dielectric_height],
          material=dielectric_material)

model.add_action(diel)

###
###
###

stages = [[input_line_len, input_line_width],
          [C1_len, C_width],
          [L1_len, L_width],
          [C2_len, C_width],
          [L2_len, L_width],
          [C3_len, C_width],
          [L3_len, L_width],
          [output_line_len, output_line_width]]

curr_pos = -(dielectric_width)/2
elements = []

for i, stage  in enumerate(stages):
    len_attr, width_attr = stage
    name = "filter_stage%i"%i
    element = Box(name, len_attr.name, width_attr.name, copper_height,
        position=[curr_pos, -(width_attr)/2, 0],
        material="pec", solve_inside=False, color='orange')
    curr_pos += len_attr
    elements.append(element)
    model.add_action(element)


for element in elements[1:]:
    comp_action = Unite_objects(elements[0], element)
    model.add_action(comp_action)


##lump port
dielectric_width_value = (input_line_len+
                          C1_len+
                          L1_len+
                          C2_len+
                          L2_len+
                          C3_len+
                          L3_len+
                          output_line_len)


rect1 = Rectangle(name='rect1', height=2*copper_height+dielectric_height,
                  width=input_line_width,
                  axis="X", transparency=0)

rect1.set_position(offset_x=-(dielectric_width)/2,
                   offset_y=-input_line_width/2,
                   offset_z=-copper_height-dielectric_height)
model.add_action(rect1)

field_dir = [[-dielectric_width.value/2, -input_line_width.value/2 , -copper_height.value-dielectric_height.value],
             [-dielectric_width.value/2, -input_line_width.value/2, copper_height.value]]

lump_port1 = Set_lumped_port("1",rect1, field_dir)
model.add_action(lump_port1) 



rect2 = Rectangle(name='rect2', height=2*copper_height+dielectric_height,
                  width=input_line_width,
                  axis="X", transparency=0)

rect2.set_position(offset_x=dielectric_width/2,
                   offset_y=-input_line_width/2,
                   offset_z=-copper_height-dielectric_height)
model.add_action(rect2)

field_dir = [[dielectric_width.value/2, -input_line_width.value/2 , -copper_height.value-dielectric_height.value],
             [dielectric_width.value/2, -input_line_width.value/2, copper_height.value]]

lump_port2 = Set_lumped_port("2",rect2, field_dir)
model.add_action(lump_port2) 





##radiation box

thumb_rule = wavel.to_value(apu.m)/4

rad_width =  dielectric_width+3*(thumb_rule)
rad_length =  dielectric_len+3*(thumb_rule)

rad_height = 2*copper_height+dielectric_height+2*(thumb_rule)

rad_box = Box("rad_box", rad_width, rad_length, rad_height, transparency=90,
            position=[
                    -(rad_width)/2,
                    -(rad_length)/2,
                    -(rad_height)/2
                ]
              )

model.add_action(rad_box)

rad = Set_radiation_boundary(rad_box)
model.add_action(rad)

##set analysis

sol = Create_analysis("sol", freq.to_value(apu.GHz), units="GHz")
fsweep = Add_fsweep(sol.name, 1, 10, 0.1, units="GHz")

model.add_action(sol)
model.add_action(fsweep)








###
### Generate output file
###


text = model.hfss_implementation()

f = open(output_filename, "w")
f.write(text)
f.close()










