FROM n8nio/n8n:latest

USER root

# Instalar dependencias usando apt (Debian/Ubuntu)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    ffmpeg \
    python3 \
    && curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp \
    && chmod a+rx /usr/local/bin/yt-dlp \
    && yt-dlp --version \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER node

EXPOSE 5678

CMD ["n8n"]
