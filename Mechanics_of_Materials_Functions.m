% Constants for consistency
PI = pi;

function stress = axial_stress(force, area)
% Calculate axial stress given force (N) and cross-sectional area (m^2).
if force <= 0 || area <= 0
    error('Force and area must be positive values.');
end
stress = force / area;
end

function strain = axial_strain(delta_length, original_length)
% Calculate axial strain given change in length (m) and original length (m).
if original_length <= 0
    error('Original length must be positive.');
end
strain = delta_length / original_length;
end

function shear_stress = torsional_shear_stress(torque, radius, polar_moment)
% Calculate torsional shear stress (Pa).
if polar_moment <= 0 || radius <= 0
    error('Polar moment and radius must be positive.');
end
shear_stress = (torque * radius) / polar_moment;
end

function inertia = polar_moment_of_inertia(diameter)
% Calculate the polar moment of inertia (m^4) for a circular cross-section.
if diameter <= 0
    error('Diameter must be positive.');
end
inertia = (PI * diameter^4) / 32;
end

function stress = bending_stress(moment, distance, moment_of_inertia)
% Calculate bending stress (Pa).
if moment_of_inertia <= 0
    error('Moment of inertia must be positive.');
end
stress = (moment * distance) / moment_of_inertia;
end

function inertia = moment_of_inertia_rectangle(base, height)
% Calculate the moment of inertia (m^4) for a rectangular cross-section.
if base <= 0 || height <= 0
    error('Base and height must be positive.');
end
inertia = (base * height^3) / 12;
end

function deflection = beam_deflection_point_load(load, length, modulus, inertia, position)
% Calculate the deflection (m) of a simply supported beam under a point load.
if position > length
    error('Position cannot exceed the length of the beam.');
end
if length <= 0 || modulus <= 0 || inertia <= 0
    error('Beam properties must be positive.');
end
deflection = (load * position^2 * (3 * length - position)) / (6 * modulus * inertia);
end

function shear_stress = shear_stress(force, area)
% Calculate transverse shear stress (Pa).
if area <= 0
    error('Area must be positive.');
end
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
if volume <= 0
    error('Volume must be positive.');
end
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
if length <= 0 || e_modulus <= 0 || moment_of_inertia <= 0
    error('Column properties must be positive.');
end
critical = (PI^2 * e_modulus * moment_of_inertia) / (k * length)^2;
end

function modulus = youngs_modulus(stress, strain)
% Calculate Young's modulus (Pa).
if strain <= 0
    error('Strain must be positive.');
end
modulus = stress / strain;
end

% Material properties structure (MATLAB uses structures for this purpose)
materials = struct('steel', struct('E', 2.1e11, 'yield_strength', 250e6), ...
                   'aluminum', struct('E', 69e9, 'yield_strength', 55e6), ...
                   'concrete', struct('E', 25e9, 'yield_strength', 20e6));

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