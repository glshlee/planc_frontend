# Build stage
FROM node:16 as build
WORKDIR /app
COPY package*.json ./

RUN npm config set loglevel verbose

# RUN npm cache clean --force
RUN npm ci
COPY . .
RUN npm run build

# Production stage
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]