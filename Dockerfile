FROM node:latest

RUN git clone  https://github.com/sathyarajagopal/spr-npmregistry.git && \
    chown -R node /spr-npmregistry

WORKDIR /spr-npmregistry
USER node 
RUN npm install

WORKDIR /spr-npmregistry
USER node
CMD npm run start

EXPOSE 4873