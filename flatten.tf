variable "clouds_string" {
  default = "Azure Aws Gcp Alibaba Ibm"
}
variable "clouds_list" {
  default = ["azure","aws","gcp","alibaba","ibm"]
}
output "clouds_string_string" {
  value = var.clouds_string
}
locals {
  contains_clous_keyword = contains(split(" ", var.clouds_string), "Azure")
}
output "contains_clouds"{
    value = local.contains_clous_keyword
}
output "string_contains_clouds" {
  value = local.contains_clous_keyword ? "String contains 'Azure'" : "String does not contain 'Azure'"
}
variable "cloud_owners_string" {
  default = "Microsoft Amazon Google"
}
variable "cloud_owners_list" {
  default = ["Microsoft", "Amazon", "Google"]
}
output "cloud_owners_string_string" {
  value = var.cloud_owners_string
}
variable "number_list_test" {
  type    = list(list(string))
   default = [[1,2,3],[1,2],[1,2,3,4],[1,2,3,4,5]]
}
locals{
   number_list_test = flatten(var.number_list_test)
}
output "number_list_test"{
      value = local.number_list_test
}
output "sumo_test"{
    value=sum ([for numberoutput in local.number_list_test: (numberoutput)])
}
