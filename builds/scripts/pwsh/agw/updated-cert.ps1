$subscription = ##subscription
 
$rg = # AGW RGRP
$agw =  # AGW Name
#  Set-AzContext 'WTW-CRBCFT-PROD'
$agww1 = Get-AzApplicationGateway -Name $agw -ResourceGroupName $rg
 
#Get the Cert name using wildcard
 
Get-AzApplicationGatewaySslCertificate -ApplicationGateway $agww1 | Where-Object Name -Like "*example*" | fl *
 
#Certificate Name

$appSSLCert =  #update the listener cert name here
 
#$appKVSecretId =  (Get-AzKeyVaultCertificate -VaultName $keyvault -Name $appSSLCert)
 
#Add the KeyVault Secret ID for the variable $appKVSecretId
 
$appKVSecretId = #keyvault secret id

az network application-gateway ssl-cert create --resource-group $rg --gateway-name $agw --name $appSSLCert --key-vault-secret-id $appKVSecretId