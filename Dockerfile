FROM python:3.7.13-slim-buster

RUN apt-get update -y
RUN apt install gcc g++ git wget -y
RUN apt-get install ffmpeg libsm6 libxext6  -y
RUN pip install setuptools cython numpy

WORKDIR /workspace
RUN git clone https://github.com/Arthur151/ROMP.git

WORKDIR /workspace/ROMP/simple_romp
RUN python setup.py install

# run this part to download weights automaticly
WORKDIR /
RUN wget http://im.rediff.com/sports/2011/aug/13pic1.jpg
RUN romp --mode=image --input 13pic1.jpg -o . --render_mesh
RUN romp --mode=image --input 13pic1.jpg -o . --render_mesh --onnx

ENTRYPOINT [ "romp" ]

# docker build -t romp . 
# docker run --privileged --rm -it --gpus 0 --ipc=host -p 8888:8888  -v $(pwd):/workspace/results -v /tmp/.X11-unix:/tmp/.X11-unix --device /dev/video0 -e DISPLAY=$DISPLAY romp --mode=webcam
