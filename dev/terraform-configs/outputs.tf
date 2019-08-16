#----root/outputs.tf-----

#---Networking Outputs -----

output "Public Subnets" {
  value = "${join(", ", module.networking.public_subnets)}"
}
