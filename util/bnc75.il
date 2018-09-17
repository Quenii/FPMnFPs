;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Connector/BNC
;Desc:BNC R/A INSULATED PCB SOCKET 75ohm
;Vendor: Kurapica@bdwm.net
;Count:1
;CVG64:bitmap field, not implemented yet.
;Datasheet:

Courtyard=0.5 Pitch=2.54 pA=14.7 pB=14.6 pH=15.8 pPad1=1.7 pHole1=0.89 pPad2=3.2 pHole2=2.01

pName="BNC75"
_PrepareNewSym(pName)

;pin
Pad1=_PadTH_Default(pPad1 pHole1)
Pad2=_PadTH_Default(pPad2 pHole2)
_CreatePin(Pad1 0:0 "1")
_CreatePinMechanical(Pad1 -2.54:0)
_CreatePin(Pad2 5.08:5.08 "2")
_CreatePinMechanical(Pad2 -5.08:5.08)

;bound
_Layer(lPkgGeoPlaceT)
_BoundHeight(_ShapeRectangle(pA+Courtyard*2 pB 0:5.08) pH)
_Layer(lPkgGeoDfaT) 
_BoundHeight(_ShapeRectangle(pA pB 0:5.08) pH pName)

;silkscreen & assembly
for(i 1 2
      if(i==1 
          _Layer(lPkgGeoSilkT) 
          _Layer(lPkgGeoAsmT)
          )
      _Rectangle(pA pB 0:5.08 0.5)
      _Rectangle(11 12.3 0:18.53 0)
      _Rectangle(9.6 12 0:30.68 0)
      )

;ref & val
_CreateRefValue(pName 0:0)
_CrossCenter()

_SaveDesign(pName)
_MakeDevice(pName 2)
