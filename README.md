Images in this repo:

    nova-dev-base:
    A basic Ubuntu 18.04 system with some general dependencies.
    Includes python, C++, vim, nano, and a user called nova-dev with sudo priveleges.
    Has access to a nova_ws folder on the host, and has access to the host's SSH info for using git.

    nova-dev-ros2:
    A (mostly) complete Ubuntu 18.04 Nova development environment.
    Includes everything from nova-dev-base, and has all the Nova repos set up by default and all dependencies (except the GUI, but including KDL) installed.
    Has access to a nova_ws folder on the host, and has access to the host's SSH info for using git.


How to use an image:

    Setup:
    1. Install Docker (https://docs.docker.com/engine/install/ubuntu/) and Docker Compose (https://docs.docker.com/compose/install/)
    2. Set up git pull / push from github/com/MonashNovaRover on your device using SSH
        This will be used within the container to interact with the Nova repos
    3. Create a folder called nova_ws somewhere on your system.
        For example, I put mine in ~/Nova/nova_ws
    4. Clone the nova_setup repo into the same parent folder as nova_ws.
        For example, I put mine in ~/Nova/nova_setup

    Starting containers:
    To create or start a container, change to the container directory and run the compose-run-<container-nickname> script
        Creates the container in your current terminal with access to nova_ws for source code and to your ~/.ssh folder so you can use git

        For example,
        cd nova_setup/nova-dev-ros2
        ./compose-run-ros2.sh

    To create additional container terminals, just open a new terminal and run
        ./compose-run-<container-nickname>.sh

    When within a container, you essentially have access to a complete Ubuntu system.
    All files in the nova_ws directory are shared between the host system and the container, so you can develop on the host, save, and then build and run in the container.
    You can also make changes within the container such as installing new packages or creating / deleting files.
    Any changes made outside of the nova_ws diretcory will stay only in the container and will not be accessible on the host.

    Exiting containers:
    To exit a container terminal (without destroying it), run
        exit
        
    To stop all container instances (without destroying the container), open a host terminal and run
        sudo docker-compose stop

        This saves the state of the container, so you can later run ./compose-run-<container-nickname>.sh and pick up where you left off

    To destroy all container instances, open a host terminal and run
        sudo docker-compose down

        This is really only necessary when you want to update the container image.
        Any changes made within the container will be lost.


How to create an image:
0. Install Docker
1. Create a DockerHub account
2. Clone the nova_setup repo anywhere on your system
3. For nova-dev-ros2 only: Set up git pull / push from github/com/MonashNovaRover on your device using SSH, then copy ~/.ssh to nova_setup/nova-dev-ros2/.ssh
    This is used during the container setup to clone all the Nova repos
4. Run the build-image script
    Builds the image from the relevant Dockerfile and pushes it to your DockerHub account.
    Pass in the name of the folder where the Dockerfile is located, adn your DockerHub username.

    For example,
    ./build-image.sh nova-dev-ros2 <dockerHubUserName>

    If your DockerHub user name is the same as your current Ubuntu user
    then you can omit the last argument.

    For example,
    ./build-image.sh nova-dev-ros2


Other scripts:
git-setup.sh - Run to clone all Nova repos into ../nova_ws/