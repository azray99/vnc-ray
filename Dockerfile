FROM alpine:latest
LABEL maintainer=azray99@yahoo.com

ENV REMOTE_HOST=localhost \
	REMOTE_PORT=5900

RUN apk --update --upgrade --no-cache add git bash supervisor python2 \
	&& git clone https://github.com/novnc/noVNC.git /root/noVNC \
	&& git clone https://github.com/novnc/websockify /root/noVNC/utils/websockify \
	&& rm -rf /root/noVNC/.git \
	&& rm -rf /root/noVNC/utils/websockify/.git \
	&& mkdir /root/noVNC/www && cp /root/noVNC/vnc* /root/noVNC/www  \
	&& cp /root/noVNC/www/vnc.html /root/noVNC/www/index.html \
	&& cp /root/noVNC/package.json /root/noVNC/www/package.json \
	&& cp /root/noVNC/app /root/noVNC/www/app -r \
        && cp /root/noVNC/core /root/noVNC/www/core -r \
        && cp /root/noVNC/vendor /root/noVNC/www/vendor -r \
	&& apk del git 

COPY supervisord.conf /etc/supervisord.conf

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]

