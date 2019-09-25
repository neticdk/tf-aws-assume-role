/*
 * Copyright (c) 2019 Netic A/S. All rights reserved.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}

# Names of roles to create that trust the service named in aws_service_name
# Key is the name of the role
# Value is the description
variable "aws_service_roles" {
  description = "Roles to create that trust the aws_service_name service"
  default     = {}
}

# Names of roles to create that trust the AWS Account ID in aws_account_id
# Key is the name of the role
# Value is the description
variable "aws_account_roles" {
  description = "Roles to create that trust the aws_account_id account"
  default     = {}
}

# Names of roles to create that trust the SAML provider given in saml_identity_provider
# Key is the name of the role
# Value is the description
variable "saml_roles" {
  description = "Roles to create that trust the saml_identity_provider saml provider"
  default     = {}
}

# Used when creating accounts of type AWS Service
variable "aws_service_name" {
  description = "Name of AWS Service to trust"
  default     = ""
}

# Used when creating accounts of type AWS Account
variable "aws_account_id" {
  description = "The AWS Account ID to trust"
  default     = ""
}

# Used when creating account of type SAML
variable "saml_identity_provider" {
  description = "The SAML provider to trust when federating using SAML"
  default     = ""
}

# Used when creating accounts of type SAML
variable "saml_account_id" {
  description = "The AWS Account ID to trust when federating using SAML"
  default     = ""
}

# SAML AUD to use when creating accounts of type SAML
variable "saml_aud" {
  description = "SAML Audience"
  default     = "https://signin.aws.amazon.com/saml"
}

# The maximum session duration (in seconds) for the specified roles. 
# This setting can have a value from 1 hour to 12 hours.
variable "max_session_duration" {
  description = "The maximum session duration (in seconds) for the specified roles."
  default     = "3600"
}
