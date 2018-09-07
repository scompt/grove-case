include <lib/rj45_case.scad>
include <conf/config.scad>

x=53;
y1=22;
y2=53;
z1=17;
z2=32;

assembly();
/* print(); */

module part(cutout=0) {
  translate([x-8, 0, 12.5]) {
    rotate([0, 0, 90]) {
      rotate([90, 0, 0]) {
        if (cutout) {
          //part to cut as holes in the case
          ranger_holder(h=5);
        } else {
          //part to add to the case
          grove_ranger2();
        }
      }
    }
  }
}

module print() {
  box_bottom();
  translate([x*1.5, 0, 0]) {
    rotate([0, 0, 180]) {
      rotate([0, -90, 0]) {
        box_top();
      }
    }
  }
}

module assembly() {
  box_bottom();
  translate([-w, 0, -w]) {
    %box_top();
  }
}
