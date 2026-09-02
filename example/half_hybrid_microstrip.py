import sys
sys.path.append("../lib_vbs")
from parameters import *
from model import *
from surfaces import *
from actions import *
from volumes import *
from astropy import constants as cte
from astropy import units as apu
import numpy as np


###
### 180 hybrid, rat-race hybrid
### 
### The idea is that the port1-port2-port3-port4 are wavel/4 away but p1 and p3 are 3wavel/4
###the inner ring is at 3/2wavel
### The impedance of the circular line should be z0*sqrt(2)

freq = 2.4*apu.GHz
wavel = (cte.c/freq)

output_filename = "vbs_files/half_hybrid_microstrip.vbs" 

##
##


dielectric_material = "FR4_epoxy"   ##e_r = 4.4
dielectric_height_value = 1.6   ##mm
dielectric_gap_value = 3

copper_height_value = 0.035

port_line_width_value = 3       ##50ohm
port_line_len_value = 8        ##this can be whatever..
circle_width_value = 1.62       #50*sqrt(2)
circle_len_value = 105        ##this one appears when imposing that the line should have a 
                                ##electrical lengtt of 6/4wavel.. These values appear in the microstrip calculator

radiation_size_value = 100      ##Im lazy with this one..
radiation_height_value = 20

circle_radius_value= circle_len_value/(2*np.pi)



###
###
###

model = hfss_vbs_model("test")

dielectric_height =  Add_model_parameter("dielectric_height", value=dielectric_height_value, unit='mm')
dielectric_gap =  Add_model_parameter("dielectric_gap", value=dielectric_gap_value, unit='mm')
copper_height = Add_model_parameter("copper_height", value=copper_height_value, unit='mm')

port_line_width = Add_model_parameter("port_line_width", value=port_line_width_value, unit='mm')
port_line_len = Add_model_parameter('port_line_len', value= port_line_len_value, unit='mm')
circle_width = Add_model_parameter("circle_width", value=circle_width_value, unit='mm')
circle_radius = Add_model_parameter("circle_radius", value=circle_radius_value, unit='mm')


radiation_size = Add_model_parameter("radiation_size", value=radiation_size_value, unit='mm')
radiation_height= Add_model_parameter("radiation_height", value=radiation_height_value, unit='mm')

model.add_action(dielectric_height)
model.add_action(dielectric_gap)
model.add_action(copper_height)
model.add_action(port_line_width)
model.add_action(port_line_len)
model.add_action(circle_width)
model.add_action(circle_radius)
model.add_action(radiation_size)
model.add_action(radiation_height)

###
###draw the ring
circ = Circle('circ', circle_radius+circle_width/2)
inner_circ = Circle('inner_circ', circle_radius-circle_width/2)

sub = Substract_objects(circ, inner_circ)

model.add_action(circ)
model.add_action(inner_circ)
model.add_action(sub)


####Add one port
port1 = Rectangle("port1", width=port_line_len,
                  height=port_line_width,
                  position=[circle_radius, -port_line_width/2,0 ])


model.add_action(port1)

##now I will copy this port each 60deg

port2 = Duplicate_object_around_axis(port1, "port2", 60, axis="Z")
port3 = Duplicate_object_around_axis(port1, "port3", 120, axis="Z")
port4 = Duplicate_object_around_axis(port1, "port4", 180, axis="Z")


model.add_action(port2)
model.add_action(port3)
model.add_action(port4)

##I will add some lines to connect the port2 and port3 

##port2 is at radius_circle+port_line) --> not really.. since its just a rotate
## rectangle there is one corner that has a bigger R than the other!..
## The expression that I put is valid only for the center of the rectangle..
## time to do some geometry...

#This one has to move an extra -rl*(1-cos(30)) since it got in the bad corner after the first adjustment
port2_loc = [(circle_radius+port_line_len)*np.cos(np.deg2rad(60))+port_line_width*(np.cos(np.deg2rad(30))/2-1),
             (circle_radius+port_line_len)*np.sin(np.deg2rad(60))-port_line_width/2*np.sin(np.deg2rad(30)),
             0]
#(circle_radius+port_line_len)*cos(asd *1deg)-port_line_width/2*cos(30deg)-(port_line_width*(1-cos(30deg))) ,(circle_radius+port_line_len)*sin(asd* 1deg)-port_line_width/2*sin(30deg) ,0mm

outline2 = Rectangle("outp2", width=port_line_width,
                     height=2*port_line_len,
                     position=port2_loc
                     )


port3_loc = [(circle_radius+port_line_len)*np.cos(np.deg2rad(120))-port_line_width/2*np.cos(np.deg2rad(30)),
             (circle_radius+port_line_len)*np.sin(np.deg2rad(120))-port_line_width/2*np.sin(np.deg2rad(30)),
             0]
#(circle_radius+port_line_len)*cos(asd *1deg)-port_line_width*(cos(30deg)/2) ,(circle_radius+port_line_len)*sin(asd* 1deg)-port_line_width/2*sin(30deg) ,0mm
outline3 = Rectangle("outp3", width=port_line_width,
                     height=2*port_line_len,
                     position=port3_loc
                     )

