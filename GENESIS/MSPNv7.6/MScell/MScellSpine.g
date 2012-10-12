//genesis
//MScellSpine.g
/***************************		MS Model, Version 7.6	*********************
**************************** 	      MScellSpine.g 	*********************
	Avrama Blackwell 	kblackw1@gmu.edu
	Wonryull Koh		wkoh1@gmu.edu
	Rebekah Evans 		rcolema2@gmu.edu
	Sriram 				dsriraman@gmail.com	
	Tom Sheehan 		tsheeha2@gmu.edu	
******************************************************************************

*****************************************************************************/

//This routine takes the MScell without spines first, then adds spines

include MScell/MScell.g                 //MScell without synapses
include MScell/SynParamsCtx.g               //parameters on synaptic channels
include MScell/channels/nmda_channel.g   //function to make nmda channel, either GHK or not, in library
include MScell/channels/synaptic_channel.g // function to make non nmda synaptic channels in library
include MScell/AddSynapticChannels.g	// contains functions to add channels to compartments
include MScell/spines.g           //creates spines, puts channels & calcium in spines


function make_MS_cell_spine (cellname,pfile)
   str cellname,pfile

   str CompName

   make_MS_cell {cellname} {pfile}

	//************* create synaptic channels in library *********
	pushe /library

  	make_synaptic_channel  {AMPAname} {AMPAtau1} {AMPAtau2} {AMPAgmax} {EkAMPA}
  	make_NMDA_channel    {NMDAname} {EkNMDA} {Kmg} {NMDAtau2} {NMDAgmax} {ghk_yesno}
	make_synaptic_channel  {GABAname} {GABAtau1} {GABAtau2} {GABAgmax} {EkGABA}


	make_spines

    pope {cellname}
	
   //********************* end synaptic channels in library **************


  //**************SPINES*************************/
  
	add_spines_evenly  {cellname} spine   16.1e-6   200.0e-6       0.1

end
