FROM reg.dev.krd/hub.docker/library/node:16 as build-stage

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm ci

COPY src src
COPY docs docs
COPY static static
COPY *.js ./

RUN npm run build

FROM reg.dev.krd/hub.docker/library/nginx:1.20-alpine AS production

COPY --from=build-stage /app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
