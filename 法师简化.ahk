; 变量声明
isEnabledMP := 0
isEnabledDeBuff := 0
isEnabledFireball := 0

; 创建 COM 对象
tts := ComObjCreate("SAPI.SpVoice")

; 当按下向下箭头键时，切换恢复MP功能启用状态
Down::
    isEnabledMP := !isEnabledMP
    if (isEnabledMP) {
        tts.Speak("Restore MP - Status: Enabled")
    } else {
        tts.Speak("Restore MP - Status: Disabled")
    }
return

; 当按下向上箭头键时，切换一键DeBuff功能启用状态
Up::
    isEnabledDeBuff := !isEnabledDeBuff
    if (isEnabledDeBuff) {
        tts.Speak("OneClickDeBuff - Status: Enabled")
    } else {
        tts.Speak("OneClickDeBuff - Status: Disabled")
    }
return

; 当按下 Control + S 时（且恢复MP功能已启用），运行以下代码
Control & s::
    if (!isEnabledMP) 
        return

    ; 按下 S 键
    Send {s down}
    Sleep, 50

    ; 按下、松开鼠标左键 3 次，并在每次点击间加入 300ms 的间隔
    Loop, 3
    {
        Send {LButton down}
        Sleep, 50
        Send {LButton up}
        Sleep, 300
    }

    ; 松开 S 键
    Send {s up}
return

; 当按下 Control + W 时（且一键DeBuff功能已启用），运行以下代码
Control & w::
    if (!isEnabledDeBuff) 
        return

    ; 按下、松开鼠标左键 3 次
    Loop, 3
    {
        Send {LButton down}
        Sleep, 50
        Send {LButton up}
        Sleep, 50
    }
return

; 当按下左箭头键时，切换 Fireball spell burst 功能启用状态
Left::
    isEnabledFireball := !isEnabledFireball
    if (isEnabledFireball) {
        tts.Speak("Fireball Spell Burst - Status: Enabled")
    } else {
        tts.Speak("Fireball Spell Burst - Status: Disabled")
    }
return

; 当按下 Control + A 时（且 Fireball spell burst 功能已启用），运行以下代码
Control & a::
    if (!isEnabledFireball)
        return

    ; 按下 a 键
    Send {a down}
    Sleep, 50
    ; 按下空格键然后松开
    Send {Space down}
    Sleep, 50
    Send {Space up}
    
    ; 按下、松开鼠标左键 2 次，并在松开时加入 50ms 的间隔
    Loop, 2
    {
        Send {LButton down}
        Sleep, 50
        Send {LButton up}
        Sleep, 50
    }
    ; 松开 a 键并等待 500ms
    Send {a up}
    Sleep, 500

    ; 重复上述过程 3 次，但使用 d 键代替 a 键
    Loop, 3
    {
        Send {d down}
        Sleep, 50
        Send {Space down}
        Sleep, 50
        Send {Space up}

        Loop, 2
        {
            Send {LButton down}
            Sleep, 50
            Send {LButton up}
            Sleep, 50
        }
        Send {d up}
        Sleep, 500

        ; 在最后一次循环后，再按下 a 键，不需要使用 d 键
        if (A_Index = 3) 
            break

        Send {a down}
        Sleep, 50
        Send {Space down}
        Sleep, 50
        Send {Space up}

        Loop, 2
        {
            Send {LButton down}
            Sleep, 50
            Send {LButton up}
            Sleep, 50
        }
        Send {a up}
        Sleep, 500
    }
return