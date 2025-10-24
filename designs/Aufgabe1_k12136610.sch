v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {SKY Modell} 520 -390 0 0 0.4 0.4 {}
T {PMOST/R Verstaerker} 150 -390 0 0 0.4 0.4 {}
N 160 -200 180 -200 {lab=in}
N 220 -270 220 -230 {lab=GND}
N 480 -200 500 -200 {lab=#net1}
N 220 -270 300 -270 {lab=GND}
N 760 -160 760 -140 {lab=GND}
N 760 -240 760 -220 {lab=#net2}
N 160 -240 160 -200 {lab=in}
N 160 -320 160 -300 {lab=GND}
N 220 -320 220 -270 {lab=GND}
N 360 -320 360 -300 {lab=GND}
N 220 -140 240 -140 {lab=out}
N 220 -60 220 -40 {lab=#net3}
N 220 -40 360 -40 {lab=#net3}
N 360 -60 360 -40 {lab=#net3}
N 360 -240 360 -120 {lab=#net4}
N 480 -240 480 -200 {lab=#net1}
N 480 -320 480 -300 {lab=GND}
N 540 -320 540 -230 {lab=GND}
N 620 -270 620 -210 {lab=GND}
N 540 -270 620 -270 {lab=GND}
N 680 -320 680 -300 {lab=GND}
N 540 -200 620 -200 {lab=GND}
N 620 -210 620 -200 {lab=GND}
N 680 -240 680 -120 {lab=#net5}
N 540 -170 540 -40 {lab=#net6}
N 680 -60 680 -40 {lab=#net6}
N 540 -40 680 -40 {lab=#net6}
N 220 -170 220 -120 {lab=out}
N 220 -200 300 -200 {lab=GND}
N 300 -270 300 -200 {lab=GND}
N 760 -320 760 -300 {lab=GND}
C {sky130_fd_pr/pfet_01v8.sym} 200 -200 0 0 {name=M1
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
C {lab_wire.sym} 160 -200 0 0 {name=p1 sig_type=std_logic lab=in}
C {vsource.sym} 160 -270 2 0 {name=VIN
value="pulse(0 -1.8 1n) ac 1"
savecurrent=false
}
C {vsource.sym} 360 -270 2 0 {name=VDD value=-1.8 savecurrent=false}
C {res.sym} 220 -90 0 0 {name=RL
value=50k
footprint=1206
device=resistor
m=1}
C {gnd.sym} 160 -320 2 0 {name=l3 lab=GND}
C {code.sym} 840 -410 0 0 {name=spice_dc only_toplevel=false value="
.lib /foss/pdks/sky130A/libs.tech/ngspice/sky130.lib.spice tt

.control
set xbrushwidth=7
set xgridwidth=2
set xfont_size=20

alter @RL[resistance]=50k

*******************
*** DC Analysis ***
*******************

dc VIN 0 -1.8 -1m
let A0=deriv(-out)
plot out
plot A0

***********************
*** Operating Point ***
***********************

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
C {opin.sym} 240 -140 0 0 {name=p2 lab=out}
C {sky130_fd_pr/pfet_01v8.sym} 520 -200 0 0 {name=M2
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
C {vsource.sym} 480 -270 2 0 {name=VGS value=0 savecurrent=false}
C {gnd.sym} 220 -320 2 0 {name=l2 lab=GND}
C {vsource.sym} 680 -270 2 0 {name=VDS value=0 savecurrent=false}
C {res.sym} 760 -270 0 0 {name=Rgds
value=1k
footprint=1206
device=resistor
m=1}
C {res.sym} 760 -190 0 0 {name=Rgm
value=1k
footprint=1206
device=resistor
m=1}
C {gnd.sym} 760 -140 0 0 {name=l7 lab=GND}
C {ammeter.sym} 680 -90 0 0 {name=VIDg savecurrent=true spice_ignore=0}
C {ammeter.sym} 360 -90 0 0 {name=VID savecurrent=true spice_ignore=0}
C {gnd.sym} 360 -320 2 0 {name=l1 lab=GND}
C {gnd.sym} 480 -320 2 0 {name=l4 lab=GND}
C {gnd.sym} 540 -320 2 0 {name=l9 lab=GND}
C {gnd.sym} 680 -320 2 0 {name=l10 lab=GND}
C {gnd.sym} 760 -320 2 0 {name=l5 lab=GND}
C {code.sym} 840 -270 0 0 {name=spice_tran only_toplevel=false value="
.control
set xbrushwidth=7
set xgridwidth=2
set xfont_size=20

**************************
*** Transient Analysis ***
**************************

tran 25p 3n
plot in out

.endc
.save all
"}
C {code.sym} 840 -130 0 0 {name=spice_ac only_toplevel=false value="
.control
set xbrushwidth=7
set xgridwidth=2
set xfont_size=20

**************************
*** AC Analysis ***
**************************

alter @VIN[ac]=-1.8
ac dec 100 1 100G
plot -v(out)/v(in)
plot phase(-v(out)/v(in))

.endc
.save all
"}
