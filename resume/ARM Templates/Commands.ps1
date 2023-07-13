# Run all of these in ARM Templates folder
$rg = ResumeWebsite
$websiteStorageName = vastagonresumewebsite

### Check set Subscription
# az account show --output table
### Change active Subscription
# az account set --subscription "Pay as you go Production"

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

./azcopy copy "../resume.html" "https://vastagonresumewebsite.blob.core.windows.net/%24web";
./azcopy copy "../resume.css" "https://vastagonresumewebsite.blob.core.windows.net/%24web";

az deployment group create --resource-group $rg --template-file ".\Resume Website\Resume Website Microsoft CDN (classic)\template.json";

