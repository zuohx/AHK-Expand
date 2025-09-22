; main.ahk - 主程序文件
; ==================== 权限检查和提权 ====================
; 检查是否具有管理员权限，如果没有则自动提权
if !A_IsAdmin {
    try {
        ; 以管理员权限重新运行脚本
        Run *RunAs "%A_AhkPath%" "%A_ScriptFullPath%"
        ExitApp
    } catch {
        MsgBox, 16, 权限错误, 无法获取管理员权限。`n请手动以管理员身份运行此脚本。
        ExitApp
    }
}

; ==================== AutoHotkey 指令 ====================
; 确保只有一个脚本实例运行，防止重复启动
#SingleInstance Force
; 保持脚本持续运行，即使没有热键或定时器
#Persistent
; 禁用环境变量读取，提高性能
#NoEnv

; ==================== 库文件包含 ====================
#Include lib
; 包含CapsLock功能库，提供macOS风格的CapsLock行为
#Include CapsLockLib.ahk
; 将Ctrl组合常用功能键映射为 Alt触发
#Include KeyboardHook.ahk

; ==================== 功能初始化 ====================
; 初始化macOS风格CapsLock功能
InitMacOSCapsLock()

; 初始化键盘钩子功能
InitKeyboardHook()
; Sleep, 1000  ; 等待1000毫秒确保初始化完成
; 启动窗口监控
try {
    StartWindowMonitoring()  ; 启动窗口监控
    OutputDebug, TEXT(成功, 窗口监控已成功启动)
} catch e {
    OutputDebug, TEXT(错误, 启动窗口监控时出错: %e%)
}

