import numpy as np
import matplotlib.pyplot as plt

# Given data
w = 8  # kN/m (uniformly distributed load)
L1 = 4  # m (distance from A to B)
L2 = 2  # m (distance from B to C)
L = L1 + L2  # total length of beam
RA = 12  # kN (reaction at A)
RB = 36  # kN (reaction at B)

# Discretized x values
x = np.linspace(0, L, 100)

# Shear Force Function
V = np.piecewise(x, [x < L1, x >= L1], 
                  [lambda x: RA - w*x, 
                   lambda x: RA - w*x + RB])

# Bending Moment Function
M = np.piecewise(x, [x < L1, x >= L1], 
                  [lambda x: RA*x - (w*x**2)/2, 
                   lambda x: RA*x - (w*x**2)/2 + RB*(x - L1)])

# Plot Shear Force Diagram
plt.figure(figsize=(10,5))
plt.plot(x, V, label="Shear Force", color='blue')
plt.fill_between(x, V, color='blue', alpha=0.3)
plt.axhline(0, color='black', linewidth=0.8)
plt.title("Shear Force Diagram")
plt.xlabel("Length of Beam (m)")
plt.ylabel("Shear Force (kN)")
plt.grid(True)
plt.legend()
plt.show()

# Plot Bending Moment Diagram
plt.figure(figsize=(10,5))
plt.plot(x, M, label="Bending Moment", color='red')
plt.fill_between(x, M, color='red', alpha=0.3)
plt.axhline(0, color='black', linewidth=0.8)
plt.title("Bending Moment Diagram")
plt.xlabel("Length of Beam (m)")
plt.ylabel("Bending Moment (kN·m)")
plt.grid(True)
plt.legend()
plt.show()
