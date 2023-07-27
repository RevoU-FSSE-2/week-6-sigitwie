[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/nj7iw4Wb)


# Executing an application using Docker.

In this project, I will conduct an experimentation to run an application within a container through Docker. The necessary steps are as follows:

## Update Windows Subsystem for Linux (WSL)
Prior to utilizing Docker on Windows, it is essential to ensure that your laptop has the latest version of Windows Subsystem for Linux (WSL) installed correctly. In this particular case, I am utilizing Windows 11, which has not yet installed WSL.

Here are the step-by-step instructions to enabling and update WSL:

1. **Enable Windows Subsystem for Linux (WSL)**:

   If you haven't already done so, you need to enable WSL on your Windows system. Here's how:

   - Open PowerShell as an administrator by right-clicking the Start button, selecting "Windows PowerShell (Admin)."

   - Run the following command to enable WSL:

     ```
     dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
     ```

   - Restart your computer to complete the installation.

2. **Enable Virtual Machine feature**
    Before installing WSL 2, you must enable the Virtual Machine Platform optional feature. Your machine will require virtualization capabilities to use this feature.

    Open PowerShell as Administrator and run:

    ```
    dism.exe /online /enable-feature /          featurename:VirtualMachinePlatform /all /norestart
    ```
    Restart your machine to complete the WSL install and update to WSL 2.

3. **Download the Linux kernel update package**:

   Next, you need to download the latest Linux kernel update package for WSL2. 

   [WSL2 Linux kernel update package for x64 machines](https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi)

   Run the update package downloaded in the previous step. (Double-click to run - you will be prompted for elevated permissions, select ‘yes’ to approve this installation.)

4. **Install WSL2 Update**:

   Docker requires WSL2 to run on Windows. You'll need to ensure you have the latest version of WSL, which includes WSL2. Follow these steps to install the WSL2 update:

   - Open PowerShell as an administrator.

   - Run the following command to set WSL2 as the default version for newly installed Linux distributions:

     ```
     wsl --set-default-version 2
     ```

   - If you already have a WSL distribution installed and want to update it to version 2, run the following command (replace "distribution" with the name of your distribution, e.g., "Ubuntu"):

     ```
     wsl --set-version distribution 2
     ```

With these steps completed, you should have an updated WSL environment on your Windows system, which can be used in conjunction with Docker to run Linux containers smoothly.

## Install Docker
1. **Check System Requirements**:

   Before installing Docker on your Windows machine, ensure that your system meets the minimum requirements. Docker for Windows requires a 64-bit version of Windows 10 Pro, Enterprise, or Education edition with Hyper-V virtualization enabled. For this, I use Windows 11 Pro Build 22621.1992.

2. **Download Docker Desktop**:

   Go to the official Docker website to download the Docker Desktop installer for Windows. You can find it at: https://www.docker.com/products/docker-desktop

3. **Run the Installer**:

   Once the Docker Desktop installer is downloaded, double-click on the installer file (usually named `Docker Desktop Installer.exe`) to start the installation process.

4. **Allow User Account Control (UAC)**:

   Windows might prompt you with a User Account Control (UAC) pop-up asking for permission to make changes to your system. Click "Yes" to proceed with the installation.

5. **Installation Wizard**:

   The Docker Desktop installation wizard will open. Follow the steps in the wizard to install Docker on your system. You can typically leave the default settings as they are.

6. **Enable Hyper-V (If Required)**:

   During the installation, Docker Desktop will enable Hyper-V, which is a requirement for running Docker on Windows. If Hyper-V is not already enabled, the installer will prompt you to do so. Follow the instructions to enable Hyper-V and restart your computer if necessary.

7. **Log in to Docker Hub (Optional)**:

   After the installation is complete, Docker Desktop will open. If you have a Docker Hub account, you can log in to Docker Desktop using your Docker Hub credentials. This step is optional but allows you to access additional Docker features and services.

8. **Docker Desktop Icon**:

   Docker Desktop will add an icon to your system tray (usually located in the lower-right corner of the screen). You can access Docker controls and settings by clicking on this icon.

9. **Verify Docker Installation**:

   Open a Command Prompt or PowerShell window and type the following command to verify that Docker is installed correctly:

   ```
   docker --version
   ```

   This should display the installed version of Docker on your system.

   ```
   C:\Windows\System32>docker --version
   version 24.0.2, build cb74dfc
   ```

You have successfully installed Docker on your Windows machine. You can now start using Docker to build, run, and manage containers for your applications.

