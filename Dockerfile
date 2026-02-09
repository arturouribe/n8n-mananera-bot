# Imagen base oficial de n8n
FROM n8nio/n8n:latest

# Cambiar a root para instalar dependencias
USER root

# Instalar dependencias del sistema y yt-dlp
RUN apk add --no-cache \
    curl \
    ca-certificates \
    ffmpeg \
    python3 \
    py3-pip \
    && curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp \
    && chmod a+rx /usr/local/bin/yt-dlp \
    && yt-dlp --version

# Verificar instalación
RUN echo "✅ yt-dlp instalado:" && yt-dlp --version

# Volver a usuario node (no root por seguridad)
USER node

# Puerto de n8n
EXPOSE 5678

# Variables de entorno por defecto
ENV N8N_PORT=5678
ENV N8N_PROTOCOL=https
ENV NODE_ENV=production

# Comando de inicio
CMD ["n8n"]
