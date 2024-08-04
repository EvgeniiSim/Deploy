ARG NODE_VERSION=20.16.0

FROM node:${NODE_VERSION}-alpine as build

WORKDIR /app
 
COPY package*.json /app/package*.json

# RUN yarn add vite -D

RUN yarn install

COPY . .

RUN yarn build

FROM nginx:1.27.0

COPY --from=build app/dist /opt/site
COPY nginx.conf /etc/nginx/conf.d/default.conf

CMD [ "nginx", "-g", "daemon off;" ]
