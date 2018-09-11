ALL=0;
INNER=1;
OUTER=2;

module connector() {
  rotate([0, 90, 0]) {
    translate([0, 0, -2]) {
      cylinder(r=3.5, h=10);
    }
    cylinder(r=5, h=11);
    hull() {
      translate([-5, -5.5, 10]) {
        cube(size=[10, 11, 17]);
      }
      translate([-12/2, -17/2, 22]) {
        cube(size=[12, 17, 10]);
      }
    }
    translate([-6, -5, 31]) {
      cube(size=[10, 10, 7]);
    }
  }
}

module connector_holder(part=ALL,z=50) {
  difference() {
    if (part==ALL || part==OUTER) {
      translate([-17, -20, 0]) {
        cube(size=[34.5,36, 5+w]);
      }
    }
    if (part<OUTER) {
      union() {
        translate([-8.5, -20-f, 5]) {
          rotate(90)
          scale([1.02, 1.02, 1.02]) {
            connector();
          }
          translate([-5, 0, 0]) {
            cube(size=[10, 11, z/2]);
          }
        }
        translate([8.5, -20-f, 5]) {
          rotate(90)
          scale([1.02, 1.02, 1.02]) {
            connector();
          }
          translate([-5, 0, 0]) {
            cube(size=[10, 11, z/2]);
          }
        }
      }
    }
  }
}
