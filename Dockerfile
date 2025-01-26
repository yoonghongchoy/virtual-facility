# Base image
FROM node:18-alpine

# Install pnpm
RUN npm install -g pnpm

# Define variables
ARG APP_NAME

# Create app directory
WORKDIR /usr/src/app

# Copy package.json, pnpm-lock.yaml, and other necessary files
COPY package.json pnpm-lock.yaml ./

# Install app dependencies
RUN pnpm install --frozen-lockfile

# Bundle app source
COPY . .

# Creates a "dist" folder with the production build
RUN pnpm run build -- ${APP_NAME}

# Start the server using the production build
CMD [ "node", "dist/apps/${APP_NAME}/main.js" ]