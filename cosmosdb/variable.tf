variable "cosmosdb_name" {
    type = string
    description = "cosmosdb account name"
}
variable "cosmosdb_location" {
    type = string
    description = "cosmosdb location"  
}
variable "cosmosdb_resource_group_name" {
    type = string
    description = "cosmosdb RG name"
}

variable "cosmosdb_geo_location1" {
    type = string
}
variable "cosmosdb_vnet_subnet_ids" {
    type = map(string)
    description = "cosmosdb subnet ids"  
}
variable "cosmosdb_tags" {
    type = map(string)
}

variable "cosmosdb_database_name" {
    type = string
    description = "cosmosdb database name"
}

variable "cosmosdb_container_name" {
    type = string
    description = "cosmosdb container name"  
}
variable "cosmosdb_container_partition_key_path" {
    type = string
}
