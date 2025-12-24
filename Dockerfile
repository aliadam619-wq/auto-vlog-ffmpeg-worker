FROM node:20-slim

# Install ffmpeg
RUN apt-get update \
  && apt-get install -y ffmpeg \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy package files first (better caching)
COPY package.json package-lock.json* ./
RUN npm install --production

# Copy the rest of the app
COPY . .

# Fly injects PORT at runtime
EXPOSE 3000

CMD ["npm", "start"]

