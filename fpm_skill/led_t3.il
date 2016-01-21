;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:LED/Through hold LED
;Desc:Through hole LED 3mm
;Vendor:Stavros
;Count:1
;CVG64:bitmap field, not implemented yet.
;Datasheet:

pH=6.0 Pitch=2.54 d=3.2

sprintf(pName,"LED_T3")
_PrepareNewSym(pName)
PadN1=_PadTH_Default(1.5 0.9 t)
PadN =_PadTH_Default(1.5 0.9  )

_CreatePin(PadN1 -Pitch/2:0 "1")
_CreatePin(PadN   Pitch/2:0 "2")

;bound
_Layer(lPkgGeoPlaceT) _BoundHeight(_ShapeCircle(d/2.0+0.5) pH)
_Layer(lPkgGeoDfaT) _BoundHeight(_ShapeCircle(d/2.0) pH)

;silkscreen & assembly
;sq2=(1.35/2+SilkGap+0.5)/1.414
for(i 1 2 if(i==1 _Layer(lPkgGeoSilkT) _Layer(lPkgGeoAsmT))
	_Circle(d/2.0)
;	_Dot(Pitch/2+sq2:sq2 1.0)
)

;ref & val
_CreateRefValue(pName 0:d/2+tSilkHeight/2+SilkWidth 0:d/2+tSilkHeight/2+SilkWidth)
_SaveDesign(pName)
