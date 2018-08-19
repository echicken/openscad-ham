// Mounting bracket for 2m/70cm quarter-wave vertical - VE3XEC

// Requires https://cdn.thingiverse.com/assets/c7/f3/51/08/71/So-239_holes.stl
// loughkb via https://www.thingiverse.com/thing:2778805

// Could be modified to accommodate a u-bolt for mast mounting, I guess.
// I'm just going to attach these to a wooden deck structure.

wall_thickness = 4; // Robustitude
length = 100; // Overall length, ie. as much as your printer can accommodate
coax_od = 6.4; // Not critical; determines width of zip-tie attachment point
hole = 4; // Diameter of mounting screw holes. Leave wiggle room, use pan-head screws.

conn = 25; // Length / width of chassis mount connector square
depth = conn + wall_thickness;

$fn = 32;

union() {
    difference() {
        union() {
            // Long / vertical piece
            cube([wall_thickness, length - (wall_thickness * 2), depth]);
            // Short / horizontal / standoff piece
            translate([wall_thickness * 2, length - wall_thickness, 0]) {
                cube([depth, wall_thickness, depth]);
            }
            // Connect vertical to horizontal; #robust
            hull() {
                translate([0, length - (wall_thickness * 2), 0]) {
                    cube([wall_thickness, wall_thickness, depth]);
                }
                translate([wall_thickness, length - wall_thickness, 0]) {
                    cube([wall_thickness, wall_thickness, depth]);
                }
            }
            // Zip tie slot to secure coax
            difference() {
                translate([wall_thickness, hole * 2, (depth / 2) - (coax_od / 2)]) {
                    cube([wall_thickness, 10, coax_od]);
                }
                translate([wall_thickness, (hole * 2) + (wall_thickness / 2), (depth / 2) - (coax_od / 2)]) {
                    cube([wall_thickness / 2, 6, coax_od]);
                }
            }
        }
        // Punch out holes for SO-239 chassis-mount connector
        translate([(conn / 2) + 5, 105, -13]) {
            rotate([90, 0, 0]) {
                import("So-239_holes.stl");
            }
        }
        // Screw holes
        translate([0, hole * 1.5, hole * 1.5]) {
            rotate([0, 90, 0]) {
                cylinder(h = wall_thickness + 1, d = hole);
            }
        }
        translate([0, hole * 1.5, depth - (hole * 1.5)]) {
            rotate([0, 90, 0]) {
                cylinder(h = wall_thickness + 1, d = hole);
            }
        }
        translate([0, depth, hole * 1.5]) {
            rotate([0, 90, 0]) {
                cylinder(h = wall_thickness + 1, d = hole);
            }
        }
        translate([0, depth, depth - (hole * 1.5)]) {
            rotate([0, 90, 0]) {
                cylinder(h = wall_thickness + 1, d = hole);
            }
        }
    }
}
