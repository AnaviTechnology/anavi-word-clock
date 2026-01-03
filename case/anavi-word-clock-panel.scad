// ========================
// Parameters
// ========================

// Case (2 mm shorter than the bottom, aka 1 mm on each side)
case_width = 98;
case_height = 3;

// Outer cylinder
outer_r = 4;
outer_h = case_height;

// Inner hole
hole_r = 2;
hole_h = case_height;

// increase for smoother cone ($fn)
segments = 64;

// smooth corners
$fn = segments;

// ========================
// Cover for the NeoPixel panel
// ========================
module panel_cover() {
    difference() {

        translate([8.5, 8.5, 0])
            cube([81, 81, case_height]);

        // Bezel to hold the NeoPixel panel

        translate([14, 14, 0])
            cube([70, 70, case_height]);

        // Field for the NeoPixel panel

        translate([9, 9, case_height-1])
            cube([80, 80, 1]);

    }
}

// ========================
// Holders for the NeoPixel panel
// ========================
module panel_holders() {
    difference() {

    union() {
        // Middle left
        translate([2, case_width/2-outer_r, 0])
                mounting_hole_round();

        // Middle right
        translate([case_width-2*outer_r-2, case_width/2-outer_r, 0])
                mounting_hole_round();
        }

        translate([8.5, 8.5, 0])
            cube([81, 81, case_height]);
    }
}
    
// ========================
// Mounting holes
// ========================
module mounting_hole_round() {
    // Position at start
    translate([outer_r, outer_r, 0]) {
        difference() {
            // Outer cylinder
            cylinder(h = outer_h, r = outer_r, $fn = segments);

            // Inner hole
            translate([0, 0, outer_h-hole_h])
                cylinder(h = hole_h, r = hole_r, $fn = segments);
        }
    }
}

// ========================
// Cover with holders
// ========================

union() {
    panel_cover();
    panel_holders();

    // Hooks

    translate([14, 6.5, 0])
        cube([10, 2, case_height]);
    translate([14, 5.5, 0])
        cube([10,1,13]);
    translate([14, 6, 0])
        cylinder(h = 13, r = 1);

    translate([case_width-2*outer_r-2-14, 6.5, 0])
        cube([10, 2, case_height]);
    translate([case_width-2*outer_r-2-14, 5.5, 0])
        cube([10,1,13]);
    translate([case_width-2*outer_r-2-14+10, 6, 0])
        cylinder(h = 13, r = 1);

    translate([14, 81+2+6.5, 0])
        cube([10, 2, case_height]);
    translate([14, 81+5+5.5, 0])
        cube([10,1,13]);
    translate([14, 81+5+6, 0])
        cylinder(h = 13, r = 1);

    translate([case_width-2*outer_r-2-14, 81+2+6.5, 0])
        cube([10, 2, case_height]);
    translate([case_width-2*outer_r-2-14, 81+5+5.5, 0])
        cube([10,1,13]);
    translate([case_width-2*outer_r-2-14+10, 81+5+6, 0])
        cylinder(h = 13, r = 1);
}