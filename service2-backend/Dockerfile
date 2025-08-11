FROM node:20-alpine

WORKDIR /app

COPY ./app/package*.json ./
COPY ./app/server.js ./

RUN npm install --production

COPY . .

ENV PORT=80

EXPOSE 80

CMD ["node", "server.js"]
