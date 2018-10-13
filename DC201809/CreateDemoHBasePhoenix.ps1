#1. Configure blob storage (main storage)
#2. configure data lake storage (additional storage)

#Login-AzureRmAccount

$subscriptionId = "b9c472f8-5d43-4435-8d5e-c661d8c7aa3d";
Select-AzureRmSubscription -SubscriptionId $subscriptionId
$tenantID = (Get-AzureRmContext).Tenant.TenantId

$resourceGroupName = "demos"
$storageAccountName = "bsdemos"
$storageKey ="ZdQeLDJiyybgxveBQRSvBltT1P6mh2dzlA9wKcTxpxC8GxHwJIhdUrnCxriYpSTxfBBUF4AXI2GZPYA4EaM8Uw=="

$containerName = "demo-labs-hbase-phoenix"

$clusterType = "HBase"

$clusterName = "demo-labs-hbase-phoenix"    # As a best practice, have the same name for the cluster and container
$clusterNodes = 2               # The number of nodes in the HDInsight cluster
$clusterNodeSize = "Standard_D13_v2" #Get-AzureRmVMSize
$headNodeSize = "Standard_D13_v2"
$zookeeperNodeSize ="Standard_A2"
 
#Credentials
$adminUser = "admin"
$adminsshUser ="sshuser"
$adminPass = "GQrGYHQ4HgmOgygyI4vy," | ConvertTo-SecureString -asPlainText -Force



#ADL Credentials
$certificateFilePath = "d:\\Repos\\Temp\\HDI-Hive-LLAP\\Certs\\MDMSecurityPrinciple.p12"
$password = "Monday!123" # Read-Host –Prompt "Enter the certificate password" 
$adlPrincipleAppUri ="https://demoUser"

$httpCredentials = new-object System.Management.Automation.PSCredential($adminUser, $adminPass)
$sshCredentials = new-object System.Management.Automation.PSCredential($adminsshUser, $adminPass)


Write-Output("Starting...")

$storageAccountKey = (Get-AzureRmStorageAccountKey -Name $storageAccountName -ResourceGroupName $resourceGroupName)[0].Value
$location = (Get-AzureRmStorageAccount -Name $storageAccountName -ResourceGroupName $resourceGroupName).Location

(Get-AzureRmADApplication -IdentifierUri $adlPrincipleAppUri).ApplicationId
#data lake security principal
#$applicationId = (Get-AzureRmADApplication -IdentifierUri $adlPrincipleAppUri).ApplicationId
$applicationId ="1c7e3b83-712f-4fa3-8650-31430e5e425d"

$objectid = (Get-AzureRmADServicePrincipal -ServicePrincipalName $applicationId).Id




$config = New-AzureRmHDInsightClusterConfig -ClusterType $clusterType


#-Config $config `
                             
New-AzureRmHDInsightCluster -ClusterName $clusterName `
                             -ResourceGroupName $resourceGroupName `
                             -HttpCredential $httpCredentials `
                             -Location $location `
                             -Config $config `
                             -DefaultStorageAccountName "$storageAccountName.blob.core.windows.net" `
                             -DefaultStorageAccountKey $storageAccountKey `
                             -DefaultStorageContainer $containerName `
                             -ClusterSizeInNodes $clusterNodes `
                             -Version "3.6" `
                             -OSType Linux `
                             -SshCredential $sshCredentials `
                             -HeadNodeSize $headNodeSize `
                             -WorkerNodeSize $clusterNodeSize `
                             -ZookeeperNodeSize $zookeeperNodeSize `
                             -ObjectID $objectId `
                             -AadTenantId $tenantID `
                             -CertificateFilePath $certificateFilePath `
                             -CertificatePassword $password  `
                             -Debug 
