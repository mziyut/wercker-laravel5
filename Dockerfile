FROM ryanwinchester/wercker-laravel5

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 6.3.0

# switch defulat shell.
RUN rm /bin/sh \
	&& ln -s /bin/bash /bin/sh

# Install nvm with node and npm
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash \
    && source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/v$NODE_VERSION/bin:$PATH
