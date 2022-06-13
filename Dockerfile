FROM node:15-alpine AS app-build

WORKDIR /app

COPY . .

RUN npm install && \
npm run build

FROM node:15-alpine AS app-run-prod

WORKDIR /app

COPY --from=app-build ./app/build ./build

COPY package* ./

RUN npm install --production

EXPOSE 5000

CMD node ./build/app.js > chat-app-server.out
