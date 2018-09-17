;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Battery Holder/AAA/AA/C/D/N
;Desc:SMD battery holder
;Vendor:keystone Inc.
;Count:1
;CVG64:bitmap field, not implemented yet.
;Datasheet:http://www.batteryspecialist.com/Merchant2/size-d-dim.html

	Tabs='(
;    name           Dmin  Dmax  Lmin Lmax Bmin  Bmax  Dp  Lp  Ln   PN              pX  pY  pG
	("BATTERY-AAA"  9.5   10.5  43.3 44.5 42.35 42.85 3.8 0.8 0.10 "keystone-5230" 7.6 5.1 5.1)
;	("BATTERY-AAAA" 7.7   8.3   41.5 42.5 39.0  40.5  3.8 0.8 0.08 "keystone-5230" 7.6 5.1 x.x)
	("BATTERY-AA"   13.5  14.5  49.2 50.5 46.5  48.8  5.5 1.0 0.10 "keystone-5230" 7.6 5.1 5.1)
;	("BATTERY-C"    24.9  26.2  48.5 50.0 46.1  46.6  7.5 1.5 0.50 "keystone-5230" 7.6 5.1 x.x)
;	("BATTERY-D"    32.3  34.2  59.5 61.5 57.0  57.8  9.5 1.5 0.28 "keystone-5230" 7.6 5.1 x.x)
	("BATTERY-N"    10.9  12.0  29.1 30.2 27.3  28.07 4.7 0.5 0.20 "keystone-5230" 7.6 5.1 5.1)
	)

Courtyard=1.0 Pitch=0.8 Side=0.5 Heel=0.5 Toe=1.0
foreach(aTb Tabs
	pName=nth(10 aTb)
	pD=(nth(1 aTb)+nth(2 aTb))/2.0
	pL=(nth(3 aTb)+nth(4 aTb))/2.0
	pB=(nth(5 aTb)+nth(6 aTb))/2.0
	pDp=nth(7 aTb)
	pLp=nth(8 aTb)
	pLn=nth(9 aTb)
	pX=nth(11 aTb)
	pY=nth(12 aTb)
	pG=nth(13 aTb)

	PadX=pX+Heel+Toe
	PadY=pY+Side*2
	Pitch=pL+pG-Heel*2+PadX

	_PrepareNewSym(pName)
	PadN=_PadSMFillet(PadX PadY)
	_CreatePin(PadN -Pitch/2:0 "1")
	_CreatePin(PadN Pitch/2:0 "2")

;bound
	_Layer(lPkgGeoPlaceT)
	s1=_ShapeRectangle(pL pD-2.54)
	s2=_ShapeRectangle(pL+(pX+pG/2)*2+Courtyard*2 pY+Courtyard*2)
	p1=_PolyCreate(s1) p2=_PolyCreate(s2)
	poly=axlPolyOperation(p1 p2 'OR)
	foreach(onepoly poly objs=axlDBCreateShape(onepoly t))
	_BoundHeight(objs pD)

;silkscreen & assembly
	for(i 1 2 if(i==1	_Layer(lPkgGeoSilkT) _Layer(lPkgGeoAsmT))
		_Rectangle(pG/2+pX pY pL/2+(pG/2+pX)/2:0)
		_Rectangle(pG/2+pX pY -pL/2-(pG/2+pX)/2:0)

		pos=-pL/2+2+pLp+1:0 _Circle(2 pos) _Cross(pos 2)
		pos=pL/2-2-pLn-1:0	_Circle(2 pos)
		_Line(list(xCoord(pos)-1:0 xCoord(pos)+1:0))

		step=fix((pG/2)/(SilkWidth*2))
		if(step>1 then	for(j 1 step
			lx=pL/2+pG/2-(j-1)*SilkWidth*2
			_Line(list(lx:pY/2 lx:-pY/2))
			_Line(list(-lx:pY/2 -lx:-pY/2))
		))

		pos=-pL/2-pG/2-pX+2.77:0     _Circle(2.48/2 pos) _Dot(pos 1.0)
		pos=-xCoord(pos):yCoord(pos) _Circle(2.48/2 pos) _Dot(pos 1.0)

		s1=_ShapeRectangle(pB pD (pL-pB)/2-pLn:0 0.4) 
		s2=_ShapeRectangle(pL/2 pD-1.0 pL/4:0 0.4)    
		s3=_ShapeRectangle(pL/2 pDp -pL/4:0 0.4)
		p1=_PolyCreate(s1) p2=_PolyCreate(s2) p3=_PolyCreate(s3)
		poly=axlPolyOperation(p1 p2 'OR)
		poly=axlPolyOperation(poly p3 'OR)

		foreach(onepoly poly _CreateObjPath(axlDBCreateShape(onepoly t)))
	)
;ref & val
	_CreateRefValue(pName)
	_CrossCenter()
	_SaveDesign(pName)
)