$rg = "ResumeWebsiteAPI";
$websiteStorageName = "vastagonresumewebsite";
$rg = "ResumeWebsiteAPI";
$accountName = "resumecosmosvastagon"

# Create API resource group
az group create --name $rg --location eastus;

# Create storage account called resumefunctionvastagon

# Create CosmosDB database and container
az deployment group create --resource-group $rg --template-file ".\CosmosDB\template.json";

# Create Function App with in binding to increase the counter stored in NoSQL CosmosDB






# Get the connection string on newly created CosmosDB

# Fix the context and locations when I can actually put things where I want them after throttle is over
Set-AzContext -Subscription "Pay as you go Production"

$cosmosDBConnectionString = (Get-AzCosmosDBAccountKey -ResourceGroupName $rg -Name $accountName -Type "ConnectionStrings")."Primary SQL Connection String"
# Updates FunctionAppSetting for the connection string
Set-AzContext -Subscription "Pay as you go Development"
Update-AzFunctionAppSetting -Name "testvastagon" -ResourceGroupName "test" -AppSetting @{"CosmosDbConnectionString" = $cosmosDBConnectionString}
