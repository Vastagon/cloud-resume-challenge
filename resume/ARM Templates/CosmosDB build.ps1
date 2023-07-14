$rg = "ResumeWebsite";
$websiteStorageName = "vastagonresumewebsite";


az deployment group create --resource-group $rg --template-file ".\CosmosDB\template.json";
