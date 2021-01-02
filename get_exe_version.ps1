# ------------------------------------------------------------------------------
# 指定したフォルダ内のexeとdllのバージョン情報をCSVに出力するスクリプト。
# ------------------------------------------------------------------------------

Write-Host 'exeとdllのバージョン情報をCSVに出力します...'

# 処理対象となるEXEの保管フォルダ
$targetFolder = 'C:\test';

# 1. 処理対象フォルダが無ければ処理を中断する。
if (!(Test-Path $targetFolder))
{
    Read-Host '処理対象フォルダがないため、処理を中断します。'
    exit
}

# 出力先となるファイルパス
$formattedDate = (Get-Date).ToString("yyyyMMdd")
$fileName = "exe_version_" + $formattedDate + ".txt"
$outputFile = Join-Path ([Environment]::GetFolderPath('Desktop')) $fileName;

# 2. 処理対象となるフォルダ内から、拡張子が.exeと.dllのファイルのみを抽出する。
$files = Get-ChildItem $targetFolder\*.* -Include @("*.exe","*.dll");

$sb = New-Object System.Text.StringBuilder
$sb.Append("ファイル名,ファイルバージョン,製品バージョン,最終更新日`r`n") > $null    # コマンドラインの出力を捨てる

# 3. ファイル名/ファイルバージョン/製品バージョン/最終更新日を取得する。
foreach ($file in $files)
{
    $row = ""
    $row += $file.Name + ",";
    $row += (Get-ItemProperty $file).VersionInfo.FileVersion + ",";
    $row += (Get-ItemProperty $file).VersionInfo.ProductVersion + ",";
    $row += $file.LastWriteTime.ToString() + "`r`n";
    $sb.Append($row) > $null    # コマンドラインの出力を捨てる
}

# 4. バージョン情報を「exe_version.txt」に出力する。
echo $sb.ToString() > $outputFile;

Write-Host '出力先ファイル名：'$outputFile
Read-Host '処理が完了しました...'