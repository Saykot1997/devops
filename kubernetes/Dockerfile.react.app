# Use an official Node runtime as a parent image
FROM node:14-alpine

# Set the working directory to /app
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies and serve package
RUN npm install --only=production && npm install -g serve

# Copy the build folder to the working directory
COPY build build

# Set environment variables
ENV NODE_ENV production
ENV PORT 3000

# Expose port 3000
EXPOSE 3000

# Start the app
CMD [ "serve", "-s", "build" ]