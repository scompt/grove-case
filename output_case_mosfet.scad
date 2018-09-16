include <lib/rj45_case.scad>
include <lib/vitamins.scad>
include <conf/config.scad>

x=65;
x1=3;
y1=45;
y2=y1;
z1=19;
z2=z1;

//default action PRINT or RENDER
ACTION=RENDER;
/* ACTION=PRINT; */

module part(cutout=NONE) {
  if (cutout==BOTTOM) {
    //part to cut as holes in the bottom case
  }
  else if (cutout==TOP) {
    //part to cut as holes in the top case
    translate([-5, -y1/2+12.5, 0]) {
      rj45();
    }
    translate([20-w*2, y1/2-17, 0]) {
      rotate([0, 0, -90]) {
        connector_holder_single(part=INNER,z=0);
      }
    }
  } else {
    //part to add to the case
    difference() {
      translate([10-w, -y1/2+12.5, 0]) {
        grove_rj45();
      }
      translate([-8+w, -y1/2+12.5-5, -f]) {
        cube(size=[5, 10, 10]);
      }
    }
    translate([20-w, y1/2, 0]) {
      rotate([0, 0, -90]) {
        connector_holder_single(ALL);
      }
    }
    translate([54, -11, 0]) {
      rotate([0, 0, 90]) {
        grove_relay();
      }
    }
  }
}

module assembly() {
  /* render() */
  box_bottom();
  translate([-w, 0, -w]) {
    /* %box_top(); */
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
