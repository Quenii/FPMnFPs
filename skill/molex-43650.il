;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Connector/Header
;Desc:
;Vendor:
;Count:11
;CVG64:bitmap field, not implemented yet.
;Datasheet:

	Courtyard=2.0
	Pitch    =3.0

	for(pPin 2 12
	pB=(pPin-1)*Pitch
	pA=pB+6.65
	pC=pB+4.3
	sprintf(pName,"molex-43650-%d",pPin)
	_PrepareNewSym(pName)

;pin
	PadN1=_PadTH_Default(1.75 1.05)
	PadN2=_PadTH_Default(3.95 2.40)

	for(col 1 pPin 
		sprintf(pin_name,"%d",col)
		_CreatePin(PadN1 Pitch*(pPin-1)/2-(col-1)*Pitch:4.6+4.32 pin_name)
	)
	
	sprintf(pin_name,"%d",pPin+1)	_CreatePin(PadN2 -pC/2:4.6 pin_name)
	sprintf(pin_name,"%d",pPin+2)	_CreatePin(PadN2  pC/2:4.6 pin_name)

;bound
	bound=axlDBCreateRectangle(list(-pA/2-Courtyard:4.6-1.75-1 pA/2+Courtyard:9.9+Courtyard) t lPkgGeoPlaceT)
	_BoundHeight(bound 5.57)

;silkscreen & assembly
	insert=17.27-9.9
	for(i 1 2
	if(i==1	_Layer(lPkgGeoSilkT) _Layer(lPkgGeoAsmT))
		_Triangle(Pitch*(pPin-1)/2:4.6+4.32+1.75/2+SilkGap+SilkWidth/2 1.0 270)
		_Line(list(-pA/2+1.4:0 pA/2-1.4:0 pA/2:1.4 pA/2:9.9 -pA/2:9.9 -pA/2:1.4 -pA/2+1.4:0))
		_Line(list(0:0 0:2))
		_Line(list(-pA/2+1.4:0 -pA/2+1.4:-insert pA/2-1.4:-insert pA/2-1.4:0))
		_Rectangle(5.09 11.74 0:-insert+11.74/2+0.5)
		if(pPin>2 then 
			_Line(list(-pA/2+1.4:-insert+0.5 -5.09/2-1:-insert+0.5 -5.09/2-1:-insert))
			_Line(list(pA/2-1.4:-insert+0.5  5.09/2+1:-insert+0.5  5.09/2+1:-insert))
		)
	)

;ref & val
	_CreateRefValue(pName 0:-insert+11.74+0.5+1)
	_CrossCenter()

	_SaveDesign(pName)
	)

