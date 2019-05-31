//genesis
// initialize the random # generator
randseed 

float PI = 3.14159

// channel equilibrium potentials	V
// resting membrane potential

float EREST = -0.080
float ENa = 0.125 + EREST
float EK = -0.012 + EREST

// leakage potential
float Eleak = 0.0106 + EREST

// cell dimensions (meters)

float soma_l = 30e-6 // cylinder equivalent to 30 micron sphere
float soma_d = 30e-6
float SOMA_A = soma_l*PI*soma_d*1.0  //sq. meter 



// peak channel conductance	S/synapse
float GNa = 80e-12
float GK = 40e-12
