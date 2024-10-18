FROM node:20 as builder

LABEL "version"="0.1.1"
LABEL "repository"="https://github.com/AchanYao/s3-upload-github-action"
LABEL "homepage"="https://github.com/AchanYao/s3-upload-github-action"
LABEL "maintainer"="AchanYao <yyx1310059081@gmail.com>"

# Add the entry point
RUN mkdir /app
ADD index.js /app/index.js
ADD package.json /app/package.json
ADD package-lock.json /app/package-lock.json
ADD entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

RUN cd /app
WORKDIR /app
RUN npm install

FROM node:20-slim as runner

COPY --from=builder /app /app
WORKDIR /app

# Load the entry point
ENTRYPOINT ["/app/entrypoint.sh"]
