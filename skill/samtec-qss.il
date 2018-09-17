;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Connector/Header
;Desc:
;Vendor:
;Count:10
;CVG64:bitmap field, not implemented yet.
;Datasheet:http://samtec.com/ftppub/pdf/QSS.PDF
/*---------------------------------
Samtec (aTb) Connector Samtec QSS Series.
(0.635mm pitch HI-Speed)
-GP -K not include
---------------------------------*/
Postions='(25 50 75 100 125)  ;check ref.

Courtyard=1.0
Pitch=0.635
pB=7.24;body width

;_PadTH_NP(0 pHole pPadTop pPadInner pPadBot pThermal pSolderMask pAssembly pAnti pKeepout)
PadNnp=_PadTH_NP('(0 1.02 0.2 0.2 0.2 1.5 1.02 1.02 1.5 1.5))

for(ls2 0 1 ;locking screw?
	foreach(pos Postions

	banks=pos/25
	if(ls2==0 pA=banks*20+1.27 pA=banks*20+13.97)

	sprintf(pName,"SAMTEC-QSS-%d-XD" pos)
	if(ls2==1 pName=strcat(pName "-LS2"))
	_PrepareNewSym(pName)

	if(ls2==1 then ;has lock screw?
		PadN=_PadTH_Default(2.44 2.44)
		pls2=banks*20+8.38
		_CreatePinMechanical(PadN pls2/2:0) 
		_CreatePinMechanical(PadN -pls2/2:0) 
	)
	_CreatePinMechanical(PadNnp banks*10.0:2.87-0.21) 
	_CreatePinMechanical(PadNnp -banks*10.0:2.87-0.21) 

	PadN=_PadSM(0.41 2.27 t)

;pin
	x0=-floor(banks/2)*20
	if(mod(banks 2)==0 x0=x0+(20-24*Pitch)/2+12*Pitch)
	xOrg=x0;keep this for pin-1 marker
	for(bank 0 banks-1
		for(i 1 3;ground pad (I think shape is better than regular pad)
		 	case(i
		 	(1 _Layer(lEtchT) soldermask=0)
		 	(2 _Layer(lPkgGeoSmT) soldermask=solder_mask_offset)
		 	(3 _Layer(lPkgGeoPmT))
			)
			_ShapeRectangle(4.7+soldermask 0.43+soldermask x0-6.35/2:0)
			_ShapeRectangle(4.7+soldermask 0.43+soldermask x0+6.35/2:0)
			_ShapeRectangle(2.79+soldermask 0.43+soldermask x0-16.13/2:0) 
			_ShapeRectangle(2.79+soldermask 0.43+soldermask x0+16.13/2:0)
		)
		for(col 0 24 ;numbered-pins
			x=x0-Pitch*12+col*Pitch
			for(row 0 1
				sprintf(pin_name,"%d",bank*50+col*2+row+1)
				_CreatePin(PadN x:-2.86+row*(2.86*2) pin_name)
			);for
		);row
		x0=x0+20
	);bank

;bound
	_Layer(lPkgGeoPlaceT)
	_BoundHeight(_ShapeRectangle(pA+2*Courtyard pB+2*Courtyard) 3.63)

;silkscreen & assembly
	for(i 1 2
		if(i==1	_Layer(lPkgGeoSilkT) _Layer(lPkgGeoAsmT))
		_Rectangle(pA pB)
		srA=banks*20 srB=5.97 delta=1.3;??
		path=axlPathLine(axlPathStart(list(-srA/2:-srB/2)) SilkWidth srA/2:-srB/2)
		axlPathLine(path SilkWidth srA/2:srB/2-delta)  axlPathLine(path SilkWidth srA/2-delta:srB/2)
		axlPathLine(path SilkWidth -srA/2+delta:srB/2) axlPathLine(path SilkWidth -srA/2:srB/2-delta)
		axlPathLine(path SilkWidth -srA/2:-srB/2)
		axlDBCreatePath(path)
		;polarity mark
		_Triangle(xOrg-Pitch*12:-2.86-2.27/2-SilkGap-SilkWidth/2 1 90)
	)
;ref & val
	_CreateRefValue(pName 0:-pB/2-Courtyard) ;default (0:0), i.e. _CreateRefValue(pName)
	_CrossCenter() ;pick-place marker (0:0)

	_SaveDesign(pName)
	);pos
);ls2

