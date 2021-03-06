include <arduino.scad>
include <grove.scad>
include <hinge.scad>
include <vitamins.scad>
include <conf/config.scad>

OLED_JOY="oled_joy";
OLED_JOY_RJ45="oled_joy_rj45";
RJ45="rj45";
RJ45LEDBTN="rj45_ledbtn";
RJ45Y="rj45y";
TOUCH_DISPLAY="touch_display";
NODEMCU="NodeMCUx";
NODEMCUY="NodeMCUy";

PART=0;
CUTOUT=1;

ALL="all";
SEAL="seal";

//width
w=1.5;

x0=47;
x1=w;
y0=w+35;
y1=w;

x=x0+mega_x+x1+w*2;
y=y0+mega_y+y1+w*2;
z=50;

//gap
g=0.45;

a=0;

board=MEGA;
inset=TOUCH_DISPLAY;

grid_x=14;
grid_y=17.5;

joy_x=70;
joy_y=60;
disp_x=50;
disp_y=30;

$fn=20;

/* assembly(); */
module assembly(
  x=x,
  x0=x0,
  y0=y0,
  di=w*2,
  y=y,
  z=z,
  w=w,
  g=g,
  a=a,
  part=PART
) {
  yh=di/2+g+w*2;
  al=a/2*0.08;
  t=w/2;
  th=4;
  font="Liberation Sans:style=Bold";
  if (part==ALL || part==PART) {
  hinge(
    h=z/2,
    x=x,
    w=w,
    x1=w*2,
    g=g,
    di=di,
    a=a
  );
  translate([0, yh, 0]) {
    difference() {
      boxx(board=board,x=x,y=y,z=z,di=di);
      if (x0>0) {
        translate([x-t, yh+w*2, z/2-w*4])
        rotate(90) rotate([90])
        {
          linear_extrude(t) {
            text(str(board,"/",inset,"/",MAT), size=th, font=font, valign="top");
            translate([0, -th*2, 0]) {
              text(str(SRC," ",VER), size=th, font=font, valign="top");
            }
          }
        }
      } else {
        translate([w*2, yh+w*2+th*2, w-t])
        {
          linear_extrude(t) {
            text(str(board,"/",inset,"/",MAT), size=th, font=font, valign="top");
            translate([0, -th*2, 0]) {
              text(str(SRC," ",VER), size=th, font=font, valign="top");
            }
          }
        }
      }
    }
    translate([x/10, yh+y, w*2+g]) {
      latch(x=x/10,di=w*2,w=w,g=g,a=al);
    }
    translate([x*0.9, yh+y, w*2+g]) {
      latch(x=x/10,di=w*2,w=w,g=g,a=al);
    }
   }
  translate([0,0,z/2]){
    rotate([a-180, 0, 0]) {
      translate([0,-yh-y,-z/2]){
        boxx(
          inset=inset,
          x=x,
          y=y,
          z=z,
          w=w,
          di=di
        );
      }
      translate([w, -yh-y, w-z/2]) {
        inset(inset=inset,x=x,y=y,z=z-w,x0=x0,y0=y0);
      }
    }
  }
  translate([w, yh, w]) {
    inset(board=board,x=x,y=y,z=z-w,x0=x0,y0=y0);
  }
  if (hook_pos=="X") {
    translate([0, y+yh, 0]) {
      rotate([0, 0, -90]) {
        hooks(x=y,y=x,w=w);
      }
    }
  } else {
    hooks(x=x,y=y+yh,w=w);
  }
}
if (part==ALL || part==SEAL) {
  translate([0, yh, 0]) {
    if (board==NODEMCU) {
      difference() {
        seal2();
        translate([x0+nodemcu_y/2+w*2, nodemcu_x/2+w*5, 0]) {
          rotate(-90){
            nodemcu_usb(h=10);
          }
        }
      }
    } else {
      %seal();
    }
  }
}
}

