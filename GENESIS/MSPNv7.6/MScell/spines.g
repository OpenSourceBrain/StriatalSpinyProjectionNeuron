//genesis
//  spines.g

/***************************		MS Model, Version 7.6	*********************
**************************** 	      spines.g  	*********************
	Avrama Blackwell 	kblackw1@gmu.edu
	Rebekah Evans 		rcolema2@gmu.edu	
	Tom Sheehan 		tsheeha2@gmu.edu	
******************************************************************************

*****************************************************************************/

include MScell/AddCaSpines.g

//****************make the spines************************************

function make_spines

float surf_neck, vol_neck, len_neck, dia_neck,dia_head,len_head,dia_head, surf_head,vol_head, shell_thick, dia_shell, shell_head, Ca_tau, kB, kE,r,Ca_base  

//int shellmode                                      
str buffer1 = "spineCa"          // name of the calcium pool in the spine
str buffer2   = "spineCaL"
str buffer3 = "buffer_NMDA"         // only to record NMDA-dependent [Ca]

// parameters:
       // for spine neck:
       len_neck=1e-6                               //0.16-2.13
       dia_neck=0.1e-6                             //(0.038-0.46)e-6
       // for spine head:
       dia_head=0.5e-6                              //adopt common size, no exact data are available now
       len_head=0.5e-6
       surf_head=dia_head*len_head*{PI}
       surf_neck=len_neck*dia_neck*{PI}
       // for calcium shells:
       shell_thick=0.1e-6
       dia_shell= dia_head - shell_thick*2
       shell_head={PI}*(dia_head*dia_head-dia_shell*dia_shell)/4


       kE =86.0                                   // Cater and Sabatini, 2004
       Ca_tau = 25.0e-3                            
       r= (1+kE)/Ca_tau
       Ca_base = 50e-6                            // baseline: 50 nM

//  vol_neck={len_neck*dia_neck*dia_neck*PI/4.0}
  if (!{exists spine})
     create compartment spine
  end

 addfield  spine position
 setfield  spine  \
           Cm     {{CM}*surf_neck} \
           Ra    { 4.0*len_neck*{RA}/(dia_neck*dia_neck*{PI})}  \
           Em     {ELEAK}     \
           initVm {EREST_ACT} \
           Rm     {{RM}/surf_neck} \
           inject  0.0         \
           dia     {dia_neck}       \
           len     {len_neck}    \
           position 0.0   




 create compartment spine/head
 addfield spine/head position
 setfield spine/head          \
         Cm     {{CM}*surf_head} \
         Ra    { 4.0*{RA}*len_head/(dia_head*dia_head*{PI})}  \
         Em     {ELEAK}           \
         initVm {EREST_ACT}       \
         Rm     {{RM}/surf_head} \
         inject  0.0              \
         dia     {dia_head}         \
         len     {len_head}       \
         position 0.0
/*combine neck-head of CA1 CA1_spine */
 addmsg spine/head spine RAXIAL Ra Vm 
 addmsg spine spine/head AXIAL Vm


// make calcium buffers 


str buffer1 = "spineCa"                         // calcium pool for the other calcium channels
str buffer2 = "spineCaL"                        // calcium pool for L-type Ca2+ channels
str buffer3 = "buffer_NMDA"                     // only to record NMDA-dependent [Ca]
	
 if ({shellMode}==0)
         makeCaBuffer {buffer1} spine/head        // to create detailed calcium shells
         copy   spine/head/{buffer1} spine/head/{buffer2}
         copy   spine/head/{buffer1} spine/head/{buffer3} 
     elif ({shellMode}==1)  // Sabatini's model.       Sabatini, 2001,2004
          create Ca_concen  spine/head/{buffer1}  // to create simplified Ca_pool here! 
        if ({CaDyeFlag}==2)
           kB = 220                     // Fluo-4, taken from Yasuda,et,al. 2004,STEK
           Ca_tau = (1+kE+kB)/r         // re-calculate time constant because of application of the new calcium-dye
        elif({CaDyeFlag}==3)
           kB = 70                      // Fluo-5F
           Ca_tau = (1+kE+kB)/r
        end

       
         float  shell_dia= dia_head - shell_thick*2
         float  shell_vol= {PI}*(dia_head*dia_head/4-shell_dia*shell_dia/4)*len_head
          setfield spine/head/{buffer1} \
                                 B          {1.0/(2.0*96494*shell_vol*(1+kE+kB))} \
                                 tau        {Ca_tau}                         \
                                 Ca_base    {Ca_base}   \
                                 thick      {shell_thick} 

        copy   spine/head/{buffer1} spine/head/{buffer2}
        copy   spine/head/{buffer1} spine/head/{buffer3}
        setfield   spine/head/{buffer2}  Ca_base  50e-6
  end 
 
 
	create neutral spine/presyn_ext
	create neutral spine/presyn_inh
 
