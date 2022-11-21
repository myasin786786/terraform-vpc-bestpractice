# ---- Data Source Availability Zones ----

data "aws_availability_zones" "AZN" {
  state = "available"
}

# ---- Data Source to get Public IP address ---- #

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}
