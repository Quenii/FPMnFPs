;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Antenna/PCB
;Desc:2.4G Antenna
;Vendor:Tariel@foretech
;Count:1
;CVG64:bitmap field, not implemented yet.
;Datasheet:

pName="2G4-ANT"

_PrepareNewSym(pName)
_Layer(lEtchT)

_Line(list(0:0 -1.20:1.20) 0.4)
_Line(list(-1.2:1.2 -3.8:1.2) 0.4)
_Line(list(-3.8:1.2 -3.8:5.8) 0.4)
_Line(list(-3.8:5.8 -2.5:5.8) 0.4)
_Line(list(-2.5:5.8 -2.5:2.95) 0.4)
_Line(list(-2.5:2.95 0:2.95) 0.4)
_Line(list(0:2.95 0:5.8) 0.4)
_Line(list(0:5.8 2.5:5.8) 0.4)
_Line(list(2.5:5.8 2.5:2.95) 0.4)
_Line(list(2.5:2.95 4.85:2.95) 0.4)
_Line(list(4.85:2.95 4.85:5.8) 0.4)
_Line(list(4.85:5.8 6.45:5.8) 0.4)
_Line(list(6.45:5.8 6.45:2.75) 0.4)
_Line(list(6.45:2.75 6.45:2.4) 0.55)

;bound
_Layer(lPkgGeoPlaceT)
_BoundHeight(_ShapeRectangle(11.5 6.2 1.5:3.1) 0.1)

PadN=_PadSM(0.2 0.2 t)  
_CreatePin(PadN 0:0 "1") 

;ref & val
_CreateRefValue(pName)

_SaveDesign(pName)
_MakeDevice(pName 2) 
