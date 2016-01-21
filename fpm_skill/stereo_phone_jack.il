;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Connector/Phone connector
;Desc:3.5mm stereo phone jack
;Vendor:Stavros ZHANG Hao
;Count:1
;CVG64: æ“‚Õº◊÷∂Œ(≤‚ ‘÷–)
;Datasheet:

pA=11.0 pB=12.0 pH=5.0 pPad=1.8 pHole=1.2 Courtyard=0.8

pName="STEREO"
_PrepareNewSym(pName)
PadN=_PadTH_Default(pPad pHole)
PadN1=_PadTH_Default(pPad pHole t)
 
ofs = -pA/2+3.0
_CreatePin(PadN1 -5.0:ofs "1")
_CreatePin(PadN -2.5:ofs "2")
_CreatePin(PadN 2.5:ofs  "3")
_CreatePin(PadN 5.0:ofs "4")
_CreatePin(PadN 0:ofs+5 "5")

_Layer(lPkgGeoPlaceT) 
_BoundHeight(_ShapeRectangle(pB+Courtyard pA+Courtyard 0:0 pB/16) pH)

for(asm 0 1 
        if(asm==1 _Layer(lPkgGeoAsmT) _Layer(lPkgGeoSilkT))

	_Rectangle(pB pA)
	_Line(list(3.0:pA/2 3.0:pA/2+3.0))
	_Line(list(-3.0:pA/2 -3.0:pA/2+3.0))
	_Line(list(-3.0:pA/2+3.0 3.0:pA/2+3.0))
)

_CreateRefValue(pName)

_SaveDesign(pName)
_MakeDevice(pName,2)

