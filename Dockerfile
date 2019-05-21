FROM nginx:alpine

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /deployment
ENTRYPOINT ["/entrypoint.sh"]