module boxx(
  inset="",
  board="",
  x=x,
  y=y,
  z=z,
  w=w,
  di=w*2
){
  if (inset==OLED_JOY) {
    box_oled_joy(
      x=x,
      y=y,
      z=(z-w)/2,
      w=w,
      di=di
    );
  }
  else if (inset==OLED_JOY_RJ45) {
    box_oled_joy_rj45(
      x=x,
      y=y,
      z=(z-w)/2,
      w=w,
      di=di
    );
  }
  else if (inset==RJ45) {
    box_rj45(
      x=x,
      y=y,
      z=(z-w)/2,
      w=w,
      di=di
    );
  }
  else if (inset==RJ45LEDBTN) {
    box_rj45_ledbtn(
      x=x,
      y=y,
      z=(z-w)/2,
      w=w,
      di=di
    );
  }
  else if (inset==RJ45Y) {
    box_rj45y(
      x=x,
      y=y,
      z=(z-w)/2,
      w=w,
      di=di
    );
  }
  else if (inset==TOUCH_DISPLAY) {
    box_touch_display(
      x=x,
      y=y,
      z=(z-w)/2,
      w=w,
      di=di
    );
  }
  else if (board==MEGA) {
    box_mega(
      x=x,
      y=y,
      z=(z-w)/2,
      w=w,
      di=di
    );
  }
  else if (board==UNO) {
    box_uno(
      x=x,
      y=y,
      z=(z-w)/2,
      w=w,
      di=di
    );
  }
  else if (board==NODEMCU) {
    box_nodemcu(
      x=x,
      y=y,
      z=(z-w)/2,
      w=w,
      di=di
    );
  }
  else if (board==NODEMCUY) {
    box_nodemcuy(
      x=x,
      y=y,
      z=(z-w)/2,
      w=w,
      di=di
    );
  }
}

module inset(
  board="",
  inset="",
  x=x,
  y=y,
  z=z-w,
  x0=x0,
  y0=y0
) {
  if (inset==OLED_JOY) {
    inset_oled_joy(x=x,y=y,z=z-w,x0=x0,y0=y0);
  }
  else if (inset==OLED_JOY_RJ45) {
    inset_oled_joy_rj45(x=x,y=y,z=z-w,x0=x0,y0=y0);
  }
  else if (inset==RJ45) {
    inset_rj45(x=x,y=y,z=z-w,x0=x0,y0=y0);
  }
  else if (inset==RJ45LEDBTN) {
    inset_rj45_ledbtn(x=x,y=y,z=z-w,x0=x0,y0=y0);
  }
  else if (inset==RJ45Y) {
    inset_rj45y(x=x,y=y,z=z-w,x0=x0,y0=y0);
  }
  else if (inset==TOUCH_DISPLAY) {
    inset_touch_display(x=x,y=y,z=z-w,x0=x0,y0=y0);
  }
  else if (board==MEGA) {
    inset_mega(x=x,y=y,z=z-w,x0=x0,y0=y0);
  }
  else if (board==UNO) {
    inset_uno(x=x,y=y,z=z-w,x0=x0,y0=y0);
  }
  else if (board==NODEMCU) {
    inset_nodemcu(x=x,y=y,z=z-w,x0=x0,y0=y0);
  }
  else if (board==NODEMCUY) {
    inset_nodemcuy(x=x,y=y,z=z-w,x0=x0,y0=y0);
  }
}


module seal(
  x=x,
  x0=x0,
  y=y,
  y0=y0,
  z=z,
  w=w,
  g=g,
  h=w*4.5
) {
  di=w*2;
  difference() {
    translate([-w/2, -w/2, z/2-w*2.5]) {
      difference() {
        cube(size=[x+w, y+w, h]);
        translate([w*2, w*2, -w]) {
          cube(size=[x-w*3, y-w*3, h+w*2]);
        }
        /* #difference() {
          translate([w/2, w/2, w*2.5]) {
            cube(size=[x, y, w*2]);
          }
          translate([w+w/2, w+w/2, w*3-1]) {
            cube(size=[x-w*2, y-w*2, w*2+2]);
          }
        } */
        rounded_border(
          w=w,
          x=x,
          y=y,
          h=h
        );
      }
    }
    boxx(
      board=board,
      x=x,
      y=y,
      z=z,
      w=w,
      di=di
    );
    translate([w, 0, w*1.5]) {
      inset(board=board,x=x,y=y,z=z-w,x0=x0,y0=y0);
    }
  }
}

