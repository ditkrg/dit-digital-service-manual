FROM node:16 as build-stage

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm ci

COPY src src
COPY docs docs
COPY static static
COPY *.js ./

RUN npm run build

FROM nginx:stable-alpine AS production

COPY --from=build-stage /app/build /usr/share/nginx/html
EXPOSE 80
