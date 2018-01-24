//For printing
EPS = 0.3;
GAP = 0.4;

// Mirror
FOCAL_LENGTH = 50;
RADIUS_OF_CURVATURE = 2 * FOCAL_LENGTH;
DIAMETER = 2 * RADIUS_OF_CURVATURE;

// Box part
HEIGHT_BOX = 20;
WIDTH_BOX = 80;

// Tube
INNER_TUBE = 50;
OUTER_TUBE = 70;
LENGTH_TUBE = 1000;
DEPTH_TUBE = HEIGHT_BOX - 5;

// Mirror
R_SQUARED = RADIUS_OF_CURVATURE * RADIUS_OF_CURVATURE;
ROOT = sqrt(4 * R_SQUARED - (INNER_TUBE * INNER_TUBE));
BIG_SEGMENT = ROOT / 2;
SEGMENT = RADIUS_OF_CURVATURE - BIG_SEGMENT;

// For wing
// Standard constants
M4_SHANK_R = 4.0 / 2 + GAP;
M4_HEAD_R   = 7.0 / 2 + GAP;

// Constants defining the design
HEAD_H   = 3.5;
NUT_H    = 2.5;
LENGTH   = 20.0;
WING_SHANK_R = M4_SHANK_R;            // Wing bolt for locking
WING_HEAD_R   = M4_HEAD_R;
DEPTH   = WIDTH_BOX;
BAR_R = INNER_TUBE / 2 + GAP * 2;


module tube() {
    difference () {
        cylinder(LENGTH_TUBE, OUTER_TUBE / 2 + GAP, OUTER_TUBE / 2 + GAP, 0);
        cylinder(LENGTH_TUBE, INNER_TUBE/2 - GAP, INNER_TUBE/2 - GAP, 0);
    }
}

module holder() {
    difference () {
        cube([WIDTH_BOX, WIDTH_BOX, HEIGHT_BOX], 0);
        translate([WIDTH_BOX / 2, WIDTH_BOX / 2, HEIGHT_BOX - DEPTH_TUBE])
            tube();
    }
}

// Wing nut and bolt tighener
module wing () {
    union () {
        cylinder (r = WING_SHANK_R, h = DEPTH, center = false, $fn = 24);
        cylinder (r = WING_HEAD_R, h = NUT_H + GAP, center = false, $fn = 6);
    }
}

module box () {
    difference () {
        holder();
        translate([WIDTH_BOX / 2, WIDTH_BOX / 2, RADIUS_OF_CURVATURE + HEIGHT_BOX - SEGMENT])
           sphere(r = RADIUS_OF_CURVATURE);
    }
}

module wings () {
    translate ([WIDTH_BOX / 2, NUT_H + 3, HEIGHT_BOX - (DEPTH_TUBE / 2)])
    rotate([90,0,0])
        wing ();
    translate ([WIDTH_BOX / 2, WIDTH_BOX - 3 - NUT_H, HEIGHT_BOX - (DEPTH_TUBE / 2)])
    rotate([270,0,0])
        wing ();
    translate ([WIDTH_BOX - 3 - NUT_H, WIDTH_BOX / 2, HEIGHT_BOX - (DEPTH_TUBE / 2)])
    rotate([0,90,0])
        wing ();
    translate ([NUT_H + 3, WIDTH_BOX / 2, HEIGHT_BOX - (DEPTH_TUBE / 2)])
    rotate([0,270,0])
        wing ();
}

difference() {
    box();
    wings ();
}