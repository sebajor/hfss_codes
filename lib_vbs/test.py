from volumes import *
from model import *
from parameters import *
from actions import *

model = hfss_vbs_model("test")

dipole_height = Add_model_parameter("dipole_height", value=10, unit="mm")
wire_radius = Add_model_parameter("wire_radius", value=1, unit="mm")
dipole_gap = Add_model_parameter("dipole_gap", value=1, unit="mm")

model.add_action(dipole_height)
model.add_action(wire_radius)
model.add_action(dipole_gap)

#cyl = Cylinder(name='cyl', radius=2*wire_radius, height=10)

#model.add_action(cyl)

box = Box("box1", dipole_height, dipole_height/2, dipole_gap, 
          position=[-dipole_height/2,-dipole_height/4,-dipole_gap/2], 
          material='pec', solve_inside=False)

model.add_action(box)
###

box_faces = Get_box_faces(box)
model.add_action(box_faces)


direction = [[box.position[0].value, box.position[1].value, box.position[2].value],
             [(box.position[0]).value, (box.position[1]+box.sizes[1]).value, box.position[2].value]
             ]

mx_bound = Set_master_boundary('mx', box_faces.face_xmin, direction, reverse_v=False
                               )


model.add_action(mx_bound)

## add slave face
direction = [[(box.position[0]+box.sizes[0]).value, box.position[1].value, box.position[2].value],
             [(box.position[0]+box.sizes[0]).value, (box.position[1]+box.sizes[1]).value, box.position[2].value]
             ]

sx_bound = Set_slave_boundary('sx', mx_bound.name, box_faces.face_xmax, direction=direction,
                              reverse_v=True)


model.add_action(sx_bound)


###set the other boundart

direction = [[box.position[0].value, box.position[1].value, box.position[2].value],
             [(box.position[0]+box.sizes[0]).value, (box.position[1]).value, box.position[2].value]
             ]

my_bound = Set_master_boundary('my', box_faces.face_ymin, direction, reverse_v=True
                               )
model.add_action(my_bound)

## add slave face
##I can also do this direction with the box_faces parameters...
direction = [[(box.position[0]).value, (box.position[1]+box.sizes[1]).value, box.position[2].value],
             [(box.position[0]+box.sizes[0]).value, (box.position[1]+box.sizes[1]).value, box.position[2].value]
             ]

sy_bound = Set_slave_boundary('sy', my_bound.name, box_faces.face_ymax, direction=direction,
                              reverse_v=False)


model.add_action(sy_bound)

##set floquet port
             ]
mode_x= [[box_faces.xmin.value, box_faces.ymin.value, box_faces.zmin.value],
         [box_faces.xmax.value, box_faces.ymin.value, box_faces.zmin.value]]

mode_y = [[box_faces.xmin.value, box_faces.ymin.value, box_faces.zmin.value],
          [box_faces.xmin.value, box_faces.ymax.value, box_faces.zmin.value]]

floq1 = Set_floquet_port("floq1", box_faces.face_zmin, mode_x, mode_y)
model.add_action(floq1)

##floquet2
mode_x= [[box_faces.xmin.value, box_faces.ymin.value, box_faces.zmax.value],
         [box_faces.xmax.value, box_faces.ymin.value, box_faces.zmax.value]]

mode_y = [[box_faces.xmin.value, box_faces.ymin.value, box_faces.zmax.value],
          [box_faces.xmin.value, box_faces.ymax.value, box_faces.zmax.value]]


floq2 = Set_floquet_port("floq2", box_faces.face_zmax, mode_x, mode_y)
model.add_action(floq2)




####
text = model.hfss_implementation()

f = open("test_dout.vbs", 'w')
f.write(text)
f.close()


