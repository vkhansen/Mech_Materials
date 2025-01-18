
# Example Usage in Jupyter Notebook

from mechanics_materials import (
    axial_stress, axial_strain, torsional_shear_stress, polar_moment_of_inertia,
    bending_stress, moment_of_inertia_rectangle, beam_deflection_point_load,
    combined_stress, critical_load, youngs_modulus
)

# Example: Calculating beam bending stress
moment = 500  # Nm
distance = 0.1  # m
base = 0.05  # m
height = 0.1  # m

# Calculate moment of inertia
I = moment_of_inertia_rectangle(base, height)

# Calculate bending stress
stress = bending_stress(moment, distance, I)
print(f"Bending Stress: {stress:.2f} Pa")

# Example: Beam deflection
load = 1000  # N
length = 2.0  # m
modulus = 2.1e11  # Pa (Steel)
position = 1.0  # m

deflection = beam_deflection_point_load(load, length, modulus, I, position)
print(f"Beam Deflection at position {position} m: {deflection:.6f} m")
