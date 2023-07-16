$rg = "ResumeWebsiteAPI";
$websiteStorageName = "vastagonresumewebsite";
$accountName = "resumecosmosvastagon"

# Create API resource group
az group create --name $rg --location eastus;

# Create storage account called resumefunctionvastagon

# Create CosmosDB database and container
az deployment group create --resource-group $rg --template-file ".\CosmosDB\template.json";

# Create Function App with in binding to increase the counter stored in NoSQL CosmosDB
# az deployment group create --resource-group ResumeWebsiteAPI --template-file ".\Azure Functions\template.json" --parameters ".\Azure Functions\parameters.json"
### CREATE THE FUNCTION APP YOURSELF USING THE CODE IN InputTrigger. Make sure CORS only works with the website's URI


# Fix the context and locations when I can actually put things where I want them after throttle is over

## Updates FunctionAppSetting for the connection string
$accountName = "resumecosmosvastagon"
$cosmosDBConnectionString = (Get-AzCosmosDBAccountKey -ResourceGroupName $rg -Name $accountName -Type "ConnectionStrings")."Primary SQL Connection String"
Update-AzFunctionAppSetting -Name "vastagonresumecountapi" -ResourceGroupName $rg -AppSetting @{"CosmosDbConnectionString" = $cosmosDBConnectionString }


# Alert rules and groups
### CREATE NEW TEMPLATES WHEN NO LONGER BEING THROTTLED
New-AzResourceGroupDeployment -ResourceGroupName $rg -TemplateFile ".\Monitoring\APIActionGroup\template.json"
New-AzResourceGroupDeployment -ResourceGroupName $rg -TemplateFile ".\Monitoring\API Latency\template.json"
