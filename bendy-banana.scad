// Bendy Banana - VE3XEC

// Guide a coaxial cable around a corner without violating its bend radius.
// Secure coax to guide with silicone tape at ends, middle to prevent slippage.

coax_od = 6.4; // Coax outer diameter.  Leave some wiggle room.
bend_radius = 64; // Best to overstate this by as many mm as is practical
wall_thickness = 2; // Increase this if the banana is too bendy

// Add some genitals if you want to join two or more of these together post-printing
// Could be useful for guiding coax around a u-turn or something, I dunno
mating_m = false; // Include a mating tab
mating_f = false; // Include a mating socket
mating_t = .85; // Mating connection tolerance

union() {

    intersection() {

        difference() {
            rotate_extrude(convexity = 10, $fn = 100) {
                translate([bend_radius - (coax_od / 2), 0, 0]) {
                    square([wall_thickness + (coax_od / 2), coax_od]);
                }
            }
            translate([0, 0, coax_od / 2]) {
                rotate_extrude(convexity = 10, $fn = 100) {
                    translate([bend_radius + wall_thickness, 0, 0]) {
                        circle(d = coax_od);
                    }
                }
        }
        }
        
        cube([bend_radius + (coax_od * 2), bend_radius + (coax_od * 2), coax_od]);

    }

    if (mating_m) {
        hull() {
            translate([bend_radius - (coax_od / 2) - (wall_thickness * mating_t), -(wall_thickness * 3), wall_thickness * (1 + (1 - mating_t))])  {
                cube([wall_thickness * mating_t, wall_thickness * 3, wall_thickness * mating_t]);
            }
            translate([bend_radius - (coax_od / 2) - 1, wall_thickness * 2, wall_thickness]) {
                cube([1, wall_thickness, wall_thickness * mating_t]);
            }
        }
    }

    if (mating_f) {
        difference() {
            translate([0, bend_radius - (coax_od / 2) - (wall_thickness * 2), 0]) {
                cube([wall_thickness * 3, wall_thickness * 2, coax_od]);
            }
            translate([0, bend_radius - (coax_od / 2) - wall_thickness, wall_thickness]) {
                cube([wall_thickness * 3, wall_thickness, coax_od - (wall_thickness * 2)]);
            }
        }
    }

}