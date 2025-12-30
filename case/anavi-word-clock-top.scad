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
case_width = 100;
case_lenght = 100;
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
            
            // Bottom left
            translate([2, 2+outer_r*2, 0])
                rotate([180, 0, 0])
                    mounting_hole_round();
            
            // Bottom right
            translate([case_width-2*outer_r-2, 2+outer_r*2, 0])
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
        
        translate([10, 10, 0])
            cube([80, 80, 1]);
        
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
            translate([11, 90-7.5-l*10, 0])
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
// Top case
// ========================

case_top();