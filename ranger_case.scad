include <lib/rj45_case.scad>
include <conf/config.scad>

x=53;
x1=10;
y1=22;
y2=53;
z1=18;
z2=32;

//default action PRINT or RENDER
ACTION=PRINT;
/* ACTION=RENDER; */

module part(cutout=NONE) {
  if (cutout==TOP) {
    translate([-5, 0, 0]) {
      rj45();
    }
  } else {
    difference() {
      translate([10-w, 0, 0]) {
        grove_rj45();
      }
      translate([-8+w, -5, -w]) {
        cube(size=[5, 10, 10]);
      }
    }
  }
  translate([x-8, 0, 12.5]) {
    rotate([0, 0, 90]) {
      rotate([90, 0, 0]) {
        if (cutout==BOTTOM) {
          //part to cut as holes in the case
          grove_ranger2();
        } else {
          //part to add to the case
          ranger_holder(h=5);
          // ranger installation position
          translate([0, 0, -6]) {
            %grove_ranger2();
          }
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
