//genesis

/***************************		MS Model, Version 7.6	*********************
**************************** 	      MScell.g 	*********************
	Avrama Blackwell 	kblackw1@gmu.edu
	Rebekah Evans 		rcolema2@gmu.edu
	Tom Sheehan 		tsheeha2@gmu.edu	
******************************************************************************

*****************************************************************************
	MS_cell.g has only one externally called function: make_MS_cell. That primary 
	function uses the services of the following two local subroutines:
		set_position
		add_channels

******************************************************************************/

include MScell/globals  		// Defines & initializes cell specific parameters

include MScell/addchans	// provides access to add_uniform_channel & add_CaShells 
					// as required by local subroutine add_channels
include MScell/proto  // provides access to make_prototypes required by primary
					// routine make_MS_cell
    	
//************************ Begin Local Subroutines ****************************
//*****************************************************************************

	//************************ Begin function set_position *********************
	//**************************************************************************
	function set_position (cellpath)
		//********************* Begin Local Variables ************************
 		str compt, cellpath
 		float dist2soma,x,y,z
 		//********************* End Local Variables *****************************
 		
 		if (!{exists {cellpath}})
  			echo The current input {cellpath} does not exist (set_position) 
  			return
 		end
 
 		foreach compt ({el {cellpath}/##[TYPE=compartment]})
     		  x={getfield {compt} x}
     		  y={getfield {compt} y}
     		  z={getfield {compt} z}
     		  dist2soma={sqrt {({pow {x} 2 }) + ({pow {y} 2}) + ({pow {z} 2})} }  
     		  setfield {compt} position {dist2soma}
   	        end
	end
	//************************ End function set_position ***********************
	//**************************************************************************

	//************************ Begin function add_channels *********************
	//**************************************************************************
	function add_channels (cellpath)
         str cellpath
		/************************************************************************
		next, to add ion channels the function "add_uniform_channel" is  
		called to insert channels in to the cell with the distance to soma  
		between a(minimum) and b(max) more details can be found in the file 
		"adjust.g"
		MAGIC_NUMBERS_1
		However the question remains: where do the values of a, b, & conductance
		density come from?
		************************************************************************/

		/* add_uniform_channel (from addchans.g)
					channel_Name	a    		b 	density	  */

		// Naf in the soma 
		add_uniform_channel "NaF_channel"   0        16.1e-6	{gNaFprox} {cellpath}
		// Naf in the dendrites
		add_uniform_channel "NaF_channel"   16.1e-6  90e-6 	{gNaFmid}  {cellpath}
		add_uniform_channel "NaF_channel"   90.0e-6  500e-6 	{gNaFdist}  {cellpath} 

		// KaF in the soma and proximal dendrites
		add_uniform_channel "KAf_channel"   0        16.1e-6	{gKAfprox} {cellpath}
		//  KaF in the middel and distal dendrites
		add_uniform_channel "KAf_channel"   16.1e-6  60.5e-6	{gKAfmid}   {cellpath}
		add_uniform_channel "KAf_channel"   60.5e-6  1000e-6    {gKAfdist}  {cellpath}
          
		//  KAs in the soma and proximal dendrites
		add_uniform_channel "KAs_channel"  0         16.1e-6	{gKAsprox} {cellpath}   
		//  KAs in the middle and distal dendrites
		add_uniform_channel "KAs_channel"  16.1e-6  1000.0e-6 	{gKAsdist} {cellpath}
    

		add_uniform_channel "KIR_channel"   0        16.1e-6	 {gKIR}  {cellpath}  
		add_uniform_channel "KIR_channel"   16.1e-6  1000e-6	 {gKIR}  {cellpath}

  		add_uniform_channel "K_DR"          0        16.1e-6     {gKDR}  {cellpath}
		add_uniform_channel "K_DR"          16.1e-6  1000e-6     {gKDR}  {cellpath}
  
		// function add_CaShells is defined in adjust.g
		// to be coupled with N/Q/R Ca2+ channels 
		add_CaShells {CA_BUFF_1}  0 500e-6   {cellpath} 
		// to be coupled with T/L Ca2+ channels 
		add_CaShells {CA_BUFF_2}  0 500e-6  {cellpath} 
		// to be coupled with all Ca2+ channels    
		add_CaShells {CA_BUFF_3}  0 500e-6   {cellpath} 
	

		/************************************************************************
		the parameters for Pbar of Calcium channels are adopted from Wolf's 
		2005 model. Please note in order to transfer the units into SI unites, 
		all parameters should be multiplied by 1e-2
		************************************************************************/

		add_uniform_channel "CaR_channel" 		0 	500e-6  {gCaR} {cellpath}
 
		add_uniform_channel "CaN_channel" 		0 	16e-6  	{gCaN}  {cellpath}

		add_uniform_channel "CaL12_channel"        0 	500e-6  {gCaL12}  {cellpath}

		add_uniform_channel "CaL13_channel" 	        0 	500e-6  {gCaL13} {cellpath}

		add_uniform_channel "CaT_channel" 		0 	500e-6  {gCaT} {cellpath}

		add_uniform_channel "BK_channel" 		0 	500e-6	{gBK} {cellpath}  
		add_uniform_channel "SK_channel" 		0 	500e-6  {gSK} {cellpath}  

	end

 
	//************************ End function add_channels ***********************
	//**************************************************************************
//************************ End Local Subroutines ******************************
//*****************************************************************************

//************************ Begin Primary Routine ******************************
//*****************************************************************************

	//************************ Begin function make_MS_cell *********************
	//**************************************************************************
	function make_MS_cell (cellpath,pfile)
         str cellpath,pfile
         echo {cellpath}
		make_prototypes					//	see proto.g
              readcell {pfile} {cellpath}
		set_position {cellpath}					// local call
		add_channels {cellpath}					// local call
	end	
	//************************ End function make_MS_cell ***********************
	//**************************************************************************			
//************************ End Primary Routine ********************************
//*****************************************************************************
