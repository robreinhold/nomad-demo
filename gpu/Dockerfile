FROM node:6.1

ENV work /app

WORKDIR ${work}

ADD gpu.js ${work}

RUN npm install restify

EXPOSE 8080

CMD ["node", "gpu.js"]