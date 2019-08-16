#----- bastion variable assignment

bastion_instance_count = 1
bastion_instance_type = "t2.micro"
bastion_instance_name = [
   "bastion-1a"
  ]

bastion_distribution = "Ubuntu"

bastion_owner = "amazon"
bastion_filter_name = "name"
bastion_filter_value = "ubuntu*"
