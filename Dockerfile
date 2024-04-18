FROM node:19-alpine3.15 as dev
WORKDIR /app
COPY package*.json ./
RUN corepack enable pnpm
RUN pnpm install

FROM node:19-alpine3.15 as builder
WORKDIR /app
COPY --from=dev /app/node_modules ./node_modules
COPY . .
RUN corepack enable pnpm
RUN pnpm run build
EXPOSE 3000
ENV NUXT_HOST=0.0.0.0
ENV NUXT_PORT=3000
CMD ["node", ".output/server/index.mjs"]