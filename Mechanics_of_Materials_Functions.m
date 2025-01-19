% Constants for consistency
PI = pi;

% Error handling helper function
function assert_positive(var, name)
if var <= 0
    error('The %s must be positive.', name);
end
end

function stress = axial_stress(force, area)
% Calculate axial stress given force (N) and cross-sectional area (m^2).
assert_positive(force, 'force');
assert_positive(area, 'area');
stress = force / area;
end

function strain = axial_strain(delta_length, original_length)
% Calculate axial strain given change in length (m) and original length (m).
assert_positive(original_length, 'original length');
strain = delta_length / original_length;
end

function shear_stress = torsional_shear_stress(torque, radius, polar_moment)
% Calculate torsional shear stress (Pa).
assert_positive(polar_moment, 'polar moment');
assert_positive(radius, 'radius');
shear_stress = (torque * radius) / polar_moment;
end

function inertia = polar_moment_of_inertia(diameter)
% Calculate the polar moment of inertia (m^4) for a circular cross-section.
assert_positive(diameter, 'diameter');
inertia = (PI * diameter^4) / 32;
end

function stress = bending_stress(moment, distance, moment_of_inertia)
% Calculate bending stress (Pa).
assert_positive(moment_of_inertia, 'moment of inertia');
stress = (moment * distance) / moment_of_inertia;
end

function inertia = moment_of_inertia_rectangle(base, height)
% Calculate the moment of inertia (m^4) for a rectangular cross-section.
assert_positive(base, 'base');
assert_positive(height, 'height');
inertia = (base * height^3) / 12;
end

function deflection = beam_deflection_point_load(load, length, modulus, inertia, position)
% Calculate the deflection (m) of a simply supported beam under a point load.
if position > length
    error('Position cannot exceed the length of the beam.');
end
assert_positive(length, 'length');
assert_positive(modulus, 'modulus');
assert_positive(inertia, 'inertia');
deflection = (load * position^2 * (3 * length - position)) / (6 * modulus * inertia);
end

function shear_stress = shear_stress(force, area)
% Calculate transverse shear stress (Pa).
assert_positive(area, 'area');
shear_stress = force / area;
end

function [sigma_n, tau_n] = stress_transformation_2D(sigma_x, sigma_y, tau_xy, theta)
% Calculate normal and shear stresses on a plane at an angle theta (degrees).
if ~(0 <= theta && theta <= 360)
    error('Angle theta must be between 0 and 360 degrees.');
end
theta = deg2rad(theta);
sigma_n = (sigma_x + sigma_y) / 2 + (sigma_x - sigma_y) / 2 * cos(2 * theta) + tau_xy * sin(2 * theta);
tau_n = -(sigma_x - sigma_y) / 2 * sin(2 * theta) + tau_xy * cos(2 * theta);
end

function energy = strain_energy(stress, strain, volume)
% Calculate strain energy (J).
assert_positive(volume, 'volume');
energy = 0.5 * stress * strain * volume;
end

function stress = combined_stress(axial, bending, torsional)
% Calculate combined stress (Pa) using the von Mises yield criterion.
stress = sqrt(axial^2 + bending^2 + torsional^2);
end

function critical = critical_load(e_modulus, moment_of_inertia, length, k)
% Calculate the critical buckling load (N) for a column (Euler's formula).
if nargin < 4
    k = 1.0; % Default to 1 for pinned-pinned ends
end
assert_positive(length, 'length');
assert_positive(e_modulus, 'modulus');
assert_positive(moment_of_inertia, 'moment of inertia');
critical = (PI^2 * e_modulus * moment_of_inertia) / (k * length)^2;
end

function modulus = youngs_modulus(stress, strain)
% Calculate Young's modulus (Pa).
assert_positive(strain, 'strain');
modulus = stress / strain;
end

% New functions

function [delta_length] = thermal_expansion(original_length, alpha, delta_temp)
% Calculate change in length due to temperature change.
assert_positive(original_length, 'original length');
delta_length = original_length * alpha * delta_temp;
end

function [shear_flow] = shear_flow(shear_force, area, Q)
% Calculate shear flow for a given section.
assert_positive(area, 'area');
shear_flow = shear_force * Q / area;
end

function [sigma1, sigma2, tau_max] = mohr_circle(sigma_x, sigma_y, tau_xy)
% Calculate principal stresses and maximum shear stress.
sigma_avg = (sigma_x + sigma_y) / 2;
R = sqrt(((sigma_x - sigma_y) / 2)^2 + tau_xy^2);
sigma1 = sigma_avg + R;
sigma2 = sigma_avg - R;
tau_max = R;
end

function [life_cycles] = fatigue_life(stress_amplitude, mean_stress, material)
% Estimate fatigue life using a simple model (e.g., Basquin's equation).
% Here, 'material' is an index for material properties.
material_props = materials(material);
life_cycles = ((stress_amplitude - material_props.fatigue_limit) / mean_stress)^(-material_props.fatigue_coefficient);
end

function [section_modulus] = section_modulus_rectangle(base, height)
% Calculate section modulus for a rectangular section.
assert_positive(base, 'base');
assert_positive(height, 'height');
section_modulus = (base * height^2) / 6;
end

% Material properties structure (MATLAB uses structures for this purpose)
materials = struct('steel', struct('E', 2.1e11, 'yield_strength', 250e6, 'fatigue_limit', 180e6, 'fatigue_coefficient', 0.1), ...
                   'aluminum', struct('E', 69e9, 'yield_strength', 55e6, 'fatigue_limit', 30e6, 'fatigue_coefficient', 0.15), ...
                   'concrete', struct('E', 25e9, 'yield_strength', 20e6, 'fatigue_limit', 5e6, 'fatigue_coefficient', 0.2));

% Example visualization function (MATLAB plotting)
function plot_beam_deflection(load, length, modulus, inertia)
positions = linspace(0, length, 101);
deflections = beam_deflection_point_load(load, length, modulus, inertia, positions);
plot(positions, deflections);
xlabel('Position along the beam (m)');
ylabel('Deflection (m)');
title('Beam Deflection Under Point Load');
grid on;
end

% Unit conversion functions
function [meters] = inches_to_meters(inches)
meters = inches * 0.0254;
end

function [pascals] = psi_to_pascals(psi)
pascals = psi * 6894.76;
end