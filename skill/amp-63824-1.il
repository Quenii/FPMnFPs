;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Misc/Faston Tap
;Desc:
;Vendor:AMP
;Count:1
;CVG64:bitmap field, not implemented yet.
;Datasheet:

	pName="AMP-63824-1"
	Courtyard=2.0
	Pitch=5.08
	Pad=3.0
	L=7.92
	w1=0.81
	w2=1.14
	W=w1+w2*2
	H=14.02-3.81
	_PrepareNewSym(pName)
;pin
	px=5.08
	PadN=_PadTH_Default(Pad 1.5)	
	_CreatePin(PadN -px/2:0 "1")
	_CreatePin(PadN  px/2:0 "2")

	_Layer(lEtchT) _ShapeRectangle(Pitch+Pad W 0:0 0.6)
	_Layer(lEtchB) _ShapeRectangle(Pitch+Pad W 0:0 0.6)

;bound
	_Layer(lPkgGeoPlaceT)
	_BoundHeight(_ShapeRectangle(L+Courtyard*2 W+Courtyard*2) H)

	for(asm 0 1
	if(asm==1 _Layer(lPkgGeoAsmT);assembly
		_Layer(lPkgGeoSilkT));silkscreen
		_Line(list(-L/2:0 L/2:0) w1)
		_Line(list(-SilkGap*2:0 -SilkGap*2:-w2) w1)
		_Line(list(SilkGap*2:0 SilkGap*2:w2) w1)
;		_Rectangle(L W 0:0 0.5)
	)

	_CrossCenter()
	_CreateRefValue(pName)
	mydesign = axlDBGetDesign()
	axlDBAddProp( mydesign, list('NODRC_SYM_SAME_PIN))

	_SaveDesign(pName)
	_MakeDevice(pName 1)
