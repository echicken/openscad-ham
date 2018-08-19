// Coax hanger for strain relief - VE3XEC

// Slip onto coaxial cable before installing connector, so that the larger circle is toward
// where the connector will be.  Takes some weight off of soldered/crimped connections.

// Configuration
connector_od = 19.6; // Connector shell outer diameter.  Leave some wiggle room
connector_length = 40; // Open end of connector shell to end of reducer (fully engaged)
coax_od = 6.6; // Coax outer diameter.  Leave some wiggle room
wall_thickness = 4; // 4 mm should be strong enough, but increase as needed
shell_length = 10; // Length of the sleeve portions

// Configurable but probably best left alone
$fn = 30;
total_length = connector_length + shell_length + 20; // Stand off 2 cm from end of reducer

rotate([0, -90, 0]) { // Prints a bit faster and may be more robust if rotated thusly.
    union() {
        
        difference() {
            cylinder(d = connector_od + wall_thickness, h = shell_length);
            cylinder(d = connector_od, h = shell_length);
        }
        
        translate([-((connector_od + wall_thickness) / 2), 0, 0]) {
            cylinder(d = wall_thickness, h = total_length - shell_length);
        }
        
        translate([0, 0, total_length - shell_length]) {
            difference() {
                cylinder(d = coax_od + wall_thickness, h = shell_length);
                cylinder(d = coax_od, h = shell_length);
            }
        }
        
        hull() {
            translate([-((connector_od + wall_thickness) / 2), 0, total_length - shell_length]) {
                cylinder(d = wall_thickness, h = shell_length);
            }
            translate([-((coax_od + wall_thickness) / 2), 0, total_length - shell_length]) {
                cylinder(d = wall_thickness, h = shell_length);
            }
        }
        
    }
}