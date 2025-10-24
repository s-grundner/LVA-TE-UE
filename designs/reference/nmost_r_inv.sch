v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N -110 60 -110 90 {lab=GND}
N -110 90 -0 90 {lab=GND}
N -0 90 160 90 {lab=GND}
N 160 0 160 90 {lab=GND}
N 100 60 100 90 {lab=GND}
N 0 20 0 90 {lab=GND}
N -110 -10 -110 -0 {lab=gate}
N -110 -10 -40 -10 {lab=gate}
N 100 -10 100 -0 {lab=GND}
N 0 -10 100 -10 {lab=GND}
N 0 -60 0 -40 {lab=out_1}
N 0 -280 0 -260 {lab=#net1}
N 0 -280 160 -280 {lab=#net1}
N 160 -280 160 -200 {lab=#net1}
N 340 20 340 90 {lab=GND}
N 160 90 340 90 {lab=GND}
N 340 -10 370 -10 {lab=GND}
N 370 -10 370 90 {lab=GND}
N 340 90 370 90 {lab=GND}
N 250 -10 300 -10 {lab=gate}
N 340 -60 340 -40 {lab=out_2}
N 340 -280 340 -260 {lab=#net1}
N 160 -280 340 -280 {lab=#net1}
N 160 -180 160 -60 {lab=#net1}
N 100 0 100 60 {lab=GND}
N -0 -180 -0 -160 {lab=#net2}
N 0 -100 0 -60 {lab=out_1}
N 340 -100 340 -60 {lab=out_2}
N 340 -80 370 -80 {lab=out_2}
N 0 -80 50 -80 {lab=out_1}
N 370 -80 390 -80 {lab=out_2}
N 0 -200 0 -180 {lab=#net2}
N 160 -200 160 -180 {lab=#net1}
N 340 -200 340 -160 {lab=#net3}
C {sky130_fd_pr/nfet_01v8.sym} -20 -10 0 0 {name=M1
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
C {vsource.sym} -110 30 0 0 {name=VIN value=1.8 savecurrent=false}
C {vsource.sym} 160 -30 0 0 {name=VDS value=1.8 savecurrent=false}
C {gnd.sym} 0 90 0 0 {name=l1 lab=GND}
C {code_shown.sym} -110 140 0 0 {name=spice_dc only_toplevel=false value="
.lib /foss/pdks/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.model nmos_L1 nmos level=1 VTO=0.5 KP=65u LAMBDA=0.2
.dc VIN 0 1.8 1m
.control
* ref ngspice docu
let start_r = 1k
let stop_r = 1meg
let r_act = start_r
* loop
while r_act le stop_r
alter RL1=r_act
alter RL2=r_act
run
write dc-sweep.out out_1, out_2
set appendwrite
let r_act = 10*r_act
end
plot dc1.out_1 dc2.out_1 dc2.out_2 
.endc
.save all"}
C {vsource.sym} 0 -230 0 0 {name=VID value=0 savecurrent=false}
C {nmos4.sym} 320 -10 0 0 {name=M_L1 model=nmos_L1 w=10 l=0.15 del=0 m=1}
C {lab_wire.sym} -80 -10 0 0 {name=p1 sig_type=std_logic lab=gate}
C {lab_wire.sym} 280 -10 0 0 {name=p2 sig_type=std_logic lab=gate}
C {vsource.sym} 340 -230 0 0 {name=VID_L1 value=0 savecurrent=false}
C {res.sym} 0 -130 0 0 {name=RL1
value=1k
footprint=1206
device=resistor
m=1}
C {res.sym} 340 -130 0 0 {name=RL2
value=1k
footprint=1206
device=resistor
m=1}
C {opin.sym} 50 -80 0 0 {name=p3 lab=out_1
}
C {opin.sym} 390 -80 0 0 {name=p4 lab=out_2
}
