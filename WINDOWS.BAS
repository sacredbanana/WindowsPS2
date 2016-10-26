'Microsoft Windows PS2 Home Edition by Cameron Armstrong
print "Memory..."
wait 3
print "OK"
wait 1
print "CMOS..."
wait 2
print "OK"
wait 1
print "Loading config.sys and autoexec.bat..."
wait 1
print "Done"
wait 1
print "Loading video drivers..."
wait 2
clear screen
print "*******Cameron's PS2 Video Driver V1.00*******"
label 1
print "1) Blaze Hi-Res VGA adaptor (640x480 @ 60Hz)"
print "2) Standard AV (320x240 @ 50Hz)"
input vga
if vga<1 or vga>2 or (vga>1 and vga<2) then
print "Invalid value"
goto 1
fi
vga=30*vga
open window 640,512
window origin "lb"
for percentage=0 to 100 step .5
setdrawbuf dw
clear window
setrgb 1,255,0,0
fill rectangle 200,370+vga to 310,260+vga
setrgb 1,0,255,0
fill rectangle 330,370+vga to 440,260+vga
setrgb 1,0,0,255
fill rectangle 200,240+vga to 310,130+vga
setrgb 1,255,255,0
fill rectangle 330,240+vga to 440,130+vga
setrgb 1,255,255,255
text 130,450,"MICROSOFT (R) WINDOWS PS2 HOME EDITION"
rectangle 270,110+vga to 371,90+vga
setrgb 1,0,0,100
setrgb 2,0,0,100
setrgb 3,0,255,255
gtriangle 271,109+vga to 271,91+vga to 270+percentage,109+vga
gtriangle 271,109+vga to 271,91+vga to 270+percentage,91+vga
setrgb 2,0,255,255
gtriangle 271,109+vga to 270+percentage,109+vga to 270+percentage,91+vga
setdispbuf dw
dw=1-dw
next percentage

cursorx=320
cursory=256+vga
desktopblue=50
dim menuitem$(50)
usernameinput=1

'MAIN SYSTEM
label main
gosub setscreenbuffer
gosub desktop
gosub taskbar
gosub menu
gosub cpu
if login=0 gosub login
gosub mouse
gosub drawscreenbuffer
goto main

label setscreenbuffer
setdrawbuf dw
clear window
return

label desktop
if login=1 then
setrgb 1,desktopred,desktopgreen,desktopblue
fill rectangle 0,0 to 640,512
setrgb 1,200,170,0
fill rectangle 50,420+vga to 90,460+vga
setrgb 1,255,100,0
fill rectangle 50,460+vga to 90,463+vga
setrgb 1,255,255,255
fill rectangle 55,460+vga to 85,480+vga
text 10,405+vga,"My Documents"
setrgb 1,0,0,0
line 57,462+vga to 83,462+vga
line 57,465+vga to 83,465+vga
line 57,468+vga to 83,468+vga
line 57,471+vga to 83,471+vga
line 57,474+vga to 83,474+vga
line 57,477+vga to 83,477+vga
fill rectangle 55,350+vga to 85,390+vga
setrgb 1,0,0,255
fill rectangle 55,350+vga to 85,355+vga
line 58,380+vga to 63,380+vga
line 63,380+vga to 63,378+vga
line 63,378+vga to 58,378+vga
line 58,378+vga to 58,373+vga
line 64,374+vga to 68,374+vga
line 68,374+vga to 68,380+vga
line 68,380+vga to 72,380+vga
line 74,380+vga to 82,380+vga
line 82,380+vga to 82,377+vga
line 82,377+vga to 74,377+vga
line 74,377+vga to 74,374+vga
line 74,374+vga to 83,374+vga
setrgb 1,255,255,255
text 40,335+vga,"My PS2"
fi
return

label taskbar
if login=1 then
setrgb 1,0,0,255
fill rectangle 0,0 to 640,30+vga
setrgb 1,0,150,0
fill rectangle 0,0 to 80,30+vga
setrgb 1,255,255,255
text 20,15+vga,"START"
setrgb 1,255,0,0
fill rectangle 5,25+vga to 10,20+vga
setrgb 1,0,255,0
fill rectangle 12,25+vga to 17,20+vga
setrgb 1,0,0,255
fill rectangle 5,18+vga to 10,13+vga
setrgb 1,255,255,0
fill rectangle 12,18+vga to 17,13+vga
setrgb 1,0,0,100
fill rectangle 540,0 to 640,30+vga
hour$=mid$(time$,1,2)
minute$=mid$(time$,4,2)
if val(hour$)>12 then
if val(minute$)<10 minute$="0"+mid$(time$,4,1)
hours=val(hour$)-12
tm$=str$(hours)+":"+minute$+" PM"
else
tm$=hour$+":"+minute$+" AM"
fi
setrgb 1,255,255,255
text 550,15+vga,tm$
fi
return

