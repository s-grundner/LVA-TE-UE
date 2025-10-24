v {xschem version=3.4.6 file_version=1.2
*
* This file is part of XSCHEM,
* a schematic capture and Spice/Vhdl/Verilog netlisting tool for circuit
* simulation.
* Copyright (C) 1998-2024 Stefan Frederik Schippers
*
* This program is free software; you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation; either version 2 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program; if not, write to the Free Software
* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
}
G {}
K {type=vsource
format="@name @pinlist @value@savecurrent"
template="name=V1 value=3 savecurrent=false"
}
V {}
S {}
E {}
N 0 -50 0 50 {lab=out}
N 0 -0 20 0 {lab=out}
N -60 80 -40 80 {lab=#net1}
N -60 -80 -60 80 {lab=#net1}
N -60 -80 -40 -80 {lab=#net1}
N -140 0 -60 0 {lab=#net1}
N 0 110 -0 140 {lab=GND}
N -140 120 -0 120 {lab=GND}
N 0 120 140 120 {lab=GND}
N 140 30 140 120 {lab=GND}
N 140 -140 140 -30 {lab=#net2}
N 0 -140 140 -140 {lab=#net2}
N 0 -140 0 -110 {lab=#net2}
N 0 -80 80 -80 {lab=#net2}
N 80 -140 80 -80 {lab=#net2}
N 0 80 80 80 {lab=GND}
N 80 80 80 120 {lab=GND}
N -140 0 -140 30 {lab=#net1}
N -140 90 -140 120 {lab=GND}
C {sky130_fd_pr/nfet_01v8.sym} -20 80 0 0 {name=M1
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
C {sky130_fd_pr/doc/pfet_01v8.svg} 430 -20 0 0 {}
C {sky130_fd_pr/pfet_01v8.sym} -20 -80 0 0 {name=M2
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
model=pfet_01v8
spiceprefix=X
}
C {vsource.sym} -140 60 0 0 {name=VIN value=1.8 savecurrent=false}
C {opin.sym} 20 0 0 0 {name=p1 lab=out}
C {vsource.sym} 140 0 0 0 {name=VDD value=1.8 savecurrent=false}
C {gnd.sym} 0 140 0 0 {name=l1 lab=GND}
C {code_shown.sym} -140 210 0 0 {name=s1 only_toplevel=false
value=".lib /foss/pdks/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.dc VIN 0 1.8 1m
.save all"}
