FROM udata/system

RUN mkdir -p /srv/udata /srv/udata-gouvfr
ADD start.sh /srv/start.sh
RUN chmod +x /srv/start.sh

RUN mkdir -p /udata/fs

VOLUME /udata/fs

ENV UDATA_SETTINGS /srv/udata/udata.cfg

EXPOSE 7000

ENTRYPOINT ["/bin/bash", "/srv/start.sh"]
