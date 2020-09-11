<#
.DESCRIPTION
  检查 wsl2 /etc/hosts 的 `wsl2.k8s.khs1994.com` `windows.k8s.khs1994.com` ip 是否正确
#>

Import-Module $PSScriptRoot/WSL-K8S.psm1

# Invoke-WSL bash -c `
# "cat /etc/hosts | grep -q 'wsl2.k8s.khs1994.com' && ping -c 1 wsl2.k8s.khs1994.com -W 1" | out-null

# if(!$?){
write-host "==> set WSL2 /etc/hosts wsl2.k8s.khs1994.com ..." -ForegroundColor Green
$WSL2_IP = & $PSScriptRoot/wsl2host

Invoke-WSL echo $WSL2_IP wsl2 wsl2.k8s.khs1994.com `>`> /etc/hosts
# }

Invoke-WSL bash -c `
  "cat /etc/hosts | grep -q 'wsl2.k8s.khs1994.com' && ping -c 1 windows.k8s.khs1994.com -W 1" | out-null

# if(!$?){
write-host "==> set WSL2 /etc/hosts windows.k8s.khs1994.com ..." -ForegroundColor Green

$WINDOWS_IP = Invoke-WSL cat /etc/resolv.conf `| grep nameserver `| cut -d ' ' -f 2

Invoke-WSL echo $WINDOWS_IP windows.k8s.khs1994.com `>`> /etc/hosts
# }
