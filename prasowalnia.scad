podloga_sz = 196;
podloga_gl = 160;
garderoba_wys = 250;
garderoba_wys_tyl = 134;
sciana_gr = 1;
polka_gr = 1.5;
sufit_sz_mar = 27;
sufit_gl_mar = 26;
sufit_sz_mar_dol = 34;
fronty = true;

module podloga() {
    translate([0, 0, -1])
        linear_extrude(height=1, center=false, convexity=10, twist=0)
            square([podloga_sz, podloga_gl]);
}

module sciany() {
    rotate([0, -90, 0]) {
        // lewa
        linear_extrude(height=1, center=false, convexity=10, twist=0)
            polygon([[0, 0],[garderoba_wys, 0], [garderoba_wys, 26], [garderoba_wys_tyl, podloga_gl], [0, podloga_gl]]);
        //prawa
        translate([0, 0, -podloga_sz-sciana_gr]) 
            linear_extrude(height=1, center=false, convexity=10, twist=0)
                square([garderoba_wys, podloga_gl]);
        //tył
        translate([0, podloga_gl, 0])
            rotate([-90, 0, 0])
                linear_extrude(height=1, center=false, convexity=10, twist=0)
                    polygon([[0, 0],[garderoba_wys_tyl, 0], [garderoba_wys_tyl, sufit_sz_mar_dol], [garderoba_wys, podloga_sz-sufit_sz_mar], [garderoba_wys, podloga_sz], [0, podloga_sz]]);
        // przód
        rotate([-90, 0, 0])
            translate([0, 0, -15])
                difference() {
                    linear_extrude(height=15, center=false, convexity=10, twist=0)
                        square([garderoba_wys, podloga_sz]);
                    translate([0, 80.5, -10]) 
                        linear_extrude(height=35, center=false, convexity=10, twist=0)
                            square([200, 75]);
                }
    }
}

module zloSufitu() {
    zapas = 30;
    polyhedron(
        points=[
          /*0 tylny lewy róg*/ [0, podloga_gl, garderoba_wys_tyl],
          /*1 lewy przedni róg*/ [0, sufit_gl_mar, garderoba_wys],
          /*2 prawy przedni róg*/ [podloga_sz-sufit_sz_mar, sufit_gl_mar, garderoba_wys],
          /*3 prawy tylny róg*/ [podloga_sz-sufit_sz_mar, podloga_gl, garderoba_wys],
          /*4 rog rog */ [sufit_sz_mar_dol, podloga_gl, garderoba_wys_tyl],
          /*5 goora */ [-zapas, podloga_gl+zapas, garderoba_wys+zapas]],
        faces=[[0, 1, 2],
            [0, 2, 4],
            [3, 4, 2],
            [0, 5, 1],
            [0, 3, 5],
            [0, 4, 3],
            [5, 2, 1],
            [5, 3, 2]
            ]
    );

}

module sufit() {
    translate([0, 0, garderoba_wys])
        linear_extrude(height=1, center=false, convexity=10, twist=0)
            polygon([[0, 0], [podloga_sz, 0], [podloga_sz, podloga_gl], [podloga_sz-sufit_sz_mar, podloga_gl], [podloga_sz-sufit_sz_mar, sufit_gl_mar], [0, sufit_gl_mar]]);
    polyhedron(
        points=[
          /*0 tylny lewy róg*/ [0, podloga_gl, garderoba_wys_tyl],
          /*1 lewy przedni róg*/ [0, sufit_gl_mar, garderoba_wys],
          /*2 prawy przedni róg*/ [podloga_sz-sufit_sz_mar, sufit_gl_mar, garderoba_wys],
          /*3 prawy tylny róg*/ [podloga_sz-sufit_sz_mar, podloga_gl, garderoba_wys],
          /*4 rog rog */ [sufit_sz_mar_dol, podloga_gl, garderoba_wys_tyl],
    
          /*5*/ [0, podloga_gl, garderoba_wys_tyl+sciana_gr],
          /*6*/ [0, sufit_gl_mar, garderoba_wys+sciana_gr],
          /*7*/ [podloga_sz-sufit_sz_mar, sufit_gl_mar, garderoba_wys+sciana_gr],
          /*8*/ [podloga_sz-sufit_sz_mar, podloga_gl, garderoba_wys+sciana_gr],
          /*9*/ [sufit_sz_mar_dol, podloga_gl, garderoba_wys_tyl+sciana_gr]],
        faces=[[0, 1, 2],
            [0, 2, 4],
            [3, 4, 2],
            [5, 7, 6],
            [5, 9, 7],
            [8, 7, 9],
            // lewy bok
            [0, 5, 1],
            [5, 6, 1],
            // przód
            [1, 6, 2],
            [6, 7, 2],
            // prawy bok
            [2, 7, 3],
            [7, 8, 3],
            // tylny skos
            [3, 8, 4],
            [8, 9, 4],
            // tylny dol
            [0, 4, 5],
            [5, 4, 9]
            ]
    );
}

module ruraOdkurzacza() {
    translate([110, podloga_gl-5, 145]) {
        for (k=[0:3:180]) {
            rotate([0, -k, 0])
                translate([25, 0, 0])
                    cylinder(r=2.55, h=2);
        }
        translate([-25, 0, -50]) cylinder(d=5, h=50);
        translate([25, 0, -50]) cylinder(d=5, h=50);
    }
}

