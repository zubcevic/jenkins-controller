# Hashicorp Vault

In order to use Jenkins with as many secrets as possible outside of Jenkins, Hashicorp Vault is used.

The **hashicorp-vault-plugin:latest** plugin is used. The vault itself is outside of Jenkins. In Jenkins we just use credentials to be able to read selected parts of the Vault.

This readme will show how to setup a simple Vault with the secrets that are used in the overall Jenkins and sample job configuration.

## Install vault on MacOS

    brew tap hashicorp/tap
    sudo rm -rf /Library/Developer/CommandLineTools
    sudo xcode-select --install
    brew install hashicorp/tap/vault
    brew upgrade hashicorp/tap/vault

## Start vault server with Web UI

    mkdir -p vault/data
    vault server -config=config.hcl

See more info on [Vault getting started](https://learn.hashicorp.com/tutorials/vault/getting-started-ui?in=vault/getting-started)
Go to [Vault UI](http://127.0.0.1:8200/ui) and create a RAFT storage cluster (5 shares with threshold 3) and save the keys.
Unseal the Vault with 3 of the 5 master keys. Use the root token for Vault admin tasks.

## Set up some Jenkins related keys

In a shell you can use the vault CLI with the root token as follows:

    export VAULT_TOKEN="s.Kbb3cUaImumeqB1qw0he3us1"
    export VAULT_ADDR="http://127.0.0.1:8200"
    vault auth enable approle
    #create a key value store for Jenkins secrets
    vault secrets enable -path=secret kv-v2
    #create a policy
    vault policy write jenkins jenkins-policy.hcl
    #create jenkins approle
    vault write auth/approle/role/jenkins token_policies="jenkins" token_ttl=1h token_max_ttl=4h
    #enable vault auditing
    vault audit enable file file_path=vault_audit.log

## Get RoleID and SecretID for Jenkins Role to use in jenkins

    vault read auth/approle/role/jenkins/role-id
    vault write -f auth/approle/role/jenkins/secret-id

## Test RoleID and SecretID and get temporary VAULT_TOKEN for that Role

    vault write auth/approle/login role_id="69b0889e-ffb6-3eab-be7b-1b55b899754b" secret_id="23098702-bf0c-2c87-1dbd-4f3c82bac221"

## Add Jenkins secrets with temp token with Jenkins role_id

    vault write auth/approle/login role_id="69b0889e-ffb6-3eab-be7b-1b55b899754b" secret_id="23098702-bf0c-2c87-1dbd-4f3c82bac221"
    export VAULT_TOKEN="...."
    export VAULT_ADDR="http://127.0.0.1:8200"
    export SSH_PK=$(cat ~/.ssh/id_rsa)
    vault kv put secret/jenkins/sonarcloud api-key=blabla
    vault kv put secret/jenkins/github privatekey="${SSH_PK}" username="rene@zubcevic.com" passphrase="" 
