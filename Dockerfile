FROM node:10.15.3

ARG PORT=5050
ENV PORT=${PORT}

ARG CONFIG_NET=production
ENV CONFIG_NET=${CONFIG_NET}

RUN apt-get update && apt-get install -y git git-core

WORKDIR /home/robiks
COPY . /home/robiks

RUN npm install -g @angular/cli@7.1.0
RUN cd /home/robiks && npm install
RUN cd /home/robiks && npm run postinstall
RUN cd /home/robiks && ng build --configuration=${CONFIG_NET}

CMD ["node", "/home/robiks/server.js"]

EXPOSE ${PORT}