module deskaDoPrasowania() {
    wysDeski = 15;
    translate([90, podloga_gl-wysDeski, 10])
        rotate([-90, -90, 0])
            linear_extrude(height=15, center=false, convexity=10, twist=0)
                translate([5, 5, 0])
                    offset(r=5)
                        difference() {
                            square([130, 30]);
                            translate([110, 0, 0])
                                rotate([0, 0, 20])
                                    translate([0, -10, 0])
                                        square([30, 10]);
                            translate([110, 30, 0])
                                rotate([0, 0, -20])
                                    square([30, 10]);
                                    
                        }
}

module kaloryfer() {
    color("red") {
        translate([0, 20, 0]) cube([12, 66, 60]);
        translate([0, 20+66, 0]) cube([5, podloga_gl-20-66, 15]);
        translate([0, podloga_gl-5, 0]) cube([37, 5, 15]);
    }
}

module polkiPrawe(glebokosc, polka_wys, fronty) {
    difference() {
        union() {
            color("green") {
                translate([podloga_sz, 0, 0])
                    rotate([0, 0, 90])
                        for(i = [garderoba_wys-polka_wys:-polka_wys:polka_wys]) {
                            if (i>(garderoba_wys-polka_wys)/2+polka_wys && i<(garderoba_wys+polka_wys)/2+polka_wys) {
                                translate([0, 0, i])
                                    cube([podloga_gl, glebokosc+5*polka_gr, polka_gr]);
                            } else {
                                translate([0, 0, i])
                                    cube([podloga_gl, glebokosc, polka_gr]);
                            }
                        }
                translate([podloga_sz-glebokosc, (podloga_gl-polka_gr)/2, 0])
                    cube([glebokosc, polka_gr, garderoba_wys]);
            }
            if (fronty) {
                translate([podloga_sz-glebokosc-(2*polka_gr), 0, 0])
                    %cube([polka_gr, podloga_gl/2+5, garderoba_wys]);
                translate([podloga_sz-glebokosc-(4*polka_gr), podloga_gl/2-5, 0])
                    %cube([polka_gr, podloga_gl/2+5, garderoba_wys]);
            }
        }
        zloSufitu();
    }
}

module wieszak() {
    color("yellow") {
        translate([-20, 15, 0])
            cube([40, 1, 1]);
        translate([-20, 15, 0])
            rotate([0, 0, -30])
                cube([23, 1, 1]);
        translate([0, 3.5, 0])
            rotate([0, 0, 30])
                cube([23, 1, 1]);
    }
}

module polkiLewe(glebokosc, polka_wys, fronty) {
    difference() {
        union() {
            color("green") {
                    translate([0, (podloga_gl+15)/2, 0])
                        cube([glebokosc, polka_gr, garderoba_wys]);
                    rotate([0, 0, -90])
                        for(i = [garderoba_wys-polka_wys:-polka_wys:polka_wys]) {
                            translate([-podloga_gl, 0, i])
                            if (i>(garderoba_wys-polka_wys)/2+polka_wys && i<(garderoba_wys+polka_wys)/2+polka_wys) {
                                cube([podloga_gl, glebokosc+5*polka_gr, polka_gr]);
                            } else {
                                if (i>(garderoba_wys-polka_wys)/2+polka_wys) {
                                    cube([podloga_gl, glebokosc/2, polka_gr]);
                                } else {
                                    cube([(podloga_gl-15)/2-polka_gr, glebokosc, polka_gr]);
                                }
                            }
                        }
                    translate([(glebokosc+polka_gr)/2, 0, 140])
                        rotate([-90, 0, 0]) {
                            cylinder(d=polka_gr, h=podloga_gl/2);
                            for (i=[0:10:podloga_gl/2]) {
                                translate([0, 0, i]) wieszak();
                            }
                        }
                        
            }
            if (fronty) {
                translate([glebokosc+(2*polka_gr), 0, 0])
                    %cube([polka_gr, podloga_gl/2+5, garderoba_wys-4*polka_wys]);
                translate([glebokosc+(4*polka_gr), podloga_gl/2-5, 0])
                    %cube([polka_gr, podloga_gl/2+5, garderoba_wys-4*polka_wys]);
            }
            
        }
        union() {
            zloSufitu();
            kaloryfer();
        }
    }
}

module lampka() {
    color("blue")
        translate([120, 0, 220]) {
            rotate([-90, 0, 0])
                cylinder(d=15, h=3);
            rotate([50, 0, 0])
                hull() {
                    translate([0, 2, 0])
                        cylinder(d=5, h=1);
                    translate([0, 0, -15])
                        cylinder(d=15, h=1);
                }

        }
}



module gniazdko() {
    color("blue")
        translate([30, 0, 69])
            cube([10, 3, 20]);
}

module wlacznik() {
    color("blue")
        translate([62, 0, 120])
            cube([10, 3, 10]);
}


//%podloga();
//%sciany();
%sufit();
kaloryfer();
gniazdko();
wlacznik();
lampka();

deskaDoPrasowania();
ruraOdkurzacza();

polkiLewe(60, 25, fronty);
polkiPrawe(33, 25, fronty);

