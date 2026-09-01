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
import matplotlib.pyplot as plt

###
### Split ring resonator type 1
###

### Note: the radiation box should be of the size of the substrate and 6lambda of height
### Also for this simulations we need to use floquet ports

##then I need to set also the boundary conditions on the radiation faces,
## there you can also play with the angle of incidence of the wave
##https://www.youtube.com/watch?v=KzO-wWwogTo




output_filename = "vbs_files/srr1.vbs"


##values
dielectric_material = "FR4_epoxy"   ##e_r = 4.4
dielectric_height_value = 1.6   ##mm
dielectric_size_value = 64      ##mm

copper_height_value = 0.035

srr_len_value= 40
srr_width_value = 48
line_width_value = 4

c_line_width_value = 4  ##this is the width of the central line
c_plate_len_value = 18  ##len of the plates
c_plate_width_value = 4       ##widht of the trace
c_gap_value = 2

####
####
####
model = hfss_vbs_model("test")


srr_len =  Add_model_parameter("srr_len", value=srr_len_value, unit='mm')
srr_width =  Add_model_parameter("srr_width", value=srr_width_value, unit='mm')
line_width = Add_model_parameter("line_width", value=line_width_value, unit='mm')
c_line_width = Add_model_parameter("c_line_width", value=c_line_width_value, unit='mm')
c_plate_len = Add_model_parameter("c_plate_len", value=c_plate_len_value, unit='mm')
c_plate_width = Add_model_parameter("c_plate_width", value=c_plate_width_value, unit='mm')
c_gap = Add_model_parameter("c_gap", value=c_gap_value, unit='mm')
copper_height = Add_model_parameter("copper_height", value=copper_height_value, unit='mm')

dielectric_size = Add_model_parameter("dielectric_size", value=dielectric_size_value, unit="mm")
dielectric_height= Add_model_parameter("dielectric_height", value=dielectric_height_value, unit="mm")



model.add_action(srr_len)
model.add_action(srr_width)
model.add_action(line_width)
model.add_action(c_line_width)
model.add_action(c_plate_len)
model.add_action(c_plate_width)
model.add_action(c_gap)

model.add_action(copper_height)
model.add_action(dielectric_size)
model.add_action(dielectric_height)


###Ill draw the inner area and then substract it from a full rectangle
points = [[-srr_width/2+line_width,     -srr_len/2+line_width],
          [-srr_width/2+line_width,     srr_len/2-line_width],
          [-c_line_width/2,             srr_len/2-line_width],
          [-c_line_width/2,             c_gap/2+c_plate_width],
          [-c_plate_len/2,              c_gap/2+c_plate_width],
          [-c_plate_len/2,              c_gap/2],
          [c_plate_len/2,               c_gap/2],
          [c_plate_len/2,               c_gap/2+c_plate_width],
          [c_plate_width/2,             c_gap/2+c_plate_width],
          [c_plate_width/2,             srr_len/2-line_width],
          [srr_width/2-line_width,      srr_len/2-line_width],
          [srr_width/2-line_width,      -srr_len/2+line_width],
          [c_line_width/2,              -srr_len/2+line_width],
          [c_line_width/2,              -c_gap/2-c_plate_width],
          [c_plate_len/2,               -c_gap/2-c_plate_width],
          [c_plate_len/2,               -c_gap/2],
          [-c_plate_len/2,              -c_gap/2],
          [-c_plate_len/2,              -c_gap/2-c_plate_width],
          [-c_line_width/2,             -c_gap/2-c_plate_width],
          [-c_line_width/2,             -srr_len/2+line_width],
          [-srr_width/2+line_width,     -srr_len/2+line_width]  ##dont know if I need to add this point
          ]


interior_curve = Polycurve_plane("srr_interior", points, plane_offset=copper_height, closed=True)

srr = Polycurve_plane("srr_closed", [[-srr_width/2,-srr_len/2],
                                               [-srr_width/2,srr_len/2],
                                               [srr_width/2, srr_len/2],
                                               [srr_width/2, -srr_len/2],
                                               [-srr_width/2, -srr_len/2]],
                                 closed=True,
                                 plane_offset=copper_height
                                  )

#interior_curve.plot()
#exterior_curve.plot()
#plt.show()

model.add_action(interior_curve)
model.add_action(srr)

sub = Substract_objects(srr, interior_curve)
model.add_action(sub)

#extrude the resulting plane
extruction = Extrude_surface(srr, copper_height)
model.add_action(extruction)

color_change = Change_object_color(srr, "orange")
material_change = Change_object_material(srr, "pec")

model.add_action(color_change)
model.add_action(material_change)


##add dielectric
diel = Box("substrate", dielectric_size, dielectric_size, dielectric_height,
           position=[-dielectric_size/2, -dielectric_size/2, -dielectric_height],
           material=dielectric_material, color='green', transparency=0
           )

model.add_action(diel)






#dielectric_height =  Add_model_parameter("dielectric_height", value=dielectric_height_value, unit='mm')
#dielectric_size =  Add_model_parameter("dielectric_size", value=dielectric_size_value, unit='mm')



###
### Generate output file
###


text = model.hfss_implementation()

f = open(output_filename, "w")
f.write(text)
f.close()


