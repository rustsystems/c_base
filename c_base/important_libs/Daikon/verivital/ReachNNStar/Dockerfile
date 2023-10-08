FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y python3 python3-dev python3-pip python python-dev python-pip && \
    apt-get clean

RUN apt-get install wget git -y

RUN git clone https://github.com/verivital/ReachNNStar.git
RUN apt-get install -y m4 libgmp3-dev libmpfr-dev libmpfr-doc libgsl-dev gsl-bin bison flex gnuplot-x11 libglpk-dev gcc-8 g++-8 libopenmpi-dev

RUN apt-get install build-essential

RUN pip3 install -U virtualenv

RUN pip install pip --upgrade

WORKDIR ReachNNStar/

RUN pip install -r requirements.txt # Run this command under the repository's root directory

RUN pip3 install -r requirements3.txt # Run this command under the repository's root directory

RUN ./compile.sh

WORKDIR ReachNN

RUN ./example.sh nn_1_relu 1e-3

