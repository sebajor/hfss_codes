from model import HFSS_model
from cylinder import Cylinder
from actions import *


model = HFSS_model("test")

dipole_height = AddModelParameter("dipole_height", value=10, unit="mm")
wire_radius = AddModelParameter("wire_radius", value=1, unit="mm")
dipole_gap = AddModelParameter("dipole_gap", value=1, unit="mm")

model.add_action(dipole_height)
model.add_action(wire_radius)
model.add_action(dipole_gap)

upper_wire = Cylinder(name='upper_wire', radius="wire_radius", height="dipole_height/2-dipole_gap/2")
upper_wire.set_position(offset_z="dipole_gap/2")

bottom_wire = Cylinder(name='upper_wire', radius="wire_radius", height="-(dipole_height/2-dipole_gap/2)")
upper_wire.set_position(offset_z="-dipole_gap/2")

model.add_action(upper_wire)
model.add_action(bottom_wire)

text = model.generate_hfss_code()

f = open("test_gen.py", 'w')
f.write(text)
f.close()







