# 🚀 INSTALACIÓN COMPLETA - n8n en Railway con yt-dlp

## 📋 VISIÓN GENERAL

Railway requiere un **Dockerfile personalizado** para instalar yt-dlp junto con n8n.

---

## 🎯 OPCIÓN 1: USANDO DOCKERFILE (RECOMENDADO)

### **Paso 1: Crear repositorio GitHub**

1. Ve a GitHub.com
2. Crea un nuevo repositorio: `n8n-mananera-bot`
3. Hazlo público o privado

### **Paso 2: Crear archivos necesarios**

Crea estos 3 archivos en tu repositorio:

#### **A) Dockerfile**

```dockerfile
# Usar imagen oficial de n8n
FROM n8nio/n8n:latest

# Cambiar a usuario root para instalar dependencias
USER root

# Instalar yt-dlp
RUN apk add --no-cache \
    curl \
    ffmpeg \
    python3 \
    && curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp \
    && chmod a+rx /usr/local/bin/yt-dlp \
    && yt-dlp --version

# Volver a usuario n8n
USER node

# Puerto de n8n
EXPOSE 5678

# Comando de inicio
CMD ["n8n"]
```

#### **B) .dockerignore**

```
node_modules
npm-debug.log
.git
.gitignore
README.md
```

#### **C) railway.json** (Opcional pero recomendado)

```json
{
  "$schema": "https://railway.app/railway.schema.json",
  "build": {
    "builder": "DOCKERFILE",
    "dockerfilePath": "Dockerfile"
  },
  "deploy": {
    "numReplicas": 1,
    "restartPolicyType": "ON_FAILURE",
    "restartPolicyMaxRetries": 10
  }
}
```

### **Paso 3: Subir a GitHub**

```bash
git init
git add .
git commit -m "n8n con yt-dlp"
git remote add origin https://github.com/TU_USUARIO/n8n-mananera-bot.git
git push -u origin main
```

### **Paso 4: Desplegar en Railway**

1. Ve a https://railway.app
2. Click en **"New Project"**
3. Selecciona **"Deploy from GitHub repo"**
4. Conecta tu cuenta de GitHub
5. Selecciona el repositorio `n8n-mananera-bot`
6. Railway detectará automáticamente el Dockerfile
7. Click en **"Deploy"**

### **Paso 5: Configurar Variables de Entorno**

En Railway, ve a tu proyecto → **Variables** y agrega:

```bash
# n8n básico
N8N_BASIC_AUTH_ACTIVE=true
N8N_BASIC_AUTH_USER=admin
N8N_BASIC_AUTH_PASSWORD=tu_password_seguro

# Webhook URL (Railway te da una URL automática)
WEBHOOK_URL=https://tu-app.up.railway.app/

# Variables del proyecto
YOUTUBE_API_KEY=AIzaSy...
GEMINI_API_KEY=AIzaSy...
GDRIVE_FOLDER_ID=1ABC...
WHATSAPP_PHONE_ID=123...
WHATSAPP_ACCESS_TOKEN=EAA...
WHATSAPP_RECIPIENT_NUMBER=521...

# Zona horaria
TZ=America/Mexico_City
```

### **Paso 6: Verificar instalación**

1. Espera a que Railway termine el deploy (~5 minutos)
2. Railway te dará una URL: `https://tu-app.up.railway.app`
3. Abre la URL en tu navegador
4. Login con las credenciales que configuraste

### **Paso 7: Verificar yt-dlp**

En n8n, crea un workflow de prueba:

**Nodo Code:**
```javascript
const { execSync } = require('child_process');

try {
  const version = execSync('yt-dlp --version', { encoding: 'utf-8' });
  console.log('yt-dlp version:', version);
  
  return [{
    json: {
      success: true,
      version: version.trim(),
      message: '✅ yt-dlp instalado correctamente'
    }
  }];
} catch (error) {
  return [{
    json: {
      success: false,
      error: error.message,
      message: '❌ yt-dlp no está instalado'
    }
  }];
}
```

Ejecuta el nodo. Deberías ver algo como: `2024.12.23`

---

## 🎯 OPCIÓN 2: RAILWAY TEMPLATE (MÁS RÁPIDO)

