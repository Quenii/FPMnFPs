;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Connector/BNC
;Desc:Samtec Bulkhead BNC R/A PCB socket 75ohm 6GHz SAMTEC_HDBNC_J_P_XX_RA_BHX 
;Vendor:Samtec
;Count:1
;CVG64:bitmap field, not implemented yet.
;Datasheet:

Courtyard=0.5 pA=7.5 pB=7.5 pH=8.0 pPad1=1.25 pHole1=0.75 pPad2=2.8 pHole2=1.7

pName="SAMTEC_HDBNC_J_P_XX_RA_BHX"
_PrepareNewSym(pName)

;pin
Pad1=_PadTH_Default(pPad1 pHole1)
Pad2=_PadTH_Default(pPad2 pHole2)
_CreatePin(Pad1 0:0 "1")
_CreatePin(Pad2 2.54:2.54 "2")
_CreatePin(Pad2 -2.54:2.54 "3")
_CreatePin(Pad2 -2.54:-2.54 "4")
_CreatePin(Pad2 2.54:-2.54 "5")

;bound
_Layer(lPkgGeoPlaceT)
_BoundHeight(_ShapeRectangle(pA+Courtyard*2 pB+Courtyard+0.8 
0:-Courtyard/2+0.4) pH)
_Layer(lPkgGeoDfaT)
_BoundHeight(_ShapeRectangle(pA pB+0.8 0:0.4) pH pName)

;silkscreen & assembly
for(i 1 2
if(i==1 _Layer(lPkgGeoSilkT) _Layer(lPkgGeoAsmT))
_Rectangle(pA pB 0:0 0.5)
)

_Layer(lPkgGeoAsmT)
_Rectangle(7 0.8 0:4.15 0)
_Rectangle(6.2 5.0 0:4.15+0.4+2.5 0)
_Line(list(-3.1:5 3.1:5.5))
_Line(list(-3.1:6 3.1:6.5))
_Line(list(-3.1:7 3.1:7.5))
_Line(list(-3.1:8 3.1:8.5))
_Line(list(-3.1:9 3.1:9.5))
_Rectangle(4.50 7.0 0:4.15+0.4+5+3.5 0)
_Line(list(-3.1:14 -2.25:14))
_Line(list(3.1:14 2.25:14))

;ref & val
_CreateRefValue(pName 0:0)
_CrossCenter()

_SaveDesign(pName)
_MakeDevice(pName 2)
