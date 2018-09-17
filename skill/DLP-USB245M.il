;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Module/Module
;Desc:USB module
;Vendor:DLP Inc.
;Count:1
;CVG64:bitmap field, not implemented yet.
;Datasheet:

pPNum  =24
pL     =15.200
pA     =17.800 
pB     =38.100 
pH     =17.40
pPad   =1.7
pHole  =1.02
Pitch  =2.54
HeadL  =16.5
HeadOut=8.0
HeadW  =12.7

pName="DLP-USB245M"
_PrepareNewSym(pName)
Courtyard=0.5
;pin
PadN1=_PadTH_Default(pPad pHole t)	
PadN2=_PadTH_Default(pPad pHole))
_CreatePin(PadN1 -13.97:-7.6 "1")
;_PinArray(PadN Col Row PitchX/Y (P1=0:0 bRight bUp bRowFirst bPin1 bPinNum P1Offset=0 PAngle=0 TAngle=0)
_PinArray(PadN2 pPNum/2 1 Pitch 0 -13.97:-7.6 t t t nil)
_PinArray(PadN2 pPNum/2 1 Pitch 0 13.97:7.6 nil t t t t 12)

;bound
x1=-pB/2-Courtyard y1=-pA/2-Courtyard
x2=-Pitch*(pPNum/2-1)/2-Pitch/2-Courtyard y2=-pL/2+Pitch/2+Courtyard
x3=Pitch*(pPNum/2-1)/2+Pitch/2+Courtyard  y3=pL/2-Pitch/2-Courtyard
x4=pB/2+Courtyard-1.5 y4=pA/2+Courtyard
_Layer(lPkgGeoPlaceT)
_BoundHeight(axlDBCreateRectangle(list(x1:y1 x2:y4) t) pH 4.2)
_BoundHeight(axlDBCreateRectangle(list(x3:y1 x4:y4) t) pH 4.2)
_BoundHeight(axlDBCreateRectangle(list(x2:y2 x3:y3) t) pH 4.2)
_BoundHeight(axlDBCreateRectangle(list(x2:y3 x3:y4) t) pH)
_BoundHeight(axlDBCreateRectangle(list(x2:y1 x3:y2) t) pH)

for(asm 0 1 if(asm==1 _Layer(lPkgGeoAsmT) _Layer(lPkgGeoSilkT));;assembly and silkscreen
	_Line(list(-pB/2:pA/2-1 -pB/2:pA/2 pB/2:pA/2 pB/2:-pA/2 -pB/2:-pA/2 -pB/2:-pA/2+1))
	_Line(list(pB/2:HeadW/2 pB/2+HeadOut:HeadW/2 pB/2+HeadOut:-HeadW/2 pB/2:-HeadW/2))
	_Line(list(pB/2-1:0 pB/2+1:0))
	_Line(list(pB/2+HeadOut:0 pB/2+HeadOut-HeadOut/3:0))
	;polarity mark
	_Triangle(-(pPNum/2-1)*Pitch/2:-pA/2 1 90)
)

_CrossCenter()
_CreateRefValue(pName)

_SaveDesign(pName)
_MakeDevice(pName)
