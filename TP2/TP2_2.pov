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
    location  <30,0,20>
    right     <-image_width/image_height,0,0> // keep propotions with any aspect ratio   
    sky <0,0,1>
    look_at   <0,0,0>
    }

light_source {<-140,200, 300> rgb <1.0, 1.0, 0.95>*1.5}
light_source {< 140,200,-300> rgb <0.9, 0.9, 1.00>*0.9 shadowless}

#macro CbeOuverture(n, r, epai, coul)
    #declare tableau = array[n];
    #for (i, 0, n - 1)
        #declare point = (pi*i)/n;
        #declare tableau[i] = <r*cos(point), r*sin(point), 0>;
        sphere{
            tableau[i] 0.5
            pigment {color rgbt<1,0,0,0>}
        }
        sphere{
            <0,0,0> 0.5
            pigment {color rgbt<1,0,0,0>}
        }     
    #end
    #for (i, 0, n - 1)       
        cylinder{
            <tableau[i].x, tableau[i].y, tableau[i].z>, <tableau[mod(i+1, n)].x, tableau[mod(i+1, n)].y, tableau[mod(i+1, n)].z>, epai
            pigment {color coul}    
        }          
    #end    
#end

#macro CbeFerme(n, r, epai, coul)
    #declare tableau = array[n];
    #for (i, 0, n - 1)
        #declare point = (2*pi*i)/n;
        #declare tableau[i] = <r*cos(point), r*sin(point), 0>;
        sphere{
            tableau[i] 0.5
            pigment {color rgbt<1,0,0,0>}
        }
        sphere{
            <0,0,0> 0.5
            pigment {color rgbt<1,0,0,0>}
        }     
    #end
    #for (i, 0, n - 1)       
        cylinder{
            <tableau[i].x, tableau[i].y, tableau[i].z>, <tableau[mod(i+1, n)].x, tableau[mod(i+1, n)].y, tableau[mod(i+1, n)].z>, epai
            pigment {color coul}    
        }          
    #end    
#end

CbeFerme(10, 10, 0.1, rgbt<1,0,0,0>)                                        