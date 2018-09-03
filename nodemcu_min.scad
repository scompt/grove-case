include <lib/nodemcu.scad>
include <lib/case2.scad>

board=NODEMCUY;
inset=RJ45Y;

x0=0;
y0=35;
x=x0+w+nodemcu_x+35;
y=y0+nodemcu_y+10+w*2;
z=50;

a=180;

grid_y=20;
grid_x=15;

joy_x=70;
joy_y=40;
disp_x=60;
disp_y=0;


/* translate([y+20,0,0]) */
rotate(90)
  assembly();
