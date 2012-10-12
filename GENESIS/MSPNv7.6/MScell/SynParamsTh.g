//genesis
/***************************		MS Model, Version 7.6	*********************
**************************** 	     SynParamsTh.g 	*********************
	Avrama Blackwell 	kblackw1@gmu.edu
	Rebekah Evans 		rcolema2@gmu.edu
	Tom Sheehan 		tsheeha2@gmu.edu	
******************************************************************************
To change synaptic parameters, change the include in MScellSpine.g
Synaptic Parameters for thalamic inputs according to Ding ... Surmeier
*****************************************************************************/

	str AMPAname = "AMPA"
	float EkAMPA = 0.0
        float AMPAtau1 = 1.1e-3
        float AMPAtau2 = 5.75e-3 
        float AMPAgmax = 0.47e-9  //Ding 2008, th-str synapses have 2/1 NMDA/AMPA ratio, so 0.47e-9 for AMPA
		
										str GABAname = "GABA"
        float GABAtau1 = 0.25e-3    // From Galarreta and Hestrin 1997 
        float GABAtau2 = 3.75e-3    //(used in Wolfs model)
        float EkGABA = -0.060
        float GABAgmax = 750e-12  //Modified Koos 2004 

	int GABA2Spine = 0                                // = 0, No GABA; 
                                                  //   1, add GABA to spine head
                                                  //   2, add GABA to spine neck
	
	int addCa2Spine = 1		// 0, no ca channels in spine, 
					//1, yes ca channels in spine (non-synaptic)
	int NMDABufferMode = 0          // 1, connect both NMDA and AMPA calcium to NMDA_buffer
                                     // 0, connect only NMDA currents to NMDA_buffer

float useAMPANMDAGHKchannels= 0  // we do not use GHK project for NMDA/AMPA

setclock 0 5e-6 //was 5e-6
        // Simulation time step (Second)       
setclock 1 2e-5        //  time step for ascii output
//setclock 1 1e-4 // time step for graphic output


// parameters for NMDA subunits


// cortex
str	    subunit = "ThDing"
float   EkNMDA   = 0
float	Kmg       = 3.57
float	NMDAtau2      = (155e-3)/2 	//thal avg for .42 NR2B and .58 NR2A.  (300e-3)/2 (NR2B) (50e-3)/2 (NR2A) 126+29 = 155
float	NMDAgmax      = 0.94e-9      //NR2A and B from (Moyner et al., 1994 figure 7)
int ghk_yesno=0

str NMDAname = {subunit}


