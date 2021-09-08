FROM udata/system

RUN mkdir -p /srv/udata /srv/udata-front
ADD start.sh /srv/start.sh
ADD udata.cfg /srv/udata.cfg
RUN chmod +x /srv/start.sh

RUN mkdir -p /udata/fs

VOLUME /udata/fs

ENV UDATA_SETTINGS /srv/udata.cfg

EXPOSE 7000

ENTRYPOINT ["/bin/bash", "/srv/start.sh"]
