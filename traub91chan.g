//genesis

/* FILE INFORMATION
** The 1991 Traub set of voltage and concentration dependent channels
** Implemented as tabchannels by : Dave Beeman
**      R.D.Traub, R. K. S. Wong, R. Miles, and H. Michelson
**	Journal of Neurophysiology, Vol. 66, p. 635 (1991)
*/

// CONSTANTS
float EREST_ACT = -0.080 /* hippocampal cell resting potl */
float ENA = 0.125 + EREST_ACT // 0.045
float EK = -0.015 + EREST_ACT // -0.095
float ECA = 0.140 + EREST_ACT // 0.080
float SOMA_A = 2.827e-9       // soma area in square meters

//========================================================================
//                Tabchannel K(DR) Hippocampal cell channel
//========================================================================
function make_Kdr_hip_traub91
        if ({exists Kdr_hip_traub91})
                return
        end

        create  tabchannel      Kdr_hip_traub91
                setfield        ^       \
                Ek              {EK}	\	           //      V
                Gbar            { 50.0*SOMA_A }    \      //      S
                Ik              0       \                  //      A
                Gk              0       \                  //      S
                Xpower  4       \
                Ypower  0       \
                Zpower  0

                setupalpha Kdr_hip_traub91 X               \
                           {16e3 * (0.0351 + EREST_ACT)}   \  // AA
                           -16e3                           \  // AB
                           -1.0                            \  // AC
                           {-1.0 * (0.0351 + EREST_ACT) }  \  // AD
                           -0.005                          \  // AF
                           250                             \  // BA
                           0.0                             \  // BB
                           0.0                             \  // BC
                           {-1.0 * (0.02 + EREST_ACT)}     \  // BD
                           0.04                               // BF

end
