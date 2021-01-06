# Allow a token to manage its own cubbyhole
path "secret" {
    capabilities = ["read", "list"]
}
path "secret/data/*" {
    capabilities = ["read", "list"]
}
path "secret/data/jenkins/*" {
    capabilities = ["create", "read", "update", "delete", "list"]
}
