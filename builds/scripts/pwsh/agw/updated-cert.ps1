$subscription = 'WTW-CRBCFT-PROD'
 
$rg = "CRBCFT-DCS-EM22-P-RGRP" # AGW RGRP
$agw = "CRBCFT-DCS-EM22-P-AGW01" # AGW Name
#  Set-AzContext 'WTW-CRBCFT-PROD'
$agww1 = Get-AzApplicationGateway -Name $agw -ResourceGroupName $rg
 
#Get the Cert name using wildcard
 
Get-AzApplicationGatewaySslCertificate -ApplicationGateway $agww1 | Where-Object Name -Like "*cms*" | fl *
 
#Certificate Name
$appSSLCert = "cms" #update the listener cert name here
 
#$appKVSecretId =  (Get-AzKeyVaultCertificate -VaultName $keyvault -Name $appSSLCert)
 
#Add the KeyVault Secret ID for the variable $appKVSecretId
 
$appKVSecretId = "https://wtw-cft-uk-s-kv-cer.vault.azure.net/secrets/cms/655a202a1a2f4794b5049159533ac169"

az network application-gateway ssl-cert create --resource-group $rg --gateway-name $agw --name $appSSLCert --key-vault-secret-id $appKVSecretId