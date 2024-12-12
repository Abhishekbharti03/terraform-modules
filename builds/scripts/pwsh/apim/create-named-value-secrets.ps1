param(
    [Parameter(Mandatory = $true)]
    [string]$apimResourceGroupName,
    [Parameter(Mandatory = $true)]
    [string]$apimName,
    [Parameter(Mandatory = $true)]
    [string]$azureFunctionResourceGroupName,
    [Parameter(Mandatory = $true)]
    [string]$azureFunctionName,
    [Parameter(Mandatory = $false)]
    [string[]] $appSlots
)
if ($appSlots -eq $null) {
    $appSlots = @("qa", "iat")
}
$functionKey = az functionapp keys list -g $azureFunctionResourceGroupName -n $azureFunctionName --query 'functionKeys' -o tsv
$namedValueName = "$azureFunctionName-key".ToUpper()
az apim nv create --service-name $apimName -g $apimResourceGroupName --named-value-id $namedValueName  --display-name $namedValueName --value $functionKey --secret true

$originalApimName = $apimName
$originalApimResourceGroupName = $apimResourceGroupName

foreach ($slot in $appSlots) {
    if ($originalApimName.ToUpper() -like "*-D-*") {
        Write-Host $slot
        $apimName = $originalApimName.ToUpper().Replace("-D", "-" + $slot.ToUpper()[0])
        Write-Host $apimName
        $apimResourceGroupName = $originalApimResourceGroupName.ToUpper().Replace("-D", "-" + $slot.ToUpper()[0])
        Write-Host $apimResourceGroupName
        $functionKey = az functionapp keys list -g $azureFunctionResourceGroupName -n $azureFunctionName --slot $slot --query 'functionKeys' -o tsv
        $namedValueName = "$azureFunctionName-$slot-key".ToUpper()
        az apim nv create --service-name $apimName -g $apimResourceGroupName --named-value-id $namedValueName  --display-name $namedValueName --value $functionKey --secret true
    }
}