c = 3*10^8;
delta_r = 1;
Bsweep = c/2*delta_r;

range_max = 300;
Ts= 5.5*(range_max*2/c) ;

beat_freq = [0 1.1e6 13e6 24e6] ;
calculated_range = c*Ts*beat_freq/(2*Bsweep) 