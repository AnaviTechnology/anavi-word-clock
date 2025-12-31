// ========================
// Parameters
// ========================

// Grid
grid_height = 0.5;

// increase for smoother cone ($fn)
segments = 64;

// smooth corners
$fn = segments;  

module grid(cells = [8.5, 8.5], spacing = 1.5, wall = 2, height = grid_height) {
    rows = 8;
    cols = 8;

    // Vertical walls
    for (i = [0:cols]) {
        translate([
            i * (cells[0] + spacing) - spacing/2 - wall/2,
            -wall,
            0
        ])
            cube([wall, rows * (cells[1] + spacing)+wall, height]);
    }

    // Horizontal walls
    for (j = [0:rows]) {
        translate([
            -wall,
            j * (cells[1] + spacing) - spacing/2 - wall/2,
            0
        ])
            cube([cols * (cells[0] + spacing)+wall, wall, height]);
    }
}

// ========================
// Top case
// ========================

difference() {
    translate([0, 0, 0])
        cube([80, 80, 1]);
    translate([0.75, 0.75, 0.5])
        grid();
}