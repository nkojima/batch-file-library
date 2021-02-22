# ------------------------------------------------------------------------------
# ノートPCのバッテリーの消耗具合を見るためのスクリプト。
# ------------------------------------------------------------------------------

# powercfgコマンドの実行結果の一時保存先。
$TEMP_FILE = './battery_report.xml'

# powercfgコマンドを実行して、XML形式で実行結果を取得する。
# powercfgコマンド実行時のメッセージが標準出力されないように、パイプでOut-Nullに渡している。
Write-Host 'ノートPCのバッテリーの消耗具合を確認します...'
powercfg /batteryreport /xml /output $TEMP_FILE | Out-Null

# XMLを解析して、設計時の容量（DESIGN CAPACITY）と満充電時の容量（FULL CHARGE CAPACITY）を取得する。
# バッテリーは1つしか存在しないと仮定して、Batteries.FirstChildで取得している。
$battery_xml = [xml](Get-Content $TEMP_FILE)
$design_capacity = $battery_xml.BatteryReport.Batteries.FirstChild.DesignCapacity
$full_charge_capacity = $battery_xml.BatteryReport.Batteries.FirstChild.FullChargeCapacity

$attenuation_rate = ($design_capacity - $full_charge_capacity) / $design_capacity * 100
$attenuation_rate = [Math]::Truncate($attenuation_rate * 10) / 10; # 小数点第一位までに揃える。

# powercfgコマンドの実行結果のファイルを削除する。
Remove-Item -Path $TEMP_FILE

# バッテリーの消耗具合（%）を出力する。
Write-Host "このPCのバッテリーの最大容量は$attenuation_rate％減少しています。"
Write-Host "設計時の容量（DESIGN CAPACITY）：$design_capacity"
Write-Host "満充電時の容量（FULL CHARGE CAPACITY）：$full_charge_capacity"