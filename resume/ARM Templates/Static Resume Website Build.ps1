# Run all of these in ARM Templates folder
$rg = ResumeWebsite
$websiteStorageName = vastagonresumewebsite

./node_modules/.bin/cypress open

### Check set Subscription
# az account show --output table
### Change active Subscription
# az account set --subscription "Pay as you go Production"
# Set-AzContext -Subscription "Pay as you go Development"

### Deploy Resume Website Resource Group
az group create --name $rg --location eastus

### Deploy Storage Container for static website
az deployment group create --resource-group Resume --template-file ".\Resume Website\Resume Website Storage Account\template.json"

### Login to azcopy with
# ./azcopy login --tenant-id=<tenant-id>

### Copy files to storage with AZ Copy
# ./azcopy copy "../resume.html" "https://vastagonresumewebsite.blob.core.windows.net/%24web"
# ./azcopy copy "../resume.css" "https://vastagonresumewebsite.blob.core.windows.net/%24web"

# Set-AzCurrentStorageAccount -ResourceGroupName $rg -Name $websiteStorageName
# Enable-AzStorageStaticWebsite -IndexDocument "resume.html"


# Login with admin creds before running the following
./azcopy login --tenant-id=<tenant-id>


# All commands in order
$rg = "ResumeWebsite";
$websiteStorageName = "vastagonresumewebsite";

az group create --name $rg --location eastus;
az deployment group create --resource-group $rg --template-file ".\Resume Website\Resume Website Storage Account\template.json";

Set-AzCurrentStorageAccount -ResourceGroupName $rg -Name $websiteStorageName;
Enable-AzStorageStaticWebsite -IndexDocument "resume.html";

./azcopy copy "../Resume Code/resume.html" "https://vastagonresumewebsite.blob.core.windows.net/%24web";
./azcopy copy "../Resume Code/resume.css" "https://vastagonresumewebsite.blob.core.windows.net/%24web";

az deployment group create --resource-group $rg --template-file ".\Resume Website\Resume Website Microsoft CDN (classic)\template.json";



### Creating temporary website for testing
$rg = "ResumeWebsite";
$websiteTestingStorageName = "testresumevastagon";
az deployment group create --resource-group $rg --template-file ".\Resume Website\Resume Website Storage Account\template.json" --parameters ".\Resume Website\Resume Website Storage Account\testingparameters.json";
# Enabling static website
az storage blob service-properties update --account-name $websiteTestingStorageName --static-website --index-document resume.html
    # Set-AzCurrentStorageAccount -ResourceGroupName $rg -Name $websiteTestingStorageName;
    # Enable-AzStorageStaticWebsite -IndexDocument "resume.html";
# Adding files
az storage blob upload-batch --account-name $websiteTestingStorageName --auth-mode key -d '$web' -s "./resume/Resume Code" --overwrite

### Run the tests on: https://testresumevastagon.z13.web.core.windows.net/

# Delete temp website
az storage account delete --name $websiteTestingStorageName --resource-group $rg
