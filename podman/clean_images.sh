#!/bin/bash

EXCLUDED_IMAGES=(
    "docker.io/library/mysql",
    "docker.io/library/python",
    "docker.io/library/redis",
    "docker.io/library/postgres"
)

IMAGES=$(podman images -q)

for IMAGE in $IMAGES; do
    IMAGE_NAME=$(podman images --format "{{.Repository}}" "$IMAGE")

    if [[ " ${EXCLUDED_IMAGES[*]} " == *" $IMAGE_NAME "*]]; then
        echo "Skipping excluded image: $IMAGE_NAME"
    else
        # Find containers that are using this image
        CONTAINERS=$(podman ps -a --filter "ancestor=$IMAGE" -q)

        # If containers exist, stop and remove them
        if [ -n "$CONTAINERS" ]; then
            echo "Stopping and removing containers for image: $IMAGE_NAME"
            podman stop $CONTAINERS
            podman rm $CONTAINERS
        fi

        # Try to remove the image, force remove if necessary
        if ! podman rmi "$IMAGE"; then
            echo "Force-removing image: $IMAGE_NAME"
            podman rmi -f "$IMAGE"
        else
            echo "Removed image: $IMAGE_NAME"
        fi
    fi
done

