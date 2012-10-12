//genesis
// globals.g 

/***************************		MS Model, Version 7.6	*********************
**************************** 	      globals.g 	*********************
	Avrama Blackwell 	kblackw1@gmu.edu
	Rebekah Evans 		rcolema2@gmu.edu	
	Tom Sheehan 		tsheeha2@gmu.edu	
******************************************************************************

*****************************************************************************/
        float ELEAK = -0.070
        float PI = 3.1415926
        float RA = 1.0;
        float RM = 8.69565217;
        float CM = 0.01;
        float EREST_ACT = -0.085
 	float TEMPERATURE = 35
	str  CA_BUFF_1 = "Ca_difshell_1"     // L and T type channels
	str  CA_BUFF_2 = "Ca_difshell_2"     // coupled to the other channels
	str  CA_BUFF_3 = "Ca_difshell_3"     // all calcium channels

	int CaDyeFlag = 0    // flags of calcium dye. "0" means NO calcium dyes.
                     
	int shellMode = 1    //  mode = 1 : simple calcium pool adopted from  Sabatini's work(Sabatini, 2001, 2004)

//parameters determined by hand tuning to match spike width, AHP shape &amp, fI curve

        str gNaFprox={90000}  //qfactor = 1.2   
        str gNaFmid={2730}
        str gNaFdist={975}

        str gKAfprox={3214/4.2}   //qfactor=1.5 for inact
        str gKAfmid={471/2.8}     //1/qfactor=1.5 for act
        str gKAfdist={314/2.8}

        str gKAsprox={277*1.3}    //qfactor=2	 
        str gKAsdist={22.9*1.7}

        str gKIR=8 		         //qfactor = 0.5
        str gKDR={7.25/1.2}       //qfactor = 0.5  

		str gBK = 10
		str gSK = 2
		
		
	float gCaL13 = {1.5*1.0625e-7}  //qfactor=2
	float gCaT  =  {1.5*0.5875e-8}
	float gCaR  =  {1.5*6.5e-7}
	float gCaN =   {1.5*2.5e-7}       //qfactor=2
	float gCaL12 = {1.5*0.8375e-7}    //qfactor=2

float qfactorKDR = 0.5    
float qfactorNaF =1.2 
float qfactorkAs=2.5
float qfactorkAf=1.5 	 
