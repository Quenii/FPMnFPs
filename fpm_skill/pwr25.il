;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Connector/Power Connector
;Desc:2.5mm power connector
;Vendor:CUI Inc.
;Count:1
;CVG64:bitmap field, not implemented yet.
;Datasheet:

pH=7.4
PadN1=_PadTH_Default(1.85 1.2 t)
PadNs=_PadTH_Default(1.85 1.2)

sprintf(pName,"PWR25")
_PrepareNewSym(pName)

_CreatePin(PadNs -8.5:2.5 "2")
_CreatePin(PadN1 -8.5+2.5:0 "1")
_CreatePin(PadNs -8.5-2.5:0 "3")
	
X=11.4 Y=5.3
;bound
_Layer(lPkgGeoPlaceT) _BoundHeight(_ShapeRectangle(X-1.8+1 Y+0.5 -(X+1.8+1)/2:0) pH)
_Layer(lPkgGeoDfaT) _BoundHeight(_ShapeRectangle(X Y -X/2:0) pH)

;silkscreen & assembly
for(i 1 2 if(i==1 _Layer(lPkgGeoSilkT) _Layer(lPkgGeoAsmT))
	_Rectangle(X Y -X/2:0)
	_Line(list(-1.8:Y/2 -1.8:-Y/2))
	_Line(list(0:0 -1.8:0))
)

;ref & val
_CreateRefValue(pName 0:-Y/2-tSilkHeight/2-SilkWidth 0:-Y/2-tSilkHeight/2-SilkWidth)

_SaveDesign(pName)
