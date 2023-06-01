# Chrome With noVNC

## Run Chrome in docker container

```
docker run -d --restart=unless-stopped --name=chrome-novnc -p 6080:6080 -v /data/chrome-novnc:/config -e VNC_PASSWORD=vnc_password jerryin/chrome-novnc
```

### Environment variable

| Variable name  | Default value  |
| -------------- | -------------- |
| `VNC_PASSWORD` | `vnc_password` |
| `WIDTH`        | `1280`         |
| `HEIGHT`       | `720`          |
| `LANGUAGE`     | `en_US.UTF-8`  |

### Docker compose

```
version: "3.8"

services:
  chrome-novnc:
    image: jerryin/chrome-novnc
    container_name: chrome-novnc
    environment:
      - VNC_PASSWORD=vnc_password
    volumes:
      - ./config/:/config
    ports:
      - 6080:6080
    restart: unless-stopped
```
