//genesis
//if2.g

reset

int i = 0
float inj =  280e-12     

float inject, delay, current_duration, total_duration
float start_current = 0
delay= 0.05
current_duration=0.4
total_duration=delay*2+current_duration
reset
for (i=0; i<1; i=i+1)
		        
    echo {inj} = "I inject"
	setfield {neuronname}/soma inject {start_current}
	step {delay} -time
	setfield {neuronname}/soma inject {inj}
	step {current_duration}  -time
	setfield {neuronname}/soma inject {start_current}
	step {{delay}+0.4} -time
	
	inj= {inj}+20.0e-12
end

