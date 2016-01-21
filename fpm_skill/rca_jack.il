;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Connector/Signal Connector
;Desc:RCA Jack
;Vendor:Stavros ZHANG Hao
;Count:1
;CVG64: æ“‚Õº◊÷∂Œ(≤‚ ‘÷–)
;Datasheet:

pA=11.5 pB=6.6 pH=5.0 pPad=4.0 pHole=2.8

pName="RCA_JACK" 
_PrepareNewSym(pName)  
PadN=_PadTH_Default(pPad pHole) 

PadN1 = _PadTH_Default(2.0 1.3)
PadS1 = _Pad_Slot(3.6 1.6 2.8 0.8)
PadS2 = _Pad_Slot(1.6 3.6 0.8 2.8)
ofs = -pB/2
_CreatePin(PadN1 0:-pB/2+pHole/2 "1")
_CreatePin(PadS1 0:pB/2 "2")

_CreatePinMechanical(PadS2 -pA/2:-pB/2+pHole/2)
_CreatePinMechanical(PadS2 pA/2:-pB/2+pHole/2)
;_CreatePin(PadN 0:ofs+5 "5")

_Layer(lPkgGeoPlaceT) 
_BoundHeight(_ShapeRectangle(pA+2 pB+3) pH)

for(asm 0 1 
        if(asm==1 _Layer(lPkgGeoAsmT) _Layer(lPkgGeoSilkT))     

	_Rectangle(pA pB)
	_Line(list(-4.5:pB/2 -4.5:pB/2+9.0))
	_Line(list(4.5:pB/2 4.5:pB/2+9.0))
	_Line(list(-4.5:pB/2+9.0 4.5:pB/2+9.0))
)

_CreateRefValue(pName) 

_SaveDesign(pName)    
_MakeDevice(pName,2) 

