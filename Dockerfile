FROM node:16.14.0-alpine AS builder

WORKDIR /app
COPY . .

RUN yarn global add serve
RUN yarn
RUN yarn build

FROM builder as production
COPY --from=builder /app/dist/ /dist

RUN rm -rf /app

EXPOSE 3000
CMD [ "serve", "-s", "/dist" ]