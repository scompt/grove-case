include <conf/config.scad>

h=2;
di=2.2;
do=di*2;

$fn=20;

difference() {
  cylinder(d=do, h=h,center=true);
  cylinder(d=di, h=h+1,center=true);
}
