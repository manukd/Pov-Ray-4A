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
    location  <50,50,50>
    right     <-image_width/image_height,0,0> // keep propotions with any aspect ratio   
    sky <0,0,1>
    look_at   <0,0,10>
    }

light_source {<-140,200, 300> rgb <1.0, 1.0, 0.95>*1.5}
light_source {< 140,200,-300> rgb <0.9, 0.9, 1.00>*0.9 shadowless}

#declare r1 = seed(0);
#declare nb_point = 10;
#declare tableau = array[2*nb_point];
#declare rCyl = 20;
#declare dimPt = 30;
#declare point = 0;
#for (i, 0, nb_point - 1)
    #declare point = (2*pi*i)/nb_point;
    #declare tableau[i] = <rCyl*cos(point), rCyl*sin(point), 0>;
    #declare tableau[i+nb_point] = <rCyl*cos(point), rCyl*sin(point), dimPt>;
    sphere{
        tableau[i] 1
        pigment {color rgbt<1,0,0,0>}
    }
    sphere{
        tableau[i+nb_point] 1
        pigment {color rgbt<1,0,0,0>}
    }
    cylinder{
        <tableau[i].x, tableau[i].y, tableau[i].z>, <tableau[i+nb_point].x, tableau[i+nb_point].y, tableau[i+nb_point].z>, 0.1
        pigment {color rgbt<1,0,0,0>}    
    }
    sphere{
        <0,0,0> 1
        pigment {color rgbt<1,0,0,0>}
    }
    sphere{
        <0,0,dimPt> 1
        pigment {color rgbt<1,0,0,0>}
    }
      
#end
    
#for (i, 0, nb_point - 1)       
    cylinder{
        <tableau[i].x, tableau[i].y, tableau[i].z>, <tableau[mod(i+1, nb_point)].x, tableau[mod(i+1, nb_point)].y, tableau[mod(i+1, nb_point)].z>, 0.1
        pigment {color rgbt<1,0,0,0>}    
    }
    cylinder{
        <tableau[i+nb_point].x, tableau[i+nb_point].y, tableau[i+nb_point].z>, <tableau[nb_point + mod(i+1, nb_point)].x, tableau[nb_point + mod(i+1, nb_point)].y, tableau[nb_point + mod(i+1, nb_point)].z>, 0.1
        pigment {color rgbt<1,0,0,0>}    
    }    
    polygon{
        3, tableau[mod(i+1, nb_point)], tableau[i], <0,0,0>
        pigment {color rgbt<0,1,0,0.8>}    
    } 
    polygon{
        3, tableau[nb_point + mod(i+1, nb_point)], tableau[nb_point+i], <0,0,dimPt>
        pigment {color rgbt<0,1,0,0.8>}    
    }           
#end
    
#for (i, 0, nb_point - 1)   
    polygon{
        4, tableau[i], tableau[i+nb_point], tableau[nb_point + mod(i+1, nb_point)], tableau[mod(i+1, nb_point)]
        pigment {color rgbt<1,0,0,0.8>}
    }    
#end
                                                            