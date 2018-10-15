include <lib/nodemcu.scad>
include <lib/case2.scad>
include <conf/nodemcu.scad>

rotate([180, 0, 0]) {
  rotate(90)
  assembly(part=SEAL);
}
