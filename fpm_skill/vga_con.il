;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Connector/VGA
;Desc:Generic VGA HD15 Connector
;Vendor:Tariel@foretech
;Count:1
;CVG64:bitmap field, not implemented yet.
;Datasheet:

	pName="VGA_CON"
	_PrepareNewSym(pName)
	;------------------------------------------------
	PadN=_PadTH_Default(1.85 1.1)
	PadNt=_PadTH_Default(1.85 1.1 t)
	mtgPadN=_PadTH_Default(5.05 3.05)
	;------------------------------------------------
	Yard=0.5
	
	DS=25.0		; 安装孔间距
	
	PitchX=2.29 PitchY=2.54
	
	D_6=7.04	; 6脚离右侧安装孔的距离
	D_16=1.14	; 6脚和1脚的X坐标之差

	Y_L2=-4.57	; 第2行引脚的Y坐标
	
	; 外形尺寸
	W=30.80
	L=9.14
	H=12.5
	
	; 丝印用数据
	W_B=16.4 L_B=L	;方形部分的大小
	W_NUT=2.5 L_NUT=2.1	;螺栓的大小
	;------------------------------------------------
	
	Y_L1=Y_L2+PitchY
	Y_L3=Y_L2-PitchY
	
	_CreatePin(mtgPadN DS/2:Y_L2 "S1")
	_CreatePin(mtgPadN -DS/2:Y_L2 "S2")
	
	sprintf(pinName "%d" 1)
	_CreatePin(PadNt (DS/2)-D_6-D_16:Y_L1 pinName)

	for(i 2 5
	sprintf(pinName "%d" i)
	_CreatePin(PadN ((DS/2)-D_6-D_16)-((i-1)*PitchX):Y_L1 pinName)
	)
	
	for(i 6 10
	sprintf(pinName "%d" i)
	_CreatePin(PadN ((DS/2)-D_6)-((i-6)*PitchX):Y_L2 pinName)
	)
	
	for(i 11 15
	sprintf(pinName "%d" i)
	_CreatePin(PadN ((DS/2)-D_6-D_16)-((i-11)*PitchX):Y_L3 pinName)
	)

		
	;silkscreen & assembly
	for(i 1 2 if(i==1 _Layer(lPkgGeoSilkT) _Layer(lPkgGeoAsmT))
		_Rectangle(W L 0:-L/2)
		
		_Line(list(-DS/2-W_NUT/2:-L+L_NUT -DS/2-W_NUT/2:-L))
		_Line(list(-DS/2+W_NUT/2:-L+L_NUT -DS/2+W_NUT/2:-L))

		_Line(list(DS/2-W_NUT/2:-L+L_NUT DS/2-W_NUT/2:-L))
		_Line(list(DS/2+W_NUT/2:-L+L_NUT DS/2+W_NUT/2:-L))
		
		_Line(list(-W_B/2:0 -W_B/2:-L_B))
		_Line(list(W_B/2:0 W_B/2:-L_B))

	)

	;bound
	_Layer(lPkgGeoPlaceT) _BoundHeight(_ShapeRectangle(W+Yard L+Yard 0:-L/2) H)
	_Layer(lPkgGeoDfaT)   _BoundHeight(_ShapeRectangle(W L 0:-L/2) H "pName")

	;ref & val
	_CreateRefValue(pName 0:0)
	_CrossCenter(0:0)	;pick-place marker(0:0)
	_SaveDesign(pName)
	_MakeDevice(pName 2)