pushe spine/head

/**************************************************************************************
******************to add NMDA/AMPA channels*******************************************
**************************************************************************************/

addSynChannel . {AMPAname} {AMPAgmax}
addNMDAchannel . {NMDAname} {buffer3} {NMDAgmax} 0 

 	setfield ../presyn_ext z 0
	addmsg   ../presyn_ext  ./{NMDAname} ACTIVATION z
	addmsg   ../presyn_ext  ./{AMPAname} ACTIVATION z
 
 
/**********************************end**********************************************

/// now to add GABA
 setfield ../presyn_inh z 0

 if({GABA2Spine}==1)
       addGABAchannel .  GABA_1  {GABAcond}         // added to spine head 
       addmsg   ../presyn_inh   ./GABA_1 ACTIVATION z 
       addGABAchannel .  GABA_2  {GABAcond}         // added to spine head 
       addmsg   ../presyn_inh   ./GABA_2 ACTIVATION z
 elif({GABA2Spine}==2)
       addGABAchannel  .. GABA_1      {GABAcond}         // added to spine neck
       addmsg   ../presyn_inh   ../GABA_1      ACTIVATION z
       addGABAchannel  .. GABA_2      {GABAcond}         // added to spine neck
       addmsg   ../presyn_inh   ../GABA_2      ACTIVATION z
 end

*/

if({addCa2Spine}==1)
/*************************************************************************************
****************** to add Calcium Channels********************************************
******************* L-type, R-type, and T-type
**************************************************************************************/
//  addCaChannel {obj} {compt} {Gchan} {CalciumBuffer}
float Pbar_CaL12, Pbar_CaL13, Pbar_CaR, Pbar_CaT

 Pbar_CaL12       =      3.35e-7
 Pbar_CaL13       =      4.25e-7
 Pbar_CaR         =     13e-7
 Pbar_CaT         =     0.235e-7

addCaChannelspines CaL12_channel      .  {Pbar_CaL12}    {buffer2}         // HVA CaL
addCaChannelspines CaL13_channel      .  {Pbar_CaL13}    {buffer2}      // LVA CaL
addCaChannelspines CaR_channel        .  {Pbar_CaR}      {buffer1}
addCaChannelspines CaT_channel        .  {Pbar_CaT}      {buffer1}

end

pope

end
//******************done making spines*********************************

//*****************begin function to add spines*********************************

function add_spines_evenly(cellpath,spine,a,b,density)
/* "spine"   :   spine prototype
** "density" :   1/um,  spine density; The number of spines in one compartment = density * compartment length. 
*/
 str cellpath,compt,spine,thespine,path
 int number,i
 float dia,len,surf_head,k,dia_dend,len_dend,surf_dend,a,b,density,position

 if(!{exists /library/{spine}})
   echo The spine protomodel has not been made! 
    return
 end

foreach compt ({el {cellpath}/##[TYPE=compartment]}) 
 if (!{{compt}=={{cellpath}@"/axIS"} || {compt}=={{cellpath}@"/ax"}}) 
    dia={getfield {compt} dia}
    position={getfield {compt} position}
     len={getfield {compt} len}
    if ({{getpath {compt} -tail}=="soma"})
              len = dia
    end
  //if the compartment is not a spine ,
  // and its position is between [a,b]
   if ({position>=a} && {position<b} ) 
     number = density * len * 1e6

   // make sure that one compartment has at least one spine
    if (number == 0)
       number = number + 1
    end

  for(i=1;i<=number;i=i+1)
       thespine = "spine"@"_"@{i}
       copy /library/{spine} {compt}/{thespine}
       addmsg {compt}/{thespine} {compt} RAXIAL Ra Vm
       addmsg {compt} {compt}/{thespine} AXIAL Vm
  end

 end // end of if position...

 end // end of if ... axIS



end // end of "foreach" loop

end
