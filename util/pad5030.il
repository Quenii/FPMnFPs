;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Pad/Single SMD Pad
;Desc:Single SMD Pad, 5mm x 3mm
;Vendor:Stavros
;Count:1

Courtyard=0.5 pH=3.0 PadX=5.0 PadY=3.0
pName = "PAD5030"
_PrepareNewSym(pName)
PadN = _PadSMFillet(PadX PadY)

_CreatePin(PadN 0:0 1 )

;bound
_Layer(lPkgGeoPlaceT) _BoundHeight(_ShapeRectangle(PadX PadY) pH)

;silkscreen & assembly
for(i 1 2 if(i==1 _Layer(lPkgGeoSilkT) _Layer(lPkgGeoAsmT))
	_Rectangle(PadX PadY)
)
;bound
;_Layer(lPkgGeoPlaceT)

;silkscreen & assembly
for(i 1 2 
	if(i==1	
		_Layer(lPkgGeoSilkT) _Layer(lPkgGeoAsmT))
    _Rectangle(PadX+Courtyard*2 PadY+Courtyard*2)
)
;ref & val
_CreateRefValue(pName)
_CrossCenter()
_SaveDesign(pName)
