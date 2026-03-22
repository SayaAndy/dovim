#!/usr/bin/env bash

movim_daemon() {
	cd /usr/local/share/movim || exit 1
	composer movim:migrate \
		&& php daemon.php start
}

download_streamlinehq_svg() {
	if [ -n "${STREAMLINEHQ_API_KEY:-}" ]; then
		bash "/usr/local/bin/download-streamlinehq-svg.bash"
	fi
}

system_services() {
	php-fpm &
}

update_volume_permissions() {
	chown -R www-data:www-data /usr/local/share/movim/cache
	chown -R www-data:www-data /usr/local/share/movim/public/cache
	chown -R www-data:www-data /usr/local/share/movim/log
}

if [ "$(id -u)" -eq 0 ]; then
	system_services
	update_volume_permissions
	su -l www-data -s /bin/bash "$0"
else
	download_streamlinehq_svg
	movim_daemon
fi
