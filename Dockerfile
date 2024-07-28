ARG NODE_VERSION=20.16.0

FROM node:${NODE_VERSION}-alpine as build
 
COPY package*.json ./

# RUN yarn add vite -D

RUN yarn

COPY . .

RUN yarn run build

FROM nginx:1.27.0

COPY --from=build /dist /usr/share/nginx/html
COPY --from=build nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 3000

CMD [ "nginx", '-g', 'daemon off;' ]
