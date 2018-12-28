include <lib/rj45_case.scad>
include <conf/config.scad>

x=58;
x1=0;
y1=25;
y2=y1;
z1=19;
z2=z1;

//default action PRINT or RENDER
/* ACTION=RENDER; */
ACTION=PRINT;

module part(cutout=NONE) {
  translate([0,0,0]){
    //part to cut as holes in the bottom case
    if (cutout==BOTTOM) {
      translate([50-w+1, -y2, 5+w]) {
        cube(size=[20, y2*2, z2+w], center=false);
      }
    }
    else if (cutout==TOP) {
      //part to cut as holes in the top case
      translate([-5, 0, 0]) {
        rj45();
      }
      translate([50-w+1+w, -y2, 5+w*2]) {
        cube(size=[20, y2*2, z2+w], center=false);
      }
    } else {
      //part to add to the case
      difference() {
        translate([10-w, 0, 0]) {
          grove_rj45();
        }
        translate([-8, -5, 0]) {
          cube(size=[5, 10, 10]);
        }
      }
      translate([50-w, 0, 0]) {
        grove_module_holder();
        %grove_module(flat=0,pos=0,block=0);
      }
    }
  }
}

module cover_bottom() {
  /* render() */
  translate([-4-w, -y2/2-w, 0]) {
    difference() {
      cube(size=[15+w*2, y2+w*2, z2-5]);
      translate([w+5, -w, w]) {
        cube(size=[15+w*2, y2+w*4, z2-5]);
      }
      translate([x1+w*4, y2+w*3, z2-5+w]) {
        rotate([0, 30, 180]) {
          cube(size=[x1+w*5, y2+w*4, w*2]);
        }
      }
      translate([0, w, -f]) {
        hull() {
          cube(size=[5, y2, z2-5-w+f]);
          translate([-w, 0, w]) {
            cube(size=[5, y2, z2-5-w+f*2]);
          }
        }
      }
      hull() {
        translate([8-w*2, y2/2-w+1, -f]) {
          cube(size=[5, 7, w]);
          translate([w, -w*2, w]) {
            cube(size=[5+w*2, 7+w*4, w]);
          }
        }
      }
      translate([4+w, y2/2+w, 0]) {
        translate([10, 0, 0]) {
          cylinder(d=2.5, h=10, center=true,$fn=12);
        }
      }
    }
  }
}

module assembly() {
  box_bottom();
  translate([50-w,0,5+w]){
    cover_bottom();
  }
  translate([-w, 0, -w]) {
    %box_top();
  }
  box_holder();
}

module print() {
  /* render() */
  {
    box_bottom();
    translate([y2, y1*1.5, 0]) {
      rotate([0, -90, 0]) {
        box_top();
      }
    }
    translate([y2*2, y1*1.5, -3+w]) {
      cover_bottom();
    }
    translate([0, -y1*1.5, 5+w]) {
      box_holder();
    }
  }
}
