// ========================
// Parameters
// ========================
// Corner radius
corner_r = 5;

// Wall thickness
wall_thickness = 2;
// smooth corners
$fn = 64;


// Case
case_width = 100;
case_lenght = 100;
case_height = 33;

// Outer cylinder
outer_r = 3;
outer_h = 4;

// Inner hole
hole_r = 3;
hole_h = 2;

// USB-C connector
usbc_l = 10;
usbc_h = 4;

// LED
led_r = 5;

// increase for smoother cone ($fn)
segments = 64;

// ========================
// Case Top Module
// ========================
module case_top() {

    // Translate so inner PCB pocket starts at (0,0)
    translate([corner_r, corner_r, 0]) {
        difference() {
            // Outer shell (walls included)
            linear_extrude(height = case_height)
                rounded_rect(case_width,
                             case_lenght,
                             corner_r);

            // Main hollow interior
            translate([wall_thickness, wall_thickness, wall_thickness])
                linear_extrude(height = case_height-3)
                    rounded_rect(case_width-2*wall_thickness, case_lenght-2*wall_thickness, corner_r);
            
            // Top hollow interior
            translate([wall_thickness/2, wall_thickness/2, case_height-3])
                linear_extrude(height = 3)
                    rounded_rect(case_width-wall_thickness, case_lenght-wall_thickness, corner_r);

            // Mounting hole 1 (top left)
            translate([2, case_lenght-4.5-hole_r*3, 0])
                // Cone
                cylinder(wall_thickness, hole_r, hole_h, center = false, $fn = segments);
            
            // Mounting hole 2 (top right)
            translate([case_width-4.5-hole_r*3+1, case_lenght-4.5-hole_r*3, 0])
                // Cone
                cylinder(wall_thickness, hole_r, hole_h, center = false, $fn = segments);

            // Mounting hole 2 (top right)
            translate([case_width-4.5-hole_r*3+1, hole_h, 0])
                // Cone
                cylinder(wall_thickness, hole_r, hole_h, center = false, $fn = segments);
            
            // Mounting hole 4 (bottom left)
            translate([2, 2, 0])
                // Cone
                cylinder(wall_thickness, hole_r, hole_h, center = false, $fn = segments);
        }
    }
    
    // Covel bottom holders
    translate([12+8-2, 2, wall_thickness])
        cube([12, 2, 2]);
    translate([12+24-2, 2, wall_thickness])
        cube([12, 2, 2]);

    // PCB stand
    middle = (case_width-usbc_l)/2+4;
    translate([middle-9.5-2, 2, wall_thickness])
        cube([4, 2, 10]);
    translate([middle+34.50-6, 2, wall_thickness])
        cube([4, 2, 23]);
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
// Mounting hole
// ========================
module mounting_hole() {
    difference() {
        // Outer cylinder
        cylinder(h = outer_h, r = outer_r, $fn = 64);
        
        // Inner hole
        translate([0, 0, outer_h-hole_h])  // hole starts at base
            cylinder(h = hole_h, r = hole_r, $fn = 64);
    }
}

module usbc() {
    linear_extrude(height = wall_thickness)
        rounded_rect(usbc_l,usbc_h,1);
}

module ramp_screw() {
    rotate([90, 0, 270])
    linear_extrude(height = 8)
        polygon([
            [0, 0],
            [4, 0],
            [4, 1]
        ]);
}

module ramp() {
    rotate([270, 0, 90])
    linear_extrude(height = 8)
        polygon([
            [0, 0],
            [3, 0],
            [3, 3]
        ]);
}

// ========================
// Top case
// ========================

difference() {
    union() {
        difference() {
            // Main part of the case
            case_top();
            // USB-C connector
            translate([(case_width-usbc_l)/2+15, 7, 0])
               usbc();
            // PCB mounting holes
            middle = (case_width-usbc_l)/2+4;
            translate([middle-9.5, 2, wall_thickness+2.5+2+8])
                rotate([90, 0, 0])
                    cylinder(h = 2, r1 = 2, r2 = 3, center = false);

            translate([middle+34.5, 2, wall_thickness+2.5+2])
                rotate([90, 0, 0])
                    cylinder(h = 2, r1 = 2, r2 = 3, center = false);
            
            // Cover for the RTC module
            translate([12, 4, 0])
                cube([40, 60, 2]);
            translate([12+40/2,65,0])
                cylinder(h = 1, d = 15, $fn = segments);
            
            translate([12+16, 1, 3])
                ramp();
            translate([12+32, 1, 3])
                ramp();
        }
        
        // Holder for the cover's nut
        difference() {
            translate([8+40/2,61,1])
                cube([8, 8, 4]);
            translate([12+40/2+4,65,1])
                ramp_screw();
        }
    }
    
    // Cover's mounting hole
    translate([12+40/2,65,1])
        cylinder(4, 2.5, 2.5, center = false, $fn = segments);

}