module seal2(
  x=x,
  x0=x0,
  y=y,
  y0=y0,
  z=z,
  w=w,
  g=g,
  h=w*4.5
) {
  di=w*2;
  difference() {
    translate([-w/2, -w/2, z/2-w*2.5]) {
      difference() {
        hull() {
          translate([w/2, w/2, 0]) {
            cube(size=[x, y, w]);
          }
          translate([0, 0, h-w*2]) {
            cube(size=[x+w, y+w, w]);
          }
        }
        hull() {
          translate([x0+w*3-w/2, w*2-w/2, -w]) {
            cube(size=[x-x0-w*3, y-w*2, w]);
          }
          translate([x0+w*3, w*2, h-w*2]) {
            cube(size=[x-x0-w*4, y-w*3, w+f]);
          }
        }
        hull() {
          translate([-w, w*2-w/2, -w]) {
            cube(size=[x0+w*2.5, y-w*2, w]);
          }
          translate([-w, w*2, h-w*2]) {
            cube(size=[x0+w*2, y-w*3, w+f]);
          }
        }
        rounded_border2(
          w=w,
          x=x,
          x0=x0,
          y=y,
          h=h
        );
      }
    }
    boxx(
      board=board,
      x=x,
      y=y,
      z=z,
      w=w,
      di=di
    );
    translate([w, 0, w*1.5]) {
      inset(board=board,x=x,y=y,z=z-w,x0=x0,y0=y0);
    }
  }
}

module rounded_border(
  w=w,
  x=x,
  y=y,
  h=w*4
) {
  translate([w, 0, h]) {
    rotate([-90, 0, 0]) {
      clip_border(w=w,l=y,d=w*2.5);
    }
  }
  translate([0, w, h]) {
    rotate([0, 90, 0]) {
      rotate(90) {
        clip_border(w=w,l=x,d=w*2.5);
      }
    }
  }
  translate([x, y+w, h]) {
    rotate([90, 0, 0]) {
      rotate(180) {
        clip_border(w=w,l=y,d=w*2.5);
      }
    }
  }
  translate([x+w, y, h]) {
    rotate([0, -90, 0]) {
      rotate(270) {
        clip_border(w=w,l=x,d=w*2.5);
      }
    }
  }
}

module rounded_border2(
  w=w,
  x=x,
  x0=x0,
  y=y,
  h=w*4
) {
  translate([x0+w*2, 0, h]) {
    rotate([-90, 0, 0]) {
      clip_border(w=w,l=y,d=w*2.5);
    }
  }
  translate([-w*2, w, h]) {
    rotate([0, 90, 0]) {
      rotate(90) {
        clip_border(w=w,l=x+w*2,d=w*2.5);
      }
    }
  }
  translate([x, y+w, h]) {
    rotate([90, 0, 0]) {
      rotate(180) {
        clip_border(w=w,l=y,d=w*2.5);
      }
    }
  }
  translate([x+w, y, h]) {
    rotate([0, -90, 0]) {
      rotate(270) {
        clip_border(w=w,l=x+w*2,d=w*2.5);
      }
    }
  }
}

module clip_border(
  w=w,
  d=w*2.5,
  l
) {
  difference() {
    cylinder(d=w*2.5, h=l+w);
    translate([-w, 0, 0]) {
      rotate([0, 45, 0]) {
        translate([0, -w*2.5, -w*5]) {
          cube(size=[w*10, w*10, w*10]);
        }
      }
    }
    translate([-w*1.25, 0, l+w*1.25]) {
      rotate([0, -45, 0]) {
        translate([0, -w*2.5, -w*5]) {
          cube(size=[w*10, w*10, w*10]);
        }
      }
    }
  }
}

