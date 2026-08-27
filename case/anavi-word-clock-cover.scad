// increase for smoother cone ($fn)
segments = 64;

// Inner hole
hole_r = 3;
hole_h = 2;

module ramp() {
    rotate([90, 0, 90])
    linear_extrude(height = 8)
        polygon([
            [0, 0],
            [3, 0],
            [3, 1.5]
        ]);
}

difference() {
    union() {
        cube([40, 60, 2]);
        translate([40/2,60,1])
            cylinder(h = 1, d = 15, $fn = segments);
        
        translate([8,-3,0])
            ramp();
        
        translate([24,-3,0])
            ramp();
    }

    // Opening for the screw
    translate([40/2,61,0])
        cylinder(2, hole_h, hole_r, center = false, $fn = segments);

    // Opening for the reset button
    translate([3,5,0])
        cylinder(2, 1, 1, center = false, $fn = segments);

    // LED
    translate([8,5,0])
        cylinder(2, 3, 3, center = false, $fn = segments);
}
