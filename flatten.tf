
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
*/
variable "original_string" {
  default = "DUBAI SYRIA ITALY FRANCE GERMANY"
}
variable "string_list" {
  default = ["Dubai", "Syria", "Italy", "France", "Germany"]
}
variable "additional_string" {
  default = "I will visit "
}
variable "visitcountries"{
    type =list(string)
  default = ["Dubai", "Syria", "Italy", "France", "Germany"]
}
variable "love_string" {
  default = "I love" 
}
variable "space_string" {
  default = " " 
}
variable "canada_string" {
  default = "Canada"
}
variable "george_string" {
  default = "GEORGE IBRAHIM"
}
variable "george_list" {
  default = ["GEORGE", "IBRAHIM"]
}
variable "additional1_string" {
  default = " from syria"
}
output "string_length" {
  value = length(var.original_string)
}
output "uppercase_string" {
  value = upper(var.original_string)
}
output "lowercase_string" {
  value = lower(var.original_string)
}
output "concatenated_string" {
  value = "${var.additional_string}${var.original_string}"
}
output "reverse_examplesecond"{
  value=reverse(var.string_list)
}
locals {
  contains_keyword = contains(split(" ", var.original_string), "CANADA")
}
output "contains"{
    value = local.contains_keyword
}
output "string_contains_no_sample" {
  value = local.contains_keyword ? "String contains 'CANADA'" : "String does not contain 'CANADA'"
}
output "concatenate_string" {
  value = "${var.love_string}${var.space_string}${var.canada_string}"
}
output "join_example" {
  value = join("+", var.string_list)
}
output "visitcountries"{
    value=[for visitcountries in var.visitcountries:visitcountries ]
}
output "join_george" {
  value = join(" ", var.george_list)
}
variable "company_name"{
 type=string
 default="Ipex"
}
variable "years_of_work"{
 type=number
 default=2
}
variable "ifstillworking"{
 type=bool
 default=true
}

variable "prefix"{
 type=string
 default="samiislam"
}
variable "firstname"{
 type=string
 default="sami"
}
variable "lastname"{
 type=string
 default="islam"
}
variable "account_tier"{
  type=string
  default="Standard"
}
variable "access_tier"{
  type=string
  default="Cool"
}
variable "account_replication_type"{
  type=string
  default="GRS"
}
variable "cross_tenant_replication_enabled"{
 type=bool
 default=false
}
variable "environment"{
 type=string
 default="staging"
}
variable "summersports"{
    type =list(string)
    default=["soccer","basketball","badminton","tabletennis"]
}
output "summersportslist"{
    value=[for summersport in var.summersports:summersport ]
}
variable "favouritefood"{
    type =list(string)
    default=["tabola","mlokia","shakrea","shawrma","falafel"]
}
output "favouritefood"{
    value=[for favouritefood in var.favouritefood:favouritefood ]
}
/*
