;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Switch/Button
;Desc:Switch/Button ITT Industries KMR211G series,
;Vendor:ITT
;Count:1
;CVG64:bitmap field, not implemented yet.
;Datasheet:http://www.ittcannon.com/media/pdf/catalogs/leaf/KMR_1apr.pdf

	pName="ITT-KMR211G"
	pX=(5.0-3.2)/2
	pCx=5.0-pX
	pY=1.0
	pCy=2.6-pY
	Courtyard=0.2

	_PrepareNewSym(pName)
;pad
;_PinArray(PadN Col Row PitchX/Y (P1=0:0 bRight bUp bRowFirst bPin1 bPinNum P1Offset=0 PAngle=0 TAngle=0)
	PadName=_PadSM(pX pY t)	  _PinArray(PadName 2 2 pCx pCy pCx/2:pCy/2 nil nil nil)
	PadName=_PadSM(1.7 0.8 t)	_CreatePin(PadName 0:-2.6/2+2.1+0.4 "5")

;bound
	_Layer(lPkgGeoPlaceT)
	_BoundHeight(_ShapeRectangle(5.0+Courtyard*2 2.8+Courtyard*2) 1.9)

	for(asm 0 1 if(asm==1 _Layer(lPkgGeoAsmT) _Layer(lPkgGeoSilkT))
		_Rectangle(4.1 2.8 0:0 0.2)
		_Rectangle(2.22-SilkWidth 1.7-SilkWidth 0:0 0.2)
		if(asm==1 then 
			_Rectangle(0.5 0.6 -(4.6-0.5)/2:-(2.2-0.6)/2)
			_Rectangle(0.5 0.6  (4.6-0.5)/2: (2.2-0.6)/2) 
			_Rectangle(0.5 0.6 -(4.6-0.5)/2: (2.2-0.6)/2)
			_Rectangle(0.5 0.6  (4.6-0.5)/2:-(2.2-0.6)/2) 
		)
	)
;ref & val
	_CrossCenter()
	_CreateRefValue(pName)

	_SaveDesign(pName)
	_MakeDevice(pName 2)
