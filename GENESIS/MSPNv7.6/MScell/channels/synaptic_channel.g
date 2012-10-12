//genesis
//  synaptic_channel.g

/***************************		MS Model, Version 7.6	*********************
**************************** 	      synaptic_channel.g  	*********************
	Avrama Blackwell 	kblackw1@gmu.edu
	Rebekah Evans 		rcolema2@gmu.edu	
	Tom Sheehan 		tsheeha2@gmu.edu	
******************************************************************************

*****************************************************************************/

function make_synaptic_channel (chanpath, tau1, tau2, gmax, Ek)
   str chanpath
   float tau1
   float tau2
   float gmax 
   float Ek

/*	echo "XXXXXXXXXXXXXXX make_synaptic_channel XXXXXXXXXXXXXXXX"
	echo "chanpath = "{chanpath}
	echo "tau1 = "{tau1}
	echo "tau2 = "{tau2}
	echo "gmax = "{gmax}
	echo "XXXXXXXXXXXXXXX make_synaptic_channel XXXXXXXXXXXXXXXX"
*/
   create synchan {chanpath}

   setfield {chanpath} tau1 {tau1} \
                       tau2 {tau2}\ 
                       gmax {gmax}\
                        Ek {Ek}

end


