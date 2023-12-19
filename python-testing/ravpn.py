import requests
from urllib3.exceptions import InsecureRequestWarning, MaxRetryError
import time

# All of them are strings
name, ip, port = "", "", ""
fmc_ip = "20.204.147.197"
fmc_user = "test"
fmc_pass = "test@123"
requests.packages.urllib3.disable_warnings(category=InsecureRequestWarning)


def generate_token():
    domainurl = f"https://{fmc_ip}//api/fmc_platform/v1/auth/generatetoken"

    domainresponse = requests.request("POST", domainurl, data={}, auth=(fmc_user, fmc_pass), verify=False)
    if domainresponse.status_code != 204:
        time.sleep(10)
        print("Error occurred in generating token. Sleeping for 10")
        generate_token()

    print("token Generation", domainresponse)
    token1 = domainresponse.headers['X-auth-access-token']
    domainUUID = domainresponse.headers['DOMAIN_UUID']
    return token1, domainUUID


token1, domainUUID = generate_token()
headers = {
        'accept': 'application/json',
        'X-auth-access-token': token1,
        'Content-Type': 'application/json'
}

def main():
    