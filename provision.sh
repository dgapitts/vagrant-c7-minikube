#! /bin/bash
if [ ! -f /home/vagrant/already-installed-flag ]
then
  echo "ADD EXTRA ALIAS VIA .bashrc"
  cat /vagrant/bashrc.append.txt >> /home/vagrant/.bashrc

  #echo "GENERAL YUM UPDATE"
  #yum -y update
  #echo "INSTALL GIT"
  #yum -y install git
  #echo "INSTALL TREE"
  #yum -y install tree
  #echo "INSTALL unzip curl wget lsof"
  #yum  -y install unzip curl wget lsof 


  # Add ShellCheck https://github.com/koalaman/shellcheck - a great tool for testing and improving the quality of shell scripts
  #yum -y install epel-release
  #yum -y install ShellCheck
  yum install -y unzip


yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum -y install docker-ce docker-ce-cli containerd.io docker-compose-plugin
systemctl start docker
systemctl enable docker

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl


free -m;uptime;

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
install minikube-linux-amd64 /usr/local/bin/minikube

free -m;uptime;
GID=`grep docker /etc/group | cut -d':' -f3`;echo $GID
adduser -g $GID -c "Docker" docker
uptime
su - docker -c "/usr/local/bin/minikube start"
uptime
su - docker -c "/usr/local/bin/kubectl get nodes"
for i in {1..10};do free -m;uptime;sleep 20;done


else
  echo "already installed flag set : /home/vagrant/already-installed-flag"
fi

