/* 
**********************************************************
This file has been written to provide a disk output to the 
program Modelneuron.g.
program developed by Sriparna Majumdar, MBU, IISc. 
**********************************************************
*/
function disk_output 

create asc_file /out_ap_c

setfield /out_ap_c flush 1 leave_open 1 append 1

addmsg /cell/soma /out_ap_c SAVE Vm

end
