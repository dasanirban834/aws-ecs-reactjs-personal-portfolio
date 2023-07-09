#Stage 1
# Fetch the latest image of node
FROM node:alpine as builder
# Set up working directry
WORKDIR /app
# Copy package.json to working directory
COPY package.json ./
COPY package-lock.json ./
COPY . .
RUN npm install
# Coping all file in our project
#Starting application
CMD [ "npm", "run", "start" ]