## Run an Application in Docker
**1. Create Dockerfile**

The Dockerfile includes a series of commands and arguments that specify what should be installed, copied, or configured in the image. When you build an image using the Dockerfile, Docker follows the instructions step by step to create a new container image.

The basic syntax of a Dockerfile includes the following components:

- `FROM` : Specifies the base image from which you want to build your image. The base image contains the operating system and necessary software to run your application.

- `WORKDIR` : Sets the working directory inside the container where subsequent commands will be executed.

- `COPY or ADD` : Copies files or directories from the host machine (where the Dockerfile is located) to the container image.

- `RUN` : Executes commands inside the container during the image build process. This is used to install packages, run scripts, or configure the environment.

- `EXPOSE` : Informs Docker that the container listens on specific network ports at runtime. However, this does not publish the specified ports to the host machine.

- `CMD or ENTRYPOINT` : Specifies the default command that should be executed when a container is run. It defines the main process that runs in the container.

Here is the Dockerfile I created for this project:

   ```
      # Use Node.js as the base image
      FROM node:14

      # Set the working directory inside the container
      WORKDIR /usr/src/app

      # Copy package.json and package-lock.json into the container
      COPY package*.json ./

      # Install dependencies
      RUN npm install

      # Copy the entire application code into the container
      COPY . .

      # Specify the port that the application will use
      EXPOSE 3001

      # Run the application when the container is launched
      CMD ["node", "app.js"]

   ```


**2. Build the Image**

You can build a Docker image by running the following command in the terminal:
   
   ```
   docker build -t image-name:tag .
   ```

The `docker build` command is used to build a Docker image from a Dockerfile. Let's break down the command and explain each part:

- `docker`: This is the Docker command-line interface (CLI) that allows you to interact with Docker and manage containers and images.

- `build`: This subcommand tells Docker that we want to build an image.

- `-t image_name:tag`: The `-t` flag is used to tag the image with a name and optional tag. It allows you to give the image a human-readable name and a version or tag for easier identification and versioning. In this case, `image_name` represents the name of the image, and `tag` represents the version or tag of the image.

- `.`: The period (`.`) at the end of the command specifies the build context. It tells Docker to look for the Dockerfile in the current directory where the command is being executed.


**3. Run the Container**

After the image is built, you can run the container using the following command:

   ```
   docker run -p 3001:3001 image_name:tag
   ```

for this project, I used the following command:

   ```
   docker run -p 3001:3001 test-app:w6
   ```

The `docker run` command is used to run a container from an image. Let's break down the command and explain each part:

- `docker`: This is the Docker command-line interface (CLI) that allows you to interact with Docker and manage containers and images.

- `run`: This subcommand tells Docker that we want to run a container.

- `-p 3001:3001`: The `-p` flag is used to publish a container's port(s) to the host. It allows you to expose a container's network port(s) to the host machine. In this case, `3001` represents the port on the host machine, and `3001` represents the port inside the container.

- `image_name:tag`: This is the name and tag of the image that you want to run in a container.

**4. Verify the Application is Running**

After the container is running, you can verify that the application is running by opening a web browser and navigating to `http://localhost:3001`. You should see the following output:

![image](/img/app-run.png)

**5. Stop the Container**

To stop a running Docker container, you can use the `docker stop` command followed by the container ID or container name. Here's the step-by-step process:

1. **List Running Containers**:

   First, you need to identify the container that you want to stop. Open a terminal or command prompt and list all running containers using the following command:

   ```
   docker ps
   ```

   This will display a list of all running containers with their container IDs, names, and other information.

2. **Stop the Container**:

   Once you have identified the container you want to stop, use the following command to stop it:

   ```
   docker stop <container_id_or_name>
   ```

   Replace `<container_id_or_name>` with either the container ID or container name from the previous step.

   For example, if your container ID is `abcdef123456`, you would run:

   ```
   docker stop abcdef123456
   ```

   If your container has a custom name, such as `my_container`, you can stop it with:

   ```
   docker stop my_container
   ```

   After running the `docker stop` command, the container will gracefully stop, allowing any running processes inside the container to shut down cleanly.

   ![image](/img/stop-image.png)

3. **Verify the Container Stopped**:

   To verify that the container has stopped, you can use the `docker ps` command again, but this time with the `-a` flag to show all containers, including the stopped ones:

   ```
   docker ps -a
   ```

   The stopped container should now be listed with a status of "Exited" and the corresponding container ID or name.

   ![image](/img/all-list.png)
