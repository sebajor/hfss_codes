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



output_filename = "vbs_files/srr2.vbs"

##values
dielectric_material = "FR4_epoxy"   ##e_r = 4.4
dielectric_height_value = 1.6   ##mm
dielectric_size_value = 64      ##mm

copper_height_value = 0.035

line_width_value = 1
srr_radius_value = 5

c_gap_value = 0.5
c_plate_len_value = 2
c_plate_width_value = 0.5

###
###
###

model = hfss_vbs_model("test")


line_width=  Add_model_parameter("line_width", value=line_width_value, unit='mm')
srr_radius = Add_model_parameter("srr_radius", value=srr_radius_value, unit='mm')
c_gap = Add_model_parameter("c_gap", value=c_gap_value, unit='mm')
c_plate_len = Add_model_parameter("c_plate_len", value=c_plate_len_value, unit='mm')
c_plate_width = Add_model_parameter("c_plate_width", value=c_plate_width_value, unit='mm')

model.add_action(line_width)
model.add_action(srr_radius)
model.add_action(c_gap)
model.add_action(c_plate_len)
model.add_action(c_plate_width)

###

srr = Circle('srr', srr_radius)
circ_cut = Circle('circ_cut', srr_radius-line_width)

sub1 = Substract_objects(srr, circ_cut)

model.add_action(srr)
model.add_action(circ_cut)
model.add_action(sub1)

###
### Create the gap for the capactior
rect_cut = Rectangle("rect_cut", width = srr_radius,
                 height=c_gap,
                 position=[-srr_radius, -c_gap/2, 0])


sub2 = Substract_objects(srr, rect_cut)

model.add_action(rect_cut)
model.add_action(sub2)

##This is not the best.. if the cut is to big then the rectangles will be
##far off... I should rotate them accordingly to match the circle cut.. but then
##you would loose the parallel plates structure

rect_c1 = Rectangle("rc1", width=c_plate_len,
                    height=c_plate_width,
                    position=[-srr_radius-c_plate_len/2+line_width/2, c_gap/2,0]
                    )


rect_c2 = Rectangle("rc12", width=c_plate_len,
                    height=-c_plate_width,
                    position=[-srr_radius-c_plate_len/2+line_width/2, -c_gap/2,0],
                    )

model.add_action(rect_c1)
model.add_action(rect_c2)

conn1 = Unite_objects(srr, rect_c1)
conn2 = Unite_objects(srr, rect_c2)

model.add_action(conn1)
model.add_action(conn2)





###
### Generate output file
###


text = model.hfss_implementation()

f = open(output_filename, "w")
f.write(text)
f.close()


