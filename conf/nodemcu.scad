include <lib/nodemcu.scad>
include <lib/grove.scad>

board=NODEMCU;
inset=RJ45LEDBTN;

hook_pos="X";

x0=35;
y0=0;
x=x0+w*5+nodemcu_y+w*4+12.5;
y=y0+10+nodemcu_x+w*4;
z=50;

a=180;
/* al=a/2*0.98; */

grid_y=14;
grid_x=15;

joy_x=70;
joy_y=40;
disp_x=60;
disp_y=0;
