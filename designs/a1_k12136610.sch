v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {SKY Modell} 370 -360 0 0 0.4 0.4 {}
T {PMOST/R Verstaerker} 50 -360 0 0 0.4 0.4 {}
N 140 -70 140 -60 {lab=GND}
N 80 -250 80 -200 {lab=in}
N 80 -250 100 -250 {lab=in}
N 80 -140 80 -60 {lab=GND}
N 140 -210 150 -210 {lab=out}
N 140 -220 140 -200 {lab=out}
N 140 -140 140 -130 {lab=#net1}
N 220 -140 220 -60 {lab=GND}
N 140 -290 140 -280 {lab=#net2}
N 320 -210 320 -200 {lab=#net3}
N 320 -210 380 -210 {lab=#net3}
N 320 -140 320 -60 {lab=GND}
N 420 -180 420 -60 {lab=GND}
N 510 -140 510 -60 {lab=GND}
N 420 -210 440 -210 {lab=#net4}
N 140 -250 220 -250 {lab=#net2}
N 220 -250 220 -200 {lab=#net2}
N 220 -290 220 -250 {lab=#net2}
N 140 -290 220 -290 {lab=#net2}
N 620 -210 620 -200 {lab=GND}
N 570 -210 620 -210 {lab=GND}
N 570 -210 570 -200 {lab=GND}
N 620 -70 620 -60 {lab=GND}
N 620 -140 620 -130 {lab=#net5}
N 440 -210 510 -210 {lab=#net4}
N 510 -210 510 -200 {lab=#net4}
N 420 -270 420 -240 {lab=#net6}
N 510 -270 510 -210 {lab=#net4}
N 420 -290 430 -290 {lab=#net6}
N 420 -290 420 -270 {lab=#net6}
N 490 -290 510 -290 {lab=#net4}
N 510 -290 510 -270 {lab=#net4}
C {sky130_fd_pr/pfet_01v8.sym} 120 -250 0 0 {name=M1
W=1
L=0.15
nf=1
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 80 -250 0 0 {name=p1 sig_type=std_logic lab=in}
C {gnd.sym} 140 -60 0 0 {name=l1 lab=GND}
C {vsource.sym} 80 -170 0 0 {name=VIN value=1.8 savecurrent=false}
C {vsource.sym} 220 -170 0 0 {name=VDD value=1.8 savecurrent=false}
C {res.sym} 140 -100 0 0 {name=RL
value=50k
footprint=1206
device=resistor
m=1}
C {gnd.sym} 80 -60 0 0 {name=l3 lab=GND}
C {gnd.sym} 220 -60 0 0 {name=l4 lab=GND}
C {code.sym} 680 -170 0 0 {name=spice_dc only_toplevel=false value="
.lib /foss/pdks/sky130A/libs.tech/ngspice/sky130.lib.spice tt

.control
set xbrushwidth=7
set xgridwidth=2
set xfont_size=20

alter @RL[resistance]=50k

dc VIN 0 1.8 1m
let A0=deriv(-out)
plot out
plot A0
meas DC A0max max A0
meas DC vgd_op max_at A0
meas DC vds_op find out at=vgd_op

alter @VGD[dc]=vgd_op
alter @VDS[dc]=vds_op

dc VDS 0 1.8 1m
let func_gds=deriv(I(VIDg))
plot func_gds
meas DC gds find func_gds at=@VDS[dc]
alter @Rgds[resistance]=1/gds

dc VGD 0 1.8 1m
let func_gm=deriv(I(VIDg))
plot func_gm
meas DC gm find func_gm at=@VGD[dc]
alter @Rgm[resistance]=1/gm

let A0_calc=1/(@Rgm[resistance]*(1/@Rgds[resistance]+1/@RL[resistance]))
print A0_calc

.endc
.save all
"}
C {opin.sym} 150 -210 0 0 {name=p2 lab=out}
C {sky130_fd_pr/pfet_01v8.sym} 400 -210 0 0 {name=M2
W=1
L=0.15
nf=1
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {vsource.sym} 320 -170 0 0 {name=VGD value=0 savecurrent=false}
C {gnd.sym} 320 -60 0 0 {name=l2 lab=GND}
C {gnd.sym} 510 -60 0 0 {name=l5 lab=GND}
C {gnd.sym} 420 -60 0 0 {name=l6 lab=GND}
C {vsource.sym} 510 -170 0 0 {name=VDS value=0 savecurrent=false}
C {res.sym} 620 -170 0 0 {name=Rgds
value=1k
footprint=1206
device=resistor
m=1}
C {res.sym} 620 -100 0 0 {name=Rgm
value=1k
footprint=1206
device=resistor
m=1}
C {gnd.sym} 620 -60 0 0 {name=l7 lab=GND}
C {gnd.sym} 570 -200 0 0 {name=l8 lab=GND}
C {ammeter.sym} 460 -290 1 0 {name=VIDg savecurrent=true spice_ignore=0}
C {ammeter.sym} 140 -170 0 0 {name=VID savecurrent=true spice_ignore=0}
