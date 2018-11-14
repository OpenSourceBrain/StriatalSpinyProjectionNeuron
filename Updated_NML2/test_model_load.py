# Load in the libraries and functions needed to create the model
import moose
import numpy as np
import pylab as plt
import plot_channel as pc
import util as u

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
#channelList = ('CaL12','CaL13','CaN','CaR','CaT','kAf','kAs','kIR','Krp','naF', 'SKCa')
channelList = ('kAf','kAs','kIR','Krp','naF')


pulse_dur = 400e-3
pulse_amp = 0.26e-9
pulse_delay1 = 100e-3
pulse_delay2 = 1e9

# Graph the curves
for chan in channelList:
        libchan=moose.element('/library/'+chan)
        pc.plot_gate_params(libchan,plot_powers, VMIN, VMAX, CAMIN, CAMAX)


# Re-create the python variable pointing to the gran_cell to limit results just to 
# type compartment (excludes the spines and allows for createDataTables function to
# work properly)
MS_cell = moose.wildcardFind('/library/MScell/#[TYPE=SymCompartment]')

# Create the pulse and apply it to the granule cell's soma
MS_soma_pulse = u.createPulse(MS_cell[0], 'rollingWave', pulse_dur, pulse_amp, 
                           pulse_delay1, pulse_delay2)

# Create a neutral object to store the data in
MS_data = moose.Neutral('/MS_data')
MS_tables = []
for comp in MS_cell:
    MS_tables.append(u.createDataTables(comp,MS_data,MS_soma_pulse))

# Choose the soma and a representative dendrite to view how voltage changes
# for the granule cell
MS_soma_Vm = MS_tables[0][0]
MS_soma_Iex = MS_tables[0][1]

# Plot the simulation
simTime = 350e-3
simdt = 2.5e-5
plotdt = 0.2e-3
for i in range(10):
    moose.setClock(i, simdt)

moose.setClock(8, plotdt)

# Use the hsolve method for the experiment
u.hsolve(MS_cell[0], simdt)
moose.reinit()
moose.start(simTime)
t = np.linspace(0,simTime,len(MS_soma_Vm.vector))
plt.figure()
plt.plot(t,MS_soma_Vm.vector * 1e3, 'r',label = 'MS_soma_Vm (mV)')
plt.legend()