module latch(
  x=x/10,
  di=w*2,
  w=w,
  g=g,
  a=a/2*0.08
) {
  b=di+w+g;
  c=x+(w+g)*2;
  do=di+(g+w)*2;
  e=do+w+di+w;

  //latch hinge
  rotate([0, 90, 0]) {
    cylinder(d=di, h=c, center=true);
  }
  difference() {
    union() {
      translate([0, -b/2, 0]) {
        cube(size=[c, b, do], center=true);
      }
        rotate([0, 90, 0]) {
          cylinder(d=do, h=c, center=true);
        }
    }
    translate([0, 0, 0]) {
      cube(size=[x+g*2, do*2, do+w], center=true);
    }
  }

  // latch
  /* rotate([-a*0.95, 0, 0]) */
  difference() {
    rotate([-a, 0, 0])
    intersection() {
      difference() {
        union() {
          rotate([0, 90, 0]) {
            cylinder(d=do, h=x, center=true);
          }
          translate([-x/2, -do/2, 0]) {
            cube(size=[x, do+w, z-w]);
          }
          translate([-x/2, -e+do/2, z-do/2+g]) {
            cube(size=[x, e, do]);
          }
          latch_catch(
            di=di,
            x=x,
            y=-e+do/2+w,
            z=z-do/2+w-g/2
          );
        }
        rotate([0, 90, 0]) {
          cylinder(d=di+g*2, h=c, center=true);
        }
        //rounding
        translate([0, -do/2-w, z/2]) {
          resize([x+g, do+di+w, z-do+di]) {
            rotate([0, 90, 0]) {
              cylinder(r=10, h=x+g, center=true, $fn=64);
            }
          }
        }
      }
      translate([0, -do+w, z/2-do]) {
        resize([x+g, do*3, z+do*2]) {
          rotate([0, 90, 0]) {
            cylinder(r=10, h=x+g, center=true, $fn=64);
          }
        }
      }
    }
    translate([-25, 0, -do/2-50]) {
      cube(size=[50, 50, 50]);
    }
  }
}

module latch_catch(
  di=w*2,
  x=x,
  y,//=-e+do/2+w,
  z,//=z-do/2+w-g/2
) {
  translate([0, y, z]) {
    rotate([0, 90, 0]) {
      cylinder(d=di, h=x, center=true);
    }
  }
}

module hooks(x=x,y=y,w=w) {
  translate([x*0.25, y, 0]) {
    hook(w=w*2);
  }
  translate([x*0.75, y, 0]) {
    hook(w=w*2);
  }
}
module hook(
  w=w,
  x=15
) {
  translate([-x/2, 0, 0]) {
    difference() {
      hull() {
        cube(size=[x, 5, w]);
        translate([x/2, x/2, 0]) {
          cylinder(d=x, h=w);
        }
      }
      translate([x/2, x/2, 0]) {
        cylinder(d=x/2, h=w*3, center=true);
      }
    }
  }
}

module inset_A(
  x=x,
  y=y,
  z=z,
  w=w,
  x0=x0,
  y0=y0
) {
  difference() {
    union() {
      translate([x0+grid_x, 0+grid_y, 0]) {
        inset_grid2(
          x=x-x0,
          y=y,
          z=z,
          w=w
        );
      }
      translate([x0, 0, 0]) {
        cube(size=[w, y, z/2-w]);
      }
      translate([x0, 0, 0]) {
        cube(size=[34.5,34.5, 7]);
      }
    }
    translate([x0, y0, 0]) {
      uno_usb();
      uno_power();
    }
    translate([x0, y0, z/4]) {
      uno_usb();
      uno_power();
    }
    translate([x0-w, 10, 5]) {
      connector();
      translate([0, -5, 0]) {
        cube(size=[w*3, 10, z/2]);
      }
    }
    translate([x0-w, 27, 5]) {
      connector();
      translate([0, -5, 0]) {
        cube(size=[w*3, 10, z/2]);
      }
    }
  }
}

module inset_grid(
  x=x,
  y=y,
  z=z,
  w=w,
  x0=x0,
  y0=y0
) {
  translate([x0+grid_x, grid_y, 0]) {
    grove_module_holder(x=5,y=4);
  }
}


module inset_grid2(
  x=x,
  y=y,
  z=z,
  w=w
) {
    grove_module_holder(x=floor(x/20),y=floor(y/20));
}

module inset_mega(
  x=x,
  y=y,
  z=z,
  w=w,
  x0=x0,
  y0=y0
) {
  difference() {
    inset_A(
      x=x,
      y=y,
      z=z,
      w=w,
      x0=x0,
      y0=y0
    );
    translate([x0+w, floor(y0)-1, 0]) {
      cube(size=[uno_x, ceil(uno_y)+1, z]);
    }
  }
  translate([x0+3, y0, 0]) {
    /* %mega(); */
    mega_holder_screw(
      w=w,
      h=3
    );
  }
}

