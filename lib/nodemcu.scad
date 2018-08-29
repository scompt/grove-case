include <lib/grove.scad>
include <lib/arduino.scad>

nodemcu_x=72;
nodemcu_y=44;

nodemcu_holes=[
[20.5,2.5,0],
[20.5,nodemcu_y-2.5,0],
[nodemcu_x-2.5,2.5,0],
[nodemcu_x-2.5,nodemcu_y-2.5,0]
];

/* !nodemcu_grove_shield(); */
module nodemcu_grove_shield() {
  translate([-nodemcu_x/2, -nodemcu_y/2, 0]) {
    difference() {
      color("darkgrey",0.6) cube(size=[nodemcu_x,nodemcu_y,1.5]);
      for (i=nodemcu_holes) {
        translate(i) {
          cylinder(d=3, h=10, center=true);
        }
      }
    }
    translate([4, 3.5, -1]) {
      color("black",0.6) cube(size=[4,37,9.5]);
    }
    translate([29, 3.5, -1]) {
      color("black",0.6) cube(size=[4,37,9.5]);
    }
    for (x=[0:2]) {
      for (y=[0:2]) {
        translate([43+2.5+9*x, 3+5+14*y, 0]) {
          color("white",0.6) grove_con();
        }
      }
    }
  }
}
/* !nodemcu_shield_holder(); */
module nodemcu_shield_holder(h=3) {
  translate([-nodemcu_x/2, -nodemcu_y/2, 0]) {
    holder_screw(h=h,holes=nodemcu_holes);
  }
  translate([0, 0, 3]) {
    %nodemcu_grove_shield();
  }
}
