$SubscriptionName = "fb0d606c-7066-43ce-8b87-9112fe309305"
$ResGrpName = "bigdataplatform"
$Namespace  = "bdpmydevlabs"
$Location = "North Europe"
$EventHubName = "mydemodevices"
$ConsumerGroupName = "mdevices"
$AuthRuleName = "MyAuthRuleName"
Login-AzureRmAccount
Select-AzureRmSubscription -SubscriptionName $SubscriptionName


# Query to see if the namespace currently exists
$CurrentNamespace = Get-AzureRMEventHubNamespace -ResourceGroupName $ResGrpName -NamespaceName $Namespace

