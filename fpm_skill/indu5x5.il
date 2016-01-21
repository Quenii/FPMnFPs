;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Inductor/RF Inductor
;Desc:Self-made VHF Coil
;Vendor:Stavros ZHANG Hao
;Count:1

pA=6.0 pB=6.0 pH=5.0 pPad=1.3 pHole=0.8 
Courtyard=0.2 

pName="INDU5X5" 
_PrepareNewSym(pName)

PadN=_PadTH_Default(pPad pHole)
 
ofs = -pA/2+3.0
_CreatePin(PadN -2.54:2.54 1)
_CreatePin(PadN 2.54:-2.54 2)

;Place层
_Layer(lPkgGeoPlaceT) ;切换到PlaceTop层
_BoundHeight(_ShapeRectangle(pA+2*Courtyard pB+2*Courtyard 0:0 0.2) pH)

for(asm 0 1 ;丝印和装配层
        if(asm==1 _Layer(lPkgGeoAsmT) _Layer(lPkgGeoSilkT))     ;层切换
;        _Circle(pA/2)   ;圆形
	path = axlPathStart( list( -0.3:-1.90))
        axlPathArcAngle(path SilkWidth -0.3:-0.65 nil 180)
        axlPathArcAngle(path SilkWidth -0.3:0.65  nil 180)
        axlPathArcAngle(path SilkWidth -0.3:1.90  nil 180)
        axlDBCreatePath(path)
    _Line( list(-2.54:2.54 -0.3:2.54 -0.3:1.90) )
    _Line( list(2.54:-2.54 -0.3:-2.54 -0.3:-1.90) )
)

_CreateRefValue(pName) ;必须的文字层

_SaveDesign(pName)    ;保存文件
_MakeDevice(pName,2) ;需要的话附带生成DEVICE文件,0=IC 1=IO 2=DISCRETE
