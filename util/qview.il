;DESCRIPTION: 2 layers PCB quick layer/colour view switch
;AUTHOR: Richard L.   fpmontreal@gmail.com
;
;some pre-define color, legal numbers are 1 to 24
c_white =1 c_qing   =6 	c_ltgreen=12 c_dkzi =17
c_ltblue=2 c_red    =7		c_golden =13 c_gray =19
c_pink  =3 c_yellow =8 	c_ltpink =14 c_jiang=22
c_cyan  =4 c_dkblue =9 	c_mud    =15 c_black=23
c_zi    =5 c_dkgray =11	c_blue   =16

qvcs='(
; you may add many layers as you want:)
;  q_name            q_layers
("top_etch"          ("ETCH/TOP" "VIA CLASS/TOP" "PIN/TOP" "BOARD GEOMETRY/OUTLINE"))
("top_silk"          ("PACKAGE GEOMETRY/SILKSCREEN_TOP" "REF DES/SILKSCREEN_TOP" "PIN/TOP" "BOARD GEOMETRY/OUTLINE"))
("top_auto_silk"     ("MANUFACTURING/AUTOSILK_TOP" "PIN/TOP" "BOARD GEOMETRY/OUTLINE"))
("top_assembly"      ("PIN/TOP" "REF DES/ASSEMBLY_TOP" "PACKAGE GEOMETRY/ASSEMBLY_TOP" "BOARD GEOMETRY/ASSEMBLY_TOP" "BOARD GEOMETRY/OUTLINE"))
("top_value"         ("PIN/TOP" "COMPONENT VALUE/ASSEMBLY_TOP" "PACKAGE GEOMETRY/ASSEMBLY_TOP" "BOARD GEOMETRY/ASSEMBLY_TOP" "BOARD GEOMETRY/OUTLINE"))

("bottom_etch"       ("ETCH/BOTTOM" "VIA CLASS/BOTTOM" "PIN/BOTTOM" "BOARD GEOMETRY/OUTLINE"))
("bottom_silk"       ("PACKAGE GEOMETRY/SILKSCREEN_BOTTOM" "REF DES/SILKSCREEN_BOTTOM" "PIN/BOTTOM" "BOARD GEOMETRY/OUTLINE"))
("bottom_auto_silk"  ("MANUFACTURING/AUTOSILK_BOTTOM" "PIN/BOTTOM" "BOARD GEOMETRY/OUTLINE"))
("bottom_assembly"   ("PIN/BOTTOM" "REF DES/ASSEMBLY_BOTTOM" "PACKAGE GEOMETRY/ASSEMBLY_BOTTOM" "BOARD GEOMETRY/ASSEMBLY_BOTTOM" "BOARD GEOMETRY/OUTLINE"))
("bottom_value"      ("PIN/BOTTOM" "COMPONENT VALUE/ASSEMBLY_BOTTOM" "PACKAGE GEOMETRY/ASSEMBLY_BOTTOM" "BOARD GEOMETRY/ASSEMBLY_BOTTOM" "BOARD GEOMETRY/OUTLINE"))
)

/*---------------------------------
ChangeColor()
---------------------------------*/
defun( ChangeColor (whichone)
	axlVisibleDesign(nil)

	foreach(one qvcs 
		if(whichone==car(one) then
			foreach(lName cadr(one)
				l_sep=parseString(lName "/")
				sprintf(strOrg,"paramLayerGroup:%s/paramLayer:%s",car(l_sep),cadr(l_sep))
				p=axlGetParam(strOrg)
				if(p then 
					p->visible=t 
					c1=1
					cond(
					(rexMatchp("AUTOSILK" lName)                   c1=c_gray   )
					(rexMatchp("PIN/TOP" lName)                    c1=c_golden )
					(rexMatchp("VIA CLASS/TOP" lName)              c1=c_golden )
					(rexMatchp("ETCH/TOP" lName)                   c1=c_golden )
					(rexMatchp("PIN/BOTTOM" lName)                 c1=c_ltgreen)
					(rexMatchp("VIA CLASS/BOTTOM" lName)           c1=c_ltgreen)
					(rexMatchp("ETCH/BOTTOM" lName)                c1=c_ltgreen)

					(rexMatchp("VALUE" lName)                      c1=c_pink)
					(rexMatchp("REF DES" lName)                    c1=c_cyan)
					(rexMatchp("PACKAGE GEOMETRY/ASSEMBLY_" lName) c1=c_gray)
					(rexMatchp("BOARD GEOMETRY/ASSEMBLY_" lName)   c1=c_gray)
					(rexMatchp("COMPONENT VALUE/ASSEMBLY_" lName)  c1=c_gray)
					(rexMatchp("OUTLINE" lName)                    c1=c_red )
					)                                                         
					p->color=c1
					axlSetParam(p)
				)
			)
		)
	)
	axlUIWRedraw(nil)
)

/*---------------------------------
CreateQViewForm()
---------------------------------*/
defun( CreateQViewForm ()
	fn=axlTempFile()
	p=outfile(fn "w")
	f_FormBegin(p 16 16 "QView - Richard L." "TOOLWINDOW")

	i=0
	foreach(onec qvcs f_CheckList(p car(onec) 0 i car(onec) "cg") i=i+2)

	f_FormEnd(p)
	close(p)
	fn
)

defun( QView ()
	QVFormFile=CreateQViewForm()	
	fw=axlFormCreate((gensym) QVFormFile '("NE" "msglines" 0) 'QViewAction t nil)
	axlUIWPerm(fw t)
	axlFormDisplay(fw)
	axlTempFileRemove(QVFormFile)
)

defun( QViewAction (fw)
	if(fw->curField then 
		foreach(onec qvcs if(fw->curField==car(onec) ChangeColor(fw->curField)))
	)
)

axlCmdRegister( "qview" `QView)
