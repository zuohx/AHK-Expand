; 将Ctrl组合常用功能键映射为 Alt触发
; Ctrl + c/x/v/a/s/w/z/f/Left/Right
; Ctrl + Shift + z/Left/Right

;LWin	                左边的 Win. 对应 <# 热键前缀.
;RWin	                右边的 Win. 对应 ># 热键前缀.
; LControl (或 LCtrl)	左 Ctrl. 对应 <^ 热键前缀.
; RControl (或 RCtrl)	右 Ctrl. 对应 >^ 热键前缀.
; LShift	            左 Shift. 对应 <+ 热键前缀.
; RShift	            右 Shift. 对应 >+ 热键前缀.
; LAlt	                左 Alt. 对应 <! 热键前缀.
; RAlt	                右 Alt. 对应 >! 热键前缀.

#SingleInstance force
#NoEnv

; 检查当前活动窗口是否不是游戏窗口
; 返回: true - 不是游戏窗口, false - 是游戏窗口
CheckWindowNotActive() {
    WinGet, activeWindowId, ID, A               ; 获取当前活动窗口ID
    WinGet, processName, ProcessName, ahk_id %activeWindowId%  ; 获取窗口进程名
    WinGetClass, windowClass, ahk_id %activeWindowId%  ; 获取窗口类名

    ; 定义需要检查的窗口类名数组,需要排除的 ahk_class
    windowClasses := ["mashinky", "grcWindow"]

    ; 定义需要检查的进程名数组,需要排除的 ahk_exe
    processNames := ["BlackDesert64_CN.exe", "Cities2.exe", "Captain of Industry.exe", "inZOI-Win64-Shipping.exe", "Factorio.exe"]

    ; 检查窗口类是否在允许的列表中
    for index, allowedClass in windowClasses {
        if (windowClass = allowedClass) {
            return false  ; 窗口类匹配，是游戏窗口
        }
    }

    ; 检查进程名是否在允许的列表中
    for index, allowedProcess in processNames {
        if (processName = allowedProcess) {
            return false  ; 进程名匹配，是游戏窗口
        }
    }

    return true  ; 窗口既不是游戏窗口类，进程名也不匹配
}

; 初始化键盘钩子功能
InitKeyboardHook() {
    global
    ; 调试信息
    Hotkey, !u, DebugHotkey
    ; 禁用Alt键
    Hotkey, Alt, AltDisable
    
    ; 基本功能键映射
    Hotkey, $!c, CopyHotkey
    Hotkey, $!x, CutHotkey
    Hotkey, $!v, PasteHotkey
    Hotkey, $!+v, PasteSpecialHotkey
    Hotkey, $!a, SelectAllHotkey
    Hotkey, $!s, SaveHotkey
    Hotkey, $!w, CloseWindowHotkey
    Hotkey, $!z, UndoHotkey
    Hotkey, $!+z, RedoHotkey
    Hotkey, $!f, FindHotkey
    
    ; 查找功能
    Hotkey, $!g, FindNextHotkey
    Hotkey, $!+g, FindPrevHotkey
    
    ; 其他功能
    Hotkey, $!t, NewTabHotkey
    Hotkey, $!+t, ReopenTabHotkey
    Hotkey, $!r, ReloadHotkey
    
    ; 删除和导航功能
    Hotkey, $!Left, HomeHotkey
    Hotkey, $!Right, EndHotkey
    Hotkey, $!+Left, SelectToHomeHotkey
    Hotkey, $!+Right, SelectToEndHotkey
}

; 禁用键盘钩子功能
DisableKeyboardHook() {
    ; 调试信息
    Hotkey, !u, Off
    ; 禁用Alt键
    Hotkey, Alt, Off
    
    ; 基本功能键映射
    Hotkey, $!c, Off
    Hotkey, $!x, Off
    Hotkey, $!v, Off
    Hotkey, $!+v, Off
    Hotkey, $!a, Off
    Hotkey, $!s, Off
    Hotkey, $!w, Off
    Hotkey, $!z, Off
    Hotkey, $!+z, Off
    Hotkey, $!f, Off
    
    ; 查找功能
    Hotkey, $!g, Off
    Hotkey, $!+g, Off
    
    ; 其他功能
    Hotkey, $!t, Off
    Hotkey, $!+t, Off
    Hotkey, $!r, Off
    
    ; 删除和导航功能
    Hotkey, $!Backspace, Off
    Hotkey, $!Left, Off
    Hotkey, $!Right, Off
    Hotkey, $!+Left, Off
    Hotkey, $!+Right, Off
}

; 调试热键
DebugHotkey() {
    if (!WinActive("ahk_exe 语雀.exe")) {
        MsgBox, active.
    } else {
        MsgBox, not active.
    }
}

; 禁用Alt键
AltDisable() {
    Return
}

; 复制
CopyHotkey() {
    Send {Ctrl Down}{c}{Ctrl Up}
}

; 剪切
CutHotkey() {
    Send {Ctrl Down}{x}{Ctrl Up}
}

; 粘贴
PasteHotkey() {
    Send {Ctrl Down}{v}{Ctrl Up}
}

; 特殊粘贴
PasteSpecialHotkey() {
    Send {Ctrl Down}{Shift Down}{v}{Ctrl Up}{Shift Up}
}

; 全选
SelectAllHotkey() {
    Send {Ctrl Down}{a}{Ctrl Up}
}

; 保存
SaveHotkey() {
    Send {Ctrl Down}{s}{Ctrl Up}
}

; 关闭窗口
CloseWindowHotkey() {
    Send {Ctrl Down}{w}{Ctrl Up}
}

; 撤销
UndoHotkey() {
    Send {Ctrl Down}{z}{Ctrl Up}
}

; 重做
RedoHotkey() {
    Send {Ctrl Down}{Shift Down}{z}{Ctrl Up}{Shift Up}
}

; 查找
FindHotkey() {
    Send {Ctrl Down}{f}{Ctrl Up}
}

; 查找下一个
FindNextHotkey() {
    Send {F3 Down}{F3 Up}
}

; 查找上一个
FindPrevHotkey() {
    Send {Shift Down}{F3 Down}{Shift Up}{F3 Up}
}

; 新标签页
NewTabHotkey() {
    Send {Ctrl Down}{t}{Ctrl Up}
}

; 重新打开标签页
ReopenTabHotkey() {
    Send {Ctrl Down}{Shift Down}{t}{Ctrl Up}{Shift Up}
}

; 刷新
ReloadHotkey() {
    Send {Ctrl Down}{r}{Ctrl Up}
}

; Home键
HomeHotkey() {
    Send {Home}
}

; End键
EndHotkey() {
    Send {End}
}

; 选择到Home
SelectToHomeHotkey() {
    Send +{Home}
}

; 选择到End
SelectToEndHotkey() {
    Send +{End}
}

; 条件初始化
If CheckWindowNotActive() {
    InitKeyboardHook()
}

; 如果脚本独立运行，自动初始化
if (A_ScriptName = "KeyboardHook.ahk") {
    ; 独立运行时的初始化逻辑
    if (CheckWindowNotActive()) {
        InitKeyboardHook()
    }
}

