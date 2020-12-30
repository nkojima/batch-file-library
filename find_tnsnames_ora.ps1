# ------------------------------------------------------------------------------
# tnsnames.oraの保管場所を探すスクリプト
# ------------------------------------------------------------------------------

Write-Host 'tnsnames.oraの保管場所を探索します...'

try {
    # 1. tnspingコマンドの存在（＝Oracleクライアントの存在）を確認する。
    #    tnspingコマンドが無い場合はエラーとなるため、catch句に飛ばされる。
    #    ※「-ErrorAction "Stop"」を付けることで、終了しないエラー（Non-terminating Errors）をcatch句で補足できるようにしている。
    $tnsPing = Get-Command tnsping -ErrorAction "Stop"
}
catch
{
    Write-Host 'Oracleクライアントがインストールされているか確認してください。'
    exit
}

# 2. tnspingコマンドの実行結果から、sqlnet.oraのパスを取得する。
$pingResult = tnsping aaa
$pingResultArray = $pingResult.Split("`r`n")

$existsTnsnames = $false

foreach ($row in $pingResultArray)
{
    if ( $row -like '*sqlnet.ora')
    {
        # 3. sqlnet.oraの保管フォルダにtnsnames.oraがあるかを確認する。
        $tnsnamesPath = Join-Path (Split-Path -Parent $row) tnsnames.ora

        if (Test-Path $tnsnamesPath)
        {
            Write-Host 'tnsnames.oraは以下の場所にありました。'
            Write-Host $tnsnamesPath
            $existsTnsnames = $true
        }
    }
}

# 4. sqlnet.oraの保管フォルダにtnsnames.oraが見つからない時は、tnsnames.oraの探索を終了する。
if (!$existsTnsnames)
{
    Write-Host 'tnsnames.oraは見つかりませんでした。'
}

Read-Host "処理が完了しました..."