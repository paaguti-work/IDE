#!/bin/bash
if [ ! -d ~/core_engine ]; then

  sudo apt-get --yes update
  sudo apt-get --yes install maven
  sudo add-apt-repository --yes ppa:webupd8team/java
#  sudo apt-get --yes update
  sudo apt-get --yes install oracle-java8-installer
  sudo apt-get --yes install oracle-java8-set-default
  
  mkdir core_engine
  cd core_engine
  git clone -b CoreImplementation https://github.com/fp7-netide/Engine
  
  cd Engine/libraries/netip/java
  mvn clean install
  
  cd
  cd core_engine/Engine/core
  mvn clean install
  cd tools/emulator
  mvn clean install
  cd target
  cp emulator-1.0-jar-with-dependencies.jar /home/vagrant/composition/
  
  cd
  git clone https://git-wip-us.apache.org/repos/asf/karaf.git karaf
  cd karaf/
  git checkout remotes/origin/karaf-3.0.x
  mvn clean install -DskipTests
  cd assemblies/apache-karaf/target
  tar xvf apache-karaf-3.0.6-SNAPSHOT.tar.gz
# cd apache-karaf-3.0.6-SNAPSHOT/bin
  
  
else
   echo "Engine seems to be already installed. Skipping..."
fi