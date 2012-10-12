//genesis
//  K_DR_channel.g

/***************************		MS Model, Version 7.6	*********************
**************************** 	      K_DR_channel.g  	*********************
	Avrama Blackwell 	kblackw1@gmu.edu
	Rebekah Evans 		rcolema2@gmu.edu	
	Tom Sheehan 		tsheeha2@gmu.edu	
******************************************************************************

*****************************************************************************/

//************************ Begin Primary Routine ******************************
//*****************************************************************************
function make_K_DR_channel
	//********************* Begin Local Variables ******************************
   float xmin = -0.1
   float xmax = 0.05
   int xdivs = 3000
   float x,dx,alpha_m,beta_m,tau_m,m_inf,a_slope,b_slope,a_vhalf,b_vhalf
   int i
   float Erev = -0.09    
	//********************* End Local Variables ********************************

 	if ({exists K_DR})
		echo "K_DR tabchannel exists"
   	return
 	end
 
 	create tabchannel K_DR 
  	setfield ^ Ek {Erev} 	\
             Gbar 100.0 	\ 
             Ik 0        	\
             Gk 0        	\
             Xpower 1    	\
             Ypower 0    	\
             Zpower 0 

  	call K_DR TABCREATE X {xdivs} {xmin} {xmax}
        dx = (xmax-xmin)/xdivs
        x = xmin
//	echo "K_DR increment:" {dx} "V"
	float a_vhalf=-0.013
    float b_vhalf=-0.013
	float a_slope=-0.00909
	float b_slope=-0.0125
echo "make KDR, qfactor=" {qfactorKDR}	
	for (i=0;i<={xdivs};i=i+1)

		/*migliore, et,al 1999 */
	  alpha_m =({exp {(x-{a_vhalf})/{a_slope}}} )
      beta_m  =({exp {(x-{b_vhalf})/{b_slope}}}) 
      tau_m = {{0.001*50*beta_m/(1+alpha_m)}/qfactorKDR}
      m_inf = 1/(1+alpha_m)
      setfield K_DR X_A->table[{i}] {tau_m}
      setfield K_DR X_B->table[{i}] {m_inf}
      x = x+dx
   end

   tweaktau K_DR X 
 
   setfield K_DR X_A->calc_mode 1 X_B->calc_mode 1
end
//************************ End Primary Routine ********************************
//*****************************************************************************
