//genesis
//  BKchannel.g

/***************************		MS Model, Version 7.6	*********************
**************************** 	      BKchannel.g  	*********************
	Avrama Blackwell 	kblackw1@gmu.edu
	Rebekah Evans 		rcolema2@gmu.edu	
	Tom Sheehan 		tsheeha2@gmu.edu	
******************************************************************************

*****************************************************************************/
//==========================================================================
// /* non-inactivating BK-type Ca-dependent K current
// ** Moczydlowski and Latorre 1983, J. Gen. Physiol. 82:511-542.
// ** Implemented by Erik De Schutter BBF-UIA,
// ** with original parameters scaled for units: V, sec, mM. 
// ** Assumes tab2Dchannel "KC" has a sibling Ca_concen "Ca_conc". 
// ** Temprature is modified to be 35C                                      */

// //=======================================================================

function make_BK_channel
    float EK=-0.09  // V 
    float K1=0.003
    float K4=0.009
  //  int xdivs = 299
    int xdivs = 299
    int ydivs = {xdivs}
    float xmin, xmax, ymin, ymax
    xmin = -0.1; xmax = 0.05; ymin = 0.0; ymax = 0.005 // x = Vm, y = [Ca],mM
    int i, j
    float x, dx, y, dy, a, b
    float Temp = 35
    float ZFbyRT = 23210/(273.15 + Temp)
    if (!({exists BK_channel}))
        create tab2Dchannel BK_channel
        setfield BK_channel Ek {EK} Gbar 0.0  \
            Xindex {VOLT_C1_INDEX} Xpower 1 Ypower 0 Zpower 0
        call BK_channel TABCREATE X {xdivs} {xmin} {xmax} \
            {ydivs} {ymin} {ymax}
    end
    dx = (xmax - xmin)/xdivs
    dy = (ymax - ymin)/ydivs
    x = xmin
    for (i = 0; i <= xdivs; i = i + 1)
        y = ymin
        for (j = 0; j <= ydivs; j = j + 1)
            a = 480*y/(y + {K1}*{exp {-0.84*ZFbyRT*x}}) //y=y+50 from Wonryull's adjustments
            b = 280/(1 + y/({K4}*{exp {-1.00*ZFbyRT*x}}))
            setfield BK_channel X_A->table[{i}][{j}] {a}
            setfield BK_channel X_B->table[{i}][{j}] {a + b}
            y = y + dy
        end
        x = x + dx
    end
    setfield BK_channel X_A->calc_mode {LIN_INTERP}
    setfield BK_channel X_B->calc_mode {LIN_INTERP}

end



