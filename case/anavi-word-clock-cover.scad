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

    translate([40/2,60,0])
        cylinder(2, hole_h, hole_r, center = false, $fn = segments);

    translate([3,5,0])
        cylinder(2, 1, 1, center = false, $fn = segments);
}
