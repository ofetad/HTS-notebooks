

1. Request a new VM from Duke's [Virtual Computing Manager](https://oit.duke.edu/help/articles/vcm-how-use-virtual-computing-manager).  Your VM should be based on "Ubuntu 16.04"

2. SSH to your new VM, and do all the following on the VM

3. Run the following commands to install Docker

```
sudo apt-get remove docker docker-engine docker.io
sudo apt-get update
sudo apt-get install -y --no-install-recommends    apt-transport-https     ca-certificates     curl     software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"
sudo apt-get update
sudo apt-get install -y --no-install-recommends docker-ce
```

4. Run the following to confirm that Docker is working
```
sudo docker run hello-world
```
It should print this:
```
Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/
 ```

5. Run the following to allow you to run docker without sudo:
``` 
sudo groupadd docker
sudo gpasswd -a $USER docker
newgrp docker
```

6. Now run the following to be sure that worked (note that we are not using 'sudo' here)
```
docker run hello-world
```

7. Run the following to get the script that will download course material and the jupyter image
```
wget https://gitlab.oit.duke.edu/HTS2018/HTS2018-notebooks/raw/master/reproducibility/prep_local_jupyter.sh
```

8. Run the following to download course material and the jupyter image, and run it. 
```
bash prep_local_jupyter.sh hts2018
```
Follow the printed instructions for accessing the Jupyter instance running on your VM.

