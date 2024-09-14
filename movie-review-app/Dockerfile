# Use the official Node.js image as the base image
FROM node:20 AS build

# Set the working directory
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the Vue.js application
RUN npm run build

# Use an NGINX image to serve the built app
FROM nginx:alpine

# Copy the built app from the previous stage to NGINX
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port 80 for the application
EXPOSE 80

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
