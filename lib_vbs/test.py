from model import *
from volumes import *
from actions import *


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


box_text = Box("Box_wn", 10,20,30)
box_text.set_position(offset_x = 30, offset_y=20)

model.add_action(box_text)



text = model.hfss_implementation()

f = open("test_dout.vbs", 'w')
f.write(text)
f.close()
