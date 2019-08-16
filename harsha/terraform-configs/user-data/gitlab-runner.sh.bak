#!/bin/bash

add_gitlab_runner_repo () {

	curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh | sudo bash
}

install_gitlab_runner () {

	if [ -z "${GITLAB_RUNNER_VERSION}" ]
	then
		# Install Latest Version of GITLAB-Runner
		sudo apt-get install gitlab-runner
	else
		# Install specific Version of GITLAB-Runner
      		sudo apt-get install gitlab-runner=${GITLAB_RUNNER_VERSION}
	fi
}

reg_gitlab_runner () {
	if [ -z "${GITLAB_SERVER_URL}" ] || [ -z "${PROJECT_REGISTRATION_TOKEN}" ]
	then
		echo "Gitlab Server URL or Project Registration Token is not defined" > /var/log/gitlab_registration_status
	else
		# Register GITLAB Runner with Server
		sudo gitlab-runner register \
		     	  --non-interactive \
			  --url "${GITLAB_SERVER_URL}" \
			  --registration-token "${PROJECT_REGISTRATION_TOKEN}" \
			  --executor "shell" \
			  --description "shell-runner" \
			  --tag-list "shell,aws" \
			  --run-untagged="true" \
			  --locked="false" \
			  --access-level="not_protected"
	fi

main () {
	add_gitlab_runner_repo
	install_gitlab_runner
	reg_gitlab_runner
}

main "$@"
