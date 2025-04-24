FROM fedora:41

ARG PORT=6565
ENV PORT=$PORT

RUN useradd speasy && dnf update -y  && dnf install -y git python3 python3-devel libxslt libxslt-devel gcc g++ qhull-devel qhull \
    glibc-langpack-en freetype-devel freetype libpng libpng-devel xorg-x11-server-Xvfb zlib-devel python3-matplotlib \
    && dnf clean all 

USER speasy
WORKDIR /home/speasy

RUN python3 -m ensurepip &&\
    python3 -mpip install -U pip &&\
    python3 -mpip install -U hypercorn pycrdt_websocket


COPY --chown=speasy --chmod=755  main.py /home/speasy/

EXPOSE $PORT
CMD [ "/home/speasy/main.py" ]