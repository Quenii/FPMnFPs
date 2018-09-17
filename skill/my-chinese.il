;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:杂项(Chinese)/简单范例
;Desc:范例如何建立一个简单的二极管封装
;Vendor:Richard L.
;Count:1
;CVG64:示意图字段(测试中)
;Datasheet:

pL=12.7  ;引脚间距
pA=7.6 pB=3.5 pH=3.5 ;长宽高
pPad=2.0 pHole=1.2 ;焊盘直径和孔径
Courtyard=1.0 ;courtyard我不知道中文怎么称呼(放置间距?)

pName="MY-DIODE"   ;给封装取个名字
_PrepareNewSym(pName)  ;文件初始化

PadN=_PadTH_Default(pPad pHole) ;建立通孔园焊盘
_CreatePin(PadN -pL/2:0 "A")  ;创建两个管脚 A 和 C
_CreatePin(PadN pL/2:0 "C")

;Place层
_Layer(lPkgGeoPlaceT) ;切换到PlaceTop层
_BoundHeight(_ShapeRectangle(pL+Courtyard*2 pB+Courtyard*2 0:0 pB/2) pH)

for(asm 0 1 ;丝印和装配层
	if(asm==1 _Layer(lPkgGeoAsmT) _Layer(lPkgGeoSilkT))     ;层切换
	_Rectangle(pA pB)   ;矩形
	_Line(list(-pL/2+pPad/2+SilkWidth/2+SilkGap:0 -pA/2:0));画三根线
	_Line(list(pL/2-pPad/2-SilkWidth/2-SilkGap:0  pA/2:0))
	_Line(list(-pA/2+1:pB/2 -pA/2+1:-pB/2))
)

_CreateRefValue(pName) ;必须的文字层

_SaveDesign(pName)    ;保存文件
_MakeDevice(pName,2) ;需要的话附带生成DEVICE文件,0=IC 1=IO 2=DISCRETE

