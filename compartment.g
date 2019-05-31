//genesis
/* 
	functions defined in this script
=============================================================================
	FUNCTION NAME		ARGUMENTS
=============================================================================
	makecompartment		(path,l,d,Eleak)
=============================================================================
All the units are SI units (mks)
*/

//=================================================
//                    COMPARTMENT
//=================================================
function makecompartment(path, l, d, Erest)
    str path
    float l, d
    float Erest
    float area = l*PI*d
    float xarea = PI*d*d/4
    // ohms-m^2
    float rm = 0.33333
    // F/m^2
    float cm = 0.01
    // ohms-m
    float ra = 0.3

    create compartment {path}
    // V
    // ohm
    // F
    // ohm
    setfield {path} Em {Erest} Rm {rm/area} Cm {cm*area} Ra {ra*l/xarea}
end
