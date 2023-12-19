#! /bin/bash

clear

rm -rf vendor

go mod vendor
go mod tidy

go build -o terraform-provider-fmc_0.2_darwin_amd64

mkdir -p ~/.terraform.d/plugins/registry.terraform.io/CiscoDevNet/fmc/0.2/darwin_amd64

mv terraform-provider-fmc_0.2_darwin_amd64 ~/.terraform.d/plugins/registry.terraform.io/CiscoDevNet/fmc/0.2/darwin_amd64

cp ~/.terraform.d/plugins/registry.terraform.io/CiscoDevNet/fmc/0.2/darwin_amd64/terraform-provider-fmc_0.2_darwin_amd64 ~/.terraform.d/plugins/registry.terraform.io/CiscoDevNet/fmc/0.2/darwin_amd64/terraform-provider-fmc

rm ~/.terraform.d/plugins/registry.terraform.io/CiscoDevNet/fmc/0.2/darwin_amd64/terraform-provider-fmc_0.2_darwin_amd64

if [ "$1" == "" ];
then
    exit 0
fi

cd examples/fmc_$1

if [ "$2" == "r" ];
then
    terraform refresh
    exit 0
fi

if [ "$2" == "d" ];
then
    terraform destroy -auto-approve
    exit 0
fi
# sleep 10

# sshpass -p Cisco@123 ssh -o StrictHostKeyChecking=no admin@18.224.91.41 configure manager add 172.16.0.50 cisco
# sshpass -p Cisco@123 ssh -o StrictHostKeyChecking=no admin@3.19.212.115 configure manager add 172.16.0.50 cisco

terraform init > /dev/null
terraform plan

terraform apply -auto-approve