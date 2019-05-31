//genesis
/*
This is a graphics file. It is meant for the graphical
representation of the activity of a simple compartment
containing the HH type delayed rectifier potassium 
channel and a transient rat brain sodium channel that 
shows prepulse amplitude and duration dependence. 
*/

//----------------------------
// injection to the cell soma
//----------------------------

function inject_soma (dialog)
str dialog
setfield /input/injectpulse/somacurr gain {getfield {dialog} value}
end

//===========================
//setting the pulsegen object
//===========================
function make_input

float injwidth = 0.2 //sec
float injdelay = 0.01 //sec
float somacurrent = 2e-9 // injection current to soma

create neutral /input
create pulsegen /input/injectpulse
setfield /input/injectpulse level1 1.0 width1 {injwidth} \ 
delay1 {injdelay} baselevel 0.0 trig_mode 0 delay2 1 
create diffamp /input/injectpulse/somacurr
setfield /input/injectpulse/somacurr saturation 1 gain {somacurrent}
addmsg /input/injectpulse /input/injectpulse/somacurr PLUS output
addmsg /input/injectpulse/somacurr /cell/soma INJECT output

end

//----------------------
//       RUN STEP
//----------------------

function step_tmax
step {tmax} -time
end

//--------------------
//  Overlaying graphs
//-------------------

function overlaytoggle (widget)
str widget
setfield /##[TYPE=xgraph] overlay {getfield {widget} state}
end

//-------------------
// The control panel
//-------------------

function make_control

create xform /control [10,10,350,150]

create xlabel /control/label -label "Control Panel" \
-hgeom 30 -bg cyan

create xbutton /control/RESET -script reset -wgeom 33%\
-ygeom 0:label -offbg yellow

create xbutton /control/RUN -script step_tmax -xgeom 0:RESET \
-ygeom 0:label -wgeom 33% -offbg green

create xbutton /control/QUIT -script quit -xgeom 0:RUN \
-ygeom 0:label -wgeom 33% -offbg red

create xdialog /control/inject -label \
"Current Injection (amperes)" -value 2e-9 \
-script "inject_soma <widget>"

create xtoggle /control/overlay \
-script "overlaytoggle <widget>"
setfield /control/overlay offlabel "Overlay OFF" onlabel \
"Overlay ON" state 0 offfg blue onfg red
xshow /control

end

//-----------------
//     GRAPHS
//-----------------

function pulse_response
create xform /data
create xform /data/Vm [500,10,400,250]
create xlabel /data/Vm/label -label "Voltage Response" \
-hgeom 30 -bg pink
create xgraph data/Vm/voltage -xmin -0.01 -xmax 0.2 -ymin -0.10 \
-ymax 0.05
setfield ^ XUnits sec YUnits V
addmsg cell/soma /data/Vm/voltage PLOT Vm *soma *red
xshow /data/Vm

create xform /data/Ik [500,500,400,250]
create xlabel /data/Ik/label -label "Current Response" \
-hgeom 30 -bg pink
create xgraph data/Ik/current -xmax 0.2 -ymin -2.0e-9 -ymax 5.0e-10
setfield ^ XUnits sec YUnits A
addmsg cell/soma/Na_rat_sm /data/Ik/current PLOT Ik *Na *blue
addmsg cell/soma/Kdr_hip_traub91 /data/Ik/current PLOT Ik *K *green
xshow /data/Ik

create xform /data/Gk [10,500,400,250]
create xlabel /data/Gk/label -label "Channel Conductances" \
-hgeom 30 -bg pink
create xgraph data/Gk/conductances -xmax 0.2 -ymin 0.1 
setfield ^ XUnits sec YUnits mho
addmsg cell/soma/Na_rat_sm /data/Gk/conductances PLOT Gk *Na *blue
addmsg cell/soma/Kdr_hip_traub91 /data/Gk/conductances PLOT Gk *K *green
xshow /data/Gk

end

//*******************
//    Main Script
//*******************
make_input
make_control
pulse_response
