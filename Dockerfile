FROM debian:latest AS build

WORKDIR /work

RUN apt update && apt install -y \
    autoconf \
    automake \
    make \
    clang \
    g++ \
    wget \
    tar

RUN wget https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs10040/ghostpdl-10.04.0.tar.gz \
    && tar -zxf ghostpdl-10.04.0.tar.gz

WORKDIR /work/ghostpdl-10.04.0
RUN ./autogen.sh && make EXTRALIBS="-lm -ldl -lc -static"

RUN mkdir -p /artifacts && cp -r bin/* /artifacts/

FROM debian:latest

WORKDIR /output

COPY --from=build /artifacts /artifacts

RUN echo '#!/bin/bash\n cp -r /artifacts/* /output\n exec "$@"' > /entrypoint.sh && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
