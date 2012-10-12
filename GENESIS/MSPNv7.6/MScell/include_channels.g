//genesis
//include_channels.g
/***************************		MS Model, Version 7.6	*********************
**************************** 	      include_channels.g 	*********************
	Avrama Blackwell 	kblackw1@gmu.edu
	Rebekah Evans 		rcolema2@gmu.edu
	Tom Sheehan 		tsheeha2@gmu.edu	
******************************************************************************

*****************************************************************************/
//this file is included by proto.g

include MScell/channels/tabchanforms.g
//calcium channels
include MScell/channels/CaL12inact_channel
include MScell/channels/CaL13_channel
include MScell/channels/CaNinact_channel
include MScell/channels/CaR_channel
include MScell/channels/CaT_channel

//voltage dependent channels
include MScell/channels/naF_chanOg
include MScell/channels/kAf_chanRE
include MScell/channels/kIR_chanKD
include MScell/channels/kAs_chanRE
include MScell/channels/K_DR_channel

//calcium dependent potassium channels
include MScell/channels/BKchannel
include MScell/channels/SKchannelCaDep


