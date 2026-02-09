# 🤖 Bot Resumen Mañanera del Pueblo

Workflow automatizado de n8n para generar resúmenes diarios de la Mañanera del Pueblo usando IA.

## 🚀 Deploy en Railway

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/new)

## 📋 Características

- ✅ Obtiene videos automáticamente del canal de YouTube
- ✅ Extrae transcripción usando yt-dlp
- ✅ Genera resumen estructurado con Google Gemini
- ✅ Guarda en Google Drive y Supabase
- ✅ Envía notificación por WhatsApp
- ✅ Ejecuta automáticamente L-V a las 9:00 AM México

## 🔧 Variables de Entorno Requeridas

Configura estas variables en Railway:

```bash
# n8n
N8N_BASIC_AUTH_ACTIVE=true
N8N_BASIC_AUTH_USER=admin
N8N_BASIC_AUTH_PASSWORD=tu_password_seguro
WEBHOOK_URL=https://tu-app.up.railway.app/

# APIs
YOUTUBE_API_KEY=AIzaSy...
GEMINI_API_KEY=AIzaSy...
GDRIVE_FOLDER_ID=1ABC...
WHATSAPP_PHONE_ID=123...
WHATSAPP_ACCESS_TOKEN=EAA...
WHATSAPP_RECIPIENT_NUMBER=521...

# Configuración
TZ=America/Mexico_City
```

## 📦 Instalación

### Opción 1: Deploy directo desde GitHub

1. Fork este repositorio
2. Ve a [Railway](https://railway.app)
3. Click en "New Project" → "Deploy from GitHub repo"
4. Selecciona este repositorio
5. Configura las variables de entorno
6. ¡Deploy automático!

### Opción 2: Deploy manual

1. Clona el repositorio:
```bash
git clone https://github.com/TU_USUARIO/n8n-mananera-bot.git
cd n8n-mananera-bot
```

2. Push a Railway:
```bash
railway login
railway init
railway up
```

## 🎯 Uso

1. Accede a tu instancia de n8n: `https://tu-app.up.railway.app`
2. Importa el workflow: `Resumen_Mañanera_v5_JAVASCRIPT.json`
3. Configura las credenciales necesarias
4. Activa el workflow
5. ¡Listo! Se ejecutará automáticamente L-V a las 9 AM

## 🧪 Prueba Manual

1. En n8n, abre el workflow
2. Ve al nodo "Set Date Parameter"
3. Cambia la fecha a una fecha con mañanera (ej: 2026-02-03)
4. Click en "Execute Workflow"
5. Espera ~30 segundos
6. Verifica el resultado

## 📚 Documentación

- [Guía de Instalación Completa](INSTALACION_RAILWAY_COMPLETA.md)
- [Workflow v5](Resumen_Mañanera_v5_JAVASCRIPT.json)

## 🛠️ Stack Tecnológico

- **n8n**: Automatización de workflows
- **yt-dlp**: Extracción de subtítulos de YouTube
- **Google Gemini**: Generación de resúmenes con IA
- **Google Drive**: Almacenamiento de reportes
- **Supabase**: Base de datos PostgreSQL
- **WhatsApp Business API**: Notificaciones

## 📄 Licencia

MIT

## 🤝 Contribuciones

¡Contribuciones son bienvenidas! Por favor abre un issue o PR.
