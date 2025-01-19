# Updated Mechanics of Materials Functions
from math import pi, cos, sin, radians

def axial_stress(force: float, area: float) -> float:
    """
    Calculate axial stress given force (N) and cross-sectional area (m^2).
    """
    if force <= 0 or area <= 0:
        raise ValueError("Force and area must be positive values.")
    return force / area

def axial_strain(delta_length: float, original_length: float) -> float:
    """
    Calculate axial strain given change in length (m) and original length (m).
    """
    if original_length <= 0:
        raise ValueError("Original length must be positive.")
    return delta_length / original_length

def torsional_shear_stress(torque: float, radius: float, polar_moment: float) -> float:
    """
    Calculate torsional shear stress (Pa).
    """
    if polar_moment <= 0 or radius <= 0:
        raise ValueError("Polar moment and radius must be positive.")
    return (torque * radius) / polar_moment

def polar_moment_of_inertia(diameter: float) -> float:
    """
    Calculate the polar moment of inertia (m^4) for a circular cross-section.
    """
    if diameter <= 0:
        raise ValueError("Diameter must be positive.")
    return (pi * diameter**4) / 32

def bending_stress(moment: float, distance: float, moment_of_inertia: float) -> float:
    """
    Calculate bending stress (Pa).
    """
    if moment_of_inertia <= 0:
        raise ValueError("Moment of inertia must be positive.")
    return (moment * distance) / moment_of_inertia

def moment_of_inertia_rectangle(base: float, height: float) -> float:
    """
    Calculate the moment of inertia (m^4) for a rectangular cross-section.
    """
    if base <= 0 or height <= 0:
        raise ValueError("Base and height must be positive.")
    return (base * height**3) / 12

def beam_deflection_point_load(load: float, length: float, modulus: float, inertia: float, position: float) -> float:
    """
    Calculate the deflection (m) of a simply supported beam under a point load.
    """
    if position > length:
        raise ValueError("Position cannot exceed the length of the beam.")
    if length <= 0 or modulus <= 0 or inertia <= 0:
        raise ValueError("Beam properties must be positive.")
    return (load * position**2 * (3 * length - position)) / (6 * modulus * inertia)

def shear_stress(force: float, area: float) -> float:
    """
    Calculate transverse shear stress (Pa).
    """
    if area <= 0:
        raise ValueError("Area must be positive.")
    return force / area

def stress_transformation(sigma_x: float, sigma_y: float, tau_xy: float, theta: float):
    """
    Calculate normal and shear stresses on a plane at an angle theta (degrees).
    """
    theta = radians(theta)
    sigma_n = (sigma_x + sigma_y) / 2 + (sigma_x - sigma_y) / 2 * cos(2 * theta) + tau_xy * sin(2 * theta)
    tau_n = -(sigma_x - sigma_y) / 2 * sin(2 * theta) + tau_xy * cos(2 * theta)
    return sigma_n, tau_n

def strain_energy(stress: float, strain: float, volume: float) -> float:
    """
    Calculate strain energy (J).
    """
    if volume <= 0:
        raise ValueError("Volume must be positive.")
    return 0.5 * stress * strain * volume

def combined_stress(axial: float, bending: float, torsional: float) -> float:
    """
    Calculate combined stress (Pa) using the von Mises yield criterion.
    """
    return (axial**2 + bending**2 + torsional**2)**0.5

def critical_load(e_modulus: float, moment_of_inertia: float, length: float, k: float = 1.0) -> float:
    """
    Calculate the critical buckling load (N) for a column (Euler's formula).
    k - effective length factor, defaults to 1 for pinned-pinned ends.
    """
    if length <= 0 or e_modulus <= 0 or moment_of_inertia <= 0:
        raise ValueError("Column properties must be positive.")
    return (pi**2 * e_modulus * moment_of_inertia) / (k * length)**2

def youngs_modulus(stress: float, strain: float) -> float:
    """
    Calculate Young's modulus (Pa).
    """
    if strain <= 0:
        raise ValueError("Strain must be positive.")
    return stress / strain

# Material properties dictionary
material_properties = {
    "steel": {"E": 2.1e11, "yield_strength": 250e6},
    "aluminum": {"E": 69e9, "yield_strength": 55e6},
    "concrete": {"E": 25e9, "yield_strength": 20e6},
}

# Example visualization function
def plot_beam_deflection(load: float, length: float, modulus: float, inertia: float):
    import matplotlib.pyplot as plt
    positions = [x / 100 * length for x in range(101)]
    deflections = [beam_deflection_point_load(load, length, modulus, inertia, pos) for pos in positions]
    
    plt.figure()
    plt.plot(positions, deflections, label="Deflection Curve")
    plt.xlabel("Position along the beam (m)")
    plt.ylabel("Deflection (m)")
    plt.title("Beam Deflection Under Point Load")
    plt.legend()
    plt.grid(True)
    plt.show()
