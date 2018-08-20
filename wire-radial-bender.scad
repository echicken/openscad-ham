// Form for bending wire to a particular angle - VE3XEC
// (I intend to use it to bend some radials 42 degrees for a quarter-wave vertical antenna)

wire_od = 3.8; // Outer diameter of radial wire
deck_length = 10; // Length of the slotted horizontal portion
slant_length = 20; // Length of the slotted slanted portion
angle = 42; // Adjust to suit your needs; 42 degrees for quarter-wave radials
$fn = 30; // Cylinder smooveness

difference() {
    union() {
        cube([deck_length, tan(angle) * slant_length, wire_od * 2]);
        translate([deck_length, 0, 0]) {
            linear_extrude(height = wire_od * 2, convexity = 10) {
                polygon(points = [[0, 0], [slant_length, 0], [0, tan(angle) * slant_length]]);
            }
        }
    }
    translate([0, tan(angle) * (slant_length), wire_od]) {
        rotate([0, 90, 0]) {
            cylinder(d = wire_od, h = deck_length);
        }
    }
    translate([deck_length + slant_length, 0, wire_od]) {
        rotate([-90, 0, 90 - angle]) {
            cylinder(d = wire_od, h = (slant_length / 2) + (tan(angle) * slant_length));
        }
    }
}