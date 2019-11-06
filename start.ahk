CoordMode, ToolTip, Screen

global ENABLED := False

global gY := A_ScreenHeight - 80
global rY := gY - 75

global basicPressed := False
global specialPressed := False

global currentStatus := 0 ;0 - nothing, 1 - basic, 2 - special
global prevStatus := 0

global remainder :="R E M A P P I N G    E N A B L E D"
global mirror_remainder :="R E M A P P E D"
global mirrorMsg := " 0        9    8   7   6`n[TAB]   P   M   I   L`n[BSP]    O   H   B   J`n[SHIFT]  N   Y   K   U"
global alterMsg := " *        ?    ""    :     `;`n[TAB]   (    )    [    ]`n[BSP]     {    }     .    ,`n[SHIFT]   &   '    /    \"

       
~^LShift::
RAlt::
    ToggleGlobal()
return

#If (currentStatus==1)
q::p
w::m
e::i
r::l
a::o
s::h
d::b
f::j

z::n
x::y
c::k
v::u

1::9
2::8
3::7
4::6
`::0

*Tab::!Tab

#if

#if (currentStatus==2)

*q::Send, {(}
*w::Send, {)}
*e::Send, {[}
*r::Send, {]}
*a::Send, {{}
*s::Send, {}}
*d::Send, {.}
*f::Send, {,}
*z::Send, {&}
*x::Send, {'}
*c::Send, {/}
*v::Send, {\}

*`::Send, {*}
*1::Send, {?}
*2::Send, {"}
*3::Send, {:}
*4::Send, {;}

#if

#if specialPressed

LShift::
    ToggleGlobal()
return
#if

#if ENABLED&(currentStatus!=2)
^2::
    SendInput, {LControl Up}{Enter}
return
^3::^Enter
^1::^+Enter
#if

#if ENABLED

~*LControl::
    specialPressed := True
    RefreshState() 
return

~*LControl Up::
    specialPressed := False
    RefreshState() 
return

MButton::
    DisableGlobal()
return

*CapsLock::BackSpace

*LAlt::
    basicPressed := True
    RefreshState() 
return

*LAlt Up::
    basicPressed := False
    RefreshState() 
return

#if

RefreshState() {
    if basicPressed & specialPressed {
        currentStatus:=2
    } else if basicPressed {
        Send {LControl, Up}
        currentStatus:=1
    } else {
        currentStatus:=0
    }
    ChangeDisplay()
}

EnableGlobal() {
    ENABLED:=True
    ShowStatus(remainder,20,gY,2)
    return
}

DisableGlobal() {
    ENABLED:=False
    HideStatus(2)
    return
}

ChangeDisplay() {
    if (prevStatus == currentStatus) {
        return
    }
    if (currentStatus == 0) {
        HideStatus(3)
    } 
    if (currentStatus == 1) {
        ShowStatus(mirrorMsg, 20, rY,3)
    } 
    if (currentStatus == 2) {
        ShowStatus(alterMsg, 20, rY,3)
    }
    prevStatus := currentStatus
}

ShowStatus(t,x,y,w){
    ToolTip, %t%, x, y,%w%
}

HideStatus(w) {
    ToolTip, , , ,%w%
}

ToggleGlobal() {
    if ENABLED {
        DisableGlobal()
        specialPressed:=False
        basicPressed:=False
        RefreshState()
    } else {
        EnableGlobal()
    }
}

