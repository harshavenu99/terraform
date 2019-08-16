#---- gitlab-server variable assignment

gitlab-server_instance_count = 1
gitlab-server_server_instance_type = "t2.micro"
gitlab-server_instance_name = [
   "gitlab-server-1a"
  ]

gitlab-server_distribution = "Ubuntu"

gitlab-server_owner = "amazon"
gitlab-server_filter_name = "name"
gitlab-server_filter_value = "ubuntu*"
