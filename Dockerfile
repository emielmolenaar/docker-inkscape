FROM debian:bullseye-slim

COPY install_dependencies.sh /tmp/install_dependencies.sh
RUN chmod +x /tmp/install_dependencies.sh
RUN /tmp/install_dependencies.sh --recommended
RUN rm /tmp/install_dependencies.sh

RUN mkdir -p /usr/src/inkscape/build

RUN wget https://inkscape.org/gallery/item/26932/inkscape-1.1.tar.xz -qO /tmp/inkscape.tar.xz
RUN tar --strip-components=1 -xf /tmp/inkscape.tar.xz -C /usr/src/inkscape
RUN rm /tmp/inkscape.tar.xz

WORKDIR /usr/src/inkscape/build

RUN cmake ..
RUN make -j$(nproc)
RUN make install
RUN rm -rf /usr/src/inkscape

RUN rm -rf /var/lib/apt/lists/*