module inset_uno(
  x=x,
  y=y,
  z=z,
  w=w,
  x0=x0,
  y0=y0
) {
  difference() {
    inset_A(
      x=x,
      y=y,
      z=z,
      w=w,
      x0=x0,
      y0=y0
    );
    translate([x0+w, floor(y0)-1, 0]) {
      cube(size=[uno_x, ceil(uno_y)+1, z]);
    }
  }
  translate([x0+3, y0, 0]) {
    %uno();
    %uno_usb();
    uno_holder_screw(
      w=w
    );
  }
  translate([x0+90, 50, 0]) {
    rotate([0, 0, 90]) {
      grove_module_holder(x=2);
    }
  }
}
/* !inset_nodemcu(
  x0=40,
  y0=0
); */
module inset_nodemcu(
  x=x,
  y=y,
  z=z,
  w=w,
  x0=x0,
  y0=y0
) {
  difference() {
    union() {
      if (x0>0) {
        translate([x0, y0, 0]) {
          cube(size=[w, y-y0-w, (z-w)/2]);
        }
      }
      if (y0>0) {
        translate([x0, y0, 0]) {
          cube(size=[x-x0-w, w, (z-w)/2]);
        }
      }
      translate([x0+nodemcu_y/2+w*2+5, nodemcu_x/2+w*5, 0]) {
        rotate(-90){
          nodemcu_shield_holder();
        }
      }
    }
    translate([x0+nodemcu_y/2+w, nodemcu_x/2+w*5, 0]) {
      rotate(-90){
        nodemcu_usb();
      }
    }
  }
}

module inset_nodemcuy(
  x=x,
  y=y,
  z=z,
  w=w,
  x0=x0,
  y0=y0
) {
  difference() {
    //subdivisions
    union() {
      if (x0>0) {
        translate([x0, y0, 0]) {
          cube(size=[w, y-y0-w, (z-w)/2]);
        }
      }
      if (y0>0) {
        translate([x0, y0+w, 0]) {
          cube(size=[x-x0-w, w, (z-w)/2]);
        }
      }
    }
    //rj45 cutouts
    translate([x0+grid_x, y0+grid_x-15, 0]) {
        rotate(90){
          rj45();
          translate([0, 0, 10]) {
            rj45();
          }
        }
    }
    //usb cutout for nodemcu
    translate([x-nodemcu_x/2-5, y0+nodemcu_y/2+w, 0]) {
      nodemcu_usb();
    }
  }
  //grove holder for rj45 module
  translate([x0+grid_x, y0+grid_x, 0]) {
    rotate([0, 0, 90]) {
      grove_rj45();
      translate([-15, -7.5, 3+g]) {
        cube(size=[w, 15, z/2-w-3-g]);
      }
    }
  }
  //holder for nodemcu grove shield
  translate([x-nodemcu_x/2-5, y0+nodemcu_y/2+w+5, 0]) {
    /* rotate(-90) */
    nodemcu_shield_holder();
  }
}

module inset_touch_display(
  x=x,
  y=y,
  z=z,
  w=w,
  x0=x0,
  y0=y0
) {
  inset_grid(
    x=x,
    y=y,
    z=z,
    w=w,
    x0=x0,
    y0=y0
  );
  translate([x0, 0, 0]) {
    cube(size=[w, y-w, z/2-w]);
  }
}

module inset_oled_joy(
  x=x,
  y=y,
  z=z,
  w=w,
  x0=x0,
  y0=y0
) {
  difference() {
    union() {
      difference() {
        union() {
          translate([x0+grid_x, 0+grid_y, 0]) {
            inset_grid2(
              x=x-x0,
              y=y,
              z=z,
              w=w
            );
          }
        }
        translate([x0+grid_x+joy_x, grid_y+joy_y, 0]) {
          joystick_cutout();
        }
      }
      translate([x0+grid_x+joy_x+10, grid_y+joy_y, -w]) {
        rotate([180, 0, 0]) {
          rotate([0, 0, 180]) {
            joystick_setup();
          }
        }
      }
    }
    translate([x0+grid_x+disp_x, grid_y+disp_y, 0]) {
      display_display(z=5);
    }
  }
  translate([x0+grid_x+disp_x, grid_y+disp_y, 0]) {
    display_setup();
  }
  translate([x0, 0, 0]) {
    cube(size=[w, y-w, z/2-w]);
  }
}

