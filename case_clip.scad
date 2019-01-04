include <sensor_case_water.scad>
include <lib/threaded-library/Thread_Library.scad>

l=50;
y=30;
wc=5;
d=20;
s=1;

ACTION=RENDER;
FILE="case_clip.scad";

module assembly() {
  rotate([180, 0, 0]) {
    translate([0, 0, 5+w*2]) {
      %box_holder();
    }
  }
  translate([x-50+5, 0, 0]) {
    clip(
      l=l,
      y=y,
      w=wc,
      d=d,
      size=s
    );
    screw(
      l=l,
      y=y,
      w=wc,
      d=d
    );
    stamp(
      l=l,
      y=y,
      w=wc,
      d=d
    );
  }
}

module print() {
  render()
  {
    translate([0, 0, y/2]) {
      rotate([90, 0, 0]) {
        clip(
          l=l,
          y=y,
          w=wc,
          d=d,
          size=s
        );
      }
    }
    translate([-d, d, -d/2-wc/4]) {
      screw(
        l=l,
        y=y,
        w=wc,
        d=d
      );
    }
    translate([d, d, -d/2+wc/2]) {
      stamp(
        l=l,
        y=y,
        w=wc,
        d=d
      );
    }
  }
}

module clip(
  l=50,
  y=30,
  w=5,
  d=20,
  size=s
) {
  for (i=[0:size-1]) {
    difference() {
      translate([l*i, -y/2, 0]) {
        cube(size=[l, y, w]);
      }
      translate([l*i+l-12.5, 0, 0]) {
        clip_holes();
      }
      translate([-0.5, 1, w-1.45]) {
        rotate([180, 0, 0]) {
          label();
        }
      }
    }
    difference() {
      translate([l*i, -y/2, d+w]) {
        cube(size=[l, y, w]);
      }
      translate([l*i+l-22.5, 0, d]) {
        trapezoidThreadNegativeSpace(
          length=w*3,
          pitch=w/2,
          pitchRadius=7.5
        );
        translate([0, 0, d/2-w]) {
          cylinder(r=7.5+w*0.75, h=w, center=true);
        }
      }
    }
  }
  translate([0, 0, d/2+w]) {
    rotate([90, 0, 0]) {
      difference() {
        cylinder(d=d+w*2, h=y, center=true);
        cylinder(d=d, h=y+1, center=true);
        translate([d/2, 0, 0]) {
          cube(size=[d, y*2, d+w*3], center=true);
        }
      }
    }
  }
}

module screw(
  l=50,
  y=30,
  w=5,
  d=20,
  r=7.5
) {
  translate([l-22.5, 0, d/2]) {
    difference() {
      trapezoidThread(
        length=d+w,
        pitch=w/2,
        pitchRadius=r
      );
      cylinder(r=r+w/2, h=w/2, center=true);
    }
    hull() {
      translate([0, 0, d+w]) {
        cylinder(r=r-w/8, h=1, center=true);
      }
      translate([0, 0, d+w+1]) {
        cylinder(r=r, h=1, center=true);
      }
      translate([0, 0, d+w+r/2]) {
        cube(size=[r*2.285, w, 0.1], center=true);
      }
    }
    translate([0, 0, d+w+r]) {
      rotate([90, 0, 0]) {
        cylinder(r=r*1.25, h=w, center=true);
      }
    }
  }
}

module stamp(
  l=50,
  y=30,
  w=5,
  d=20,
  r=7.5
) {
  translate([l-22.5, 0, d/2]) {
    difference() {
      cylinder(r=r+w/2, h=w, center=true);
      translate([0, 0, w/2]) {
        trapezoidThreadNegativeSpace(
          length=d+w,
          pitch=w/2,
          pitchRadius=r
        );
      }
    }
  }
}
