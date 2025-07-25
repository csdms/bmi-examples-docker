# Build the C, C++, Fortran, and Python BMI examples from a condaforge/miniforge3 (Linux/Ubuntu) base.
FROM csdms/bmi:0.2.1

LABEL org.opencontainers.image.authors="Mark Piper <mark.piper@colorado.edu>"
LABEL org.opencontainers.image.url="https://hub.docker.com/r/csdms/bmi-examples"
LABEL org.opencontainers.image.source="https://github.com/csdms/bmi-examples-docker"
LABEL org.opencontainers.image.vendor="CSDMS"

ENV base_url=https://github.com/csdms

ENV project=bmi-example-c
ENV version="2.0.3"
ENV prefix=/opt/${project}
RUN git clone --branch v${version} ${base_url}/${project} ${prefix}
WORKDIR ${prefix}/_build
RUN cmake .. -DCMAKE_INSTALL_PREFIX=${CONDA_DIR} && \
    make && \
    make test && \
    make install && \
    make clean

ENV project=bmi-example-cxx
ENV version="2.1.2"
ENV prefix=/opt/${project}
RUN git clone --branch v${version} ${base_url}/${project} ${prefix}
WORKDIR ${prefix}/_build
RUN cmake .. -DCMAKE_INSTALL_PREFIX=${CONDA_DIR} && \
    make && \
    make test && \
    make install && \
    make clean

ENV project=bmi-example-fortran
ENV version="2.1.4"
ENV prefix=/opt/${project}
RUN git clone --branch v${version} ${base_url}/${project} ${prefix}
WORKDIR ${prefix}/_build
RUN cmake .. -DCMAKE_INSTALL_PREFIX=${CONDA_DIR} && \
    make && \
    make test && \
    make install && \
    make clean

ENV project=bmi-example-python
ENV version="2.1.2"
ENV prefix=/opt/${project}
RUN git clone --branch v${version} ${base_url}/${project} ${prefix}
WORKDIR ${prefix}
RUN pip install . && \
    pip cache purge

WORKDIR /opt
