FROM node:20-slim

# Install ffmpeg
RUN apt-get update \
  && apt-get install -y ffmpeg \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY package.json package-lock.json* ./
RUN npm install --production

COPY . .

# Fly.io expects the app to listen on $PORT
EXPOSE 8080

CMD ["npm", "start"]
