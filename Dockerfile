FROM ubuntu
RUN apt-get update
RUN apt-get -y install wget python git automake libtool build-essential cmake libglib2.0-dev closure-compiler libz-dev sudo

USER root

WORKDIR /root
RUN wget https://s3.amazonaws.com/mozilla-games/emscripten/releases/emsdk-portable.tar.gz
RUN tar xzvf emsdk-portable.tar.gz
WORKDIR /root/emsdk-portable 
RUN ./emsdk update
RUN ./emsdk install emscripten-1.37.40 
RUN ./emsdk activate emscripten-1.37.40 
RUN ./emsdk install clang-e1.37.40-64bit
RUN ./emsdk activate clang-e1.37.40-64bit
RUN ./emsdk install node-8.9.1-64bit
RUN ./emsdk activate node-8.9.1-64bit

WORKDIR /root
RUN git clone https://github.com/emscripten-ports/zlib

ENV PATH="/root/emsdk-portable:/root/emsdk-portable/clang/e1.37.40_64bit:/root/emsdk-portable/node/8.9.1_64bit/bin:/root/emsdk-portable/emscripten/1.37.40:${PATH}"

COPY . /root/ffmpeg.js/
WORKDIR /root/ffmpeg.js

CMD ["make", "clean", "ffmpeg-worker-mp4.js"]
