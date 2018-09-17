;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Connector/BNC
;Desc:Bulkhead BNC R/A PCB socket 75ohm 3GHz 112809-75
;Vendor:Amphenol
;Count:1
;CVG64:bitmap field, not implemented yet.
;Datasheet:

Courtyard=0.5 Pitch=2.54 pA=10.52 pB=10.52 pH=10.98 pPad1=2.0 pHole1=1.17 pPad2=3.2 pHole2=2.11

pName="BNC_AMPHENOL_112809-75"
_PrepareNewSym(pName)

;pin
Pad1=_PadTH_Default(pPad1 pHole1)
Pad2=_PadTH_Default(pPad2 pHole2)
_CreatePin(Pad1 0:0 "1")
_CreatePin(Pad2 3.3:3.3 "2")
_CreatePin(Pad2 -3.3:3.3 "3")
_CreatePin(Pad2 -3.3:-3.3 "4")
_CreatePin(Pad2 3.3:-3.3 "5")

;bound
_Layer(lPkgGeoPlaceT)
_BoundHeight(_ShapeRectangle(pA+Courtyard*2 pB+Courtyard 
0:-Courtyard/2) pH)
_Layer(lPkgGeoDfaT)
_BoundHeight(_ShapeRectangle(pA pB 0:0) pH pName)

;silkscreen & assembly
for(i 1 2
if(i==1 _Layer(lPkgGeoSilkT) _Layer(lPkgGeoAsmT))
_Rectangle(pA pB 0:0 0.5)
)

_Layer(lPkgGeoAsmT)
_Rectangle(8 1.16 0:5.84 0)
_Rectangle(13.97 0.89 0:6.865 0)
_Rectangle(12.80 4.65 0:9.635 0)
_Rectangle(10.00 10.67 0:17.295 0)

;ref & val
_CreateRefValue(pName 0:0)
_CrossCenter()

_SaveDesign(pName)
_MakeDevice(pName 2)

