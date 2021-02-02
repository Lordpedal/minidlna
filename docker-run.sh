#!/bin/bash
docker run -d \
        --name=miniDLNA \
        -v $HOME/docker/minidlna/Descargas:/media/Descargas \
        -v $HOME/docker/minidlna/Musica:/media/Musica \
        -v $HOME/docker/minidlna/Videos:/media/Videos \
        -v $HOME/docker/minidlna/Imagenes:/media/Imagenes \
        -e MINIDLNA_MEDIA_DIR_1=AVP,/media/Descargas \
        -e MINIDLNA_MEDIA_DIR_2=A,/media/Musica \
        -e MINIDLNA_MEDIA_DIR_3=V,/media/Videos \
        -e MINIDLNA_MEDIA_DIR_4=P,/media/Imagenes \
        -e MINIDLNA_FRIENDLY_NAME="Lordpedal DLNA" \
        -e MINIDLNA_INOTIFY=yes \
        -e MINIDLNA_ROOT_CONTAINER=B \
        -e MINIDLNA_MAX_CONNECTIONS=7 \
        -e MINIDLNA_SERIAL=15161881 \
        -e MINIDLNA_MODEL_NUMBER=1 \
        -e MINIDLNA_PORT=8200 \
        --net=host \
        --restart=always \
        lordpedal/minidlna
