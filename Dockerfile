FROM node:16 as build

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm ci

COPY src src
COPY docs docs
COPY static static
COPY *.js ./

RUN npm run build

RUN echo "nobody:x:1001:1001:nobody:/:" > /etc_passwd
RUN chown -R 1001:1001 /app/build

FROM reg.dev.krd/hub.docker/joseluisq/static-web-server:2 AS production

COPY --from=build /app/build /public
COPY --from=build /etc_passwd /etc/passwd

ENV SERVER_PORT=8080
ENV SERVER_LOG_LEVEL=info
ENV SERVER_FALLBACK_PAGE=/public/404.html

USER nobody

EXPOSE 8080
