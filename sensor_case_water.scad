include <lib/rj45_case.scad>
include <conf/config.scad>

x=57;
x1=3;
y1=25;
y2=y1;
z1=19;
z2=z1;

//default action PRINT or RENDER
ACTION=RENDER;

module part(cutout=NONE) {
  f=0.5;
  if (cutout==BOTTOM) {
    //part to cut as holes in the bottom case
    translate([x+w*1.5,0,3+w/2]){
      cube(size=[10, 20+f, w+f], center=true);
    }
  }
  else if (cutout==TOP) {
    //part to cut as holes in the top case
    translate([-5, 0, 0]) {
      rj45();
    }
  } else {
    //part to add to the case
    intersection()
    {
      union() {
        translate([10-w, 0, 0]) {
          grove_rj45();
        }
        /* translate([-8, -5, 0]) {
          cube(size=[5, 10, 10]);
        } */
        translate([50-w,0,0]){
          grove_module_holder();
        }
      }
      translate([-w, -y1/2-w, -w]) {
        cube(size=[x+w*2, y2+w*2, z2]);
      }
    }
  }
  translate([50-w,0,0]){
    %water_sensor();
  }
}

module assembly() {
  box_bottom();
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
    translate([0, -y1*1.5, 0]) {
      box_holder();
    }
  }
}
