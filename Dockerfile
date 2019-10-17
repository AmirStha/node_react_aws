FROM node:carbon as builder

ARG BIT_NODE_TOKEN
RUN mkdir -p /usr/builder/code
WORKDIR /usr/builder/code
ENV PATH /usr/builder/code/node_modules/.bin:$PATH
COPY package.json package.json
RUN echo "Adding bit.dev to npm registry" && \
  echo "always-auth=true" >> ~/.npmrc && \
  echo "@bit:registry=https://node.bit.dev" >> ~/.npmrc && \
  echo "//node.bit.dev/:_authToken=$BIT_NODE_TOKEN" >> ~/.npmrc
RUN npm install

FROM node:carbon as main

RUN mkdir -p /usr/main/code
WORKDIR /usr/main/code
ENV PATH /usr/main/code/node_modules/.bin:$PATH

RUN apt-get update

COPY . .
COPY --from=builder /usr/builder/code/node_modules /usr/main/code/node_modules
ARG BIT_NODE_TOKEN
RUN echo "Adding bit.dev to npm registry" && \
  echo "always-auth=true" >> ~/.npmrc && \
  echo "@bit:registry=https://node.bit.dev" >> ~/.npmrc && \
  echo "//node.bit.dev/:_authToken=$BIT_NODE_TOKEN" >> ~/.npmrc

EXPOSE 3001
CMD export NODE_OPTIONS=--max_old_space_size=4096 && npm run build && npm run server
