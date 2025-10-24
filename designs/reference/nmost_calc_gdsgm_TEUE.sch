v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {Calculate A0 } 50 -140 0 0 1 1 {}
T {Calculate gm, gds
} -70 350 0 0 1 1 {}
T {sky model} -90 690 0 0 1 1 {}
T {Level 1 model} 250 710 0 0 1 1 {}
N 410 600 410 670 {lab=GND}
N 410 570 440 570 {lab=GND}
N 440 570 440 670 {lab=GND}
N 410 670 440 670 {lab=GND}
N 320 570 370 570 {lab=#net1}
N 410 520 410 540 {lab=#net2}
N 410 440 410 460 {lab=#net3}
N 320 640 320 670 {lab=GND}
N 320 570 320 580 {lab=#net1}
N 410 440 530 440 {lab=#net3}
N 530 440 530 520 {lab=#net3}
N 530 580 530 670 {lab=GND}
N 440 670 530 670 {lab=GND}
N 320 670 410 670 {lab=GND}
N -60 280 -60 310 {lab=GND}
N -60 310 50 310 {lab=GND}
N 50 310 210 310 {lab=GND}
N 210 220 210 310 {lab=GND}
N 150 280 150 310 {lab=GND}
N 50 240 50 310 {lab=GND}
N -60 210 -60 220 {lab=gate}
N 150 210 150 220 {lab=GND}
N 50 210 150 210 {lab=GND}
N 50 160 50 180 {lab=out_sky}
N 50 -60 50 -40 {lab=#net4}
N 50 -60 210 -60 {lab=#net4}
N 390 240 390 310 {lab=GND}
N 210 310 390 310 {lab=GND}
N 390 210 420 210 {lab=GND}
N 420 210 420 310 {lab=GND}
N 390 310 420 310 {lab=GND}
N 300 210 350 210 {lab=gate}
N 390 160 390 180 {lab=out_L1}
N 390 -60 390 -40 {lab=#net4}
N 210 -60 390 -60 {lab=#net4}
N 150 220 150 280 {lab=GND}
N 50 40 50 60 {lab=#net5}
N 50 120 50 160 {lab=out_sky}
N 390 120 390 160 {lab=out_L1}
N 390 140 420 140 {lab=out_L1}
N 50 140 100 140 {lab=out_sky}
N 420 140 440 140 {lab=out_L1}
N 50 20 50 40 {lab=#net5}
N 390 20 390 60 {lab=#net6}
N 210 -60 210 160 {lab=#net4}
N -60 210 10 210 {lab=gate}
N -77.5 627.5 -77.5 657.5 {lab=GND}
N -77.5 657.5 32.5 657.5 {lab=GND}
N 32.5 657.5 192.5 657.5 {lab=GND}
N 192.5 567.5 192.5 657.5 {lab=GND}
N 32.5 587.5 32.5 657.5 {lab=GND}
N -77.5 557.5 -77.5 567.5 {lab=#net7}
N -77.5 557.5 -7.5 557.5 {lab=#net7}
N 132.5 557.5 132.5 567.5 {lab=GND}
N 32.5 557.5 132.5 557.5 {lab=GND}
N 32.5 507.5 32.5 527.5 {lab=#net8}
N 32.5 427.5 32.5 447.5 {lab=#net9}
N 32.5 427.5 192.5 427.5 {lab=#net9}
N 192.5 427.5 192.5 507.5 {lab=#net9}
N 132.5 567.5 132.5 657.5 {lab=GND}
N 1210 170 1210 200 {lab=#net10}
N 1210 260 1210 290 {lab=#net11}
N 1210 350 1210 380 {lab=#net12}
N 1210 440 1210 460 {lab=GND}
N 1210 80 1260 80 {lab=GND}
N 1210 80 1210 110 {lab=GND}
C {gnd.sym} 370 670 0 0 {name=l1 lab=GND}
C {code_shown.sym} 630 -170 0 0 {name=spice_dc only_toplevel=false value="
.lib /foss/pdks/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.model nmos_L1 nmos level=1 VTO=0.5 KP=65u LAMBDA=0.2

.control
alter @RL1[resistance]=50k
alter @RL2[resistance]=50k

dc VIN 0 1.8 1m
let A0_sky=deriv(-out_sky)
let A0_L1=deriv(-out_L1)
plot out_sky, out_L1
plot A0_sky, A0_L1
meas DC A0max_sky max A0_sky
meas DC A0max_L1 max A0_L1
meas DC vgs_sky_op max_at A0_sky
meas DC vds_sky_op find out_sky at=vgs_sky_op
meas DC vgs_L1_op max_at A0_L1
meas DC vds_L1_op find out_L1 at=vgs_L1_op

alter @VGS_sky[dc]=vgs_sky_op
alter @VDS_sky[dc]=vds_sky_op
alter @VGS_L1[dc]=vgs_L1_op
alter @VDS_L1[dc]=vds_L1_op

dc VDS_sky 0 1.8 1m
let f_gds_sky=deriv(I(VID_sky_g))
plot f_gds_sky
meas DC gds_sky find f_gds_sky at=@VDS_sky[dc]
alter @Rgds_sky[resistance]=1/gds_sky

dc VGS_sky 0 1.8 1m
let f_gm_sky=deriv(I(VID_sky_g))
plot f_gm_sky
meas DC gm_sky find f_gm_sky at=@VGS_sky[dc]
alter @Rgm_sky[resistance]=1/gm_sky

dc VDS_L1 0 1.8 1m
let f_gds_L1=deriv(I(VID_L1_g))
plot f_gds_L1
meas DC gds_L1 find f_gds_L1 at=@VDS_L1[dc]
alter @Rgds_L1[resistance]=1/gds_L1

dc VGS_L1 0 1.8 1m
let f_gm_L1=deriv(I(VID_L1_g))
plot f_gm_L1
meas DC gm_L1 find f_gm_L1 at=@VGS_L1[dc]
alter @Rgm_L1[resistance]=1/gm_L1

let A0_sky_calc=1/(@Rgm_sky[resistance]*(1/@Rgds_sky[resistance]+1/@RL1[resistance]))
print A0_sky_calc
let A0_L1_calc=1/(@Rgm_L1[resistance]*(1/@Rgds_L1[resistance]+1/@RL2[resistance]))
print A0_L1_calc
.endc
.save all"}
C {nmos4.sym} 390 570 0 0 {name=M_L1 model=nmos_L1 w=10 l=0.15 del=0 m=1}
C {vsource.sym} 410 490 0 0 {name=VID_L1_g value=0 savecurrent=false}
C {vsource.sym} 530 550 0 0 {name=VDS_L1 value=0 savecurrent=false}
C {vsource.sym} 320 610 0 0 {name=VGS_L1 value=0 savecurrent=false}
C {sky130_fd_pr/nfet_01v8.sym} 30 210 0 0 {name=M1
W=10
L=0.15
nf=1 
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {vsource.sym} -60 250 0 0 {name=VIN value=1.8 savecurrent=false}
C {vsource.sym} 210 190 0 0 {name=VDD value=1.8 savecurrent=false}
C {gnd.sym} 50 310 0 0 {name=l2 lab=GND}
C {vsource.sym} 50 -10 0 0 {name=VID_sky value=0 savecurrent=false}
C {nmos4.sym} 370 210 0 0 {name=M_L2 model=nmos_L1 w=10 l=0.15 del=0 m=1}
C {lab_wire.sym} -30 210 0 0 {name=p1 sig_type=std_logic lab=gate}
C {lab_wire.sym} 330 210 0 0 {name=p2 sig_type=std_logic lab=gate}
C {vsource.sym} 390 -10 0 0 {name=VID_L1 value=0 savecurrent=false}
C {res.sym} 50 90 0 0 {name=RL1
value=1k
footprint=1206
device=resistor
m=1}
C {res.sym} 390 90 0 0 {name=RL2
value=1k
footprint=1206
device=resistor
m=1}
C {opin.sym} 100 140 0 0 {name=p3 lab=out_sky

}
C {opin.sym} 440 140 0 0 {name=p4 lab=out_L1

}
C {sky130_fd_pr/nfet_01v8.sym} 12.5 557.5 0 0 {name=M2
W=10
L=0.15
nf=1 
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {vsource.sym} -77.5 597.5 0 0 {name=VGS_sky value=0 savecurrent=false}
C {vsource.sym} 192.5 537.5 0 0 {name=VDS_sky value=0 savecurrent=false}
C {gnd.sym} 42.5 657.5 0 0 {name=l3 lab=GND}
C {vsource.sym} 32.5 477.5 0 0 {name=VID_sky_g value=0 savecurrent=false}
C {res.sym} 1210 410 0 0 {name=Rgds_L1
value=1k
footprint=1206
device=resistor
m=1}
C {res.sym} 1210 320 0 0 {name=Rgm_L1
value=1k
footprint=1206
device=resistor
m=1}
C {res.sym} 1210 230 0 0 {name=Rgds_sky
value=1k
footprint=1206
device=resistor
m=1}
C {res.sym} 1210 140 0 0 {name=Rgm_sky
value=1k
footprint=1206
device=resistor
m=1}
C {gnd.sym} 1210 460 0 0 {name=l6 lab=GND}
C {gnd.sym} 1260 80 0 0 {name=l7 lab=GND}
