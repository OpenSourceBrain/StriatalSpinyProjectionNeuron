set -e

pynml-channelanalysis -temperature 32   -minV -100  -maxV 100  -duration 600  -clampBaseVoltage -55  -clampDuration 580  -stepTargetVoltage 10  -erev 50  -caConc 0.001  kAf_chanREqfact.nml  kAs_chanREqfact.nml  KDr_chanQfact.nml  kIR_chanRE2.nml naFchanOgeqn.nml -html -md


