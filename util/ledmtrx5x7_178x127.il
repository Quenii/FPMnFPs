;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Display/Numeric LED Display
;Desc: Matrix LED Display, 5x7 dots, 17.8mm x 12.7mm (0.7inch x 0.5inch)
;Vendor: stavrosatic@gmail.com
;Count:1

pA=17.8 pB=12.7 pH=7.0 pPad=1.3 pHole=0.7 ;焊盘直径和孔径
Courtyard=0.0 ;放置间距

pName="LEDMTRX5X7_178X127"   ;给封装取个名字
_PrepareNewSym(pName)  ;文件初始化

PadN=_PadTH_Default(pPad pHole) ;建立通孔园焊盘
 
for(x 0 5
	sprintf( pN1 "%d" x+1)
	_CreatePin(PadN (x-2.5)*2.54:-3.81 pN1)
	sprintf( pN2 "%d" x+7)
	_CreatePin(PadN (2.5-x)*2.54:3.81 pN2)
   )
;Place层
_Layer(lPkgGeoPlaceT) ;切换到PlaceTop层
_BoundHeight(_ShapeRectangle(pA+Courtyard*2 pB+Courtyard*2 0:0 0) pH)

for(asm 0 1 ;丝印和装配层
        if(asm==1 _Layer(lPkgGeoAsmT) _Layer(lPkgGeoSilkT))     ;层切换
	_Rectangle(pA pB)
    
    for(y 1 5
        for(x 1 7
            _Dot((x-0.5)*2.54-pA/2:(y-0.5)*2.54-pB/2 2.0)
        )
	)
)
_CreateRefValue(pName) ;必须的文字层
_SaveDesign(pName)    ;保存文件
_MakeDevice(pName,2) ;需要的话附带生成DEVICE文件,0=IC 1=IO 2=DISCRETE
