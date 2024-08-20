# Stage 1: Build the React app
FROM node:16-alpine AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json and package-lock.json (if available)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the React app
RUN npm run build

# Stage 2: Serve the app with nginx
FROM nginx:alpine

# Copy the build output to nginx's default public directory
COPY --from=build /app/build /usr/share/nginx/html

# Expose the port on which nginx is running
EXPOSE 80

# Start nginx server
CMD ["nginx", "-g", "daemon off;"]
