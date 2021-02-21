# Avoid 'Invalid bind mount spec' error when starting a container via docker-compose.
# https://github.com/docker/compose/issues/4303
# https://docs.docker.com/compose/reference/envvars/#compose_convert_windows_paths
export COMPOSE_CONVERT_WINDOWS_PATHS=0
export COMPOSE_FORCE_WINDOWS_HOST=1
