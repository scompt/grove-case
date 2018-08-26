include <lib/grove.scad>
include <conf/config.scad>

x=53;
y1=25;
y2=50;
z1=20;
z2=30;

/* assembly(); */
box_bottom();
translate([x*1.5, 0, 0]) {
  rotate([0, 0, 180]) {
    rotate([0, -90, 0]) {
      box_top();
    }
  }
}

module assembly() {
  box_bottom();
  translate([-w, 0, -w]) {
    box_top();
  }
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
  y1=y1,
  y2=y2,
  z1=z1,
  z2=z2,
  w=w
) {
  intersection() {
    translate([-w*2, -y2, -w]) {
      cube(size=[x+7, y2*2, z2*2]);
    }
    difference() {
      box(
        x=x+w*2,
        y1=y1+w*2,
        y2=y2+w*2,
        z1=z1+w*2,
        z2=z2+w*2,
        w=w
      );
      translate([-5, 0, w]) {
        rj45();
      }
      label();
    }
  }
}

module box_bottom(
  x=x,
  y1=y1,
  y2=y2,
  z1=z1,
  z2=z2,
  w=w
) {
  translate([10, 0, 0]) {
    grove_rj45();
  }
  difference() {
    box_finish (
      x=x,
      y1=y1,
      y2=y2,
      z1=z1,
      z2=z2,
      w=w
    );
    translate([-w*2, -y2, 0]) {
      cube(size=[x+w*3-7, y2*2, z2+w*2]);
    }
    label();
  }
}

module box_finish (
  x=54,
  y1=30,
  y2=50,
  z1=20,
  z2=30,
  w=w
) {
  difference() {
    translate([0, 0, 0]) {
      box(
        x=x,
        y1=y1,
        y2=y2,
        z1=z1,
        z2=z2,
        w=w
      );
      ranger(holder=1);
    }
    translate([-2, 0, 0]) {
      rj45();
    }
    ranger();
  }
}

module ranger(holder=0) {
  translate([45, 0, 12.5]) {
    rotate([0, 0, 90]) {
      rotate([90, 0, 0]) {
        if (holder) {
          ranger_holder(h=5);
        } else {
          grove_ranger2();
        }
      }
    }
  }
}

module box(
  x=54,
  y1=30,
  y2=50,
  z1=20,
  z2=30,
  w=w
) {
  w2=w*2;
  difference() {
    translate([-w, 0, -w]) {
      block(
        x=x+w2,
        y1=y1+w2,
        y2=y2+w2,
        z1=z1+w2,
        z2=z2+w2,
        w=w
      );
    }
    block(
      x=x,
      y1=y1,
      y2=y2,
      z1=z1,
      z2=z2,
      w=w
    );
  }
}

module block(
  x=56,
  y1=30,
  y2=50,
  z1=20,
  z2=30,
  w=w
) {
  hull() {
    translate([0, -y1/2, 0]) {
      cube(size=[w, y1, z1]);
    }
    translate([x, -y2/2, 0]) {
      cube(size=[w,y2,z2]);
    }
    translate([x-7, -y2/2, 0]) {
      cube(size=[7,y2,z2]);
    }
  }
}
