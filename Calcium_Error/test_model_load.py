# Load in the libraries and functions needed to create the model
import moose
import numpy as np
import pylab as plt

# Set plt to show the graphs that will be created for each channel type
plt.ion()

# Read the NML model into MOOSE
filename = 'MScellupdated.nml'
reader = moose.mooseReadNML2(filename)
