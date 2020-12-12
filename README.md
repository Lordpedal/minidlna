# docker MiniDLNA - [Tutorial](https://blog.lordpedal.duckdns.org/ "miniDLNA: Docker")

Modos de ejecución para crear el container:

### docker-compose (*Opción recomendada*)

Compatible con los esquemas docker-compose v2.

```
version: "2"
services:
  minidlna:
    image: lordpedal/minidlna
    container_name: miniDLNA
    network_mode: host
    environment:
      - MINIDLNA_MEDIA_DIR_1=AVP,/media/Descargas
      - MINIDLNA_MEDIA_DIR_2=A,/media/Musica
      - MINIDLNA_MEDIA_DIR_3=V,/media/Videos
      - MINIDLNA_MEDIA_DIR_4=P,/media/Imagenes
      - MINIDLNA_FRIENDLY_NAME=Lordpedal DLNA
      - MINIDLNA_INOTIFY=yes
      - MINIDLNA_ROOT_CONTAINER=B
      - MINIDLNA_MAX_CONNECTIONS=7
      - MINIDLNA_SERIAL=15161881
      - MINIDLNA_MODEL_NUMBER=1
      - MINIDLNA_PORT=8200
    volumes:
      - '~/docker/minidlna/Descargas:/media/Descargas'
      - '~/docker/minidlna/Musica:/media/Musica'
      - '~/docker/minidlna/Videos:/media/Videos'
      - '~/docker/minidlna/Imagenes:/media/Imagenes'
    restart: always
```

### docker-cli

```
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
```

## Parámetros

Las imágenes de contenedor se configuran utilizando parámetros pasados en tiempo de ejecución (como los anteriores). 
Estos parámetros están separados por dos puntos e indican ``<external>: <internal>`` respectivamente. 

| Parámetro | Función |
| ------ | ------ |
| -v ``<Ruta_Origen_Descargas>:/media/Descargas`` | Definimos ruta donde alojamos las descargas a compartir por Red |
| -v ``<Ruta_Origen_Musica>:/media/Musica`` | Definimos ruta donde alojamos la musica a compartir por Red |
| -v ``<Ruta_Origen_Videos>:/media/Videos`` | Definimos ruta donde alojamos los videos a compartir por Red |
| -v ``<Ruta_Origen_Imagenes>:/media/Imagenes`` | Definimos ruta donde alojamos las imagenes a compartir por Red |
| -v ``... : ...`` | Respetando la estructura podriamos seguir añadiendo contenidos |
| ``--net=host`` | Habilitamos el uso de la red ``host`` en vez de una virtual para docker |

## Variables entorno

Puedes especificar culaquier variable del fichero [minidlna.conf](http://manpages.ubuntu.com/manpages/raring/man5/minidlna.conf.5.html), añadiendo la variable ``MINIDLNA_``.

| Parámetro | Función |
| ------ | ------ |
| -e ``MINIDLNA_MEDIA_DIR_1=AVP,/media/Descargas`` | Definimos que el contenido puede contener: Audio, Video o Imagenes (**AVP**) |
| -e ``MINIDLNA_MEDIA_DIR_2=A,/media/Musica`` | Definimos que el contenido puede contener: Audio (**A**) |
| -e ``MINIDLNA_MEDIA_DIR_3=V,/media/Videos`` | Definimos que el contenido puede contener: Videos (**V**) |
| -e ``MINIDLNA_MEDIA_DIR_4=P,/media/Imagenes`` | Definimos que el contenido puede contener: Imagenes (**P**) |
| -e ``MINIDLNA_MEDIA_DIR_n= ...`` | Respetando la estructura podriamos seguir añadiendo contenidos, **n** sería el siguiente número |
| -e ``MINIDLNA_INOTIFY=yes`` | Actualiza la base de datos cuando detecta nuevo contenido |
| -e ``MINIDLNA_ROOT_CONTAINER=B`` | Definimos como mostras la estructura del contenido |
| -e ``MINIDLNA_MAX_CONNECTIONS=7`` | Definimos el número máximo de clientes DLNA |
| -e ``MINIDLNA_PORT=8200`` | Asignamos el puerto de comunicación **8200** |

## Gestión Web

Accedemos con un navegador web a la ``ip_del_host:8200`` para usar la interfaz web

> ... la culminación de un fin es el comienzo de una realidad.
