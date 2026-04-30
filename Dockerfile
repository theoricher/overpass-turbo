FROM node:22-alpine AS builder

RUN apk add --no-cache git && \
    corepack enable

WORKDIR /app

COPY . .

RUN pnpm install --frozen-lockfile

# Fix missing L (Leaflet) global injection in vite.config.mts
RUN node -e "var fs=require('fs');var c=fs.readFileSync('vite.config.mts','utf8');c=c.replace('jQuery: \"jquery\"','jQuery: \"jquery\",\n      L: \"leaflet\"');fs.writeFileSync('vite.config.mts',c);"

RUN pnpm build

FROM nginx:alpine

COPY --from=builder /app/dist /usr/share/nginx/html
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 80
ENTRYPOINT ["/docker-entrypoint.sh"]
