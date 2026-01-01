// ========================
// Parameters
// ========================

// Case (2 mm shorter than the bottom, aka 1 mm on each side)
case_width = 98;
case_lenght = 98;
case_height = 4;

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
     
        translate([8, 8, 0])
            cube([82, 82, case_height]);

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

        translate([8, 8, 0])
            cube([82, 82, case_height]);
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

module grid(cells = [8.5, 8.5], spacing = 1.5, wall = 0.5, height = case_height) {
    rows = 8;
    cols = 8;

    // Vertical walls
    for (i = [1:cols-1]) {
        translate([
            i * (cells[0] + spacing) - spacing/2 - wall/2,
            -wall,
            0
        ])
            cube([wall, rows * (cells[1] + spacing), height]);
    }

    // Horizontal walls
    for (j = [1:rows-1]) {
        translate([
            -2*wall,
            j * (cells[1] + spacing) - spacing/2 - wall/2,
            0
        ])
            cube([cols * (cells[0] + spacing)+wall, wall, height-1]);
    }
}

// ========================
// Top case
// ========================

union() {
    panel_cover();
    translate([9.5, 9.5, 0])
        grid();
    panel_holders();
}