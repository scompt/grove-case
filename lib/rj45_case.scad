include <lib/grove.scad>

x=53;
x1=7;
y1=22;
y2=53;
z1=17;
z2=32;

NONE=0;
BOTTOM=1;
TOP=2;

/* assembly(); */
/* print(); */

module label() {
  translate([0, -y1/2, -w+t]) {
    rotate([180,0,0]) {
      linear_extrude(t) {
        text(str(MAT), size=th, font=font, valign="top");
        translate([0, -th*2, 0]) {
          text(str(SRC," ",VER," "), size=th, font=font, valign="top");
        }
        translate([0, -th*4, 0]) {
          text(str(FILE), size=th, font=font, valign="top");
        }
      }
    }
  }
}

module box_top(
  x=x,
  x1=x1,
  y1=y1,
  y2=y2,
  z1=z1,
  z2=z2,
  w=w
) {
  intersection() {
    translate([-w*2, -y2, -w]) {
      cube(size=[x+x1+w*5, y2*2, z2*2]);
    }
    difference() {
      box(
        x=x+w,
        x1=x1,
        y1=y1+w*2,
        y2=y2+w*2,
        z1=z1+w*2,
        z2=z2+w*2,
        w=w
      );
      translate([-5, 0, w]) {
        rj45();
      }
      translate([x+w*2, 0, z2/2+w]) {
        cube(size=[w*4, y2+w*2, z2+w*2], center=true);
      }
      label();
      translate([0, 0, w]) {
        part(cutout=TOP);
      }
    }
  }
}

module box_bottom(
  x=x,
  x1=x1,
  y1=y1,
  y2=y2,
  z1=z1,
  z2=z2,
  w=w
) {
  translate([10-w, 0, 0]) {
    grove_rj45();
  }
  difference() {
    box_finish (
      x=x,
      x1=x1,
      y1=y1,
      y2=y2,
      z1=z1,
      z2=z2,
      w=w
    );
    translate([-w*2, -y2, 5]) {
      cube(size=[x+w*3-x1, y2*2, z2+w*2]);
    }
    translate([-w*2, -y1/2, 0]) {
      cube(size=[w*4, y1, z1]);
    }
    label();
  }
  part();
}

module box_finish (
  x=x,
  x1=x1,
  y1=y1,
  y2=y2,
  z1=z1,
  z2=z2,
  w=w
) {
  difference() {
    box(
      x=x,
      x1=x1,
      y1=y1,
      y2=y2,
      z1=z1,
      z2=z2,
      w=w
    );
    part(cutout=BOTTOM);
    translate([-w, 0, 0]) {
      rj45();
    }
  }
}

module box(
  x=x,
  y1=y1,
  y2=y2,
  z1=z1,
  z2=z2,
  w=w
) {
  w2=w*2;
  difference() {
    translate([-w, 0, -w]) {
      block(
        x=x+w2,
        x1=x1+w2,
        y1=y1+w2,
        y2=y2+w2,
        z1=z1+w2,
        z2=z2+w2,
        w=w
      );
    }
    block(
      x=x,
      x1=x1,
      y1=y1,
      y2=y2,
      z1=z1,
      z2=z2,
      w=w
    );
  }
}

module block(
  x=x,
  x1=x1,
  y1=y1,
  y2=y2,
  z1=z1,
  z2=z2,
  w=w
) {
  hull() {
    translate([0, -y1/2, 0]) {
      cube(size=[w, y1, z1]);
    }
    translate([x, -y2/2, 0]) {
      cube(size=[w,y2,z2]);
    }
    translate([x-x1, -y2/2, 0]) {
      cube(size=[x1,y2,z2]);
    }
  }
}
