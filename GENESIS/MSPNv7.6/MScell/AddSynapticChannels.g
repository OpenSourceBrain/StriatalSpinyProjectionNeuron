//genesis
//  AddSynapticChannels.g

/***************************		MS Model, Version 7.6	*********************
**************************** 	      AddSynapticChannels.g  	*********************
	Avrama Blackwell 	kblackw1@gmu.edu
	Rebekah Evans 		rcolema2@gmu.edu	
	Tom Sheehan 		tsheeha2@gmu.edu	
******************************************************************************

*****************************************************************************/

function addNMDAchannel(compPath, chanpath,caBuffer, gbar, ghk)

  str compPath, chanpath
  float gbar
  str caBuffer 

  copy /library/{chanpath} {compPath}/{chanpath}
  addmsg {compPath} {compPath}/{chanpath}/block VOLTAGE Vm
  addmsg {compPath} {compPath}/{chanpath} VOLTAGE Vm
  if (ghk==0)
    addmsg {compPath}/{chanpath}/block {compPath} CHANNEL Gk Ek
  end

  if (ghk==1)
    addmsg {compPath} {compPath}/{chanName}/GHK VOLTAGE Vm
    addmsg {compPath}/{chanName}/GHK {compPath} CHANNEL Gk Ek
  end

  // Set the new conductance
  float len = {getfield {compPath} len}
  float dia = {getfield {compPath} dia}
  float pi = 3.141592653589793
  float surf = {len*dia*pi}

/*	echo "XXXXXXXXXXXXXXX addNMDAchannel XXXXXXXXXXXXXXXX"
	echo "compPath = "{compPath}
	echo "chanpath = "{chanpath}
	echo "caBuffer = "{caBuffer}
	echo "gbar = "{gbar}
	echo "XXXXXXXXXXXXXXX addNMDAchannel XXXXXXXXXXXXXXXX"
*/
//  setfield {compPath}/{chanName} gmax {surf*gbar}
  setfield {compPath}/{chanpath} gmax {gbar}

  
 if ({isa dif_shell  {compPath}/{caBuffer}} )         // dif_shell 
  //    echo spine calcium model is dif_shell
 addmsg {compPath}/{chanpath}/block {compPath}/{caBuffer} FINFLUX Ik 0.1
 
  elif ({isa Ca_concen {compPath}/{caBuffer}})      // Ca_conc
 //     echo spine calcium model is Ca_conc
 addmsg {compPath}/{chanpath}/block {compPath}/{caBuffer} fI_Ca Ik 0.1
  end


end


function addSynChannel (compPath, chanpath, gbar)

  str compPath, chanpath
  float gbar

  copy /library/{chanpath} {compPath}/{chanpath}

  addmsg {compPath} {compPath}/{chanpath} VOLTAGE Vm
  addmsg {compPath}/{chanpath} {compPath} CHANNEL Gk Ek

  // Set the new conductance
  float len = {getfield {compPath} len}
  float dia = {getfield {compPath} dia}
  float pi = 3.141592653589793
  float surf = {len*dia*pi}

/*	echo "XXXXXXXXXXXXXXX addSynChannel XXXXXXXXXXXXXXXX"
	echo "compPath = "{compPath}
	echo "chanpath = "{chanpath}
	echo "gbar = "{gbar}
	echo "XXXXXXXXXXXXXXX addSynchannel XXXXXXXXXXXXXXXX"
*/

//  setfield {compPath}/{chanName} gmax {surf*gbar}
  setfield {compPath}/{chanpath} gmax {gbar}
end
 
 
