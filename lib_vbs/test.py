from model import *
from volumes import *
from actions import *
from surfaces import *


model = hfss_vbs_model("test")


dipole_height = Add_model_parameter("dipole_height", value=10, unit="mm")
wire_radius = Add_model_parameter("wire_radius", value=1, unit="mm")
dipole_gap = Add_model_parameter("dipole_gap", value=1, unit="mm")

model.add_action(dipole_height)
model.add_action(wire_radius)
model.add_action(dipole_gap)


upper_wire = Cylinder(name='upper_wire', radius="wire_radius", height="dipole_height/2-dipole_gap/2")
upper_wire.set_position(offset_z="dipole_gap/2")

bottom_wire = Cylinder(name='bottom_wire', radius="wire_radius", height="-(dipole_height/2-dipole_gap/2)")
bottom_wire.set_position(offset_z="-dipole_gap/2")

model.add_action(upper_wire)
model.add_action(bottom_wire)


box_test = Box("Box_wn", 10,20,30, transparency=100)
box_test.set_position(offset_x = 30, offset_y=20)

model.add_action(box_test)

rect1 = Rectangle("Rect1", width = 10, height=5, axis="X")
model.add_action(rect1)

##far field boundary
rad = Set_radiation_boundary(box_test)
model.add_action(rad)

##lumped port
## we will assign it to the rectange, this should be between [0,0,0,], [0,0,5], [0,10,5], [0,10,0] (it does live in the X plane)
field_dir = [[0,0, 2.5], [0,10,2.5]]

l_port0 = Set_lumped_port(rect1, field_dir)
model.add_action(l_port0)




text = model.hfss_implementation()

f = open("test_dout.vbs", 'w')
f.write(text)
f.close()
