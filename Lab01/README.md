# Steps

## Install the following tools:

### Required
* [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started)
* [Azure Cli](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
* [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

### Recommended
* [tfenv](https://github.com/tfutils/tfenv#installation)
* [iTerm2](https://iterm2.com/)
* [OhMyZSH](https://ohmyz.sh/#install)


## Create Service Principal
```sh
az ad sp create-for-rbac --name iac_service_principal
```

## Get Subscription
```sh
az account subscription list
```

## Configure Env Variables
```sh
export ARM_CLIENT_ID=
export ARM_CLIENT_SECRET=
export ARM_SUBSCRIPTION_ID=
export ARM_TENANT_ID=
```

## Pick a Location
```sh
az account list-locations --query '[].name'
```

## Create main.tf

As shown [here](main.tf)