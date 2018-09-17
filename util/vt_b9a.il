;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Socket/Vacuum Tube Socket
;Desc:Miniature 9 pins (B9A) 
;Vendor:Stavros ZHANG Hao
;Count:1
;CVG64: æ“‚Õº◊÷∂Œ(≤‚ ‘÷–)
;Datasheet:

pL=10.5  pA=25 pH=18.5 Courtyard=2.0 
pName="VT_B9A"   
_PrepareNewSym(pName)  
PadS = _Pad_Slot(3.0 1.6 2.2 0.8) 

for(i 1 9
    j=i+7.5
    angle = j*36
    rad = angle * 3.1416/180 
    _CreatePin(PadS pL*cos(rad):pL*sin(rad) i angle+90)
  )


_Layer(lPkgGeoPlaceT) 
_BoundHeight(_ShapeCircle(pL+Courtyard lPkgGeoPlaceT) pH)

for(asm 0 1 
if(asm==1 _Layer(lPkgGeoAsmT) _Layer(lPkgGeoSilkT)) 
_Circle(pA/2)   
)

_CreateRefValue(pName) 

_SaveDesign(pName)
_MakeDevice(pName,2) 

