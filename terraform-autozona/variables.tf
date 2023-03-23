## Variables Provider, Region and AWS Profile

variable "region" {
  description = "AWS Region"
  default     = "us-east-1"
  type        = string
}

variable "profile" {
  description = "Costech Solution Profile"
  default     = "Autozona"
  type        = string
}
## Domain Registered Variables ##

# Domain Contact: Arturo Prada

variable "regcontact_ap" {
  type = map(string)
  default = {
    "contact_type"      = "COMPANY"
    "first_name"        = "Arturo"
    "last_name"         = "Prada"
    "organization_name" = "autozona.cr"
    "email"             = "soporte@autozona.cr"
    "phone_number"      = "+506.88829381"
    "city"              = "Heredia"
    "address_line_1"    = "Heredia"
    "address_line_2"    = "Heredia"
    "country_code"      = "CR"
    "zip_code"          = "20108"
  }

}

variable "admincontact_ap" {
  type = map(string)
  default = {
    "contact_type"      = "COMPANY"
    "first_name"        = "Arturo"
    "last_name"         = "Prada"
    "organization_name" = "autozona.cr"
    "email"             = "soporte@autozona.cr"
    "phone_number"      = "+506.88829381"
    "city"              = "Heredia"
    "address_line_1"    = "Heredia"
    "address_line_2"    = "Heredia"
    "country_code"      = "CR"
    "zip_code"          = "20108"
  }

}

variable "techcontact_ap" {
  type = map(string)
  default = {
    "contact_type"      = "COMPANY"
    "first_name"        = "Arturo"
    "last_name"         = "Prada"
    "organization_name" = "autozona.cr"
    "email"             = "soporte@autozona.cr"
    "phone_number"      = "+506.88829381"
    "city"              = "Heredia"
    "address_line_1"    = "Heredia"
    "address_line_2"    = "Heredia"
    "country_code"      = "CR"
    "zip_code"          = "20108"
  }

}


variable "hz_autozona" {
  type        = string
  default     = "autozona.click"
  description = "The domain name of Autozona"
}

variable "hz_electrozona" {
  type        = string
  default     = "electrozona.click"
  description = "The domain name of Electrozona"
}

