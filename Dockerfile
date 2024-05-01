# syntax=docker/dockerfile:1

ARG CHM_FILENAME=docs.chm
ARG OUT_DIR=/out

########## Builder ##########
FROM debian:bookworm-slim AS download_extract_zip

# I know it says it's an exe, but it's really a self extracting zip file
ARG ZIP_URL=http://www.asmirvine.com/files/IrvineLibHelp.exe
ARG CHECKSUM_TYPE=sha256
ARG CHECKSUM=b373cbff93e0e8836c85ac4ed458a4302dee51e2fa888915f8e8b60f323a1e13
ARG OUTPUT_ZIP=docs.zip
ARG CHM_FILENAME

# Install packages
# curl		: download documentation
# unzip		: unzipping documentation
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
	apt-get -y upgrade && \
	apt-get -y install --no-install-recommends curl unzip && \
	rm -rf /var/lib/apt/lists/*

WORKDIR /build

ADD --checksum=${CHECKSUM_TYPE}:${CHECKSUM} \
	${ZIP_URL} \
	${OUTPUT_ZIP}

RUN unzip -j ${OUTPUT_ZIP} && \
	rm ${OUTPUT_ZIP}

# there should now be a single .chm file in the working directory
RUN mv IrvineLibHelp.chm docs.chm

########## Builder2 ##########
FROM python:slim-bookworm AS extract_chm

ARG CHM_FILENAME
ARG OUT_DIR

WORKDIR /build

# Install packages
# libchm-dev: hard dependency
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
	apt-get -y upgrade && \
	apt-get -y install --no-install-recommends gcc libc6-dev libchm-dev && \
	rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir setuptools archmage

COPY --from=download_extract_zip /build/${CHM_FILENAME} .

RUN archmage -x $CHM_FILENAME ${OUT_DIR}

########## Output ##########
FROM scratch

ARG OUT_DIR
COPY --from=extract_chm ${OUT_DIR} /
