include <lib/case2.scad>

//width
w=1.5;

x0=47;
x1=w;
y0=w+35;
y1=w;

x=x0+mega_x+x1+w*2;
y=y0+mega_y+y1+w*2;
z=40;

board=UNI;
inset=OLED_JOY;

a=180;

translate([y+20,0,0])
rotate(90)
  assembly();
