// Coax coil clip - VE3XEC

// Two of these fit together to form a clip, useful for making a tidy air-core coax coil.
// You'll probably want at least three clips (six of these) per coil, more for larger coils.
// The clip at the start/end of the coil should accommodate an extra pass of coax.

// Configuration
coax_od = 6.5; // Outer diameter of coax.  Leave some wiggle room.
width = 10; // 4 mm is the absolute minimum to prevent lateral movement of clip halves
wall_thickness = 1; // Should be at least 1mm
passes = 2; // How many passes of coax to accommodate
spacing = 0; // passes are separated centre-to-centre by coax_od plus this amount

// Configurable but best left alone
height = (coax_od / 2) + wall_thickness;
$fn = 30;

rotate([90, 0, 0]) { // Rotated so that the fastener doesn't bend away from its base layer. #robust
    difference() {
        union() {
            cube([wall_thickness * 2, width, height]);
            translate([0, (width / 2) - 1, height]) {
                cube([2, 2, height]);
            }
            hull() {
                translate([0, (width / 2) - 1, height * 2]) {
                    cube([1, 2, 2]);
                }
                translate([2, (width / 2) - 1, height * 2]) {
                    cube([2, 2, 1]);
                }
            }
            translate([3.5, (width / 2) + 1, (height * 2)]) {
                rotate([90, 0, 0]) {
                    cylinder(d = 1, h = 2);
                }
            }
            difference() {
                translate([wall_thickness * 2, 0, 0]) {
                    cube([(wall_thickness * 4) + (coax_od * passes) + (spacing * (passes - 1)), width, height]);
                }
                for (n = [0 : 1 : passes - 1]) {
                    translate([(wall_thickness * 4) + (coax_od / 2) + ((coax_od + spacing) * n), 0, wall_thickness + (coax_od / 2)]) {
                        rotate([-90, 0, 0]) {
                            cylinder(d = coax_od, h = width + 1);
                        }
                    }
                }
            }
            difference() {
                translate([(wall_thickness * 4) + ((coax_od + spacing) * passes), 0, 0]) {
                    cube([wall_thickness * 4, width, height]);
                }
                translate([(wall_thickness * 6) + ((coax_od + spacing) * passes), (width / 2) - 1.125, 0]) {
                    cube([wall_thickness * 2, 2.25, height]);
                }
            }
        }
        translate([(wall_thickness * 4) + ((coax_od + spacing) * passes) + 1, (width / 2) - 1.125, 0]) {
            rotate([-90, 0, 0]) {
                cylinder(d = 1.15, h = 2.25);
            }
        }
    }
}