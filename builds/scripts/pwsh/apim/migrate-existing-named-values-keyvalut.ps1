param(
    [Parameter(Mandatory = $true)]
    [string]$resourceGroupName,
    [Parameter(Mandatory = $true)]
    [string]$apimServiceName,
    [Parameter(Mandatory = $true)]
    [string]$keyVaultName
)

# List of named values to process
$namedValuesList = @("PlatformServices.Workflow", "wtw-cft-uk-s-dev-mks-onboard-automation-app-key")

# Create the APIM context
$apimContext = New-AzApiManagementContext -ResourceGroupName $resourceGroupName -ServiceName $apimServiceName

foreach ($targetNamedValue in $namedValuesList) {
    Write-Output "Processing named value: $targetNamedValue"
    
    # Get the specific named value
    $namedValue = Get-AzApiManagementNamedValue -Context $apimContext | Where-Object { $_.Name -eq $targetNamedValue }

    if ($null -ne $namedValue) {
        if ($namedValue.Secret) {
            # Get the secret value from APIM
            $secretValueObject = Get-AzApiManagementNamedValueSecretValue -Context $apimContext -NamedValueId $namedValue.NamedValueId
            $secretValue = $secretValueObject.Value

            # Store the secret in Key Vault
            $keyVaultSecret = Set-AzKeyVaultSecret -VaultName $keyVaultName -Name $namedValue.Name -SecretValue (ConvertTo-SecureString $secretValue -AsPlainText -Force)

            Write-Output "Secret $($namedValue.Name) moved to Key Vault."

            # Construct the Key Vault secret reference
            $keyVaultSecretUri = $keyVaultSecret.Id
            $keyVaultReference = "@Microsoft.KeyVault(SecretUri=$keyVaultSecretUri)"

            # Update the named value in APIM to reference the Key Vault secret
            Set-AzApiManagementNamedValue -Context $apimContext -NamedValueId $namedValue.NamedValueId -Value $keyVaultReference -Secret $false

            Write-Output "APIM named value $($namedValue.Name) updated to reference Key Vault secret."
        } else {
            Write-Output "APIM named value $($namedValue.Name) is not a secret or is already in Key Vault."
        }
    } else {
        Write-Output "Named value '$targetNamedValue' not found in APIM."
    }

    # Construct the secret identifier for the Key Vault secret
    $secretIdentifier = "https://$keyVaultName.vault.azure.net/secrets/$targetNamedValue"

    # Create a Key Vault object for the secret
    $keyvault = New-AzApiManagementKeyVaultObject -SecretIdentifier $secretIdentifier

    # Create the new named value in APIM, referencing the Key Vault secret
    try {
        $keyVaultNamedValue = New-AzApiManagementNamedValue -Context $apimContext -Name $targetNamedValue -NamedValueId $targetNamedValue -KeyVault $keyvault -Secret
        Write-Output "New APIM named value '$targetNamedValue' created as a Key Vault reference."
    } catch {
        Write-Error "Failed to create named value '$targetNamedValue'. Error: $_"
    }
}