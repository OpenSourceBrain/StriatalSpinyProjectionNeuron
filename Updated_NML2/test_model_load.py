# Load in the libraries and functions needed to create the model
import moose
import numpy as np
import pylab as plt
import plot_channel as pc
import util as u

# Use plt.ion to show the graphs that will be created for each channel type and for the simulation
plt.ion()

# Read the NML model into MOOSE
#filename = 'MScellupdated2.nml'
#filename = 'MScellupdated_SecDendRE.nml'
filename = 'MScellupdated_primDend.nml'
reader = moose.mooseReadNML2(filename)

# Define the variables to be used for the somatic current injection
pulse_dur = 400e-3
pulse_amp = 0.26e-9
pulse_delay1 = 100e-3
pulse_delay2 = 1e9

# Define the variables needed to view the underlying curves for the channel kinetics
plot_powers = True
VMIN = -120e-3
VMAX = 50e-3
CAMIN = 0.01e-3
CAMAX = 40e-3
channelList = ('kAf','kAs','kIR','Krp','naF')

# Graph the curves
for chan in channelList:
        libchan=moose.element('/library/'+chan)
        pc.plot_gate_params(libchan,plot_powers, VMIN, VMAX, CAMIN, CAMAX)


# Re-create the python variable pointing to the MS cell to limit results just to 
# type compartment (excludes the spines and allows for createDataTables function to
# work properly)
MS_cell = moose.wildcardFind('/library/MScell/#[TYPE=SymCompartment]')

# Create the pulse and apply it to the MS cell's soma
MS_soma_pulse = u.createPulse(MS_cell[0], 'rollingWave', pulse_dur, pulse_amp, 
                           pulse_delay1, pulse_delay2)

# Create a neutral object to store the data in
MS_data = moose.Neutral('/MS_data')
MS_tables = []
for comp in MS_cell:
    MS_tables.append(u.createDataTables(comp,MS_data,MS_soma_pulse))

# Create a variable for the table recording the voltage for the MS cell's soma
MS_soma_Vm = MS_tables[0][0]

# Define variables needed for running the simulation, and set the clocks for all the channels, compartments,
# and tables recording voltage and current during the simulation
simTime = 400e-3
simdt = 10e-6
plotdt = 0.2e-3
for i in range(10):
    moose.setClock(i, simdt)

moose.setClock(8, plotdt)

# Run the experiment using the hsolve method and plot the voltage for the MS cell soma
u.hsolve(MS_cell[0], simdt)
moose.reinit()
moose.start(simTime)
t = np.linspace(0,simTime,len(MS_soma_Vm.vector))
plt.figure()
plt.plot(t,MS_soma_Vm.vector, 'r',label = 'soma_Vm')
plt.legend()