label login
setrgb 1,0,0,150
fill rectangle 0,0 to 640,512
setrgb 1,0,0,255
setrgb 2,255,255,255
setrgb 3,255,255,255
gtriangle 180,350+vga to 180,150+vga to 480,150+vga
gtriangle 480,350+vga to 180,150+vga to 480,150+vga
setrgb 2,0,0,255
gtriangle 180,350+vga to 480,350+vga to 480,150+vga
setrgb 1,0,0,0
rectangle 180,150+vga to 480,350+vga
setrgb 1,255,255,0
text 270,330+vga,"Login to PS2"
setrgb 1,0,0,0
text 190,250+vga,"Username"
text 190,200+vga,"Password"
setrgb 1,255,255,255
fill rectangle 190,240+vga to 470,220+vga
fill rectangle 190,190+vga to 470,170+vga
setrgb 1,0,0,0
rectangle 190,240+vga to 470,220+vga
rectangle 190,190+vga to 470,170+vga
if errorstop=1 then
input$=inkey$
if input$<>"up" and input$<>"down" and input$<>"left" and input$<>"right" and input$<>"cross" and input$<>"square" and input$<>"circle" and input$<>"triangle" and input$<>"backspace" and input$<>"enter" and input$<>"tab" then
if usernameinput=1 then
if len(username$)<27 username$=username$+input$
fi
if passwordinput=1 then
if len(password$)<27 password$=password$+input$
fi
fi
wait .11
fi
if input$="tab" then
usernameinput=1-usernameinput
passwordinput=1-passwordinput
fi
if input$="backspace" then
if usernameinput=1 username$=left$(username$,(len(username$)-1))
if passwordinput=1 password$=left$(password$,(len(password$)-1))
fi
if input$="enter" then
if username$="sacredbanana" and password$="aeonpower" then
login=1
else
messagetitle$="Login error"
messagetext$="Incorrect Username and/or Password. Please try again."
messagetype$="Exclamation"
messagebuttons=1
messagebuttin1$="OK"
beeps=1
message=1
fi
fi
censor$=""
if password$="" goto nocensor
for censor=1 to len(password$)
censor$=censor$+"*"
next censor
label nocensor
wait .11
errorstop=1
text 195,255,username$
text 195,255,username$
text 195,205,censor$
text 195,205,censor$
if usernameinput=1 line 197+10*len(username$),238+vga to 197+10*len(username$),222+vga
if passwordinput=1 line 197+10*len(password$),188+vga to 197+10*len(password$),172+vga
return

label message
gosub setscreenbuffer
if beeps>0 then
for beeping=1 to beeps
beep
wait .1
next beeping
fi
setrgb 1,255,255,255
fill rectangle 200,200+vga to 500,400+vga
gosub mouse
gosub drawscreenbuffer
goto message
return

label mouse
if and(peek("port1"),16384)>0 then
leftclick=1
else
leftclick=0
fi
if and(peek("port1"),8192)>0 then
rightclick=1
else
rightclick=0
fi
if login=0 then
if and(peek("port1"),128)>0 and cursorx>-1 cursorx=cursorx-9
if and(peek("port1"),32)>0 and cursorx<641 cursorx=cursorx+9
if and(peek("port1"),16)>0 and cursory<513 cursory=cursory+9
if and(peek("port1"),64)>0 and cursory>0 cursory=cursory-9
fi
if login=1 then
if and(peek("port1"),128)>0 and cursorx>-1 cursorx=cursorx-3
if and(peek("port1"),32)>0 and cursorx<641 cursorx=cursorx+3
if and(peek("port1"),16)>0 and cursory<513 cursory=cursory+3
if and(peek("port1"),64)>0 and cursory>0 cursory=cursory-3
fi
setrgb 1,0,0,0
fill triangle cursorx,cursory+vga to cursorx+8,cursory-7+vga to cursorx+3,cursory-7+vga
fill triangle cursorx,cursory+vga to cursorx,cursory-10+vga to cursorx+3,cursory-7+vga
setrgb 1,255,255,255
line cursorx,cursory+vga to cursorx+8,cursory-7+vga
line cursorx+8,cursory-7+vga to cursorx+3,cursory-7+vga
line cursorx+3,cursory-7+vga to cursorx,cursory-10+vga
line cursorx,cursory-10+vga to cursorx,cursory+vga
return

label menu
if login=1 then
if menuitems=0 menu=0
if menu=1 then
setrgb 1,255,255,255
fill rectangle menux,menuy to menux+menuwidth,menuy-20*menuitems
setrgb 1,0,0,0
rectangle menux,menuy to menux+menuwidth,menuy-20*menuitems
if cursorx>menux and cursorx<menux+menuwidth and cursory+vga<menuy and cursory+vga>menuy-20*menuitems then
setrgb 1,0,0,100
menuitemselected=int((menuy-cursory)/22)
fill rectangle menux,menuy-20*menuitemselected to menux+menuwidth,menuy-20*(menuitemselected-1)
fi
for texts=1 to menuitems
if texts=menuitemselected and cursorx>menux and cursorx<menux+menuwidth and cursory+vga<menuy and cursory+vga>menuy-20*menuitems then
setrgb 1,255,255,255
else
setrgb 1,0,0,0
fi
text menux+3,menuy-13-20*(texts-1),menuitem$(texts)
next texts
fi
fi
return

label cpu
if login=0 then
if leftclick=1 and cursorx>190 and cursorx<470 and cursory+vga>220+vga and cursory+vga<240+vga then
usernameinput=1
passwordinput=0
fi
if leftclick=1 and cursorx>190 and cursorx<470 and cursory+vga>170+vga and cursory+vga<190+vga then
usernameinput=0
passwordinput=1
fi
fi
if login=1 then
if leftclick=1 menu=0
if rightclick=1 and peek("port1")=8192 then
menux=cursorx
menuy=cursory+vga
menu=1
menuitems=4
menuwidth=180
menuitem$(1)="Version"
menuitem$(2)="Properties"
menuitem$(3)="Help"
menuitem$(4)="Exit to DOS"
fi
fi
if message=1 gosub message
return

label drawscreenbuffer
setdispbuf dw
dw=1-dw
return





