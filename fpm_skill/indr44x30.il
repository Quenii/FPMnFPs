;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Inductor/Power Ring Indcutor
;Desc:44x28 Ring Inductor
;Vendor:Stavros ZHANG Hao
;Count:1

pA=44.0 pB=30.0 Pitch=26.0 pH=44.0 pPad=4.0 pHole=2.0 Courtyard=0.5 

pName="INDR44X30" 
_PrepareNewSym(pName)

PadN=_PadTH_Default(pPad pHole)
 
_CreatePin(PadN 0:-Pitch/2 1)
_CreatePin(PadN 0:Pitch/2 2)

;Place层
_Layer(lPkgGeoPlaceT) ;切换到PlaceTop层
_BoundHeight(_ShapeRectangle(pA+2*Courtyard pB+2*Courtyard 0:0 0.2) pH)

for(asm 0 1 ;丝印和装配层
        if(asm==1 _Layer(lPkgGeoAsmT) _Layer(lPkgGeoSilkT))     ;层切换
;        _Circle(pA/2)   ;圆形
    _Rectangle(pA pB)
)

_CreateRefValue(pName) ;必须的文字层

_SaveDesign(pName)    ;保存文件
_MakeDevice(pName,2) ;需要的话附带生成DEVICE文件,0=IC 1=IO 2=DISCRETE
