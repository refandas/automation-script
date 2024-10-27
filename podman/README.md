# Podman Cleanup Utility

This repo provides a utility for cleaning up unused Podman containers and
images on both Linux and Windows. The cleanup process includes removing any
container associated with an image before deleting the image itself, with the
option to exclude specific images.

## Prerequisites

- **Podman** must be installed on your system.
- **PowerShell** for Windows users.
- **Make** for executing the `Makefile` commands.

## Files

- `Makefile` - Contains commands to run cleanup scripts for Bash (Linux/macOS)
and PowerShell (Windows).
- `clean_images.sh` - Bash script to stop and remove containers, then delete
unused images on Linux.
- `clean_podman.ps1` - PowerShell script to stop and remove containers, then
delete unused images on Windows.

## Usage

### Linux/MacOS

1. Run the Bash cleanup script:

```bash
make clean_images_bash
```

This will start the `clean_images.sh` script, which:

- Lists all Podman images.
- Stops and removes any containers using each image.
- Deletes the image if it is not the excluded list.

### Windows

1. Run the PowerShell cleanup script:

```bash
make clean_images_powershell
```

This will start the `clean_images.ps1` script, which performs the same tasks
as the Bash script but is compatible with PowerShell on Windows.

## Excluding Images

To exclude specific images from cleanup, edit the `EXCLUDED_IMAGES` variable in
both `clean_images.sh` and `clean_images.ps1` files, adding the image names you
wish to keep.

## Notes

- Ensure that `Makefile`, `clean_images.sh`, and `clean_images.ps1` are all in
the same directory, or adjust the file paths as necessary.
- Run the `Makefile` targets from the directory containing the scripts.

## Example Exclusion List

In each script, you'll see a list like:

```bash
EXCLUDED_IMAGES=(
    "docker.io/library/mysql",
    "docker.io/library/python",
    "docker.io/library/redis",
    "docker.io/library/postgres"
)
```

Add your image names here to prevent them from being deleted.

## License

This project is open-source and available for use and modification. This
`README.md` file provides an overview of the scripts, prerequisites, and usage
instructions. Adjust `EXCLUDED_IMAGES` in each script to suit your needs, and
execute `Makefile` targets based on your environment.
