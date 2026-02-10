FROM n8nio/n8n:latest

USER root

# Verificar qué herramientas están disponibles
RUN echo "=== Sistema detectado ===" \
    && cat /etc/os-release || echo "No /etc/os-release" \
    && echo "=== Comandos disponibles ===" \
    && which curl || which wget || echo "No curl/wget" \
    && echo "=========================="

# Instalar curl si no está (intentar con diferentes package managers)
RUN (which curl > /dev/null 2>&1) || \
    (apk add --no-cache curl 2>/dev/null) || \
    (apt-get update && apt-get install -y curl 2>/dev/null) || \
    (yum install -y curl 2>/dev/null) || \
    echo "curl ya instalado o no se pudo instalar"

# Descargar yt-dlp
RUN curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp \
    && chmod a+rx /usr/local/bin/yt-dlp

# Verificar
RUN /usr/local/bin/yt-dlp --version && echo "✅ yt-dlp instalado correctamente"

USER node

EXPOSE 5678

CMD ["n8n"]
