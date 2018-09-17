;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Display/Numeric LED Display
;Desc:Numeric LED Display, 2 Dights, 7 segments with DP, 0.36 inch
;Vendor:stavrosatic@gmail.com
;Count:1
;CVG64:示意图字段(测试中)
;Datasheet:

pA=15.0 pB=14.0 pH=7.0 pPad=1.3 pHole=0.7 Courtyard=0.0

pName="LED2X036S"   ;给封装取个名字
_PrepareNewSym(pName)  ;文件初始化

;PadN=_PadTH_Default(pPad pHole) ;建立通孔园焊盘
FilletR = 0.6
PadN=_PadSMFillet(1.2 3.0)
 
for(x 0 4
	sprintf( pN1 "%d" x+1)
	_CreatePin(PadN (x-2)*2.54:-pB/2-2 pN1)
   )
for(x 0 4
	sprintf( pN2 "%d" x+6)
	_CreatePin(PadN (2-x)*2.54:pB/2+2 pN2)
   )
;Place层
_Layer(lPkgGeoPlaceT) ;切换到PlaceTop层
_BoundHeight(_ShapeRectangle(pA+Courtyard*2 pB+Courtyard*2 0:0 0) pH)

for(asm 0 1 ;丝印和装配层
        if(asm==1 _Layer(lPkgGeoAsmT) _Layer(lPkgGeoSilkT))     ;层切换
	_Rectangle(pA pB)

	y1=2.8 x1=2.0 left=-pA/2 top=pB/2
	y2=7.0 x2=1.6
	y3=11.2 x3=1.2
	for(ofs 0 1
		w1=ofs*7.2
		w2=ofs*7.2+3.9

		_Line(list(left+x1+w1:top-y1 left+x2+w1+.03:top-y2+.3) .5)
		_Line(list(left+x2+w1-.03:top-y2-.3 left+x3+w1:top-y3) .5)

		_Line(list(left+x1+w2:top-y1 left+x2+w2+.03:top-y2+.3) .5)
		_Line(list(left+x2+w2-.03:top-y2-.3 left+x3+w2:top-y3) .5)
			
		_Line( list(left+x1+w1+.6:top-y1 left+x1+w2-.6:top-y1) .5)
		_Line( list(left+x2+w1+.6:top-y2 left+x2+w2-.6:top-y2) .5)
		_Line( list(left+x3+w1+.6:top-y3 left+x3+w2-.6:top-y3) .5)

		_Dot( left+x3+w2+.9:top-y3 .8)
	)
)
_CreateRefValue(pName) ;必须的文字层
_SaveDesign(pName)    ;保存文件
_MakeDevice(pName,2) ;需要的话附带生成DEVICE文件,0=IC 1=IO 2=DISCRETE
