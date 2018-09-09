include <lib/rj45_case.scad>
include <conf/config.scad>

x=62;
x1=0;
y1=25;
y2=y1;
z1=19;
z2=z1;

//default action PRINT or RENDER
ACTION=RENDER;

module part(cutout=NONE) {
  translate([50-w,0,0]){
    if (cutout==BOTTOM) {
      translate([4, 0, 0]) {
        moisture_sensor();
      }
      //part to cut as holes in the bottom case
    }
    if (cutout==TOP) {
      //part to cut as holes in the top case
    } else {
      //part to add to the case
      translate([4, 0, 0]) {
        grove_module_holder();
        %moisture_sensor();
      }
      translate([10, -y2/2-w, w]) {
        cube(size=[5, w, z2]);
      }
      translate([10, y2/2, w]) {
        cube(size=[5, w, z2]);
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
  translate([y2, y1*1.5, 0]) {
    rotate([0, -90, 0]) {
      box_top();
    }
  }
}
