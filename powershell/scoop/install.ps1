###  windows install packages with scoop 

set-executionpolicy unrestricted -force

Invoke-Expression (new-object net.webclient).downloadstring('https://get.scoop.sh')

### console theme

scoop install concfg pshazz
concfg import solarized small

### Dev-tools
scoop bucket add extras
scoop install sublime-text 
scoop install git sudo nodejs gow 
scoop install azure-cli azure-ps
scoop install dotnet-sdk


