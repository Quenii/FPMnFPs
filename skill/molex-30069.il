;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Connector/Header
;Desc:
;Vendor:
;Count:7
;CVG64:bitmap field, not implemented yet.
;Datasheet:

Tabs='(2 4  6 8 10 12 16)

Courtyard=1.0 pH=12.8 Pitch=4.2

foreach(CKTS Tabs
  A=(CKTS/2-1)*Pitch
  B=A+5.4
  C=B+3.6
  D=C+6.4
  for(peg 0 1

  sprintf(pName,"MOLEX-30069-%02d%d1",CKTS,(peg+1)*2);2-flange 4-peg
  _PrepareNewSym(pName)

  if(peg==1 
;_PadTH_NP(0 pHole pPadTop pPadInner pPadBot pThermal pSolderMask pAssembly pAnti pKeepout)
    MtgPadN=_PadTH_NP(list(0 3.0 1.0 1.0 1.0 5.0 5.0 5.0 5.0 5.0))
    MtgPadN=_PadTH_NP(list(0 3.2 1.0 1.0 1.0 5.0 5.0 5.0 5.0 5.0))
  )
  PadN=_PadTH_Default(2.40 1.45)
  if(peg==1 then
    _CreatePinMechanical(MtgPadN -C/2:5.5/2-0.5)
    _CreatePinMechanical(MtgPadN C/2:5.5/2-0.5)
    else 
    _CreatePinMechanical(MtgPadN -C/2:5.5/2-2.1)
    _CreatePinMechanical(MtgPadN C/2:5.5/2-2.1)
  )
  for(col 1 CKTS/2
    x0=(CKTS/2-1)*Pitch/2-Pitch*(col-1)
    sprintf(pNum,"%d",(col-1)*2+1) _CreatePin(PadN x0:-5.5/2 pNum)
    sprintf(pNum,"%d",col*2)       _CreatePin(PadN x0:5.5/2 pNum)
  )
  
;bound
  if(peg==0 
    bound=axlDBCreateRectangle(list(-D/2-Courtyard:-11.3/2-Courtyard D/2+Courtyard:11.3/2+1.4+Courtyard) t lPkgGeoPlaceT)
    bound=axlDBCreateRectangle(list(-C/2-3.2/2-Courtyard:-11.3/2-Courtyard C/2+3.2/2+Courtyard:11.3/2+1.4+Courtyard) t lPkgGeoPlaceT))
  _BoundHeight(bound pH)

;silkscreen & assembly
  for(i 1 2
  case(i
  (1 _Layer(lPkgGeoSilkT))
  (2 _Layer(lPkgGeoAsmT)))
    _Triangle((CKTS/2-1)*Pitch/2:-11.3/2 2 90)
    _Rectangle(B 11.3)
    _Rectangle(3.4 1.4 0:11.3/2+1.4/2)
    if(peg==0 then
      _Rectangle((D-B)/2 6.2 -B/2-(D-B)/4:5.5/2-2.1)
      _Rectangle((D-B)/2 6.2 B/2+(D-B)/4:5.5/2-2.1)
      else 
      _Rectangle(3.2 3.2 -B/2-3.2/2:5.5/2-0.5)
      _Rectangle(3.2 3.2 B/2+3.2/2:5.5/2-0.5)
    )
    if(i==2 then
      od=0.5 px=-B/2+od py=-11.3/2+od 
      _Line(list(px:py -px:py -px:-py-1 -px-1:-py px+1:-py px:-py-1 px:py))
      _Line(list(px:0 -px:0))
    )
  )

;ref & val
  _CreateRefValue(pName 0:-11.3/2-tSilkHeight/2)
;  _CrossCenter()

  _SaveDesign(pName)
  _MakeDevice(pName 2) ;0-IC 1-IO 2-DISCRETE
);for peg
);foreach
