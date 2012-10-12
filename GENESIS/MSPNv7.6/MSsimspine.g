//genesis
// MSsimspine.g 

/***************************		MS Model, Version 7.6	*********************
**************************** 	      MSsimspine.g 	*********************
	Avrama Blackwell 	kblackw1@gmu.edu
	Rebekah Evans 		rcolema2@gmu.edu	
	Tom Sheehan 		tsheeha2@gmu.edu	
******************************************************************************

*****************************************************************************/

str 	neuronname = "/cell"
str pfile="MScell/MScell08.p"
include MScell/MScellSpine.g	// access make_MS_cell this function is only called from MSsim.g

include graphics1		        // access functions make_control & make_graph
				// These two functions are only called from MSsim.g
/****************************** End includes *********************************/

setclock 0 5e-6         // Simulation time step (Second)       
setclock 1 2e-5        //  time step for ascii output


	make_MS_cell_spine {neuronname} {pfile}		// MS_cell.g

	reset

	make_graph {neuronname}		// graphics1.g
	

	
        reset	


/****************************** End MSsim.g **********************************/
str diskpath 
//include if2.g
