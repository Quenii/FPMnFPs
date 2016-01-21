;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Transistor/Through hole transistor
;Desc:TO-92 package by fairchild
;Vendor:Stavros ZHANG Hao
;Count:1
;CVG64:
;Datasheet:

pL=2.54 pA=5.2 pH=5.2 pPad=1.3 pHole=0.7 Yard=0.3 pName="TO92VAR"
_PrepareNewSym(pName)  

PadN=_PadTH_Default(pPad pHole) 

_CreatePin(PadN  1.8:0 "1")
_CreatePin(PadN 0:-1.8 "2")
_CreatePin(PadN -1.8:0 "3") 

for(asm 0 1 
    if(asm==1 
        _Layer(lPkgGeoAsmT) 
        _Layer(lPkgGeoSilkT)
    ) 
	path = axlPathStart( list( -2.2:1.3))
    axlPathArcAngle(path SilkWidth 2.2:1.3 nil 240)
    axlPathLine(path SilkWidth -2.2:1.3)
    axlDBCreatePath(path)
)
l_poly = axlPolyFromDB(path) 
axlDBCreateShape(car(l_poly) t lPkgGeoDfaT)

path = axlPathStart( list( -2.2-Yard:1.3+Yard))
axlPathArcAngle(path SilkWidth 2.2+Yard:1.3+Yard nil 245)
axlPathLine(path SilkWidth -2.2-Yard:1.3+Yard) 
l_poly = axlPolyFromDB(path) 
axlDBCreateShape(car(l_poly) t lPkgGeoPlaceT) 

_CreateRefValue(pName) 
_SaveDesign(pName)
_MakeDevice(pName,2) 
