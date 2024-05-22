variable "simple_nested_list" {
  type    = list(list(string))
   default = [["a", "b"], ["c", "d"], ["e", "f"]]
}
variable "presidents_countries" {
  type    = list(list(string))
   default = [["Obama","Justin","Kim jong Un"], ["United States","Canada", "North Korea"]]
}
variable "number_list" {
  type    = list(list(string))
   default = [[2,2,2],[1,2,3],[2,3,2],[3,1,3]]
}
variable "nested_list" {
  type    = list(list(string))
  default = [["a", "b"], ["c", "d"], ["e", "f"]]
}

variable "nested_map" {
  type    = map(map(string))
  default = {
    group1 = {"name" = "Alice", "age" = "25"}
    group2 = {"name" = "Bob", "age" = "30"}
    group3 = {"name" = "Charlie", "age" = "35"}
  }
}

locals{
   simple_local_flattened_list = flatten(var.simple_nested_list)
   presidents_countries_flattened_list = flatten(var.presidents_countries)
   number_list = flatten(var.number_list)
   flattened_list = flatten(var.nested_list)
   flattened_map  = flatten([for k, v in var.nested_map : [for kk, vv in v : { group = k, key = kk, value = vv }]])
   characters = ["luke", "yoda", "darth"]
  enemies_destroyed = [4252, 900, 20000056894]
  character_enemy_map =   { for index,character in local.characters: # Convert character list to a set
      character => local.enemies_destroyed[index]
  }
}
output "simple_local"{
    value = local.simple_local_flattened_list
}
output "flattened_list"{
    value = local.flattened_list
}
output "flattened_map"{
    value = local.flattened_map
}
output "enemies_destroyed"{
    value = local.enemies_destroyed
}
output "character_enemy_map"{
    value = local.character_enemy_map
}
output "characters"{
    value = local.characters
}
output "number_list"{
    value = local.number_list
}
variable "total_output" {
  type    = list(string)
  default = ["150", "150", "150"]
}

locals {
  incremented_output = [
    for value in var.total_output : tostring(tonumber(value) + 10)
  ]
}
output "incremented_output_show" {
  value=local.incremented_output
}
output "map_presidents_countries"{
    value = local.presidents_countries_flattened_list
}
