;FPM skill by Richard L. version=0.08 fpmontreal@gmail.com
;Tree:Inductor/PowerInductor
;Desc:37 kinds of SUMIDA's Power Inductor
;Vendor:SUMIDA
;Count:37
;CVG64:bitmap field, not implemented yet.
;Datasheet:

	Tabs='(
; name                  pA    pB    pH   pL  pY  pG
	("SUMIDA-CDH38D09"     4.0   4.0   1.0  4.2 3.0 1.0)
	("SUMIDA-CDH38D11"     4.0   4.0   1.2  4.6 3.0 1.0)
	("SUMIDA-CDH40D11"     4.2   4.2   1.2  4.0 3.7 1.2)
	("SUMIDA-CDMC104"     11.5  10.2   4.0  8.2 4.6 6.0)
	("SUMIDA-CDRH10D43FB" 10.3  10.3   4.5 11.0 6.0 5.0)
	("SUMIDA-CR43"         4.3   4.3   3.5  5.0 4.5 1.5)
	("SUMIDA-CR54"         5.6   5.6  4.85  6.0 5.5 1.7)
	("SUMIDA-CR75"         7.3   7.3   5.5  8.0 5.5 2.0)
	("SUMIDA-CR10D37"     10.4  10.4   4.0 12.0 9.6 4.0)
	("SUMIDA-CR105"       10.4   9.5   5.8 10.0 9.5 2.5)
	("SUMIDA-CDH5D14"      6.0   6.0   1.5  6.8 5.0 1.4)
	("SUMIDA-CDH53"        5.4   6.0   3.2  6.0 2.2 2.5)
	("SUMIDA-CDH63"        6.5   6.2   2.9  7.0 2.1 3.6)
	("SUMIDA-CDH73"        8.0   7.3   3.3  8.4 2.4 5.4)
	("SUMIDA-CDH74"        8.0   7.3   5.2  8.4 2.4 5.4)
	("SUMIDA-CDH113"      11.2  11.2   3.7 11.8 4.4 7.0)
	("SUMIDA-CDH115"      11.2  11.2   5.2 11.8 4.4 7.0)
	("SUMIDA-CDRH4D15"     4.7   4.7   1.7  5.1 5.1 1.5)
	("SUMIDA-CDRH4D18"     5.0   5.0   2.0  5.3 5.3 1.5)
	("SUMIDA-CDRH4D22"     5.0   5.0   2.4  5.3 5.3 1.5)
	("SUMIDA-CDRH4D28"     5.0   5.0   3.0  5.3 5.3 1.5)
	("SUMIDA-CDRH5D14"     6.3   6.0   1.5  7.0 2.6 3.2)
	("SUMIDA-CDRH5D18"     6.0   6.0   2.0  6.3 6.3 2.0)
	("SUMIDA-CDRH5D28"     6.0   6.0   3.0  6.3 6.3 2.0)
	("SUMIDA-CDRH5D28R"    6.3   6.2   3.0  6.6 2.1 4.6)
	("SUMIDA-CDRH6D26"     7.0   7.0   2.8  7.3 7.3 2.0)
	("SUMIDA-CDRH6D28"     7.0   7.0   3.0  7.3 7.3 2.0)
	("SUMIDA-CDRH6D38"     7.0   7.0   4.0  7.3 7.3 2.0)
	("SUMIDA-CDRH103R"    10.5  10.3   3.1 10.5 3.2 7.3)
	("SUMIDA-CDRH104R"    10.5  10.3   4.0 10.5 3.2 7.3)
	("SUMIDA-CDRH105R"    10.5  10.3   5.1 10.5 3.2 7.3)
	("SUMIDA-CDRH10D68"   10.5  10.5   7.1 10.8 3.4 6.0)
	("SUMIDA-CDRH12D43R"  12.4  12.4   4.5 13.0 4.2 7.8)
	("SUMIDA-CDRH12D58R"  12.4  12.4   6.0 13.0 4.2 7.8)
	("SUMIDA-CDRH124"     12.3  12.3   4.5 12.8 5.4 7.0)
	("SUMIDA-CDRH125"     12.3  12.3   6.0 12.8 5.4 7.0)
	("SUMIDA-CDRH127"     12.3  12.3   8.0 12.8 5.4 7.0)
	)

	Courtyard=0.5
foreach(aTb Tabs
	pName=nth(0 aTb)
	pA=nth(1 aTb)
	pB=nth(2 aTb)
	pH=nth(3 aTb)
	pL=nth(4 aTb)
	PadY=nth(5 aTb)
	pG=nth(6 aTb)
	PadX=(pL-pG)/2.0
	Pitch=pG+PadX

	_PrepareNewSym(pName)

;pin
	PadN=_PadSMFillet(PadX PadY)
	_CreatePin(PadN -Pitch/2:0 "1")
	_CreatePin(PadN Pitch/2:0 "2")
	
;bound
	_Layer(lPkgGeoPlaceT)
	_BoundHeight(_ShapeRectangle(pA+Courtyard*2 pB+Courtyard*2) pH)

;keepout
	_Layer(lRouteKoT);keepout
	_ShapeRectangle(Pitch-PadX PadY 0:0 0.5)

;silkscreen & assembly
	for(i 1 2
	if(i==1	_Layer(lPkgGeoSilkT) _Layer(lPkgGeoAsmT))
		_Rectangle(pA pB 0:0 0.2)
		_Circle(pA/2-0.8)
	)

;ref & val
	_CreateRefValue(pName 0:0)
	_CrossCenter()

	_SaveDesign(pName)
}

