rem -------------------------------------------------------------------------------
rem ハードウェア情報を取得する。
rem
rem [参考URL] https://webbibouroku.com/Blog/Article/cmd-cpu-os-product
rem -------------------------------------------------------------------------------

echo [CPU Info]
wmic CPU get Name | findstr /C:"AMD" /C:"Intel"

echo [Memory Info]
wmic computersystem get TotalPhysicalMemory | findstr ^[0-9]