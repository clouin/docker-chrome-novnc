FROM debian:bullseye-slim

# Install Chrome
RUN apt update && \
    apt upgrade -y && \
    apt install --no-install-recommends -y wget fonts-droid-fallback && \
    wget --no-check-certificate https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/google-chrome-stable_current_amd64.deb && \
    apt install --no-install-recommends -f -y /tmp/google-chrome-stable_current_amd64.deb && \
    rm /tmp/google-chrome-stable_current_amd64.deb

# Install vnc server and noVNC
ARG NOVNC_VERSION=v1.4.0
RUN apt install --no-install-recommends -y tightvncserver xfonts-base git websockify python-pkg-resources net-tools procps && \
    git clone --branch $NOVNC_VERSION https://github.com/novnc/noVNC.git /opt/novnc

# Configuration
COPY chrome-novnc.sh /usr/bin/chrome-novnc.sh
RUN ln -s /opt/novnc/vnc.html /opt/novnc/index.html && \
    chmod +x /usr/bin/chrome-novnc.sh && \
# Clean
    apt purge -y git && \
    apt autoremove --purge -y && \
    rm -rf /var/lib/apt/lists/*

ENV VNC_PASSWORD=vnc_password \
    WIDTH=1280 \
    HEIGHT=720 \
    LANGUAGE=en_US.UTF-8

EXPOSE 6080

VOLUME /config

CMD ["bash", "-c", "/usr/bin/chrome-novnc.sh"]