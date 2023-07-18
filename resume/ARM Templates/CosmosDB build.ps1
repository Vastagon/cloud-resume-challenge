$rg = "ResumeWebsiteAPI";
$websiteStorageName = "vastagonresumewebsite";
$accountName = "resumecosmosvastagon"

# Create API resource group
az group create --name $rg --location eastus;

# Create storage account called resumefunctionvastagon

# Create CosmosDB database and container
az deployment group create --resource-group $rg --template-file ".\CosmosDB\template.json";

# Create Function App with in binding to increase the counter stored in NoSQL CosmosDB
$templateUri = ".\Azure Functions\template.json"
$rg = "ResumeWebsiteAPI";
$FunctionFilePath = "..\..\InputTrigger\__init__.py"
New-AzResourceGroupDeployment -ResourceGroupName $rg -TemplateFile $templateUri
### CREATE THE FUNCTION APP YOURSELF USING THE CODE IN InputTrigger. Make sure CORS only works with the website's URI
$FunctionFilePath = "D:\Code\cloud-resume-challenge\InputTrigger\__init__.py"

# Get the content for the function
$FunctionFilePath = "..\..\InputTrigger\__init__.py"
$FunctionFileContent = Get-Content -Path $FunctionFilePath
az deployment group create --subscription "Pay as you go Production" --resource-group $rg --template-file $templateUri --parameters ((@{ __init__file = $FunctionFileContent }))



# Fix the context and locations when I can actually put things where I want them after throttle is over

## Updates FunctionAppSetting for the connection string
$accountName = "resumecosmosvastagon"
$cosmosDBConnectionString = (Get-AzCosmosDBAccountKey -ResourceGroupName $rg -Name $accountName -Type "ConnectionStrings")."Primary SQL Connection String"
Update-AzFunctionAppSetting -Name "vastagonresumecountapi" -ResourceGroupName $rg -AppSetting @{"CosmosDbConnectionString" = $cosmosDBConnectionString }


# Alert rules and groups
### CREATE NEW TEMPLATES WHEN NO LONGER BEING THROTTLED
New-AzResourceGroupDeployment -ResourceGroupName $rg -TemplateFile ".\Monitoring\APIActionGroup\template.json"
New-AzResourceGroupDeployment -ResourceGroupName $rg -TemplateFile ".\Monitoring\API Latency\template.json"




"files": {
    "__init__.py": "import azure.functions as func \n\n\ndef main(req: func.HttpRequest, inputDocument: func.DocumentList):\n    if inputDocument:\n        totalCount = inputDocument[0]\n        updatedCount = totalCount['count']\n        updatedCount = updatedCount + 1\n\n        totalCount['count'] = updatedCount\n        return totalCount\n    else:\n        return func.Document.from_dict({'id': 'count', 'count': 0})\n"
}


$templateUri = ".\Azure Functions\template.json"
$rg = "ResumeWebsiteAPI";
$accountName = "resumecosmosvastagon"
$FunctionFilePath = "..\..\InputTrigger\__init__.py"

# Get the content for the function
$FunctionFileContent = Get-Content -Path $FunctionFilePath
# Get connection string
$cosmosDBConnectionString = (Get-AzCosmosDBAccountKey -ResourceGroupName $rg -Name $accountName -Type "ConnectionStrings")."Primary SQL Connection String"
# Deploy the Function app
az deployment group create --subscription "Pay as you go Production" --resource-group $rg --template-file $templateUri --parameters initpy=$FunctionFileContent cosmosDBConnectionString=$cosmosDBConnectionString




# ## Updates FunctionAppSetting for the connection string
# $cosmosDBConnectionString = (Get-AzCosmosDBAccountKey -ResourceGroupName $rg -Name $accountName -Type "ConnectionStrings")."Primary SQL Connection String"
# Update-AzFunctionAppSetting -Name "vastagonresumecountapi" -ResourceGroupName $rg -AppSetting @{"CosmosDbConnectionString" = $cosmosDBConnectionString }




## MIGHT BE ABLE TO CREATE A FOREACH THAT ADDS \n TO EACH LINE




import azure.functions as func \n\n\ndef main(req: func.HttpRequest, inputDocument: func.DocumentList):\n    if inputDocument:\n        totalCount = inputDocument[0]\n        updatedCount = totalCount['count']\n        updatedCount = updatedCount + 1\n\n        totalCount['count'] = updatedCount\n        return totalCount\n    else:\n        return func.Document.from_dict({ 'id': 'count', 'count': 0 })\n




import azure.functions as func

    
def main(req: func.HttpRequest, inputDocument: func.DocumentList):
if inputDocument:
totalCount = inputDocument[0]
updatedCount = totalCount['count']
updatedCount = updatedCount + 1

totalCount['count'] = updatedCount
return totalCount
else:
return func.Document.from_dict({ "id": "count", "count": 0 })
    


# temp = """
# import azure.functions as func \n
# \n
# \n
# def main(req: func.HttpRequest, inputDocument: func.DocumentList):\n
#     if inputDocument:\n
#         totalCount = inputDocument[0]\n
#         updatedCount = totalCount['count']\n
#         updatedCount = updatedCount + 1\n
# \n
#         totalCount['count'] = updatedCount\n
#         return totalCount\n
#     else:\n
#         return func.Document.from_dict({"id": "count", "count": 0})\n
# """