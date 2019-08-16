#!/bin/bash

add_gitlab_server_repo () {

	sudo apt-get install -y curl openssh-server ca-certificates
	curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash

}

install_gitlab_server () {

	if [ -z "${GITLAB_RUNNER_VERSION}" ]
	then
		# Install GITLAB Server
		sudo EXTERNAL_URL="${GITLAB_SERVER_EXTERNAL_URL}" apt-get install gitlab-ce
	else
		echo "External URL for GITLAB-Server not defined" > /var/log/gitlab-server.status
		exit
	fi
}

main () {
	add_gitlab_server_repo
	install_gitlab_runner
}

main "$@"