module inset_oled_joy_rj45(
  x=x,
  y=y,
  z=z,
  w=w,
  x0=x0,
  y0=y0
) {
  difference() {
    inset_oled_joy(
      x=x,
      y=y,
      z=z,
      w=w,
      x0=x0,
      y0=y0
    );
    translate([x0+grid_x-5, grid_y, 0]) {
      for (i=[0:floor((y-grid_y)/20)]) {
        translate([0,i*20,0]) {
          resize([0,0,z]){
            rj45();
          }
        }
      }
    }
  }
  translate([x0, grid_y, 0]) {
    for (i=[0:floor((y-grid_y)/20)]) {
      translate([grid_x,i*20,0]) {
        grove_rj45();
      }
      translate([w+g/2, -9+i*20, 3+g]) {
        cube(size=[w, 18, z/2-w-3-g]);
      }
    }
  }
}

module inset_rj45(
  x=x,
  y=y,
  z=z,
  w=w,
  x0=x0,
  y0=y0
) {
  difference() {
    union() {
      intersection() {
        translate([x0, y0, -w]) {
          cube(size=[x-x0-w,y-y0,z/2-w/2]);
        }
        translate([x0+grid_x, grid_y, 0]) {
          inset_grid2(
            x=x-x0,
            y=y-y0,
            z=z,
            w=w
          );
        }
        /* cube(size=[x0,y,z/w]); */
      }
      if (x0>0) {
        translate([x0, y0, 0]) {
          cube(size=[w, y-y0-w, (z-w)/2]);
        }
      }
      if (y0>0) {
        translate([x0, y-w*2-y0, 0]) {
          cube(size=[x-x0-w, w, (z-w)/2]);
        }
      }
    }
    translate([x0+grid_x-5, y0+grid_y, 0]) {
      for (i=[0:floor((y-y0-grid_y)/20)]) {
        translate([-grid_x+5+w,i*20,]) {
          hull() {
            resize([f,0,0])
            rj45();
            translate([-w, 0, w]) {
              resize([f,0,0])
              rj45();
            }
          }
        }
      }
    }
  }
  translate([w, 0, 0]) {
    intersection() {
      translate([x0, y0, 4]) {
        hull() {
          cube(size=[f, y-y0-w, z/2-w]);
          translate([w-f*2, 0, w]) {
            cube(size=[f, y-y0-w, z/2-w]);
          }
        }
      }
      translate([x0+grid_x-5, y0+grid_y, -g]) {
        for (i=[0:floor((y-y0-grid_y)/20)]) {
          translate([0,i*20,0]) {
            rj45(h=14.2);
          }
        }
      }
    }
  }
  intersection() {
    translate([x0, y0, -w]) {
      cube(size=[x-x0-w,y-y0,z/2-w/2]);
    }
    translate([x0, y0+grid_y, 0]) {
      for (i=[0:floor((y-y0-grid_y)/20)]) {
        translate([grid_x,i*20,0]) {
          grove_rj45();
        }
      }
    }
  }
}

module inset_rj45_ledbtn(
  x=x,
  y=y,
  z=z,
  w=w,
  x0=x0,
  y0=y0
){
    inset_rj45(
      x=x,
      y=y,
      z=z,
      w=w,
      x0=x0,
      y0=y0
    );
}

