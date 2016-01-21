;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Pad/Single SMD Pad
;Desc:Single SMD Pad, 5mm x 3mm
;Vendor:Stavros
;Count:1

Courtyard=0.3 pH=3.0 pA=5 pB=7 PadX=5.0 PadY=3.0
pName = "PAD5030-2"
_PrepareNewSym(pName)
PadN = _PadSMFillet(PadX PadY)

_CreatePin(PadN 0:2 "1" )
_CreatePin(PadN 0:-2 "2" )

;bound
_Layer(lPkgGeoPlaceT) 
_BoundHeight(_ShapeRectangle(pA+Courtyard*2 pB+Courtyard*2))
_Layer(lPkgGeoDfaT) 
_BoundHeight(_ShapeRectangle(PadX PadY) pH)


;silkscreen & assembly
for(i 1 2 
	if(i==1	
		_Layer(lPkgGeoSilkT) _Layer(lPkgGeoAsmT))
    _Rectangle(pA+Courtyard*2 pB+Courtyard*2)
)
;ref & val
_CreateRefValue(pName)
_CrossCenter()
_SaveDesign(pName)
