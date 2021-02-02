#!/usr/bin/env bash
#
# Another fine release by Lordpedal
#
# Variables bash
set -euo pipefail
IFS=$'\n\t'
pidfile="/minidlna/minidlna.pid"
#
# Borrar viejos pid si existen
[ -f $pidfile ] && rm -f $pidfile
#
# Habilitar cambios configuracion
: > /etc/minidlna.conf
for VAR in $(env); do
  if [[ "$VAR" =~ ^MINIDLNA_ ]]; then
    if [[ "$VAR" =~ ^MINIDLNA_MEDIA_DIR ]]; then
      minidlna_name='media_dir'
    else
      minidlna_name=$(echo "$VAR" | sed -r "s/MINIDLNA_(.*)=.*/\\1/g" | tr '[:upper:]' '[:lower:]')
    fi
    minidlna_value=$(echo "$VAR" | sed -r "s/.*=(.*)/\\1/g")
    echo "${minidlna_name}=${minidlna_value}" >> /etc/minidlna.conf
  fi
done
#
# Directorios con permisos de escritura
echo "db_dir=/minidlna/cache" >> /etc/minidlna.conf
echo "log_dir=/minidlna/" >>/etc/minidlna.conf
#
# Iniciar servicio
exec /usr/sbin/minidlnad -P $pidfile -S "$@"
