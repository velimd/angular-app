FROM node:alpine as development

WORKDIR /app

COPY package.json .
RUN  npm install

COPY . .
RUN npm install -g @angular/cli@7.3.3 && ng build

EXPOSE 4200
CMD ["ng", "serve", "--host", "0.0.0.0"]

FROM nginx as production
COPY --from=development /app/dist/my-first-app /usr/share/nginx/html
