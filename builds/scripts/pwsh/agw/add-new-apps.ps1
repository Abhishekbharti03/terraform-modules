# Login to your Azure account
#Connect-AzAccount
Set-AzContext ###subscription name

# app specific
$appname = #app name
$frontendurl = #frontendurl
$backendtarget = ##backendtarget

# usually shared. for slots it'll usually point to the parent settings
$certname = #cert name
$healthProbe = #healthprobe

# Get the existing app gateway
$appgw = Get-AzApplicationGateway -Name "agw" -ResourceGroupName "agw-RGRP"

function Get-NewOrExistingAppGwBackendPool {
    param (
        [Parameter(Mandatory = $true)]
        [string]$name,
        [Parameter(Mandatory = $true)]
        [string]$target,
        [Parameter(Mandatory = $true)]
        [Microsoft.Azure.Commands.Network.Models.PSApplicationGateway]$appgw
    )

    $ErrorActionPreference = 'SilentlyContinue'
    try {
        $pool = Get-AzApplicationGatewayBackendAddressPool -ApplicationGateway $appgw -Name $name         
    }
    catch {
        # write to the console that a pool was not found
        write-host "Backend pool not found -- ok if this is new" -foregroundcolor Yellow        
    }
    $ErrorActionPreference = 'Continue'
    
    if ($null -eq $pool) {
        # Create a new backend pool
        Add-AzApplicationGatewayBackendAddressPool -ApplicationGateway $appgw -Name $name -BackendFqdns $target
        # get it again
        $pool = Get-AzApplicationGatewayBackendAddressPool -ApplicationGateway $appgw -Name $name
    }
    return $pool
}

function Get-NewOrExistingAppGwBackendHttpSettings {
    param (
        [Parameter(Mandatory = $true)]
        [string]$name,
        [Parameter(Mandatory = $true)]
        [Microsoft.Azure.Commands.Network.Models.PSApplicationGateway]$appgw
    )
    $ErrorActionPreference = 'SilentlyContinue'
    try {
        
        $settings = Get-AzApplicationGatewayBackendHttpSetting -ApplicationGateway $appgw -Name $name
    }
    catch {
        # write to the console that a pool was not found
        write-host "Settings not found -- ok if this is new" -foregroundcolor Yellow        
    }
    $ErrorActionPreference = 'Continue'

    if ($null -eq $settings) {
        # Get the existing probe
        $probe = Get-AzApplicationGatewayProbeConfig -Name $healthProbe -ApplicationGateway $appgw
        # Create a new backend http settings object
        Add-AzApplicationGatewayBackendHttpSetting -ApplicationGateway $appgw -Name $name  -Port 443 -Protocol Https -PickHostNameFromBackendAddress -CookieBasedAffinity Disabled  -Probe $probe
        # get it again
        $settings = Get-AzApplicationGatewayBackendHttpSetting -ApplicationGateway $appgw -Name $name
    }
    return $settings
}

function Get-NewOrExistingAppGwHttpListener {
    param (
        [Parameter(Mandatory = $true)]
        [string]$name,
        [Parameter(Mandatory = $true)]
        [Microsoft.Azure.Commands.Network.Models.PSApplicationGateway]$appgw
    )
    $ErrorActionPreference = 'SilentlyContinue'
    try {
        
        $listener = Get-AzApplicationGatewayHttpListener -ApplicationGateway $appgw -Name $name
    }
    catch {
        # write to the console that a pool was not found
        write-host "listener not found -- ok if this is new" -foregroundcolor Yellow        
    }
    $ErrorActionPreference = 'Continue'

    if ($null -eq $listener) {
        # get the cert
        $cert = Get-AzApplicationGatewaySslCertificate -Name $certname -ApplicationGateway $appgw
        if ($null -eq $cert) {
            write-host "Certificate not found" -foregroundcolor red
            exit
        }
        # Get the front-end IP configuration by name
        $ipconfig = Get-AzApplicationGatewayFrontendIPConfig -ApplicationGateway $appgw -Name "appGatewayFrontendIP"
        if ($null -eq $ipconfig) {
            write-host "Front-end IP configuration not found" -foregroundcolor red
            exit
        }
        # Get the front-end port by name
        $port = Get-AzApplicationGatewayFrontendPort -ApplicationGateway $appgw -Name "port_443"
        if ($null -eq $port) {
            write-host "Front-end port not found" -foregroundcolor red
            exit
        }

        # Create a new listener
        Add-AzApplicationGatewayHttpListener -ApplicationGateway $appgw -Name $name -Protocol Https -SslCertificate $cert -HostName $frontendurl -RequireServerNameIndication false  -FrontendIPConfiguration $ipconfig -FrontendPort $port
        # get it again
        $listener = Get-AzApplicationGatewayHttpListener -ApplicationGateway $appgw -Name $name
    }
    return $listener
}

function Get-NewOrExistingAppGwRule {
    param (
        [Parameter(Mandatory = $true)]
        [string]$name,
        [Parameter(Mandatory = $true)]
        [Microsoft.Azure.Commands.Network.Models.PSApplicationGateway]$appgw,
        [Parameter(Mandatory = $true)]
        [Microsoft.Azure.Commands.Network.Models.PSApplicationGatewayHttpListener] $listener,
        [Parameter(Mandatory = $true)]
        [Microsoft.Azure.Commands.Network.Models.PSApplicationGatewayBackendAddressPool] $pool,
        [parameter(Mandatory = $true)]
        [Microsoft.Azure.Commands.Network.Models.PSApplicationGatewayBackendHttpSettings] $settings,
        [Parameter(Mandatory = $true)]
        [int]$priority
    )
    $ErrorActionPreference = 'SilentlyContinue'
    try {
        $rule = Get-AzApplicationGatewayRequestRoutingRule -ApplicationGateway $appgw -Name $name
    }
    catch {
        # write to the console that a pool was not found
        write-host "rule not found -- ok if this is new" -foregroundcolor Yellow        
    }
    $ErrorActionPreference = 'Continue'

    if ($null -eq $rule) {
        # Create a new rule
        Add-AzApplicationGatewayRequestRoutingRule -ApplicationGateway $appgw -Name $name -RuleType Basic -HttpListener $listener -BackendAddressPool $pool -BackendHttpSettings $settings -Priority $priority
        # get it again
        $rule = Get-AzApplicationGatewayRequestRoutingRule -ApplicationGateway $appgw -Name $name
    }
    return $rule
}

$pool = Get-NewOrExistingAppGwBackendPool -name $appname -target $backendtarget -appgw $appgw
$settings = Get-NewOrExistingAppGwBackendHttpSettings -name $appname -appgw $appgw
$listener = Get-NewOrExistingAppGwHttpListener -name $appname -appgw $appgw

# save the changes so far if there are any
write-host "Save the listener, backend pool and settings changes to the app gateway..."
Set-AzApplicationGateway -ApplicationGateway $appgw

# find the highest priority of the existing rules
$maxPriority = 0
$rules = Get-AzApplicationGatewayRequestRoutingRule -ApplicationGateway $appgw
foreach ($r in $rules) {
    if ($r.Priority -gt $maxPriority) {
        $maxPriority = $r.Priority
    }
}
$priority = $maxPriority + 1

$rule = Get-NewOrExistingAppGwRule -name $appname -appgw $appgw -listener $listener -pool $pool -settings $settings -priority $priority

# Update the app gateway
try {
    Set-AzApplicationGateway -ApplicationGateway $appgw
    Write-Host "Application Gateway Updated" -ForegroundColor Green
}
catch {
    #write the exception
    Write-Host $_.Exception.Message
}