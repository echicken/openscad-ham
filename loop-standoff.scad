// Parallel loop conductor standoff - VE3XEC

// Secure to conductors with zip ties
// Maybe wrap conductors with silicone tape to prevent slippage

// Configuration
wall_thickness = 4; // Overall robustitude of this magnificent assemblage
spacing = 101.6; // Centre-to-centre spacing of conductors
c1_id = 27; // Inner diameter of cup 1
c2_id = 16; // Inner diameter of cup 2
zip_tie_width = 7; // Width of your zip ties; leave some tolerance
zip_tie_thickness = 5; // Thickness of your zip ties; leave some tolerance
$fn = 30; // Cylinder smooveness

// Compooted
c1_od = c1_id + (wall_thickness * 2);
c2_od = c2_id + (wall_thickness * 2);
depth = zip_tie_width + (wall_thickness * 2);

union() {
	difference() {
		cylinder(d = c1_od, h = depth);
		cylinder(d = c1_id, h = depth);
		translate([-(c1_od / 2), -(c1_od / 2), 0]) {
			cube([c1_od, c1_od / 2, depth]);
		}
	}
	translate([0, spacing, 0]) {
		difference() {
			cylinder(d = c2_od, h = depth);
			cylinder(d = c2_id, h = depth);
			translate([-(c2_od / 2), 0, 0]) {
				cube([c2_od, c2_od / 2, depth]);
			}
		}
	}
	translate([-(wall_thickness / 2), (c1_od / 2) - .5, 0]) {
		difference() {
			cube([wall_thickness, spacing - (c1_od / 2) - (c2_od / 2) + 1, depth]);
			translate([0, 0, wall_thickness]) {
				cube([wall_thickness, wall_thickness, zip_tie_width]);
			}
			translate([0, spacing - (c1_od / 2) - (c2_od / 2) - zip_tie_thickness + (wall_thickness / 2), wall_thickness]) {
				cube([wall_thickness, wall_thickness, zip_tie_width]);
			}

		}

	}
}