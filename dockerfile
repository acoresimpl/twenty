# Usa una imagen base de Node.js
FROM node:18 as builder

# Directorio de trabajo
WORKDIR /usr/src/app

# Copia package.json y instalación de dependencias
COPY package*.json ./
RUN npm ci --only=production

# Copia el resto del código
COPY . .

# Construye la aplicación si es necesario
# RUN npm run build

# Comienza desde una imagen ligera
FROM node:18-slim
WORKDIR /usr/src/app

# Copia solo lo necesario del stage anterior
COPY --from=builder /usr/src/app ./

# Expone el puerto
EXPOSE 3000

# Comando para iniciar la app
CMD ["npm", "run", "start"]
