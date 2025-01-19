# Mechanics of Materials Functions

from math import pi

def axial_stress(force: float, area: float) -> float:
    """
    Calculate axial stress given force and cross-sectional area.
    """
    return force / area

def axial_strain(delta_length: float, original_length: float) -> float:
    """
    Calculate axial strain given change in length and original length.
    """
    return delta_length / original_length

def torsional_shear_stress(torque: float, radius: float, polar_moment: float) -> float:
    """
    Calculate torsional shear stress.
    """
    return (torque * radius) / polar_moment

def polar_moment_of_inertia(diameter: float) -> float:
    """
    Calculate the polar moment of inertia for a circular cross-section.
    """
    return (pi * diameter**4) / 32

def bending_stress(moment: float, distance: float, moment_of_inertia: float) -> float:
    """
    Calculate bending stress given moment, distance from neutral axis, and moment of inertia.
    """
    return (moment * distance) / moment_of_inertia

def moment_of_inertia_rectangle(base: float, height: float) -> float:
    """
    Calculate the moment of inertia for a rectangular cross-section about its centroidal axis.
    """
    return (base * height**3) / 12

def beam_deflection_point_load(load: float, length: float, modulus: float, inertia: float, position: float) -> float:
    """
    Calculate the deflection of a simply supported beam under a point load.
    """
    if position > length:
        raise ValueError("Position cannot exceed the length of the beam.")
    return (load * position**2 * (3 * length - position)) / (6 * modulus * inertia)

def combined_stress(axial: float, bending: float, torsional: float) -> float:
    """
    Calculate combined stress using the von Mises yield criterion approximation.
    """
    return (axial**2 + bending**2 + torsional**2)**0.5

def critical_load(e_modulus: float, moment_of_inertia: float, length: float, k: float = 1.0) -> float:
    """
    Calculate the critical buckling load for a column (Euler's formula).
    k - effective length factor, defaults to 1 for pinned-pinned ends.
    """
    return (pi**2 * e_modulus * moment_of_inertia) / (k * length)**2

def youngs_modulus(stress: float, strain: float) -> float:
    """
    Calculate Young's modulus from stress and strain.
    """
    return stress / strain