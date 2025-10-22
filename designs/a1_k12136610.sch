v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {SKY Modell} 480 -390 0 0 0.4 0.4 {}
T {PMOST/R Verstaerker} 110 -390 0 0 0.4 0.4 {}
N 120 -200 140 -200 {lab=#net1}
N 180 -250 180 -230 {lab=GND}
N 440 -200 460 -200 {lab=#net2}
N 180 -250 260 -250 {lab=GND}
N 720 -160 720 -140 {lab=GND}
N 720 -240 720 -220 {lab=#net3}
N 120 -230 120 -200 {lab=#net1}
N 120 -320 120 -290 {lab=GND}
N 180 -320 180 -250 {lab=GND}
N 320 -320 320 -290 {lab=GND}
N 180 -160 200 -160 {lab=out}
N 180 -80 180 -60 {lab=#net4}
N 180 -60 320 -60 {lab=#net4}
N 320 -80 320 -60 {lab=#net4}
N 320 -230 320 -140 {lab=#net5}
N 440 -230 440 -200 {lab=#net2}
N 440 -300 440 -290 {lab=GND}
N 440 -320 440 -300 {lab=GND}
N 500 -320 500 -230 {lab=GND}
N 580 -250 580 -210 {lab=GND}
N 500 -250 580 -250 {lab=GND}
N 640 -320 640 -300 {lab=GND}
N 500 -200 580 -200 {lab=GND}
N 580 -210 580 -200 {lab=GND}
N 640 -240 640 -220 {lab=#net6}
N 500 -170 500 -60 {lab=#net7}
N 640 -160 640 -60 {lab=#net7}
N 500 -60 640 -60 {lab=#net7}
N 180 -170 180 -140 {lab=out}
N 180 -200 260 -200 {lab=GND}
N 260 -250 260 -200 {lab=GND}
N 720 -320 720 -300 {lab=GND}
C {sky130_fd_pr/pfet_01v8.sym} 160 -200 0 0 {name=M1
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
C {lab_wire.sym} 120 -200 0 0 {name=p1 sig_type=std_logic lab=in}
C {vsource.sym} 120 -260 2 0 {name=VIN value=-1.8 savecurrent=false}
C {vsource.sym} 320 -260 2 0 {name=VDD value=-1.8 savecurrent=false}
C {res.sym} 180 -110 0 0 {name=RL
value=50k
footprint=1206
device=resistor
m=1}
C {gnd.sym} 120 -320 2 0 {name=l3 lab=GND}
C {code.sym} 790 -280 0 0 {name=spice_dc only_toplevel=false value="
.lib /foss/pdks/sky130A/libs.tech/ngspice/sky130.lib.spice tt

.control
set xbrushwidth=7
set xgridwidth=2
set xfont_size=20

alter @RL[resistance]=50k

dc VIN 0 -1.8 -1m
let A0=deriv(-out)
plot out
plot A0
meas DC A0max max A0
meas DC vgs_op max_at A0
meas DC vds_op find out at=vgs_op

alter @VGS[dc]=vgs_op
alter @VDS[dc]=vds_op

dc VDS 0 -1.8 -1m
let func_gds=deriv(I(VIDg))
plot func_gds
meas DC gds find func_gds at=@VDS[dc]
alter @Rgds[resistance]=1/gds

dc VGS 0 -1.8 -1m
let func_gm=deriv(I(VIDg))
plot func_gm
meas DC gm find func_gm at=@VGS[dc]
alter @Rgm[resistance]=1/gm

let A0_calc=1/(@Rgm[resistance]*(1/@Rgds[resistance]+1/@RL[resistance]))
print A0_calc

.endc
.save all
"}
C {opin.sym} 200 -160 0 0 {name=p2 lab=out}
C {sky130_fd_pr/pfet_01v8.sym} 480 -200 0 0 {name=M2
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
C {vsource.sym} 440 -260 2 0 {name=VGS value=0 savecurrent=false}
C {gnd.sym} 180 -320 2 0 {name=l2 lab=GND}
C {vsource.sym} 640 -270 2 0 {name=VDS value=0 savecurrent=false}
C {res.sym} 720 -270 0 0 {name=Rgds
value=1k
footprint=1206
device=resistor
m=1}
C {res.sym} 720 -190 0 0 {name=Rgm
value=1k
footprint=1206
device=resistor
m=1}
C {gnd.sym} 720 -140 0 0 {name=l7 lab=GND}
C {ammeter.sym} 640 -190 0 0 {name=VIDg savecurrent=true spice_ignore=0}
C {ammeter.sym} 320 -110 0 0 {name=VID savecurrent=true spice_ignore=0}
C {gnd.sym} 320 -320 2 0 {name=l1 lab=GND}
C {gnd.sym} 440 -320 2 0 {name=l4 lab=GND}
C {gnd.sym} 500 -320 2 0 {name=l9 lab=GND}
C {gnd.sym} 640 -320 2 0 {name=l10 lab=GND}
C {gnd.sym} 720 -320 2 0 {name=l5 lab=GND}