module inset_rj45y(
  x=x,
  y=y,
  z=z,
  w=w,
  x0=x0,
  y0=y0
) {
  difference() {
    union() {
      //subdivisions
      if (x0>0) {
        translate([x0, y0, 0]) {
          cube(size=[w, y-y0-w, (z-w)/2]);
        }
      }
      if (y0>0) {
        translate([x0, y-w*2-y0, 0]) {
          cube(size=[x-x0-w, w, (z-w)/2]);
        }
      }
      //connector_holder block
      translate([x0+17, y0, 0]) {
        rotate([0, 0, 180]) {
          connector_holder(OUTER);
        }
      }
    }
    translate([x0+35, y0, 0]) {
      //rj45 cutouts
      grove_repeatx(
        x=x-x0-w-40,
        y=40,
        z=z/2-w,
        sizey=40
      ){
        translate([0, y-y0-40, 0]) {
          rotate(-90) {
            rj45();
            translate([0, 0, 10]) {
              rj45();
            }
          }
        }
      }
    }
    // connector holder cutouts
    translate([x0+17, y0+w, 0]) {
      rotate([0, 0, 180]) {
        connector_holder(INNER);
      }
    }
  }
  //fill with rj45 modules
  translate([x0+35, y0, 0]) {
    grove_repeatx(
      x=x-x0-w-40,
      y=40,
      z=z/2-w,
      sizey=40
    ){
      translate([0, y-y0-grid_y-w*2-30, 0]) {
        rotate(-90) {
          grove_rj45();
          translate([-15, -7.5, 3+g]) {
            cube(size=[w, 15, z/2-w-3-g]);
          }
        }
      }
    }
  }
}

module grove_repeatx(
  x=x,
  y=y,
  z=z,
  sizex=20,
  sizey=20
) {
  /* %color("white",0.2) cube(size=[x, y, z]); */
  nx=floor((x-grid_x)/sizex);
  translate([grid_x, 0, 0]) {
    for (i=[0:nx]) {
      translate([i*sizex,0,0]) {
        children();
      }
    }
  }
}

module box_mega(
  x=x,
  x0=x0,
  y=y,
  y0=y0,
  z=z/2,
  w=w,
  g=g,
  di=w*2,
) {
  difference() {
    box(
      x=x,
      y=y,
      z=z,
      w=w,
      g=g,
      di=di,
      latch=0
    );
    cutout(y=y/2,z=z,w=w);
  }
}

module box_uno(
  x=x,
  x0=x0,
  y=y,
  y0=y0,
  z=z/2,
  w=w,
  g=g,
  di=w*2,
) {
  difference() {
    box(
      x=x,
      y=y,
      z=z,
      w=w,
      g=g,
      di=di,
      latch=0
    );
    cutout(y=y/2,z=z,w=w);
  }
}

module box_nodemcu(
  x=x,
  x0=x0,
  y=y,
  y0=y0,
  z=z/2,
  w=w,
  g=g,
  di=w*2,
) {
  difference() {
    box(
      x=x,
      y=y,
      z=z,
      w=w,
      g=g,
      di=di,
      latch=0
    );
    if (y0>0) {
      cutout(y=y0,z=z,w=w);
    } else {
      cutout(y=y-w*2,z=z,w=w);
    }
  }
}

module box_nodemcuy(
  x=x,
  x0=x0,
  y=y,
  y0=y0,
  z=z/2,
  w=w,
  g=g,
  di=w*2,
) {
  difference() {
    box(
      x=x,
      y=y,
      z=z,
      w=w,
      g=g,
      di=di,
      latch=0
    );
    if (y0>0) {
      cutout(y=y0,z=z,w=w);
    } else {
      cutout(y=y/2,z=z,w=w);
    }
  }
}

module box_touch_display(
  x=x,
  x0=x0,
  y=y,
  y0=y0,
  z=z/2,
  w=w,
  g=g,
  di=w*2
) {
  box(
    x=x,
    y=y,
    z=z,
    w=w,
    g=g,
    di=di,
    latch=1
  );
}

module box_oled_joy_rj45(
  x=x,
  x0=x0,
  y=y,
  y0=y0,
  z=z/2,
  w=w,
  g=g,
  di=w*2
) {
  difference() {
    box_oled_joy(
      x=x,
      x0=x0,
      y=y,
      y0=y0,
      z=z,
      w=w,
      g=g,
      di=di
    );
    translate([0, y/2-w*2, 0]) {
      cutout(y=y/2,z=z,w=w);
    }
  }
}

module box_oled_joy(
  x=x,
  x0=x0,
  y=y,
  y0=y0,
  z=z/2,
  w=w,
  g=g,
  di=w*2
) {
  difference() {
    box(
      x=x,
      y=y,
      z=z,
      w=w,
      g=g,
      di=di,
      latch=1
    );
    translate([x0+grid_x+joy_x+w, grid_y+joy_y, 0]) {
      joystick_cutout();
    }
    translate([x0+grid_x+disp_x+w, grid_y+disp_y, 0]) {
      display_display(z=5);
    }
  }
}

