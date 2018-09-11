include <lib/rj45_case.scad>
include <lib/vitamins.scad>
include <conf/config.scad>

x=62;
x1=0;
y1=60;
y2=y1;
z1=19;
z2=z1;

//default action PRINT or RENDER
/* ACTION=RENDER; */
ACTION=PRINT;

module part(cutout=NONE) {
    if (cutout==BOTTOM) {
      //part to cut as holes in the bottom case
    }
    if (cutout==TOP) {
      //part to cut as holes in the top case
      translate([-5, -y1/2+12.5, 0]) {
        rj45();
      }
      translate([20-w*2, y1/2-17, 0]) {
        rotate([0, 0, -90]) {
          connector_holder(part=INNER,z=0);
        }
      }
    } else {
      difference() {
        translate([10-w, -y1/2+12.5, 0]) {
          grove_rj45();
        }
        translate([-8+w, -y1/2+12.5-5, -f]) {
          cube(size=[5, 10, 10]);
        }
      }
      //part to add to the case
      translate([20-w, y1/2-17, 0]) {
        rotate([0, 0, -90]) {
          connector_holder(ALL);
        }
      }
      translate([50, -y1/2+25, 0]) {
        rotate([0, 0, 90]) {
          grove_relay();
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

module print() {
  box_bottom();
  translate([x*1.5, 0, 0]) {
    rotate([0, -90, 0]) {
      box_top();
    }
  }
}
