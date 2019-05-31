// genesis

/* This channel is the Rat Brain type IIA sodium channel modeled as a tab 
channel. The activation and inactivation parameters have been determined for 
these channels in the CHO surrogate system in which the alpha subunit of the 
channel has been heterologously expressed. 

The channel parameters are modeled to m^3h kind of model. The slow inactivation
parameter has to be added to it. 

Model implemented by Sriparna Majumdar, MBU, IISc, '2002 */

include constants.g
//===============================================================
//		 Voltage gated Sodium (Na) Channel from Rat Brain 
//===============================================================

function make_Na_rat_sm  // Na current
str compartment 
float EREST = -.080 // resting membrane potl.
float ENa = 0.125 + EREST   //reversal potential (V)
float SOMA_A = 2.827e-9 //sq. m

//****************************************
//checking if the channel already exists
//****************************************

if ({exists Na_rat_sm})
	return
end

//********************************
// creating the tab channel object
//********************************

create tabchannel Na_rat_sm
setfield Na_rat_sm Ek {ENa} Gbar {7000.0*SOMA_A} Ik 0 Gk 0 \
Xpower 3 Ypower 1 Zpower 0

//**************************************************
//call Na_rat_sm TABCREATE X  40 -0.130 0.070
//setfield Na_rat_sm \
//X_A {file2tab tau_m_c.data X_A table -skiplines 1}
//X_B {file2tab m_inf_c.data X_B table -skiplines 1}

//call Na_rat_sm TABCREATE Y 40 -0.130 0.070

//setfield Na_rat_sm \
//Y_A {file2tab tau_h_c.data Y_A table -skiplines 1}
//Y_B {file2tab h_inf_c.data Y_B table -skiplines 1}
//*************************************************


//alpha for the control data
//setupalpha Na_rat_sm X \
//{0.1705e6*(0.06766+EREST)} -0.1705e6 -1.0 {-1.0*(0.06766+EREST)} \
//-0.0049368 \  //Alpha table
//0.626e3 0.0 0.0 {-1.0*(0.07783+EREST)} 0.02837 //Beta table 

//beta for the control
setupalpha Na_rat_sm Y \  //control data
0.0041e3 0.0 0.0 {-1.0*(0.1189+EREST)} 0.03798 \ //Alpha table
1.411e3 0.0 1.0 {-1.0*(0.07337+EREST)} -0.009042  //Beta table

end
