# STAGE 1
### STAGE 1: Build ###

# We label our stage as ‘builder’
FROM node:16.14.2-alpine as builder

RUN #!/bin/sh
RUN apk add --update git

COPY package.json package-lock.json ./

## Storing node modules on a separate layer will prevent unnecessary npm installs at each build

#RUN npm ci && mkdir /ng-app && mv ./node_modules ./ng-app
RUN npm i && mkdir /ng-app && mv ./node_modules ./ng-app

WORKDIR /ng-app

COPY . .

## Build the angular app in production mode and store the artifacts in dist folder
ARG ENV=stage

RUN npm run ng build


# STAGE 2
FROM nginx:1.14.1-alpine
# COPY --from=builder /usr/src/todo/dist /usr/share/nginx/html
