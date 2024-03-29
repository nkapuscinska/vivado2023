/**
 * Copyright (C) 2023  AGH University of Science and Technology
 * MTM UEC2
 * Author: Piotr Kaczmarczyk
 *
 * Description:
 * Package with vga related constants.
 */

package vga_pkg;

// Parameters for VGA Display 800 x 600 @ 60fps using a 40 MHz clock;
localparam HOR_PIXELS = 800;
localparam VER_PIXELS = 600;

localparam start = 0;

localparam H_Tot_time = 1056 ;
localparam H_Blank_time = 800 ;
localparam H_Sync_start = 840 ; //porch end
localparam H_Back_time = 968 ;

localparam V_Tot_time = 628 ;
localparam V_Blank_time = 600 ;
localparam V_Sync_start = 601 ; //porch end
localparam V_Back_time =  605;


// Add VGA timing parameters here and refer to them in other modules.

endpackage
