# Load in the libraries and functions needed to create the model
import moose
import numpy as np
import pylab as plt
import plot_channel as pc

# Set plt to show the graphs that will be created for each channel type
plt.ion()

# Read the NML model into MOOSE
filename = 'MScellupdated.nml'
reader = moose.mooseReadNML2(filename)

# Define the variables needed to view the undelying curves for the channel kinetics
plot_powers = True
VMIN = -120e-3
VMAX = 50e-3
CAMIN = 0.01e-3
CAMAX = 40e-3
channelList = ('CaT', 'kAf', 'kAs', 'kIR')

# Graph the curves
for chan in channelList:
        libchan=moose.element('/library/'+chan)
        pc.plot_gate_params(libchan,plot_powers, VMIN, VMAX, CAMIN, CAMAX)
