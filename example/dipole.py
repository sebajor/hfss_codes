import sys
sys.path.append('../lib/')
from cylinder import Cylinder
from astropy import units as apu
from astropy import constants as cte
import numpy as np
import matplotlib.pyplot as plt


###
### Well do a dipole at 2.4GHz 
###

freq = 2.4*apu.GHz
wavel = (cte.c/freq)

r = 1*apu.mm
height = wavel/4   ##we will use two wavel/4 to have a big wavel/2 dipole
gap = 1*apu.mm


cil1 = Cylinder(r_max=r.to_value(apu.m), height=height.to_value(apu.m), material='cooper')

cil2 = Cylinder(r_max=r.to_value(apu.m), height=height.to_value(apu.m), material='cooper')

cil1.set_position(z=gap.to_value(apu.m))
cil2.set_rotation(ang_x=180)
cil2.set_position(z=-gap.to_value(apu.m))

fig = plt.figure()
ax = fig.add_subplot(projection='3d')

cil1.plot(ax=ax,show=False)
cil2.plot(ax=ax, show=True)

#ax.set_aspect('equal')
plt.show()



