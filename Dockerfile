# Step 1: Build the Next.js app
FROM node:18 AS build

WORKDIR /app

# Copy dependencies and install
COPY package.json package-lock.json ./
RUN npm install

# Copy the application code
COPY . ./

# Build the app
RUN npm run build

# Step 2: Serve the Next.js app
FROM node:18-slim

WORKDIR /app

# Copy built application from the build stage
COPY --from=build /app ./
RUN npm install --production

# Expose the dynamic port (Render sets this through the PORT environment variable)
EXPOSE 3000

# Set the port that Next.js should use
ENV PORT 3000

# Start the Next.js app and make sure it respects the dynamic port (Render uses $PORT)
CMD ["npm", "start"]
