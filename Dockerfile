FROM n8nio/n8n:latest

USER root

# Usar wget (que SÍ está disponible) en lugar de curl
RUN wget -O /usr/local/bin/yt-dlp https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp \
    && chmod a+rx /usr/local/bin/yt-dlp \
    && /usr/local/bin/yt-dlp --version

USER node

EXPOSE 5678

CMD ["n8n"]
