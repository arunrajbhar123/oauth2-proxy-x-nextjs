# Use the official Node.js image.
FROM node:latest

# Create and change to the app directory.
WORKDIR /app

# Copy application dependency manifests to the container image.
COPY package*.json ./

# Install dependencies.
RUN npm install

# Copy local code to the container image.
COPY . .

# Build the Next.js app.
RUN npm run build

# Start the Next.js app.
CMD ["npm", "start"]