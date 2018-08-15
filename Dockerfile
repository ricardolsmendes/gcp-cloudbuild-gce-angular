FROM node:8-alpine AS build-stage
WORKDIR /app
COPY . .
RUN npm install && \
    npm run build --prod

FROM nginx:alpine
## Remove default nginx website
RUN rm -rf /usr/share/nginx/html/*
## From 'build' stage copy over the artifacts in dist folder to default nginx public folder
COPY --from=build-stage /app/dist/gcp-cloudbuild-gce-angular /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]
