//genesis

/***************************		MS Model, Version 7.6	*********************
**************************** 	      graphics1.g 	*********************
	Avrama Blackwell 	kblackw1@gmu.edu
	Rebekah Evans 		rcolema2@gmu.edu	
	Tom Sheehan 		tsheeha2@gmu.edu	
******************************************************************************

*****************************************************************************/


/*********************** Begin Local Subroutines *****************************/
/*****************************************************************************/

	//************************ Begin function record_channel *******************
	function record_channel(compt,channel,xcell, color)
 		str compt,xcell,channel, color		
 		str path, graphic_path
                       
		path = {neuronname}@"/"@{compt}@"/"@{channel}
		if ({channel}=="Ca_difshell_1"||{channel}=="Ca_difshell_2"||	\
															{channel}=="Ca_difshell_3")
			if( {isa difshell {path}})
				addmsg {neuronname}/{compt}/{channel} 							\
										{xcell}/Ca PLOT C  *	{channel}  *{color}
			elif( {isa Ca_concen {path}})
				addmsg {neuronname}/{compt}/{channel} 							\
										{xcell}/Ca PLOT Ca *{compt}  *{color}
			end
		else 
			addmsg {neuronname}/{compt}/{channel} {xcell}/channels 			\
										PLOT Ik *{channel} *{color}
		end 
	end
	//************************ End function record_channel *********************
	//**************************************************************************

	//************************ Begin function record_channel *******************
	function record_voltage (compt, xcell,color)
 		str compt, xcell, color
 	
 		str path, spacer, graphic_path
 	
		spacer = "        "
		graphic_path = {compt}@{spacer}
    	addmsg {neuronname}/{compt} {xcell}/v PLOT Vm *{graphic_path} *{color}
	end
	//************************ End function record_channel *********************
	//**************************************************************************
	
	//************************ Begin function step_tmax ************************
	function step_tmax
   	reset
   	setfield /cell/soma inject 0
   	step 5000
   	setfield /cell/soma inject {getfield /control/Injection value}
   	step 20000
   	setfield /cell/soma inject 0.0
	end
	//************************ End function step_tmax **************************
	//**************************************************************************
	
	//************************ Begin function set_inject ***********************
	function set_inject(dialog)
    	str dialog
    	setfield /cell/soma inject {getfield {dialog} value}
	end
	//************************ End function set_inject *************************
	//**************************************************************************
	
	//************************ Begin function overlaytoggle ********************
	function overlaytoggle(widget)
    	str widget
    	setfield /##[TYPE=xgraph] overlay {getfield {widget} state}
	end
	//************************ End function overlaytoggle **********************
	//**************************************************************************
	
	//************************ Begin function add_overlay **********************
	function add_overlay
		create xtoggle /control/overlay   -script "overlaytoggle <widget>"
		setfield /control/overlay offlabel "Overlay OFF" onlabel "Overlay ON" \
																								state 0
	end
	//************************ End function add_overlay ************************
	//**************************************************************************

/*********************** End Local Subroutines *******************************/
/*****************************************************************************/


/*********************** Begin Externally Available Subroutines **************/
/*****************************************************************************/

	//************************ Begin function make_control *********************
	function make_control
    	create xform /control [1050,0,250,145]
    	create xlabel /control/label -hgeom 25 -bg cyan -label "CONTROL PANEL"
       
    	create xbutton /control/RESET -wgeom 33%       -script reset
    	create xbutton /control/RUN  -xgeom 0:RESET -ygeom 0:label -wgeom 33% \
         -script step_tmax
         
    	create xbutton /control/QUIT -xgeom 0:RUN -ygeom 0:label -wgeom 34% 	 \
      	-script quit
    	create xdialog /control/Injection -label "Inject Amps" 					 \
         -value 304.95e-12 -script "set_inject <widget>"
   
    	xshow /control
	end
	//************************ End function make_control ***********************
	//**************************************************************************

	//************************ Begin function make_graph ***********************	
	function make_graph (cellname)
		str cellname
		str xcell = "/data"	
		float tmax = 0.6
		float xmin = 0.01
					
		create xform  /data [0,0,1000,1000]
		create xlabel /data/label [10,0,95%,25] 							\
			-label " MSN Cell"  													\
      	-fg    red

		create xgraph /data/soma [10,10:label.bottom, 50%, 45%] 			\
      	-title "Membrane Potential in the Soma"  					\
      	-bg    white

		create xgraph /data/NMDACa [10,10:soma.bottom,50%,45%] 	\
      	-title "NMDA calcium in spine"  										\
      	-bg    white 
	
		create xgraph /data/TotalCa [10:soma.right,10:label.bottom,50%,45%] \
      	-title "Total Calcium Concentration" 			\
      	-bg    white
      
		create xgraph /data/spineVm	[10:soma.right,10:TotalCa.bottom,48%,45%] 					\
      	-title "spineVm" 			\
      	-bg    white

		setfield /data/soma      	xmin {xmin} xmax {tmax+0.01}   	\
											ymin -0.1 ymax 0.05
		setfield /data/TotalCa     	xmin {xmin} xmax {tmax+0.01}   	\
											ymin 0 ymax .003
		setfield /data/NMDACa 		xmax {tmax+0.8}  ymin 0 			\
											ymax .01
		setfield /data/spineVm   	xmin {xmin} xmax {tmax+0.01}   	\
											ymin -0.1 ymax 0.05

  		useclock /data/soma					 	1
  		useclock /data/TotalCa        			1 
  		useclock /data/NMDACa        			1 
  		useclock /data/spineVm  			1
		xshow /data
	
		reset

	addmsg {cellname}/soma /data/soma PLOT Vm *Vm *black
	 
	addmsg {cellname}/secdend1/spine_1/head/ /data/spineVm PLOT Vm *Vm *black
	addmsg {cellname}/secdend1/spine_1/head/spineCa /data/TotalCa PLOT Ca *Ca *black
	 
	addmsg {cellname}/secdend1/spine_1/head/buffer_NMDA /data/NMDACa PLOT Ca *Ca *black
	
end
	//************************ End function make_graph *************************
	//**************************************************************************
	
/*********************** End Externally Available Subroutines ****************/
/*****************************************************************************/




