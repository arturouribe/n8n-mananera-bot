FROM n8nio/n8n:latest

USER root

# Descargar yt-dlp usando wget
RUN wget -O /usr/local/bin/yt-dlp https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp \
    && chmod a+rx /usr/local/bin/yt-dlp

USER node

EXPOSE 5678

CMD ["n8n"]
