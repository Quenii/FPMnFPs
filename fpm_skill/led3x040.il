;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Display/Numeric LED Display
;Desc:Numeric LED Display, 3 Dights, 7 segments with DP, 0.40 inch
;Vendor:Stavros ZHANG Hao
;Count:1
;CVG64:
;Datasheet:

pLength=30.1 pWidth=16.0 pH=7.0 pPad=1.2 pHole=0.6 ;焊盘直径和孔径
Courtyard=0.0 ;放置间距

pName="LED3x040"   ;给封装取个名字
_PrepareNewSym(pName)  ;文件初始化

PadN1=_PadTH_Default(pPad pHole t) ;建立通孔园焊盘
PadN=_PadTH_Default(pPad pHole) ;建立通孔园焊盘
 
for(x 1 6
    if( x==1 then _CreatePin(PadN1 (x-3.5)*2.54:-6.35 x)
    else _CreatePin(PadN (x-3.5)*2.54:-6.35 x) )
   )
for(x 7 12
	_CreatePin(PadN (9.5-x)*2.54:6.35 x)
   )
;Place层
_Layer(lPkgGeoPlaceT) ;切换到PlaceTop层
_BoundHeight(_ShapeRectangle(pLength+Courtyard*2 pWidth+Courtyard*2 0:0 0) pH)

for(asm 0 1 ;丝印和装配层
        if(asm==1 _Layer(lPkgGeoAsmT) _Layer(lPkgGeoSilkT))     ;层切换
	_Rectangle(pLength pWidth)

	y1=3.0 x1=3.0 left=-pLength/2 top=pWidth/2
	y2=8.0 x2=2.6
	y3=13.0 x3=2.2
	for(ofs 0 2
		w1=ofs*10
		w2=ofs*10+5.9

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
