FROM node:16 as build-stage

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm ci

COPY src src
COPY docs docs
COPY static static
COPY *.js ./

RUN npm run build

FROM nginxinc/nginx-unprivileged:1.20-alpine AS production

COPY --from=build-stage /app/build /usr/share/nginx/html
EXPOSE 8080
