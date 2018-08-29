include <lib/case2.scad>

board=UNI;
inset=OLED_JOY_RJ45;

a=180;

translate([y+20,0,0])
rotate(90)
  assembly();
