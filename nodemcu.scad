include <lib/nodemcu.scad>
include <lib/case2.scad>

board=NODEMCU;
inset=OLED_JOY_RJ45;

x0=35;
y0=0;
x=x0+w+nodemcu_y+65;
y=y0+nodemcu_x+w*4;
z=50;

a=180;

grid_y=20;

joy_x=70;
joy_y=40;
disp_x=60;
disp_y=0;


/* translate([y+20,0,0]) */
rotate(90)
  assembly();
