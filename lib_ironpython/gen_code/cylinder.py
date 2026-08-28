import numpy as np
from base import Volume


class Cylinder(Volume):

    def __init__(self, r_max, height, material, r_min=0.0,
                 theta_min=0.0, theta_max=360.0, name=None):
        super().__init__(material, name)
        if r_max <= 0 or height <= 0:
            raise ValueError("r_max and height must be > 0")
        if not (0 <= r_min < r_max):
            raise ValueError("Must have 0 <= r_min < r_max")
        if not (0 <= theta_min < theta_max <= 360):
            raise ValueError("Must have 0 <= theta_min < theta_max <= 360")

        self.r_max = float(r_max)
        self.height = float(height)
        self.r_min = float(r_min)
        self.theta_min = float(theta_min)
        self.theta_max = float(theta_max)

    @property
    def is_hollow(self):
        return self.r_min >0
    @property
    def is_partial(self):
        return not np.isclose(self.theta_max - self.theta_min, 360.0)

    def _geometry_patches(self, resolution=60):
        patches = []
        th = np.linspace(np.radians(self.theta_min), np.radians(self.theta_max), resolution)
        z_levels = np.array([0.0, self.height])

        # outer lateral surface
        Th, Z = np.meshgrid(th, z_levels)
        X = self.r_max * np.cos(Th)
        Y = self.r_max * np.sin(Th)
        patches.append({"kind": "surface", "X": X, "Y": Y, "Z": Z})

        # inner lateral surface (if hollow)
        if self.is_hollow:
            Xi = self.r_min * np.cos(Th)
            Yi = self.r_min * np.sin(Th)
            patches.append({"kind": "surface", "X": Xi, "Y": Yi, "Z": Z})

        # top and bottom caps (annulus if hollow, pie wedge if solid)
        r_in = self.r_min if self.is_hollow else 0.0
        for z in (0.0, self.height):
            if self.is_hollow:
                th_out, th_in = th, th[::-1]
                xs = np.concatenate([self.r_max * np.cos(th_out), self.r_min * np.cos(th_in)])
                ys = np.concatenate([self.r_max * np.sin(th_out), self.r_min * np.sin(th_in)])
            else:
                xs = np.concatenate([[0.0], self.r_max * np.cos(th)])
                ys = np.concatenate([[0.0], self.r_max * np.sin(th)])
            zs = np.full_like(xs, z)
            patches.append({"kind": "polygon", "points": np.stack([xs, ys, zs], axis=-1)})

        # flat radial side walls, only needed for a partial sector
        if self.is_partial:
            for angle in (self.theta_min, self.theta_max):
                a = np.radians(angle)
                p1 = [r_in * np.cos(a), r_in * np.sin(a), 0.0]
                p2 = [self.r_max * np.cos(a), self.r_max * np.sin(a), 0.0]
                p3 = [self.r_max * np.cos(a), self.r_max * np.sin(a), self.height]
                p4 = [r_in * np.cos(a), r_in * np.sin(a), self.height]
                patches.append({"kind": "polygon", "points": np.array([p1, p2, p3, p4])})

        return patches


    ###HFSS implementation: TODO CHECK!! 
    def hfss_implementation(self, modeler=None):
        return None



