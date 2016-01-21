;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Socket/Vacuum Tube Socket
;Desc:Octal Vacuum Tube (K8A)
;Vendor:Stavros ZHANG Hao
;Count:1
;CVG64: æ“‚Õº◊÷∂Œ(≤‚ ‘÷–)
;Datasheet:

pL=13.0  pA=30.0 pH=30.0 Courtyard=2.0 

pName="VT_K8A"   
_PrepareNewSym(pName)  

PadS = _Pad_Slot(3.6 1.6 2.8 0.8) 

for(i 1 8
    j=i+5
    angle = (j+0.5)*45
    rad = angle * 3.1416/180 
    _CreatePin(PadS pL*cos(rad):pL*sin(rad) i angle+90)
)


_Layer(lPkgGeoPlaceT) 
_BoundHeight(_ShapeCircle(pL+Courtyard lPkgGeoPlaceT) pH)

for(asm 0 1 
if(asm==1 _Layer(lPkgGeoAsmT) _Layer(lPkgGeoSilkT)) 
_Circle(pA/2)   
	_Circle(4.2)
	_Circle(1.5 0:-4.0)	
)
_CreateRefValue(pName) 

_SaveDesign(pName)
_MakeDevice(pName,2)
