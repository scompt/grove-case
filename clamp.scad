include <lib/grove.scad>

for (j=[0:2]) {
  for (i=[0:9]) {
    translate([j*30, i*5, 0]) {
      rotate([90, 0, 0]) {
        grove_clamp();
      }
    }
  }
}
