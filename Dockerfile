FROM alpine:3
LABEL maintainer "Lordpedal"

# Instalar paquetes
RUN apk --no-cache add bash curl minidlna tini

# Definir usuario MiniDLNA
RUN chown minidlna:minidlna /etc/minidlna.conf && chmod ugo+w /etc/minidlna.conf
RUN mkdir /minidlna && chown minidlna:minidlna /minidlna && chmod 777 /minidlna
USER minidlna
RUN mkdir /minidlna/cache && chmod 777 /minidlna/cache

# Inicio
COPY lordpedal.sh /
ENTRYPOINT ["/sbin/tini", "--", "/lordpedal.sh"]

# Puertos
EXPOSE 1900/udp
EXPOSE 8200

# Health check
HEALTHCHECK --interval=10s --timeout=10s --retries=6 CMD \
  curl --silent --fail localhost:8200 || exit 1
