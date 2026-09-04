import sys
sys.path.append("../../lib_vbs")
from parameters import *
from model import *
from surfaces import *
from actions import *
from volumes import *
from material import *
from astropy import constants as cte
from astropy import units as apu


###
### 90 deg hybrid in microstrip
### there are 2 line impedances in this design one is z0 and the other one z0/sqrt(2)
###

###
### TODO: make this again but with the polyline.. then should be more cleaner
###

freq = 2.4*apu.GHz
wavel = (cte.c/freq)


output_filename = "vba_files/quad_hybrid_microstrip.vbs"


##
##As typical dont have the equations.. just the values..
##

#dielectric_material = "FR4_epoxy"   ##e_r = 4.4
dielectric_material = "FR-4 (lossy)"   ##e_r = 4.4
dielectric_height_value = 1.6   ##mm


copper_height_value = 0.035
width50_value = 3.05
length50_value  = 17.1

width35_value = 5.3
length35_value = 16.7

feedline_length_value = 10

substrate_gap_value = 3 ##some gap to have in the substrate



###
###
### 



model = cst_vba_model("test")

fr4 = Define_material(dielectric_material)
model.add_action(fr4)

dielectric_height =  Add_model_parameter("dielectric_height", value=dielectric_height_value, unit='mm')
copper_height = Add_model_parameter("copper_height", value=copper_height_value, unit='mm')
width50 = Add_model_parameter("width50", value=width50_value, unit='mm')
length50 = Add_model_parameter("length50", value=length50_value, unit='mm')

width35 = Add_model_parameter("width35", value=width35_value, unit='mm')
length35 = Add_model_parameter("length35", value=length35_value, unit='mm')

feedline_length = Add_model_parameter("feedline_length", value=feedline_length_value, unit='mm')
substrate_gap = Add_model_parameter("substrate_gap", value=substrate_gap_value, unit='mm')

model.add_action(dielectric_height)
model.add_action(copper_height)
model.add_action(width50)
model.add_action(length50)
model.add_action(width35)
model.add_action(length35)
model.add_action(feedline_length)
model.add_action(substrate_gap)



##ground plane
#dielectric_width = "length35+2*width50+2*feedline_length"
dielectric_width = length35+2*(feedline_length-width50)
dielectric_length = length50+2*width35+2*substrate_gap

gnd = Box('ground_plane',dielectric_width, dielectric_length, copper_height, 
          position=[-(dielectric_width)/2,-(dielectric_length)/2,-copper_height],
          material='PEC', solve_inside=False, color='orange')

model.add_action(gnd)


##substrate
diel = Box('diel',dielectric_width, dielectric_length, dielectric_height, 
          position=[-(dielectric_width)/2,-(dielectric_length)/2,0],
          material=dielectric_material)

model.add_action(diel)


##There are two ways to do this.. with a box that cut the other one in the good amount
##but this is not very intuitive.. 
## I will build the microstrip lines one by one since its the most natural think to do


##35 ohm lines
line1 = Box("line1", length35, width35, copper_height, 
            position=[-length35/2, length50/2-width50, dielectric_height],
            material="PEC", solve_inside=False, color='orange')


line2 = Box("line2", length35, -width35, copper_height, 
            position=[-length35/2, -length50/2+width50, dielectric_height],
            material="PEC", solve_inside=False, color='orange')


model.add_action(line1)
model.add_action(line2)

##50 ohm lines
line3 = Box("line3", width50, length50, copper_height, 
            position=[-length35/2, -length50/2, dielectric_height],
            material="PEC", solve_inside=False, color='orange')


line4 = Box("line4", -width50, length50, copper_height, 
            position=[length35/2, -length50/2, dielectric_height],
            material="PEC", solve_inside=False, color='orange')

model.add_action(line3)
model.add_action(line4)

##feed lines


feed1= Box("feed1", -feedline_length, -width50, copper_height, 
            position=[-length35/2+width50, length50/2, dielectric_height],
            material="PEC", solve_inside=False, color='orange')


feed2= Box("feed2", -feedline_length, width50, copper_height, 
            position=[-length35/2+width50, -length50/2, dielectric_height],
            material="PEC", solve_inside=False, color='orange')


feed3= Box("feed3", feedline_length, -width50, copper_height, 
            position=[length35/2-width50, length50/2, dielectric_height],
            material="PEC", solve_inside=False, color='orange')


feed4= Box("feed4", feedline_length, width50, copper_height, 
            position=[length35/2-width50, -length50/2, dielectric_height],
            material="PEC", solve_inside=False, color='orange')



model.add_action(feed1)
model.add_action(feed2)
model.add_action(feed3)
model.add_action(feed4)


###Ill do the transition between the feedline and the trace smoother
## for that Ill generate a triangular cut for that Ill generate a box, rotate it
# ans use it as a way to cut
#in one axis I got width50 and in the other width35-width50 -> cut width=sqrt(2*width50**2+width35**2)

##Its not that easy... since hte angle is not 45 I need to re-calculate the center and its not
## that easy... TODO: make this!, the rotation is ok, but I need to find the good center to 
##move the cut box (it should be a function of the angle generated here)

"""
angle_cut = "atan(width50/(width35-width50))"
cut_size = "sqrt(width50^2+(width35-width50)^2)"

box_cut = Box("cut", cut_size, cut_size, "copper_height",
              position=["-("+cut_size+")/2", "-("+cut_size+")/2", "dielectric_height"],
              color='red')

rot_cut = Rotate_object(box_cut, angle_cut, axis="Z")
mov_cut = Move_object(box_cut, x="length35/2", y="length50/2+(width35-width50)")

model.add_action(box_cut)
model.add_action(rot_cut)
model.add_action(mov_cut)
"""


##compose the lines and feed lines in one 
comp1 = Unite_objects(line1,line2)
comp2 = Unite_objects(line1,line3)
comp3 = Unite_objects(line1,line4)
comp4 = Unite_objects(line1,feed1)
comp5 = Unite_objects(line1,feed2)
comp6 = Unite_objects(line1,feed3)
comp7 = Unite_objects(line1,feed4)

model.add_action(comp1)
model.add_action(comp2)
model.add_action(comp3)
model.add_action(comp4)
model.add_action(comp5)
model.add_action(comp6)
model.add_action(comp7)


###
### TODO: make the sim setup!
### 


###
### Generate output file
###


text = model.cst_implementation()

f = open(output_filename, "w")
f.write(text)
f.close()






