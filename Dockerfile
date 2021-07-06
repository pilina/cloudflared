FROM alpine:latest AS build
ARG VERSION=2021.5.10
WORKDIR /opt
RUN apk add git go make \
  && git clone https://github.com/cloudflare/cloudflared \
  && cd cloudflared \
  && git checkout $VERSION \
  && make cloudflared

FROM alpine:latest
COPY --from=build /opt/cloudflared/cloudflared /usr/bin/cloudflared
ENTRYPOINT ["cloudflared"]
CMD ["version"]
