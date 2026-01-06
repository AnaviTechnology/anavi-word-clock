// ========================
// Parameters
// ========================

// Case (2 mm shorter than the bottom, aka 1 mm on each side)
case_width = 98;
case_lenght = 98;
case_height = 6.5;

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

        // Field for the NeoPixel panel

        translate([9, 9, 0])
            cube([80, 80, case_height]);

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

module grid(cell = 9.5625, wall = 0.5, height = case_height, diffuser = true) {
    rows = 8;
    cols = 8;

    if (false == diffuser) {
        // Vertical walls
        for (i = [1:cols-1]) {
            translate([
                i * cell + (i-1) * wall,
                0,
                0
            ])
                color("black")
                    cube([wall, rows*cell+(rows-1)*wall, height]);
        }

        // Horizontal walls
        for (j = [1:rows-1]) {
            translate([
                0,
                j * cell + (j-1) * wall,
                0
            ])
                color("black")
                    cube([cols * cell+(cols-1)*wall, wall, height-1]);
        }
    }
    else if (true == diffuser) {
        // White cubes inside each cell, height = 1
        color("white")
        for (i = [0:cols-1]) {
            for (j = [0:rows-1]) {
                translate([
                    i * (cell + wall),
                    j * (cell + wall),
                    0
                ])
                    cube([cell, cell, 0.5]);
            }
        }
    }
}

// ========================
// Top case
// ========================

union() {
    translate([9, 9, 0])
            //grid();
            grid(cell = 9.5625, wall = 0.5, height = case_height-0.5, diffuser = false);
}
