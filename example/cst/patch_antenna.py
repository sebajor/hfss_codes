import sys
sys.path.append("../lib_vbs")
from parameters import *
from model import *
from surfaces import *
from actions import *
from volumes import *
from material import *
from astropy import constants as cte
from astropy import units as apu

###
### Simple patch antenna
###

freq = 2.4*apu.GHz
wavel = (cte.c/freq)


output_filename = "vba_files/patch_antenna.mcs"

### values for hyper parameters
dielectric_material = "FR-4 (lossy)"   ##e_r = 4.4
dielectric_height_value = 1.6   ##mm
dielectric_size_value = 60      ##mm

copper_height_value = 0.035
patch_width_value = 30          ##these values are for 2.4
patch_length_value = 29.4

feedline_width_value = 3

###cut in the feedline insertion to match the impedance
feed_cut_x_value = 9.5
feed_cut_y_value = 5


##
## create hyperparameters

model = cst_vba_model("test")

fr4 = Define_material(dielectric_material)
model.add_action(fr4)


dielectric_height =  Add_model_parameter("dielectric_height", value=dielectric_height_value, unit='mm')
dielectric_size =  Add_model_parameter("dielectric_size", value=dielectric_size_value, unit='mm')
copper_height = Add_model_parameter("copper_height", value=copper_height_value, unit='mm')
patch_width= Add_model_parameter("patch_width", value=patch_width_value, unit='mm')
patch_length= Add_model_parameter("patch_length", value=patch_length_value, unit='mm')

feedline_width= Add_model_parameter("feedline_width", value=feedline_width_value, unit='mm')
feed_cut_x= Add_model_parameter("feed_cut_x", value=feed_cut_x_value, unit='mm')
feed_cut_y= Add_model_parameter("feed_cut_y", value=feed_cut_y_value, unit='mm')


model.add_action(dielectric_height)
model.add_action(dielectric_size)
model.add_action(copper_height)
model.add_action(patch_width)
model.add_action(patch_length)
model.add_action(feedline_width)
model.add_action(feed_cut_y)
model.add_action(feed_cut_x)


###create ground plane I place it at -line_height, then the substrate sits at z=0
gnd = Box('ground_plane', dielectric_size, dielectric_size, copper_height, 
          position=[-dielectric_size/2,-dielectric_size/2,-copper_height],
          material='PEC', solve_inside=False, color='orange')

model.add_action(gnd)

###create dielectric
dielec = Box("diel", dielectric_size, dielectric_size, dielectric_height,
             position=[-dielectric_size/2, -dielectric_size/2,0],
             material=dielectric_material, transparency=0)

model.add_action(dielec)

###add the patch at the center
patch = Box('patch', patch_width, patch_length, copper_height,
            position=[-patch_width/2, -patch_length/2, dielectric_height],
            material="PEC", solve_inside=False, color='orange'
            )
model.add_action(patch)


###add the feed.. here we just let the boxes to collide
feedline = Box("feedline", -dielectric_size/2, feedline_width, copper_height,
                position=[dielectric_size/2, -feedline_width/2, dielectric_height],
                material="PEC", solve_inside=False, color='orange')

model.add_action(feedline)

###The feedline is 50ohm at 2.4, but the patch is 250 so to match the port she wants 
## to cut a rectangle from the patch in the insertion of the feedline

feed_cut = Box("feed_cut", -feed_cut_x, feed_cut_y, copper_height,
               position=[ patch_width/2, -feed_cut_y/2 , dielectric_height],
               material="PEC", solve_inside=False, color='red')

model.add_action(feed_cut)

###
sub_patch =  Subtract_objects(patch, feed_cut)
model.add_action(sub_patch)

##unite the feedline with the patch
compose_patch = Unite_objects(patch, feedline)
model.add_action(compose_patch)

###
###TODO: simulation setup!




###
###
###

text = model.cst_implementation()

f = open(output_filename, "w")
f.write(text)
f.close()
