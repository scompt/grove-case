include <lib/nodemcu.scad>
include <lib/case2.scad>
include <conf/nodemcu.scad>

/* ACTION=ASSY; */

if (ACTION==ASSY) {
  assembly(part=PART,a=0);
} else {
  rotate(90)
  assembly(part=PART);
}
