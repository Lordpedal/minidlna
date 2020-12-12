# Alpine v3
FROM alpine:3
LABEL maintainer "Lordpedal - https://t.me/lordpedal_rss"

# Instalacion dependencias
RUN apk --no-cache add bash curl minidlna tini

# Usuario MiniDLNA
RUN chown minidlna:minidlna /etc/minidlna.conf && chmod ugo+w /etc/minidlna.conf
RUN mkdir /minidlna && chown minidlna:minidlna /minidlna && chmod 777 /minidlna
USER minidlna
RUN mkdir /minidlna/cache && chmod 777 /minidlna/cache

# Arranque Docker
COPY lordpedal.sh /
EXPOSE 1900/udp
EXPOSE 8200
ENTRYPOINT ["/sbin/tini", "--", "/lordpedal.sh"]

# Check Docker
HEALTHCHECK --interval=10s --timeout=10s --retries=6 CMD \
  curl --silent --fail localhost:8200 || exit 1
