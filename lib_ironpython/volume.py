from abc import ABC, abstractmethod 
import copy


class Volumen(ABC):

    def __init__(self, name, material='vacuum', color='steelblue', units='mm'):
        self.name = name
        self.material = material
        self.color = color
        position = [0]*3
        rotation = [0]*3
        ##depending on the object you could have more parameters here
        self.parameters = {'position': position,
                          'rotation': rotation,
                           'units':units
                           }
    
    def set_rotation(self,ang_x=0, ang_y=0, ang_z=0):
        rotation = [0]*3
        rotation[0] = ang_x
        rotation[1] = ang_y
        rotation[2] = ang_z
        self.parameters['rotation'] = rotation


    def set_position(self, offset_x=0, offset_y=0, offset_z=0):
        position =[0]*3
        position[0]= offset_x
        position[1]= offset_y
        position[2]= offset_z
        self.parameters['position'] = position
    
    ##before calling these two the global parameters should be resolved.
    def add_rotation():
        return
    def add_rotation():
        return


    @abstractmethod
    def hfss_implementation(self, model_parameters):
        raise NotImplementedError

    @abstractmethod
    def _check_variables(self, model_parameters):
        raise NotImplementedError

    #@statictmethod
    def _resolve(self, model_params):
        resolved_params = dict()
        for key, values in self.parameters.items():
            local = [None]*len(values)
            for i in range(len(values)):
                if (type(values[i]) == int) or (type(value[i] == float)):
                    local[i] = values[i]
                elif(values[i] in models_params.keys()):
                    local[i] = values_params[values[i]]
        self.resolved_params = resolved_params 
        return resolved_params

    @abstractmethod
    def _geometry_patches(self, resolution=60, params=None):
        raise NotImplementedError

    def _render_patches(self, ax, patches, transform, color, alpha, edgecolor, linewidth):
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

    def plot(self, ax=None, show=True, params=None, color=None, alpha=0.75,
             resolution=60, edgecolor="k", linewidth=0.15, return_points=False):
        import matplotlib.pyplot as plt
        own_fig = ax is None
        if own_fig:
            fig = plt.figure(figsize=(6, 6))
            ax = fig.add_subplot(111, projection="3d")

        patches = self._geometry_patches(resolution=resolution, params=params)
        all_pts = self._render_patches(ax, patches, self.to_world,
                                        color or self.color, alpha, edgecolor, linewidth)

        if all_pts and own_fig:
            pts = np.vstack(all_pts)
            self._set_equal_aspect(ax, pts)
            ax.set_xlabel("X"); ax.set_ylabel("Y"); ax.set_zlabel("Z")
            ax.set_title(f"{self.name} ({self.material})")
        if show and own_fig:
            plt.show()

        if return_points:
            return ax, all_pts
        return ax

    @staticmethod
    def _set_equal_aspect(ax, pts):
        mins = pts.min(axis=0); maxs = pts.max(axis=0)
        centers = (mins + maxs) / 2
        radius = max((maxs - mins).max() / 2, 1e-6)
        ax.set_xlim(centers[0] - radius, centers[0] + radius)
        ax.set_ylim(centers[1] - radius, centers[1] + radius)
        ax.set_zlim(centers[2] - radius, centers[2] + radius)

    def __repr__(self):
        return (f"<{self.__class__.__name__} name={self.name!r} material={self.material!r} "
                f"pos={self.position.tolist()} rot={self.rotation.tolist()}>")







