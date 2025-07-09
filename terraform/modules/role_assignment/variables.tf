variable "principal_id" {
  description = "The principal (object) ID of the identity to receive the role"
  type        = string
}

variable "scope" {
  description = "The resource ID to assign the role on (e.g. ACR ID)"
  type        = string
}

variable "role_definition_name" {
  description = "Built-in role to assign (e.g. AcrPull, Contributor)"
  type        = string
  default     = "AcrPull"
}
