include <MCAD/nuts_and_bolts.scad>
include <lib/grove.scad>
include <conf/config.scad>

x=53;
x1=7;
y1=22;
y2=53;
z1=17;
z2=32;

NONE=0;
BOTTOM=1;
TOP=2;

//default action PRINT or RENDER
ACTION=RENDER;

if (ACTION==PRINT) {
  print();
} else {
  assembly();
}


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
        x=x+w*2,
        x1=x1+w*1.5,
        y1=y1+w*2,
        y2=y2+w*2,
        z1=z1+w*2,
        z2=z2+w*2,
        w=w
      );
      translate([x+w*2, 0, z2/2+w]) {
        cube(size=[w*4+f, y2+w*2, z2+w*2], center=true);
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
    translate([-w*2-5, -y2, 5+w]) {
      cube(size=[x+w*5-x1, y2*2, z2+w*2]);
    }
    translate([-w*2, -y1/2, 0]) {
      cube(size=[w*3, y1, z1+z2]);
    }
    hull() {
      translate([x-x1, -y2/2, 0]) {
        cube(size=[x1+w, y2, z2]);
      }
      translate([x-x1, -y2/2, w+5]) {
        cube(size=[x1, y2, z2-5+f]);
      }
    }
    translate([x-x1+w*2, y2/2+w*2, z2+w]) {
      rotate([0, 30, 180]) {
        cube(size=[x1+w, y2+w*4, w*2]);
      }
    }
    translate([x-x1-w, -y2/2, w+5]) {
      cube(size=[x1+w, y2, z2-5]);
    }
    label();
  }
  difference() {
    part();
    part(cutout=BOTTOM);
  }
}

module clip_holes(
  M=3,
  w2=5,
) {
  for (i=clip_holes) {
    translate(i) {
      translate([0, 0, w2-METRIC_NUT_THICKNESS[M]+0.01]) {
        nutHole(size=M);
        rotate([180, 0, 0]) {
          boltHole(size=M,length=w2*2,$fn=8);
        }
      }
    }
  }
}

module box_holder() {
  ya=min(y1,y2);
  yb=max(y1,y2);
  w2=5;
  a=atan((y1-y2)/(x-x1))/2;
  b=-atan((z2-z1)/(x-x1));
  translate([-w*2.5, 0, -w*2-w2]) {
    difference() {
      block(
        x=x+w*4.5,
        x1=x1+w*2,
        y1=y1+w*3,
        y2=y2+w*4,
        z1=w2,
        z2=w2,
        w=w
      );
      translate([x-w*3, 0, 0]) {
        clip_holes(w2=w2);
      }
      translate([x+w*3, -w, w2-w+0.1]) {
        rotate([0, 180, 0]) {
          label();
        }
      }
    }
  }
  translate([-w*3.5, -y1/2-w*1.5, -w*2-w2]) {
    difference() {
      cube(size=[w, y1+w*3, w2+w*2.5]);
      translate([w/2, -w, w*2.5+w2]) {
        rotate([0, 45, 0]) {
          cube(size=[w*2, y1+w*5, w]);
        }
      }
    }
  }
  translate([x+w*3, -y2/2-w*2.5, -w*2-w2]) {
    cube(size=[w, y2+w*5, w*3+w2]);
    translate([-x1-w, 0, 0]) {
      cube(size=[x1+w, y2+w*5, w2]);
    }
    translate([-x1-w, -w, 0]) {
      cube(size=[x1+w*2, w, w*3+w2]);
    }
    translate([-x1-w, y2+w*5, 0]) {
      cube(size=[x1+w*2, w, w*3+w2]);
    }
  }
  translate([0, -(ya+(yb-ya)/2)/2-w*2.25, 0]) {
    clamp(w2=w2,a=a,b=b);
  }
  translate([0, (ya+(yb-ya)/2)/2+w*2.25, 0]) {
    clamp(w2=w2,a=180-a,b=-b);
  }
}

module clamp(w2=w,a=0,b=0) {
  za=min(z1,z2);
  zb=max(z1,z2);
  z=za+(zb-za)/2;
  translate([(x-x1)/2, 0, 0]) {
    rotate(a) {
      translate([-w*2, -w/2, -w*2-w2]) {
        hull() {
          cube(size=[w*4, w, z + w*5+w2]);
          translate([-w, 0, 0]) {
            cube(size=[w*6, w, w]);
          }
        }
        intersection() {
          translate([0, 0, z+w*2+w2]) {
            /* rotate([0,b,0]) */
            cube(size=[w*4, w*4, w*6]);
          }
          translate([w*2, w*0.75, z+w*5+w2]) {
            rotate([0,b,0])
            rotate([35, 0, 0]) {
              cube(size=[w*5, w*2.25, w*2],center=true);
            }
          }
        }
      }
    }
  }
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
        x1=x1+w,
        y1=y1+w,
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
