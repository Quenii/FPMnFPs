;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Connector/Header
;Desc:Very High Speed connector:)
;Vendor:MOLEX
;Count:1
;CVG64:bitmap field, not implemented yet.
;Datasheet:

	Courtyard=1.0 pH=25.8 Pitch=2.0

	sprintf(pName,"MOLEX-VHDM")
	_PrepareNewSym(pName)

;pin
	PadN1=_PadTH_Default(1.0 0.66 t)
	PadN2=_PadTH_Default(1.0 0.66)
	_CreatePin(PadN1 0:0 "A1")
	x0=0 y0=0
	for(row 1 6
		case(row (1 pn="A") (2 pn="B") (3 pn="C") (4 pn="D") (5 pn="E") (6 pn="F"))
		if(row==1 _PinArray(PadN2 45 1 Pitch 0 x0:y0 t nil t nil t 0 0 0 1 pn)
		_PinArray(PadN2 45 1 Pitch 0 x0:y0 t nil t t t 0 0 0 1 pn))
;		_PinArray(PadN Col Row PitchX PitchY Pos1 bRight bUp bRowFirst bPin1 bPinNum Pin1Offset PinAngle PinTAngle Prefix)
		y0=y0-2.25
	)
	x0=-1.0 y0=-1.125
	for(row 1 5
		_PinArray(PadN2 45 1 Pitch 0 x0:y0 t nil t t t (row-1)*45 0 0 1 "S")
		y0=y0-2.25
	)
		
;bound
	yc0=-1.125*5 h=17.1 w=57+20+27 ;Pitch*44.5+1.5*2
	_Layer(lPkgGeoPlaceT)
	_BoundHeight(_ShapeRectangle(w+Courtyard*2 h+Courtyard*2 Pitch*43.5/2:yc0) pH)
	_Layer(lPkgGeoDfaT)   
	_BoundHeight(_ShapeRectangle(w h Pitch*43.5/2:yc0) pH 0 "MOLEX-VHDM")

	G1b=-5.41:-9.96 G1t=xCoord(G1b):yCoord(G1b)+7.26
	G2b=44*Pitch+4.59:-9.96 G2t=xCoord(G2b):yCoord(G2b)+7.26

;silkscreen & assembly
	TorS=make_axlTextOrientation(?textBlock tSilkName, ?justify "center" ?mirrored t)
	for(i 1 2
		if(i==1	_Layer(lPkgGeoSilkT) _Layer(lPkgGeoAsmT))
		_Rectangle(w h Pitch*43.5/2:yc0 0)
		_Triangle(0:0.5+SilkGap+SilkWidth/2 1 270)

		_Circle(2 G1b) _Cross(G1b 5) 
		_CornerRectangle(4 4 G1t 1 SilkWidth) _Circle(1.8 G1t) _Cross(G1t 1.5)
		
		_Circle(2 G2b) _Cross(G2b 5) 
		_CornerRectangle(4 4 G2t 1 SilkWidth) _Circle(1.8 G2t) _Cross(G2t 1.5)

		_Line(list(24*Pitch+Pitch/2:yc0+h/2 24*Pitch+Pitch/2:yc0-h/2))
		_Line(list(34*Pitch+Pitch/2:yc0+h/2 34*Pitch+Pitch/2:yc0-h/2))

		;PCB BASE-LINE
		_Line(list(-8.5:-0.66 -8.5+6:-0.66))
		for(m 1 6 _Line(list(-8.5+(m-1)*1:-0.66 -8.5+(m-1)*1+1:-0.66+1)))
		_Line(list(-8.5+104:-0.66 -8.5+104-6:-0.66))
		for(m 1 6 _Line(list(-8.5+104-(m-1)*1:-0.66 -8.5+104-(m-1)*1-1:-0.66+1)))

		;bottom 10-base guide
		for(j 1 4 tx=9*Pitch+(j-1)*10*Pitch
			posS=tx:0.5+SilkGap+tSilkHeight/2+0.1
			sprintf(guide "%d" j*10)
			if(i==1 then
				_Layer(lPkgGeoSilkB)
				_Triangle(0:0.5+SilkGap+SilkWidth/2 1 270)
				_Line(list(tx-0.8:0.5+SilkGap+SilkWidth/2+0.5 tx+0.8:0.5+SilkGap+SilkWidth/2+0.5))
				_Line(list(tx-0.8:-0.5-11.25-SilkGap-SilkWidth/2-0.5 tx+0.8:-0.5-11.25-SilkGap-SilkWidth/2-0.5))
				_Line(list(tx:0.5+SilkGap+SilkWidth/2+0.5 tx:-0.5-11.25-SilkGap-SilkWidth/2-0.5))
				axlDBCreateText(guide posS TorS lPkgGeoSilkB)
				axlDBCreateText(guide xCoord(posS):-14.5 TorS lPkgGeoSilkB)
				_Layer(lPkgGeoSilkT)
			)
		)
	)

;ref & val
_CreateRefValue(pName 0:4 0:4)

_SaveDesign(pName)
