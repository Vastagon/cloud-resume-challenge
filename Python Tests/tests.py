import requests
import json
### Make sure to temporarily allow CORS when testing



def testAPI():
    url = "https://vastagonresumecountapi.azurewebsites.net/api/UpdateVisitCount?code=vkWbdknVU5eE-hHjIGv3-_SYny77exqri0dlogICMPJFAzFuXX7YCg=="

    try: 
        response = requests.request("POST", url)
        data = json.loads(response.text)
        count = data[0]["count"]

        # Make sure the count is increasing
        response = requests.request("POST", url)
        data = json.loads(response.text)
        secondCount = data[0]["count"]

        if secondCount > count:
            return "Count is increasing and API is called"
        else:
            return "API called successfully. Count is not increasing"
    except json.JSONDecodeError:
        return "Could not call the API"
    


print(testAPI())