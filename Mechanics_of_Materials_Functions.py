
# Mechanics of Materials Functions

def axial_stress(force: float, area: float) -> float:
    return force / area

def axial_strain(delta_length: float, original_length: float) -> float:
    return delta_length / original_length

def torsional_shear_stress(torque: float, radius: float, polar_moment: float) -> float:
    return (torque * radius) / polar_moment

def polar_moment_of_inertia(diameter: float) -> float:
    return (3.14159 * diameter**4) / 32

def bending_stress(moment: float, distance: float, moment_of_inertia: float) -> float:
    return (moment * distance) / moment_of_inertia

def moment_of_inertia_rectangle(base: float, height: float) -> float:
    return (base * height**3) / 12

def beam_deflection_point_load(load: float, length: float, modulus: float, inertia: float, position: float) -> float:
    if position > length:
        raise ValueError("Position cannot exceed the length of the beam.")
    return (load * position**2 * (3 * length - position)) / (6 * modulus * inertia)

def combined_stress(axial: float, bending: float, torsional: float) -> float:
    return (axial**2 + bending**2 + torsional**2)**0.5

def critical_load(e_modulus: float, moment_of_inertia: float, length: float, k: float = 1.0) -> float:
    return (3.14159**2 * e_modulus * moment_of_inertia) / (k * length)**2

def youngs_modulus(stress: float, strain: float) -> float:
    return stress / strain
