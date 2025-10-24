v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
N 20 -50 170 -50 {lab=drain}
N 20 -50 20 -30 {lab=drain}
N -70 70 -70 80 {lab=GND}
N 110 70 110 80 {lab=GND}
N 110 80 180 80 {lab=GND}
N 240 -50 240 10 {lab=drain}
N 170 -50 240 -50 {lab=drain}
N -70 80 110 80 {lab=GND}
N -70 80 -70 90 {lab=GND}
N 20 30 20 80 {lab=GND}
N -70 -0 -20 -0 {lab=gate}
N -70 0 -70 10 {lab=gate}
N 20 0 110 0 {lab=bulk}
N 110 0 110 10 {lab=bulk}
N 180 80 240 80 {lab=GND}
N 240 70 240 80 {lab=GND}
C {sky130_fd_pr/nfet_01v8.sym} 0 0 0 0 {name=M1
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
C {gnd.sym} -70 90 0 0 {name=l1 lab=GND}
C {vsource.sym} 240 40 0 0 {name=VDS value=1.8 savecurrent=false}
C {vsource.sym} 110 40 0 0 {name=VBS value=0 savecurrent=false}
C {vsource.sym} -70 40 0 0 {name=VGS value=1.8 savecurrent=false}
C {lab_wire.sym} 20 -50 0 0 {name=p1 sig_type=std_logic lab=drain
}
C {lab_wire.sym} 110 0 0 1 {name=p2 sig_type=std_logic lab=bulk}
C {lab_wire.sym} -70 0 0 0 {name=p3 sig_type=std_logic lab=gate

}
C {code_shown.sym} -80 150 0 0 {name=s1 only_toplevel=false
value=".lib /foss/pdks/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.dc VDS 0 1.8 1m VGS 0 1.8 200m
.save all"}
