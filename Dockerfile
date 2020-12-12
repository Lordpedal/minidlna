FROM alpine:3
LABEL maintainer "Lordpedal"

# Instalar paquetes
RUN apk --no-cache add bash curl minidlna tini

# Definir usuario MiniDLNA
RUN chown minidlna:minidlna /etc/minidlna.conf && chmod ugo+w /etc/minidlna.conf
RUN mkdir /minidlna && chown minidlna:minidlna /minidlna && chmod 777 /minidlna
USER minidlna
RUN mkdir /minidlna/cache && chmod 777 /minidlna/cache

# Arranque
COPY lordpedal.sh /
EXPOSE 1900/udp
EXPOSE 8200
ENTRYPOINT ["/sbin/tini", "--", "/lordpedal.sh"]

# Health check
HEALTHCHECK --interval=10s --timeout=10s --retries=6 CMD \
  curl --silent --fail localhost:8200 || exit 1

# Metadata params
ARG VERSION
ARG VCS_URL
ARG VCS_REF
ARG BUILD_DATE

# Metadata
LABEL org.opencontainers.image.title="Lordpedal MiniDLNA" \
      org.opencontainers.image.url="$VCS_URL" \
      org.opencontainers.image.authors="Lordpedal" \
      org.opencontainers.image.licenses="Apache-2.0" \
      org.opencontainers.image.version="$VERSION" \
      org.opencontainers.image.source="$VCS_URL" \
      org.opencontainers.image.revision="$VCS_REF" \
      org.opencontainers.image.created="$BUILD_DATE"
