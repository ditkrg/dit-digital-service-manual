FROM node:16 as build-stage

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm ci

COPY src src
COPY docs docs
COPY static static
COPY *.js ./

RUN npm run build

FROM bitnami/nginx:1.20 AS production

COPY --from=build-stage /app/build /app
EXPOSE 8080
