#STAGE 1
FROM node:16.14.2-alpine as builder
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build --prod


#SATGE 2
FROM nginx:1.14.1-alpine
COPY --from=builder /app/dist/test-app /usr/share/nginx/html