model.add_action(outline2)
model.add_action(outline3)

##
un1 = Unite_objects(circ, port1)
un2 = Unite_objects(circ, port2)
un3 = Unite_objects(circ, port3)
un4 = Unite_objects(circ, port4)
un5 = Unite_objects(circ, outline2)
un6 = Unite_objects(circ, outline3)

model.add_action(un1)
model.add_action(un2)
model.add_action(un3)
model.add_action(un4)
model.add_action(un5)
model.add_action(un6)


###
### put the substrate
dielectric_width = 2*circle_radius+2*port_line_len  ##check.. i think is fine
#dielectric_len = circle_radius+circle_width/2+(circle_radius+port_line_len)+2*port_line_len
dielectric_len = ((circle_radius+port_line_len)*np.sin(np.deg2rad(120))-port_line_width/2*np.sin(np.deg2rad(30))+2*port_line_len)+(circle_radius+circle_width/2)+dielectric_gap

dielec = Box("diel", dielectric_width, dielectric_len, dielectric_height,
             position=[-dielectric_width/2, 
                       -circle_radius-circle_width/2-dielectric_gap,
                       -dielectric_height],
             material=dielectric_material, transparency=0)

model.add_action(dielec)
##add ground
gnd = Rectangle("gnd", width=dielectric_width, height=dielectric_len,
                axis='Z', 
                position=[-dielectric_width/2,
                       -circle_radius-circle_width/2-dielectric_gap,
                       -dielectric_height],
                color='orange'
            )

model.add_action(gnd)

##set pec on the surfaces
pec1 = Set_PEC(gnd, "gnd_pec")
pec2 = Set_PEC(circ, "rat_race_pec")

model.add_action(pec1)
model.add_action(pec2)


##add rectangles for the lumped ports....
p1 = Rectangle('p1', width=port_line_width, 
                    height=dielectric_height,
                    axis="X",
                    position=[
                        circle_radius+port_line_len,
                        -port_line_width/2,
                        -dielectric_height
                        ],
               color='red'
               )
model.add_action(p1)

field_dir = [[(circle_radius+port_line_len).value, 0, -dielectric_height.value],
             [(circle_radius+port_line_len).value, 0, 0]]

lump_port1 = Set_lumped_port("1",p1, field_dir)
model.add_action(lump_port1)



p4 = Rectangle('p4', width=port_line_width, 
                    height=dielectric_height,
                    axis="X",
                    position=[
                        -(circle_radius+port_line_len),
                        -port_line_width/2,
                        -dielectric_height
                        ],
               color='red'
               )

model.add_action(p4)

field_dir = [[(-(circle_radius+port_line_len)).value, 0, -dielectric_height.value],
             [(-(circle_radius+port_line_len)).value, 0, 0]]

lump_port4 = Set_lumped_port("4",p4, field_dir)
model.add_action(lump_port4)

##now the complicated ones...

p2_y = ((circle_radius+port_line_len)*np.sin(np.deg2rad(120))-port_line_width/2*np.sin(np.deg2rad(30))+2*port_line_len)
p2_x = (circle_radius+port_line_len)*np.cos(np.deg2rad(60))+port_line_width*(np.cos(np.deg2rad(30))/2-1)


p2 = Rectangle('p2', width=dielectric_height, 
                    height=port_line_width,
                    axis="Y",
                    position=[
                        p2_x,
                        p2_y,
                        -dielectric_height
                        ],
               color='red'
               )

model.add_action(p2)

field_dir = [[p2_x.value, p2_y.value, -dielectric_height.value],
             [p2_x.value, p2_y.value, 0]]

lump_port2 = Set_lumped_port("2",p2, field_dir)
model.add_action(lump_port2)



p3_x = (circle_radius+port_line_len)*np.cos(np.deg2rad(120))-port_line_width/2*np.cos(np.deg2rad(30))

p3 = Rectangle('p3', width=dielectric_height, 
                    height=port_line_width,
                    axis="Y",
                    position=[
                        p3_x,
                        p2_y,
                        -dielectric_height
                        ],
               color='red'
               )

model.add_action(p3)

field_dir = [[p3_x.value, p2_y.value, -dielectric_height.value],
             [p3_x.value, p2_y.value, 0]]

lump_port3 = Set_lumped_port("3",p3, field_dir)
model.add_action(lump_port3)

##radiation box


rad_box = Box("rad_box", radiation_size, radiation_size, radiation_height, transparency=90,
            position=[
                    -radiation_size/2,
                    -radiation_size/2,
                    -radiation_height/2
                ]
              )

model.add_action(rad_box)
rad = Set_radiation_boundary(rad_box)
model.add_action(rad)


## geneate analysis

sol = Create_analysis("sol", freq.to_value(apu.GHz), units="GHz")
fsweep = Add_fsweep(sol.name, 2, 4, 0.1, units="GHz")

model.add_action(sol)
model.add_action(fsweep)






###
### Generate output file
###


text = model.hfss_implementation()

f = open(output_filename, "w")
f.write(text)
f.close()


