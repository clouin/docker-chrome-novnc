#!/bin/bash
export USER=nobody
chrome_window_size=$(($WIDTH + 1)),$(($HEIGHT + 1))
chrome_param="--test-type --window-size=$chrome_window_size --no-sandbox --window-position=0,0 --user-data-dir=/config/google-chrome"
vnc_geometry=$WIDTH'x'$HEIGHT
vnc_config=/root/.vnc

if [ ! -e '/config/google-chrome/First Run' ]; then
  mkdir -p /config/google-chrome
  touch '/config/google-chrome/First Run'
fi
if [ ! -e "$vnc_config" ]; then
  mkdir -p $vnc_config
fi

vncpasswd -f <<<"$VNC_PASSWORD" >"$vnc_config/passwd"
chmod 600 $vnc_config/passwd
echo "while [ 1 ]; do /opt/google/chrome/google-chrome $chrome_param; done" >"$vnc_config/xstartup"
chmod +x $vnc_config/xstartup
vncserver -kill :1 1>/dev/null 2>&1

if [ -e /tmp/.X11-unix ]; then
  rm -rf /tmp/.X11-unix
fi
if [ -e /tmp/.X1-lock ]; then
  rm -rf /tmp/.X1-lock
fi

vncserver -name chrome-novnc -depth 24 -geometry "$vnc_geometry" :1
/opt/novnc/utils/novnc_proxy --vnc localhost:5901