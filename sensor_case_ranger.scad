include <lib/rj45_case.scad>
include <conf/config.scad>

x=53;
x1=15;
y1=22;
y2=53;
z1=18;
z2=33;

//default action PRINT or RENDER
/* ACTION=PRINT; */
/* ACTION=ASSY; */

module part(cutout=NONE) {
  if (cutout==TOP) {
    translate([-5, 0, 0]) {
      rj45();
    }
  } else if (cutout==BOTTOM) {
  } else {
    difference() {
      translate([10-w, 0, 0]) {
        grove_rj45(cone=true);
      }
      translate([-8+w, -5, -w]) {
        cube(size=[5, 10, 10]);
      }
    }
  }
  translate([x-10, 0, 16]) {
    rotate([0, 0, 90]) {
      rotate([90, 0, 0]) {
        if (cutout==BOTTOM) {
          //part to cut as holes in the case
          grove_ranger2(1);
        } else if (cutout==TOP) {
        } else {
          //part to add to the case
          difference() {
            intersection() {
              ranger_holder(h=8,cone=false);
              translate([0, 0, 5]) {
                cube(size=[x, z2, x1], center=true);
              }
            }
            *translate([-7.5, 25/2, 0]) {
              cube(size=[20, 20, 17], center=true);
            }
          }
          // ranger installation position
          translate([0, 0, -8]) {
            %grove_ranger2();
          }
        }
      }
    }
  }
}

module print() {
  /* render() */
  {
    translate([0, 0, x+w]) {
      rotate([0, 90, 0]) {
        box_bottom();
      }
    }
    translate([x*1, 0, 0]) {
      rotate([0, 0, 180]) {
        rotate([0, -90, 0]) {
          box_top();
        }
      }
    }
    translate([w*3, -y2*1.5, 5+w]) {
      box_holder();
    }
  }
}

module assembly() {
  box_bottom();
  translate([-w, 0, -w]) {
    if (ACTION==RENDER) {
      %box_top();
    } else {
      box_top();
    }
  }
  box_holder();
}
