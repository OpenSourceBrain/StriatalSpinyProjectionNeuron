//genesis
//gaba_channel.g

function make_GABA_channel

   str chanpath = "GABA_channel"
   // From Galarreta and Hestrin 1997 (used in Wolfs model)
   float tau1 = 0.25e-3
   float tau2 = 3.75e-3

   float gmax = 750e-12  //Modified Koos 2004 (Wolf uses 435e-12)
   float Ek = -0.060

	echo "XXXXXXXXXXXXXXX make_GABA_channel XXXXXXXXXXXXXXXX"
	echo "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
	echo "XXXXXXXXXXXXXXX make_GABA_channel XXXXXXXXXXXXXXXX"

   create synchan {chanpath}

   setfield {chanpath} tau1 {tau1} \
                       tau2 {tau2}\ 
                       gmax {gmax}\
                        Ek {Ek}

end


