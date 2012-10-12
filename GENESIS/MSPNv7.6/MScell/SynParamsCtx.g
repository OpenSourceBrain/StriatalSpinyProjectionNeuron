//genesis
// SynParamsCtx.g

/***************************		MS Model, Version 7.6	*********************
**************************** 	      SynParamsCtx.g  	*********************
	Avrama Blackwell 	kblackw1@gmu.edu
	Rebekah Evans 		rcolema2@gmu.edu	
	Tom Sheehan 		tsheeha2@gmu.edu	
******************************************************************************
To change synaptic parameters, change the include in MScellSpine.g
Synaptic Parameters for cortical inputs according to Ding ... Surmeier
*****************************************************************************/
	str AMPAname = "AMPA"
	float EkAMPA = 0.0
        float AMPAtau1 = 1.1e-3
        float AMPAtau2 = 5.75e-3 
        float AMPAgmax = 0.342e-9  //593e-12 I changed this to make the NMDA/AMPA ratio more like 2.75/1 which is what Ding 2008 finds int corticalstriatal synapses
									//more like 2/1 for thalamus so should be 0.47e-9 for thalamo-striatal syanpnse if NMDA is 0.94e-9 Rebekah Evans 6/25/10

        str GABAname = "GABA"
        float GABAtau1 = 0.25e-3    // From Galarreta and Hestrin 1997 
        float GABAtau2 = 3.75e-3    
        float EkGABA = -0.060
        float GABAgmax = 750e-12  //Modified Koos 2004 

	int GABA2Spine = 0                                // = 0, No GABA; 
	
	int addCa2Spine = 1		// 0, no ca channels in spine, 
							//1, yes ca channels in spine (non-synaptic)
	int NMDABufferMode = 0          // 1, connect both NMDA and AMPA calcium to NMDA_buffer
                                    // 0, connect only NMDA currents to NMDA_buffer

float useAMPANMDAGHKchannels= 0  // we are not using GHK for NMDA/AMPA


// parameters for NMDA subunits


// cortex
str	    subunit = "Cortex"
float   EkNMDA   = 0
float	Kmg       = 3.57
float	NMDAtau2      = (112.5e-3)/2 	//ctx avg for .25 NR2B and .75 NR2A.  (300e-3)/2 (NR2B) (50e-3)/2 (NR2A) 75+37.5 = 112.5
float	NMDAgmax      = 0.94e-9      //NR2A and B from (Moyner et al., 1994 figure 7)
int ghk_yesno=0

str NMDAname = {subunit}


