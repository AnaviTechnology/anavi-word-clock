// ========================
// Parameters
// ========================
// PCB corner radius
corner_r = 5;    
// Wall thickness
wall_thickness = 2;  
// smooth corners
$fn = 64;              


// Case (2 mm shorter than the bottom, aka 1 mm on each side)
case_width = 98;
case_lenght = 98;
case_height = 2.5;

// Outer cylinder
outer_r = 4;
outer_h = 5;

// Inner hole
hole_r = 2.5;
hole_h = 2;

// USB-C connector
usbc_l = 10;
usbc_h = 5;

// LED
led_r = 5;

// Grid
grid_height = 5+case_height;

// increase for smoother cone ($fn)
segments = 64;

// ========================
// Case Top Module
// ========================

module case_top() {
    difference() {
        
        // Translate so inner PCB pocket starts at (0,0)
        union() {
            
            translate([corner_r, corner_r, 0])
            // Outer shell (walls included)
            linear_extrude(height = case_height)
                rounded_rect(case_width,
                             case_lenght,
                             corner_r);
            
            // Mounting holes

            // Bottom left
            translate([2, 2+outer_r*2, 0])
                rotate([180, 0, 0])
                    mounting_hole_round();
            
            // Bottom right
            translate([case_width-2*outer_r-2, 2+outer_r*2, 0])
                rotate([180, 0, 0])
                    mounting_hole_round();
            
            // Middle left
            translate([2, outer_r+case_width/2, 0])
                rotate([180, 0, 0])
                    mounting_hole_round();

            // Middle right
            translate([case_width-2*outer_r-2, outer_r+case_width/2, 0])
                rotate([180, 0, 0])
                    mounting_hole_round();

            // Top left
            translate([2, case_lenght-2*outer_r-3+outer_r*2, 0])
                rotate([180, 0, 0])
                    mounting_hole_round();
            
            // Top right
            translate([case_width-2*outer_r-2, case_lenght-2*outer_r-3+outer_r*2, 0])
                rotate([180, 0, 0])
                    mounting_hole_round();
        }
        
        // Field for the letters

        translate([8.5, 8.5, -outer_h])
            cube([81, 81, outer_h+case_height-1]);

        // Letters
        
        lines = [
                "ATWENTYD", 
                "QUARTERY",
                "FIVEHALF",
                "DPASTORO",
                "FIVEIGHT",
                "SIXTHREE",
                "TWELEVEN",
                "FOURNINE"
        ];
        
        for (l = [0 : 7]) {
            translate([10, case_lenght-9.5-7.5-l*10, 0])
                line(lines[l]);
        }
    }
    
}

// ========================
// Rounded rectangle module
// ========================
module rounded_rect(x, y, radius) {
    minkowski() {
        square([x - 2*radius, y - 2*radius], center = false);
        circle(r = radius, $fn = $fn);
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

module mounting_hole(left = true) {
    tr = left ? 0 : -outer_r;
    // Position at start
    translate([outer_r, outer_r, 0]) {
        difference() {
            
            union() {
                // Outer cylinder
                cylinder(h = outer_h, r = outer_r, $fn = segments);
                translate([tr, -outer_r, 0])
                    cube([4, 8, outer_h]);
                translate([-outer_r, 0, 0])
                    cube([8, 4, outer_h]);
            }
            
            // Inner hole
            translate([0, 0, outer_h-hole_h])
                cylinder(h = hole_h, r = hole_r, $fn = segments);
        }
    }
}

module line(
    s,
    cell = [8.5, 6],
    spacing = 1.5,          // new spacing between letters
    font = "ArialStencila"
) {
    base_size = 15;   // tuned for Allerta Stencil
    scale_factor = min(
        cell[0] / base_size,
        cell[1] / (base_size)
    );

    for (i = [0 : 7]) {
        ch = s[i];

        translate([i * (cell[0] + spacing) + cell[0]/2, cell[1]/2, 0])
            scale(scale_factor)
                linear_extrude(height = case_height+5)
                    text(
                        ch,
                        font = font,
                        size = base_size,
                        halign = "center",
                        valign = "center"
                    );
    }
}

// ========================
// Cover for the NeoPixel panel
// ========================
module panel_cover() {
    difference() {
        translate([-0.5, -0.5, 0])
            cube([81, 81, grid_height]);

        // Field for the NeoPixel panel
        translate([0, 0, 0])
            cube([80, 80, grid_height]);

    }
}

module grid(cell = 9.5625, wall = 0.5, height = grid_height) {
    rows = 8;
    cols = 8;

    // Vertical walls
    for (i = [1:cols-1]) {
        translate([
            i * cell + (i-1) * wall,
            0,
            0
        ])
            cube([wall, rows*cell+(rows-1)*wall, height]);
    }

    // Horizontal walls
    for (j = [1:rows-1]) {
        translate([
            0,
            j * cell + (j-1) * wall,
            0
        ])
            cube([cols * cell+(cols-1)*wall, wall, height]);
    }
}

module hook() {
    difference() {
        union() {
            cube([3, 1, 5]);
            translate([4, 0.5, 0]) {
                cylinder(h = 5, r = 2);
            }
        }
        translate([4, 0.5, 0])
            cylinder(h = 5, r = 1);
        translate([4.5, -0.3, 0])
            cube([2, 1.6, 5]);
    }
}

// ========================
// Top case
// ========================

union() {
    case_top();
    translate([9, 9, -grid_height+case_height]) {
        panel_cover();
    }

    // Hooks for the NeoPixel panel
    translate([9.5, (case_width-80)/2-4, -5])
        hook();

    translate([9.5, 7.5+81+3, -5])
        hook();

    translate([case_width-9.5, (case_width-80)/2-4, 0])
        rotate([0, 180, 0])
            hook();

    translate([case_width-9.5, 7.5+81+3, 0])
        rotate([0, 180, 0])
            hook();
}
