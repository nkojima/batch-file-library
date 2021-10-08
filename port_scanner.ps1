# 簡易ポートスキャナ

$target_host = "192.168.10.240"

# 調査対象のポート番号
$target_ports = @("22", "80", "443")

# 22番ポート（SSH）が開放されているかを確認する。
Write-Output ("[Target Host] " + $target_host);

foreach($port in $target_ports)
{
    $result = Test-NetConnection -ComputerName $target_host -Port $port;
    
    if ( $result.TcpTestSucceeded -eq "True" )
    {
        Write-Output ([string]$result.RemotePort + ",Open");
    }
    else
    {
        Write-Output ([string]$result.RemotePort + ",Closed");
    }
}

#Pause;