Si Railway tiene un template de n8n, puedes modificarlo:

### **Paso 1: Usar template de n8n**

1. Ve a https://railway.app/templates
2. Busca "n8n"
3. Click en **"Deploy"**

### **Paso 2: Agregar yt-dlp después del deploy**

Railway no permite SSH directo, pero puedes:

**A) Usar un Init Container Script:**

En Railway → Settings → Start Command, cambia a:

```bash
sh -c 'apk add --no-cache curl ffmpeg python3 && curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp && chmod a+rx /usr/local/bin/yt-dlp && n8n'
```

⚠️ **Problema:** Esto instala yt-dlp cada vez que se reinicia el contenedor.

**Mejor solución:** Usar Dockerfile personalizado (Opción 1)

---

## 🎯 OPCIÓN 3: USAR NIXPACKS (Railway moderno)

Railway ahora usa Nixpacks por defecto. Puedes crear:

### **nixpacks.toml**

```toml
[phases.setup]
nixPkgs = ["nodejs_18", "python3", "ffmpeg"]

[phases.install]
cmds = [
  "npm install -g n8n",
  "curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp",
  "chmod a+rx /usr/local/bin/yt-dlp"
]

[start]
cmd = "n8n"
```

Sube esto a tu repo y Railway lo detectará automáticamente.

---

## 🐳 OPCIÓN 4: DOCKER COMPOSE (Para desarrollo local)

Si quieres probarlo localmente primero:

### **docker-compose.yml**

```yaml
version: '3.8'

services:
  n8n:
    build: .
    container_name: n8n-mananera
    ports:
      - "5678:5678"
    environment:
      - N8N_BASIC_AUTH_ACTIVE=true
      - N8N_BASIC_AUTH_USER=admin
      - N8N_BASIC_AUTH_PASSWORD=admin123
      - YOUTUBE_API_KEY=${YOUTUBE_API_KEY}
      - GEMINI_API_KEY=${GEMINI_API_KEY}
      - GDRIVE_FOLDER_ID=${GDRIVE_FOLDER_ID}
      - TZ=America/Mexico_City
    volumes:
      - n8n_data:/home/node/.n8n
    restart: unless-stopped

volumes:
  n8n_data:
```

Ejecutar:
```bash
docker-compose up -d
```

---

## 📋 RESUMEN DE PASOS (OPCIÓN 1 - RECOMENDADA)

1. ✅ Crear repo GitHub
2. ✅ Crear Dockerfile con yt-dlp
3. ✅ Push a GitHub
4. ✅ Conectar Railway con GitHub
5. ✅ Configurar variables de entorno
6. ✅ Deploy automático
7. ✅ Importar workflow v5
8. ✅ ¡Funciona!

---

## 🔧 TROUBLESHOOTING

### **Error: "yt-dlp: not found"**

**Solución:** Verificar que el Dockerfile se construyó correctamente.

En Railway → Deployments → Build Logs, deberías ver:
```
Step 4/6 : RUN apk add --no-cache curl ffmpeg python3 ...
✓ yt-dlp installed successfully
```

### **Error: "Permission denied"**

**Solución:** Asegúrate de que el `chmod a+rx` esté en el Dockerfile.

### **Railway no detecta el Dockerfile**

**Solución:** 
1. Asegúrate de que el archivo se llame exactamente `Dockerfile` (con D mayúscula)
2. Debe estar en la raíz del repositorio
3. En Railway → Settings → Build, fuerza "Dockerfile" como builder

---

## 🎯 SIGUIENTE PASO

Una vez que tengas n8n corriendo en Railway con yt-dlp instalado:

1. **Importa** el workflow: `Resumen_Mañanera_v5_JAVASCRIPT.json`
2. **Configura** las variables de entorno
3. **Prueba** con fecha: 2026-02-03
4. **¡Listo!** 🎉

---

## 💰 COSTOS DE RAILWAY

- **Starter Plan:** $5/mes
- **Hobby Plan:** Gratis con $5 de crédito/mes
- **Pro Plan:** $20/mes

Para este proyecto, el Hobby Plan es suficiente.

---

¿Necesitas ayuda con algún paso específico?
