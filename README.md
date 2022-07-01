# BigHand

Terraform module that allows for configuration for BigHand using terraform variables.

The following variables can be used to configure the infrastructure.

### Variable sets

##### Azure

| Name                       | Default | Description |
| -------------------------- | ------- | ----------- |
| ARM_CLIENT_ID              |         |
| ARM_CLIENT_SECRET          |         |
| ARM_CLIENT_SUBSCRIPTION_ID |         |
| ARM_TENANT_ID              |         |

### Variables

| Name                   | Default | Description |
| ---------------------- | ------- | ----------- |
| vm_db_name             |         |
| nic_db_name            |         |
| snet_app_name          |         |
| nic_app_ip_address     |         |
| vnet_name              |         |
| vm_app_name            |         |
| rg_vnet_name           |         |
| rg_db_name             |         |
| rg_app_name            |         |
| snet_db_name           |         |
| nic_app_name           |         |
| nic_db_ip_address      |         |
| vm_db_size             |         |
| vm_app_size            |         |
| windows_admin_username |         |
| windows_admin_password |         |
