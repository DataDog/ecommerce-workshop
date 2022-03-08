# build environment
FROM node:13.12.0-alpine as build
WORKDIR /app
COPY ./src/main ./
ENV PATH /app/node_modules/.bin:$PATH
RUN npm ci
RUN npm run-script build

# production environment
FROM nginx:1.19.7
COPY --from=build /app/dist /usr/share/nginx/html
COPY ./assets/nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]