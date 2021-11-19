#
# Subtitle Edit Dockerfile
#
# https://github.com/csandman/docker-subtitle-edit
#

# Pull base image.
FROM jlesage/baseimage-gui:ubuntu-18.04

# Docker image version is provided via build arg.
ARG DOCKER_IMAGE_VERSION=unknown

# Define software download URLs.
ARG SUBTITLEEDIT_URL=https://github.com/SubtitleEdit/subtitleedit/releases/download/3.6.3/SE363.zip

# Define working directory.
WORKDIR /tmp

# Download Subtitle Edit.
RUN add-pkg --virtual build-dependencies \
  curl \
  unzip \
  && mkdir -p /defaults \
  # Download.
  && curl -# -L -o /tmp/se.zip ${SUBTITLEEDIT_URL} \
  && unzip /tmp/se.zip -d /defaults \
  # Cleanup.
  && del-pkg build-dependencies \
  && rm -rf /tmp/* /tmp/.[!.]*

# Install dependencies.
RUN add-pkg \
  mono-complete \
  libhunspell-dev \
  libmpv-dev \
  tesseract-ocr-all \
  vlc \
  ffmpeg

# Maximize only the main/initial window.
RUN \
  sed-patch 's/<application type="normal">/<application type="normal" title="Subtitle Edit">/' \
  /etc/xdg/openbox/rc.xml

# Generate and install favicons.
RUN \
  APP_ICON_URL=https://raw.githubusercontent.com/csandman/docker-subtitle-edit/master/se-icon.png?token=ACGJR47ZCPDPMXPTDGIDYFTBUBDYO && \
  install_app_icon.sh "$APP_ICON_URL"

# Add files.
COPY rootfs/ /

# Set environment variables.
ENV APP_NAME="Subtitle Edit" \
  S6_KILL_GRACETIME=8000 \
  ENABLE_CJK_FONT=1

# Define mountable directories.
VOLUME ["/config"]
VOLUME ["/data"]

# Metadata.
LABEL \
  org.label-schema.name="subtitle-edit" \
  org.label-schema.description="Docker container for Subtitle Edit" \
  org.label-schema.version="$DOCKER_IMAGE_VERSION" \
  org.label-schema.vcs-url="https://github.com/csandman/docker-subtitle-edit" \
  org.label-schema.schema-version="1.0"