module box_rj45(
  x=x,
  x0=x0,
  y=y,
  y0=y0,
  z=z/2,
  w=w,
  g=g,
  di=w*2
) {
  difference() {
    box(
      x=x,
      y=y,
      z=z,
      w=w,
      g=g,
      di=di,
      latch=1
    );
    if (y0>0) {
      translate([0, y-y0-w*2, 0]) {
        cutout(y=y0,z=z,w=w);
      }
    } else {
      cutout(y=y-w*2,z=z,w=w);
    }
  }
}

module breakout_hole(
  d=8,
  w=w,
  g=g, //gap
  sq=0,
  part=PART
) {
  if (part==PART) {
    hull() {
      cucy(d=d,h=w,sq=sq);
      translate([0, 0, w]) {
        cucy(d=d+w,h=w/2,sq=sq);
      }
    }
    translate([0, 0, w+f]) {
      cucy(d=d+w+g*1.5, h=w/2,sq=sq);
    }
  } else {
    hull() {
      cucy(d=d+g,h=w,sq=sq);
      translate([0, 0, w]) {
        cucy(d=d+w+g,h=w/2,sq=sq);
      }
    }
    translate([0, 0, -w]) {
      cucy(d=d+g, h=w*2, sq=sq);
    }
  }
}

module cucy(d,h,sq=0) {
  if (sq==0) {
    cylinder(d=d, h=h);
  }
  else {
    translate([-d/2, -d/2, 0]) {
      cube(size=[d, d, h]);
    }
  }
}

module box_rj45_ledbtn(
  x=x,
  x0=x0,
  y=y,
  y0=y0,
  z=z/2,
  w=w,
  g=g,
  di=w*2
) {
  led_d=8;
  btn_d=8;
  led_pos=[
    [40,50,0]
  ];
  btn_pos=[
    [40,20,0]
  ];
  difference() {
    box_rj45(
      x=x,
      x0=x0,
      y=y,
      y0=y0,
      z=z,
      w=w,
      g=g,
      di=di
    );
    translate([x0+grid_x+w, grid_y, 0]) {
      for (i=led_pos) {
        translate(i) {
          breakout_hole(d=led_d,part=CUTOUT);
        }
      }
      for (i=btn_pos) {
        translate(i) {
          breakout_hole(d=btn_d,sq=1,part=CUTOUT);
        }
      }
    }
  }
  translate([x0+grid_x+w, grid_y, 0]) {
    for (i=led_pos) {
      translate(i) {
        breakout_hole(d=led_d,part=PART);
      }
    }
    for (i=btn_pos) {
      translate(i) {
        breakout_hole(d=btn_d,sq=1,part=PART);
      }
    }
  }
}

module box_rj45y(
  x=x,
  x0=x0,
  y=y,
  y0=y0,
  z=z/2,
  w=w,
  g=g,
  di=w*2
) {
  difference() {
    box(
      x=x,
      y=y,
      z=z,
      w=w,
      g=g,
      di=di,
      latch=1
    );
    if (y0>0) {
      translate([0, y-y0-w*2, 0]) {
        cutout(y=y0,z=z,w=w);
      }
    } else {
      translate([0, y/2-w*2, 0]) {
        cutout(y=y/2,z=z,w=w);
      }
    }
  }
}

module box(
  x=x,
  y=y,
  z=z/2,
  w=w,
  g=g,
  di=w*2,
  latch=0
) {
  difference() {
    cube(size=[x, y, z]);
    translate([w, w, w]) {
      cube(size=[x-w*2, y-w*2, z]);
    }
    if (latch>0) {
      translate([x*0.1, 0, 0]) {
        latch_catch(
          di=w*2,
          x=x/10+w,
          y=w*2,//=-e+do/2+w,
          z=-w+g//=z-do/2+w-g/2
        );
      }
      translate([x*0.9, 0, 0]) {
        latch_catch(
          di=w*2,
          x=x/10+w,
          y=w*2,//=-e+do/2+w,
          z=-w+g//=z-do/2+w-g/2
        );
      }
    }
  }
}

module cutout(
  w=w,
  y=y/2,
  z=z
) {
  translate([-w, w, w*3]) {
    cube(size=[w*3, y, z]);
  }
}
