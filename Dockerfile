FROM node:latest

WORKDIR /
RUN git clone  https://github.com/sathyarajagopal/spr-npmregistry.git && \
    chown -R node /spr-npmregistry

ENV VERDACCIO_APPDIR=/spr-npmregistry \
    VERDACCIO_USER_NAME=verdaccio \
    VERDACCIO_USER_UID=10001 \
    VERDACCIO_PORT=4873 \
    VERDACCIO_PROTOCOL=http
ENV PATH=$VERDACCIO_APPDIR/node_modules/verdaccio/bin:$PATH

WORKDIR /spr-npmregistry
USER node 
RUN npm install

# RUN chown -R $VERDACCIO_USER_UID:root /verdaccio/storage && \
#     chmod -R g=u /verdaccio/storage

# USER $VERDACCIO_USER_UID

EXPOSE $VERDACCIO_PORT

CMD verdaccio --config ./conf/registry-config.yaml --listen $VERDACCIO_PROTOCOL://0.0.0.0:$VERDACCIO_PORT