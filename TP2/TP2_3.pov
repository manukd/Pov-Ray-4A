#version 3.6;
global_settings{ assumed_gamma 1.3 max_trace_level 5}
#include "math.inc"
#include "colors.inc"
#include "functions.inc"
#include "logo.inc"
#include "skies.inc"

sky_sphere {
    S_Cloud5
    rotate <90,0.051, 1>
}

camera { 
    location  <20,10,20>
    right     <-image_width/image_height,0,0> // keep propotions with any aspect ratio   
    sky <0,0,1>
    look_at   <0,0,0>
    }

light_source {<-140,200, 300> rgb <1.0, 1.0, 0.95>*1.5}
light_source {< 140,200,-300> rgb <0.9, 0.9, 1.00>*0.9 shadowless}

#macro MaSphere(r, m, p)
    #declare tableau = array[p][m]
    
    #for (i, 0, p - 1)
        #for (j, 0, m - 1)
            #declare pointP = (2*pi*j)/m;
            #declare pointM = (pi*i)/p;
            #declare tableau[i][j] = <r * cos(pointP) * sin(pointM), r * cos(pointP) * cos(pointM), r * sin (pointP)>;
            sphere{
                tableau[i][j] 0.1
                pigment {color rgbt<1,0,0,0>}
            }
        #end
    #end
    sphere{
        <0,0,r> 0.3
        pigment {color rgbt<0,1,0,0>}
    }
    sphere{
        <0,0,-r> 0.3
        pigment {color rgbt<0,1,0,0>}
    }
    #for (i, 0, p - 1)
        #for (j, 0, m - 1)
            cylinder{
                <tableau[i][j].x, tableau[i][j].y, tableau[i][j].z>, <tableau[mod(i, p)][mod(j+1, m)].x, tableau[mod(i, p)][mod(j+1, m)].y, tableau[mod(i, p)][mod(j+1, m)].z>, 0.05
                pigment {color rgbt<0,0,1,0.8>}    
            }
            cylinder{
                <tableau[i][j].x, tableau[i][j].y, tableau[i][j].z>, <tableau[mod(i+1, p)][mod(j+1, m)].x, tableau[mod(i+1, p)][mod(j+1, m)].y, tableau[mod(i+1, p)][mod(j+1, m)].z>, 0.05
                pigment {color rgbt<0,0,1,0.8>}    
            }
        #end
    #end
#end

MaSphere(10, 20, 10)    