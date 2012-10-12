//genesis
//  kIR_chanKD.g

/***************************		MS Model, Version 7.6	*********************
**************************** 	      kIR_chanKD.g  	*********************
	Avrama Blackwell 	kblackw1@gmu.edu
	Rebekah Evans 		rcolema2@gmu.edu	
	Tom Sheehan 		tsheeha2@gmu.edu	
******************************************************************************
**implemented by Kai Du, kai.du@ki.se
*****************************************************************************/
function make_KIR_channel

 float Erev       = -0.09      // V

    
    str path = "KIR_channel" 

    float xmin  = -0.15  /* minimum voltage we will see in the simulation */     // V
    float xmax  = 0.05  /* maximum voltage we will see in the simulation */      // V
    int xdivsFiner = 4000
    int c = 0


 	 /****** Begin vars used to enable genesis calculations ********/
   float increment = (xmax - xmin)*1e3/xdivsFiner  // mV
   echo "KIR increment:" {increment} "mV"
   float x = -150.00 
   float minf       = 0
   float hinf       = 0
   float mvhalf     = -52.0      // mV
   float mshift     = 50.0      // 30, mV
   float mslope     = 13.0      // mV
   float taum       = 0         // ms
   float tauh       = 0         //  ms
  	 /****** End vars used to enable genesis calculations **********/ 	 
  	 
  	  
    create tabchannel {path} 
    call {path} TABCREATE X {xdivsFiner} {xmin} {xmax}  // activation   gate
//    call {path} TABCREATE Y {xdivsFiner} {xmin} {xmax}  // inactivation gate, no longer used


 float qfactor = 0.5    // to match in vitro data, Wolf,et.al.2005
 create table  kir_taum                    // ms
 call  kir_taum  TABCREATE 20 {xmin} {xmax}
//the table corresponds to -150 mV to 50 mV, digitally extracted from JE Steephen,et.al. 2008, fig1
 setfield kir_taum table->table[0] 0.2    \
                    table->table[1] 0.2    \
                    table->table[2] 0.2    \
                    table->table[3] 0.2    \
                    table->table[4] 0.2    \
                    table->table[5] 0.38   \
                    table->table[6] 0.97   \
                    table->table[7] 1.486  \
                    table->table[8] 5.3763 \
                    table->table[9] 6.0606 \
                    table->table[10] 6.8966 \
                    table->table[11] 7.6923 \
                    table->table[12] 7.1429 \
                    table->table[13] 5.8824 \
                    table->table[14] 4.4444 \
                    table->table[15] 4.0   \
                    table->table[16] 4.0   \
                    table->table[17] 4.0   \
                    table->table[18] 4.0   \
                    table->table[19] 4.0   \
                    table->table[20] 4.0
  call  kir_taum  TABFILL  {xdivsFiner} 2

                   
    /*fills the tabchannel with values for KIR_alpha & KIR_beta*/

    for(c = 0; c < {xdivsFiner} + 1; c = c + 1) 
         minf  = 1/(1 + {exp {(x - mvhalf + mshift)/mslope}})	
         taum  = {getfield kir_taum  table->table[{c}]}/qfactor
         setfield {path} X_A->table[{c}] {taum*1e-3}
         setfield {path} X_B->table[{c}] {minf}  
         x = x + increment
        
    end

     /* Defines the powers of m Hodgkin-Huxley equation*/
    setfield {path} Ek {Erev} Xpower 1 Ypower 0

    /* fill the tables with the values of tau and minf/hinf
     * calculated from tau and minf/hinf
     */
    tweaktau {path} X
       
end
