FROM node:20 AS builder
WORKDIR /opt/server
COPY code/ . 
RUN npm install

FROM node:20.18.0-alpine3.20
EXPOSE 8080
RUN addgroup -S roboshop && adduser -S roboshop -G roboshop
# RUN addgroup -S <group-name> && adduser -S <user-name> -G <group-name>
RUN mkdir /opt/server
run chown roboshop:roboshop /opt/server
# chown <user>:<group> <path>
WORKDIR /opt/server
COPY --from=builder /opt/server /opt/server
USER roboshop
CMD ["node", "server.js"]
