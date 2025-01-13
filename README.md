# Ghostscript Build Environment

This repository provides a Docker-based environment for building [Ghostscript](https://www.ghostscript.com/) with static libraries.


## Prerequisites

Before proceeding, ensure you have the following installed:

- [Docker](https://www.docker.com/)

## Build Instructions

Follow these steps to build Ghostscript:

### Step 1: Clone the Repository

Clone this repository to your local machine:

```
git clone git@github.com:pauloeduardods/ghostscript-static-build.git
cd ghostscript-static-build
```

### Step 2: Build the Docker Image

Use the docker build command to create the Docker image:

```
docker build -t ghostscript-static-build .
```

### Step 3: Run the Build Container

Run the container to build Ghostscript and export the artifacts:

```
docker run --rm -v $(pwd)/output:/output ghostscript-static-build
```

The `-v $(pwd)/output:/output` option maps the container's `/output` directory to a local `output` directory, so the built files are saved on your host machine.

### Step 4: Verify the Output

After running the container, the built artifacts will be available in the `output` directory:

```
ls output
```

You should see the Ghostscript binaries and other generated files.

## Verifications

### Check the Target System Compatibility

To verify the system architecture and platform for which the binary was built, use the file command on the generated executable:

```
file output/gs
```

Expected output for a 64-bit Linux binary:

`output/gs: ELF 64-bit LSB executable, x86-64, statically linked, for GNU/Linux 4.x.x, ...`

If you see `statically linked` in the output, the build has successfully created a static binary.

### Check if the Binary is Statically Linked

Use the `ldd` command to verify that the executable is statically linked. A statically linked binary will show the following output:

```
ldd output/gs
````

Expected output for a statically linked binary:

`not a dynamic executable`

If `ldd` outputs library dependencies, the binary is not statically linked, and the build configuration needs to be adjusted.
## Notes

- This setup uses Debian as the base image and installs the required dependencies for building Ghostscript.
- The build process generates a statically linked executable with the required libraries (-lm -ldl -lc -static).
- For more details about Ghostscript, visit the official website.

Feel free to update the [repository](https://github.com/pauloeduardods/ghostscript-static-build) and any specific paths as needed.

For more details about [Ghostscript](https://www.ghostscript.com/), visit the official website.