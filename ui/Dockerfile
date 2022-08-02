FROM node:18.3-buster

USER root 

WORKDIR /app

COPY package.json package.json 

RUN npm i 

COPY . .


EXPOSE 3000

CMD npm run start 
