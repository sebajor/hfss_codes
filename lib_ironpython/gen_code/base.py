from abc import ABC, abstractmethod
import numpy as np


###
### The geometry is always define locally first.. at the end is translated to the 
### global coord system.
###





class Volume(ABC):
    def __init__(self, material:str="vacuum", name: str=None):
        self.material = material
        self.name = name or f"{self.__class__.__name__}_{id(self) % 10000}"
        self.position = np.zeros(3)
        self.rotation = np.zeros(3)

    def rotate(self, ang_x=0, ang_y=0, ang_z=0):
        self.rotation = self.rotation + np.array([ang_x, ang_y, ang_z])
        return self

    def postion_offset(self, offset_x=0, offset_y=0, offset_z=0):
        self.postion = self.position + np.array([offset_x, offset_y, offset_z])
        return self

    def set_rotation(self, ang_x=0.0, ang_y=0.0, ang_z=0.0):
        """Set absolute rotation (degrees), overwriting any previous value."""
        self.rotation = np.array([ang_x, ang_y, ang_z], dtype=float)
        return self

    def set_position(self, x=0.0, y=0.0, z=0.0):
        """Set absolute position, overwriting any previous value."""
        self.position = np.array([x, y, z], dtype=float)
        return self

    def _rotation_matrix(self):
        ax, ay, az = np.radians(self.rotation)
        Rx = np.array([[1, 0, 0],
                        [0, np.cos(ax), -np.sin(ax)],
                        [0, np.sin(ax), np.cos(ax)]])
        Ry = np.array([[np.cos(ay), 0, np.sin(ay)],
                        [0, 1, 0],
                        [-np.sin(ay), 0, np.cos(ay)]])
        Rz = np.array([[np.cos(az), -np.sin(az), 0],
                        [np.sin(az), np.cos(az), 0],
                        [0, 0, 1]])
        return Rz @ Ry @ Rx

    def to_world(self, points_local):
        """points_local: (..., 3) array -> world coordinates (rotate then translate)."""
        R = self._rotation_matrix()
        pts = np.asarray(points_local, dtype=float)
        shape = pts.shape
        flat = pts.reshape(-1, 3)
        world = flat @ R.T + self.position
        return world.reshape(shape)

    ###interfaces that the child obj has to give!
    @abstractmethod
    def _geometry_patches(self, resolution=60):
        """
        Return a list of "patches" describing the shape in LOCAL coordinates.
        Each patch is a dict with either:
            {'kind': 'surface', 'X': 2D array, 'Y': 2D array, 'Z': 2D array}
        or
            {'kind': 'polygon', 'points': (N,3) array}
        """
        raise NotImplementedError

    @abstractmethod
    def hfss_implementation(self, modeler=None):
        """Build (and optionally execute) the HFSS/pyaedt creation script."""
        raise NotImplementedError

    def _render_patches(self, ax, patches, transform, color, alpha, edgecolor, linewidth):
        """
        Render a list of LOCAL-frame patches onto `ax`, mapping each
        patch's points through `transform` (local -> world) first.
        Returns the list of transformed point arrays (for bounding-box /
        equal-aspect calculations by the caller).

        This is split out of `plot()` so composite objects (e.g. `Assembly`)
        can render many children -- each with its own transform chain and
        color -- into a single shared axis.
        """
        from mpl_toolkits.mplot3d.art3d import Poly3DCollection

        all_pts = []
        for patch in patches:
            if patch["kind"] == "surface":
                X, Y, Z = patch["X"], patch["Y"], patch["Z"]
                pts_local = np.stack([X, Y, Z], axis=-1)
                pts_world = transform(pts_local)
                Xw, Yw, Zw = pts_world[..., 0], pts_world[..., 1], pts_world[..., 2]
                ax.plot_surface(Xw, Yw, Zw, color=color, alpha=alpha,
                                 linewidth=0, antialiased=True, shade=True)
                all_pts.append(pts_world.reshape(-1, 3))
            elif patch["kind"] == "polygon":
                pts_world = transform(patch["points"])
                poly = Poly3DCollection([pts_world], facecolor=color, alpha=alpha,
                                         edgecolor=edgecolor, linewidths=linewidth)
                ax.add_collection3d(poly)
                all_pts.append(pts_world)
        return all_pts

    def plot(self, ax=None, show=True, color="steelblue", alpha=0.75,
             resolution=60, edgecolor="k", linewidth=0.15):
        import matplotlib.pyplot as plt

        own_fig = ax is None
        if own_fig:
            fig = plt.figure(figsize=(6, 6))
            ax = fig.add_subplot(111, projection="3d")

        patches = self._geometry_patches(resolution=resolution)
        all_pts = self._render_patches(ax, patches, self.to_world, color, alpha,
                                        edgecolor, linewidth)

        if all_pts and own_fig:
            pts = np.vstack(all_pts)
            self._set_equal_aspect(ax, pts)
            ax.set_xlabel("X")
            ax.set_ylabel("Y")
            ax.set_zlabel("Z")
            ax.set_title(f"{self.name} ({self.material})")

        if show and own_fig:
            plt.show()
        return ax

    @staticmethod
    def _set_equal_aspect(ax, pts):
        mins = pts.min(axis=0)
        maxs = pts.max(axis=0)
        centers = (mins + maxs) / 2
        radius = max((maxs - mins).max() / 2, 1e-6)
        ax.set_xlim(centers[0] - radius, centers[0] + radius)
        ax.set_ylim(centers[1] - radius, centers[1] + radius)
        ax.set_zlim(centers[2] - radius, centers[2] + radius)

    def __repr__(self):
        return (f"<{self.__class__.__name__} name={self.name!r} material={self.material!r} "
                f"pos={self.position.tolist()} rot={self.rotation.tolist()}>")


    










