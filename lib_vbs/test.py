from volumes import *
from model import *
from parameters import *

model = hfss_vbs_model("test")

dipole_height = Add_model_parameter("dipole_height", value=10, unit="mm")
wire_radius = Add_model_parameter("wire_radius", value=1, unit="mm")
dipole_gap = Add_model_parameter("dipole_gap", value=1, unit="mm")

model.add_action(dipole_height)
model.add_action(wire_radius)
model.add_action(dipole_gap)

cyl = Cylinder(name='cyl', radius=2*wire_radius, height=10)

model.add_action(cyl)

box = Box("box1", dipole_height, dipole_height/2, dipole_gap, 
          position=[5,1,-10], material='pec', solve_inside=False)

model.add_action(box)


text = model.hfss_implementation()

f = open("test_dout.vbs", 'w')
f.write(text)
f.close()


