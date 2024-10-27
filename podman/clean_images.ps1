$ExcludedImages = @(
    "docker.io/library/mysql",
    "docker.io/library/python",
    "docker.io/library/redis",
    "docker.io/library/postgres"
)

$Images = podman images --format "{{.ID}}" | ForEach-Object { $_.Trim() }

foreach ($Image in $Images) {
    $ImageName = podman images --format "{{.Repository}}" $Image 

    if ($ExcludedImages -contains $ImageName) {
        Write-Output "Skipping excluded image: $ImageName"
    } else {
        # Find containers using this image
        $Containers = podman ps -a --filter "ancestor=$Image" --format "{{.ID}}" | ForEach-Object { $_.Trim() }

        # Stop and remove containers if they exist
        if ($Containers) {
            Write-Output "Stopping and removing containers for image: $ImageName"
            podman stop $Containers | Out-Null
            podman rm $Containers | Out-Null
        }

        # Attempt to remove the image, and force remove if necessary
        $RemoveResult = podman rmi $Image 2>&1
        if ($RemoveResult -match "image is in use by a container") {
            Write-Output "Force-removing image: $ImageName"
            podman rmi -f $Image | Out-Null
        }
        else {
            Write-Output "Removed image: $ImageName"
        }
    }
}

