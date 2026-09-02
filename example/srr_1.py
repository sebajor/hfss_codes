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


###The values are took from a paper at 1THz in um, I use them in mm so I should be 
###around 1GHz

freq = 1*apu.GHz
wavel = cte.c/freq



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

rad_thumbs_rule = wavel.to_value(apu.mm)/4

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

rad_thumbs_rule = Add_model_parameter("rad_thumbs_rule", value=rad_thumbs_rule, unit="mm")



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
model.add_action(rad_thumbs_rule)


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
###you can see the actual figure using
##interior_curve.plot()

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


##create radiation box, since we are going to use periodic boundary condition
## this should be of the same size of the dielectric.

rad_box = Box('rad_box', dielectric_size, dielectric_size, 2*rad_thumbs_rule+dielectric_height,
              position=[-dielectric_size/2, -dielectric_size/2, -rad_thumbs_rule-dielectric_height/2],
              transparency=1)

model.add_action(rad_box)

##now we set periodic boundries over the faces.. this is a mess
rad_box_faces= Get_box_faces(rad_box)
model.add_action(rad_box_faces)


direction = [[rad_box.position[0].value, rad_box.position[1].value, rad_box.position[2].value],
             [(rad_box.position[0]).value, (rad_box.position[1]+rad_box.sizes[1]).value, rad_box.position[2].value]
             ]

mx_bound = Set_master_boundary('mx', rad_box_faces.face_xmin, direction, reverse_v=False)
model.add_action(mx_bound)

##same for the slave face
direction = [[(rad_box.position[0]+rad_box.sizes[0]).value, rad_box.position[1].value, rad_box.position[2].value],
             [(rad_box.position[0]+rad_box.sizes[0]).value, (rad_box.position[1]+rad_box.sizes[1]).value, rad_box.position[2].value]
             ]
sx_bound = Set_slave_boundary('sx', mx_bound.name, rad_box_faces.face_xmax, direction=direction,
                              reverse_v=True)
model.add_action(sx_bound)

###
direction = [[rad_box.position[0].value, rad_box.position[1].value, rad_box.position[2].value],
             [(rad_box.position[0]+rad_box.sizes[0]).value, (rad_box.position[1]).value, rad_box.position[2].value]
             ]

my_bound = Set_master_boundary('my', rad_box_faces.face_ymin, direction, reverse_v=True)
model.add_action(my_bound)

direction = [[(rad_box.position[0]).value, (rad_box.position[1]+rad_box.sizes[1]).value, rad_box.position[2].value],
             [(rad_box.position[0]+rad_box.sizes[0]).value, (rad_box.position[1]+rad_box.sizes[1]).value, rad_box.position[2].value]
             ]

sy_bound = Set_slave_boundary('sy', my_bound.name, rad_box_faces.face_ymax, direction=direction,
                              reverse_v=False)

model.add_action(sy_bound)

##Add floquet port
mode_x= [[rad_box_faces.xmin.value, rad_box_faces.ymin.value, rad_box_faces.zmin.value],
         [rad_box_faces.xmax.value, rad_box_faces.ymin.value, rad_box_faces.zmin.value]]

mode_y = [[rad_box_faces.xmin.value, rad_box_faces.ymin.value, rad_box_faces.zmin.value],
          [rad_box_faces.xmin.value, rad_box_faces.ymax.value, rad_box_faces.zmin.value]]

floq1 = Set_floquet_port("floq1", rad_box_faces.face_zmin, mode_x, mode_y)
model.add_action(floq1)

##floquet2
mode_x= [[rad_box_faces.xmin.value, rad_box_faces.ymin.value, rad_box_faces.zmax.value],
         [rad_box_faces.xmax.value, rad_box_faces.ymin.value, rad_box_faces.zmax.value]]

mode_y = [[rad_box_faces.xmin.value, rad_box_faces.ymin.value, rad_box_faces.zmax.value],
          [rad_box_faces.xmin.value, rad_box_faces.ymax.value, rad_box_faces.zmax.value]]


floq2 = Set_floquet_port("floq2", rad_box_faces.face_zmax, mode_x, mode_y)
model.add_action(floq2)


##create analysis

sol = Create_analysis("sol", freq.to_value(apu.GHz), units="GHz")
fsweep = Add_fsweep(sol.name, 0.8, 4, 0.1, units="GHz")

model.add_action(sol)
model.add_action(fsweep)







###
### Generate output file
###


text = model.hfss_implementation()

f = open(output_filename, "w")
f.write(text)
f.close()


